import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const root = "../../../";
const workbookPath = `${root}dados_organizados_limpos_para_pacote_aulas.xlsx`;
const rawPath = `${root}provisorios/fsa_idades_savel/ShadCR.csv`;
const cleanPath = "../idades_savel_repetibilidade_limpo.csv";
const validationPath = "../validacao_idades_savel_repetibilidade.json";

function parseCsv(text) {
  const [header, ...lines] = text.trim().split(/\r?\n/);
  const columns = header.split(",");
  return lines.map((line) => {
    const values = line.split(",");
    return Object.fromEntries(columns.map((column, index) => [column, values[index] === "" ? null : values[index]]));
  });
}

function quantile(values, probability) {
  const sorted = [...values].sort((a, b) => a - b);
  const position = (sorted.length - 1) * probability;
  const lower = Math.floor(position);
  const upper = Math.ceil(position);
  return sorted[lower] + (sorted[upper] - sorted[lower]) * (position - lower);
}

function normalCdf(value) {
  const sign = value < 0 ? -1 : 1;
  const x = Math.abs(value) / Math.sqrt(2);
  const t = 1 / (1 + 0.3275911 * x);
  const erf = 1 - (((((1.061405429 * t - 1.453152027) * t + 1.421413741) * t - 0.284496736) * t + 0.254829592) * t * Math.exp(-x * x));
  return 0.5 * (1 + sign * erf);
}

function pairedSummary(rows, firstField, secondField) {
  const pairs = rows
    .filter((row) => row[firstField] !== null && row[secondField] !== null)
    .map((row) => Number(row[secondField]) - Number(row[firstField]));
  const nonzero = pairs.filter((difference) => difference !== 0);
  const ranked = nonzero.map((difference) => ({ difference, absolute: Math.abs(difference) })).sort((a, b) => a.absolute - b.absolute);
  let positiveRankSum = 0;
  let tieCorrection = 0;
  for (let start = 0; start < ranked.length;) {
    let end = start + 1;
    while (end < ranked.length && ranked[end].absolute === ranked[start].absolute) end += 1;
    const rank = (start + 1 + end) / 2;
    for (let index = start; index < end; index += 1) if (ranked[index].difference > 0) positiveRankSum += rank;
    if (end - start > 1) tieCorrection += (end - start) ** 3 - (end - start);
    start = end;
  }
  const n = nonzero.length;
  const mean = n * (n + 1) / 4;
  const variance = n * (n + 1) * (2 * n + 1) / 24 - tieCorrection / 48;
  const correction = positiveRankSum > mean ? 0.5 : positiveRankSum < mean ? -0.5 : 0;
  const z = n > 0 ? (positiveRankSum - mean - correction) / Math.sqrt(variance) : null;
  return {
    pares_completos: pairs.length,
    diferencas_zero: pairs.length - nonzero.length,
    concordancia_exata_pct: 100 * (pairs.length - nonzero.length) / pairs.length,
    diferenca_minima: Math.min(...pairs),
    diferenca_mediana: quantile(pairs, 0.5),
    diferenca_maxima: Math.max(...pairs),
    wilcoxon_aproximado: {
      v_soma_postos_positivos: positiveRankSum,
      z: z,
      p_bicaudal: z === null ? null : 2 * (1 - normalCdf(Math.abs(z))),
      empates_em_diferencas_absolutas: tieCorrection > 0,
    },
  };
}

const [rawText, workbookBlob] = await Promise.all([
  fs.readFile(rawPath, "utf8"),
  FileBlob.load(workbookPath),
]);
const raw = parseCsv(rawText);
const rows = raw.map((row) => ({
  fish_id: row.fishID,
  true_age: Number(row.trueAge),
  reader_a_1: row.agerA1 === null ? null : Number(row.agerA1),
  reader_a_2: row.agerA2 === null ? null : Number(row.agerA2),
  reader_b_1: row.agerB1 === null ? null : Number(row.agerB1),
  reader_b_2: row.agerB2 === null ? null : Number(row.agerB2),
  reader_c_1: row.agerC1 === null ? null : Number(row.agerC1),
  reader_c_2: row.agerC2 === null ? null : Number(row.agerC2),
}));

const pairSummaries = {
  leitor_a: pairedSummary(rows, "reader_a_1", "reader_a_2"),
  leitor_b: pairedSummary(rows, "reader_b_1", "reader_b_2"),
  leitor_c: pairedSummary(rows, "reader_c_1", "reader_c_2"),
};
const validation = {
  conjunto: "idades_savel_repetibilidade",
  linhas: rows.length,
  colunas: 8,
  ausentes_por_variavel: Object.fromEntries(Object.keys(rows[0]).map((field) => [field, rows.filter((row) => row[field] === null).length])),
  fish_id_duplicados: rows.length - new Set(rows.map((row) => row.fish_id)).size,
  idades_fora_da_faixa_esperada: rows.filter((row) => Object.entries(row).some(([field, value]) => field !== "fish_id" && value !== null && (!Number.isInteger(value) || value < 0))).length,
  comparacoes_pareadas: pairSummaries,
  decisao_curadoria: "Os 53 peixes e as ausencias originais foram preservados. Cada comparacao deve usar somente pares completos do leitor e dos dois momentos envolvidos.",
};

const workbook = await SpreadsheetFile.importXlsx(workbookBlob);
if (workbook.worksheets.items.some((sheet) => sheet.name === "idades_savel_repetibilidade")) {
  throw new Error("A aba idades_savel_repetibilidade ja existe; interrompido para evitar sobrescrita.");
}
workbook.comments.setSelf({ displayName: "EAPADados" });
const sheet = workbook.worksheets.add("idades_savel_repetibilidade");
sheet.showGridLines = false;
const headers = Object.keys(rows[0]);
const matrix = rows.map((row) => headers.map((header) => row[header]));
sheet.getRangeByIndexes(0, 0, matrix.length + 1, headers.length).values = [headers, ...matrix];
const table = sheet.tables.add(`A1:H${matrix.length + 1}`, true, "IdadesSavelRepetibilidadeTable");
table.style = "TableStyleMedium2";
sheet.freezePanes.freezeRows(1);
sheet.getRange("A1:H54").format.autofitColumns();
sheet.getRange("A1:H54").format.autofitRows();
sheet.getRange("A1:A54").format.columnWidth = 15;
sheet.getRange("B1:H54").format.columnWidth = 14;

const comments = {
  A: "Identificador unico do peixe. E o vinculo que define o pareamento entre as duas leituras de um mesmo leitor.",
  B: "Idade verdadeira conhecida do peixe, em anos, devido a marcacao anterior. Variavel de referencia para avaliar vies e erro.",
  C: "Idade estimada pelo leitor A na primeira leitura de escamas, em anos.",
  D: "Idade estimada pelo leitor A na segunda leitura de escamas, em anos. Para Wilcoxon pareado com o leitor A, comparar esta coluna com reader_a_1 somente para pares completos.",
  E: "Idade estimada pelo leitor B na primeira leitura de escamas, em anos. Valores ausentes significam que o leitor nao atribuiu idade a escama.",
  F: "Idade estimada pelo leitor B na segunda leitura de escamas, em anos.",
  G: "Idade estimada pelo leitor C na primeira leitura de escamas, em anos.",
  H: "Idade estimada pelo leitor C na segunda leitura de escamas, em anos.",
};
for (const [column, note] of Object.entries(comments)) workbook.comments.addThread({ cell: sheet.getRange(`${column}1`) }, note);

const infoSheet = workbook.worksheets.getItem("info_conjuntos");
const infoRow = [[
  "idades_savel_repetibilidade_fsa_mcbride_2005",
  "idades_savel_repetibilidade",
  "Repetibilidade da determinacao da idade do savel-americano",
  "Aplicar o teste de Wilcoxon pareado para investigar se as idades atribuidas pelo mesmo leitor diferem sistematicamente entre duas leituras independentes.",
  "bioecologia pesqueira; leitura de idade",
  "idade de peixes; repetibilidade; precisao; vies; concordancia; Wilcoxon pareado",
  "Wilcoxon pareado; concordancia exata; tabela cruzada; grafico de pares; erro em relacao a idade verdadeira",
  "reader_a_2 - reader_a_1",
  "wilcox.test(reader_a_2, reader_a_1, paired = TRUE, exact = FALSE)",
  "peixe individual; cada peixe forma um par dentro de cada leitor",
  "limpo_validado",
  "Nomes em ingles, conforme convencao da fonte e do EAPADados; ausencias originais preservadas.",
  "idades_savel_repetibilidade",
  53,
  8,
  53,
  8,
  "FSAdata::ShadCR; McBride, R. S.; Hendricks, M. L.; Olney, J. E. (2005). Testing the validity of Cating's (1953) method for age determination of American Shad using scales. Fisheries, 30:10-18.",
  "10.1577/1548-8446(2005)30[10:TTVOCM]2.0.CO;2",
  "https://fishr-core-team.github.io/FSAdata/reference/ShadCR.html",
  "GPL-2 ou GPL-3",
  "aula, atividade de consolidacao, avaliacao, livro e pacote EAPADados, com atribuicao da fonte",
  "provisorios/fsa_idades_savel/ShadCR.csv",
  "Ausencias refletem leitores que nao atribuiram idade a determinadas escamas. Em cada teste, manter somente pares completos do leitor e dos dois momentos comparados. Diferenca nao significativa nao implica concordancia perfeita.",
]];
const startRow = infoSheet.getUsedRange().values.length + 1;
infoSheet.getRangeByIndexes(startRow - 1, 0, 1, 24).values = infoRow;
infoSheet.getRange(`A${startRow}:X${startRow}`).format.wrapText = true;
infoSheet.getRange(`A${startRow}:X${startRow}`).format.borders = { preset: "inside", style: "thin", color: "#D9D9D9" };
infoSheet.getRange(`A${startRow}:X${startRow}`).format.autofitRows();

const csvLines = [headers.join(","), ...matrix.map((record) => record.map((value) => value ?? "").join(","))];
await fs.writeFile(cleanPath, `${csvLines.join("\n")}\n`, "utf8");
await fs.writeFile(validationPath, `${JSON.stringify(validation, null, 2)}\n`, "utf8");
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(workbookPath);
console.log(JSON.stringify(validation, null, 2));
