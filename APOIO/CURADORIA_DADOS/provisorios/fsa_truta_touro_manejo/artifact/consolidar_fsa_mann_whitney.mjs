import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const root = "../../../";
const workbookPath = `${root}dados_organizados_limpos_para_pacote_aulas.xlsx`;
const darterPath = `${root}provisorios/fsa_darter_ontario/darter_ontario_limpo.csv`;
const bullPath = `${root}provisorios/fsa_truta_touro_manejo/BullTroutRML1.csv`;
const validationPath = "../validacao_truta_touro_manejo.json";

function parseCsv(text) {
  const [header, ...lines] = text.trim().split(/\r?\n/);
  const columns = header.split(",");
  return lines.map((line) => {
    const values = line.split(",");
    return Object.fromEntries(columns.map((column, index) => [column, values[index]]));
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

function mannWhitney(groupA, groupB) {
  const all = [
    ...groupA.map((value) => ({ value, group: "a" })),
    ...groupB.map((value) => ({ value, group: "b" })),
  ].sort((a, b) => a.value - b.value);
  let ties = 0;
  let rankSumA = 0;
  for (let start = 0; start < all.length;) {
    let end = start + 1;
    while (end < all.length && all[end].value === all[start].value) end += 1;
    const rank = (start + 1 + end) / 2;
    for (let i = start; i < end; i += 1) if (all[i].group === "a") rankSumA += rank;
    if (end - start > 1) ties += (end - start) ** 3 - (end - start);
    start = end;
  }
  const nA = groupA.length;
  const nB = groupB.length;
  const uA = rankSumA - (nA * (nA + 1)) / 2;
  const uB = nA * nB - uA;
  const mean = (nA * nB) / 2;
  const variance = (nA * nB / 12) * ((nA + nB + 1) - ties / ((nA + nB) * (nA + nB - 1)));
  const correction = uA > mean ? 0.5 : -0.5;
  const z = (uA - mean - correction) / Math.sqrt(variance);
  return { u_periodo_1977_79: uA, u_2001: uB, u_menor: Math.min(uA, uB), z_aproximado: z, p_bicaudal_aproximado: 2 * (1 - normalCdf(Math.abs(z))), empates: ties > 0 };
}

function addDatasetSheet(workbook, { name, rows, headers, comments, tableName, tableStyle }) {
  if (workbook.worksheets.items.some((sheet) => sheet.name === name)) {
    throw new Error(`A aba ${name} ja existe; interrompido para evitar sobrescrita.`);
  }
  const sheet = workbook.worksheets.add(name);
  sheet.showGridLines = false;
  sheet.getRangeByIndexes(0, 0, rows.length + 1, headers.length).values = [headers, ...rows];
  const endColumn = String.fromCharCode(64 + headers.length);
  const table = sheet.tables.add(`A1:${endColumn}${rows.length + 1}`, true, tableName);
  table.style = tableStyle;
  sheet.freezePanes.freezeRows(1);
  sheet.getRange(`A1:${endColumn}1`).format.wrapText = true;
  sheet.getRange(`A1:${endColumn}${rows.length + 1}`).format.autofitColumns();
  sheet.getRange(`A1:${endColumn}${rows.length + 1}`).format.autofitRows();
  for (let column = 0; column < headers.length; column += 1) {
    sheet.getRangeByIndexes(0, column, rows.length + 1, 1).format.columnWidth = Math.min(Math.max(sheet.getRangeByIndexes(0, column, rows.length + 1, 1).format.columnWidth ?? 12, 13), 24);
  }
  for (const [column, note] of Object.entries(comments)) {
    workbook.comments.addThread({ cell: sheet.getRange(`${column}1`) }, note);
  }
  return sheet;
}

const [darterText, bullText, workbookBlob] = await Promise.all([
  fs.readFile(darterPath, "utf8"),
  fs.readFile(bullPath, "utf8"),
  FileBlob.load(workbookPath),
]);
const workbook = await SpreadsheetFile.importXlsx(workbookBlob);
const darter = parseCsv(darterText);
const bull = parseCsv(bullText).map((row, index) => ({
  id_peixe: `BT${String(index + 1).padStart(3, "0")}`,
  comprimento_furcal_mm: Number(row.fl),
  massa_umida_g: Number(row.mass),
  periodo_coleta: row.era,
}));

const periodos = ["1977-79", "2001"];
const porPeriodo = Object.fromEntries(periodos.map((periodo) => {
  const values = bull.filter((row) => row.periodo_coleta === periodo).map((row) => row.comprimento_furcal_mm);
  return [periodo, {
    n: values.length,
    minimo_mm: Math.min(...values),
    q1_mm: quantile(values, 0.25),
    mediana_mm: quantile(values, 0.5),
    q3_mm: quantile(values, 0.75),
    maximo_mm: Math.max(...values),
  }];
}));
const mw = mannWhitney(
  bull.filter((row) => row.periodo_coleta === "1977-79").map((row) => row.comprimento_furcal_mm),
  bull.filter((row) => row.periodo_coleta === "2001").map((row) => row.comprimento_furcal_mm),
);
const validation = {
  conjunto: "truta_touro_manejo",
  n_total: bull.length,
  n_por_periodo: Object.fromEntries(periodos.map((periodo) => [periodo, porPeriodo[periodo].n])),
  ausentes: Object.fromEntries(["comprimento_furcal_mm", "massa_umida_g", "periodo_coleta"].map((field) => [field, bull.filter((row) => row[field] === null || row[field] === "").length])),
  duplicatas_completas: bull.length - new Set(bull.map((row) => `${row.comprimento_furcal_mm}|${row.massa_umida_g}|${row.periodo_coleta}`)).size,
  estatisticas_comprimento_furcal_mm: porPeriodo,
  mann_whitney_comprimento_por_periodo: mw,
  decisao_curadoria: "Todos os 137 peixes foram preservados. A base publicada foi reconstruida aproximadamente da Figura 2; o identificador do lago nao esta disponivel no CSV e nao pode ser controlado na analise didatica.",
};

const infoSheet = workbook.worksheets.getItem("info_conjuntos");
const dataStyle = "TableStyleMedium2";
workbook.comments.setSelf({ displayName: "EAPADados" });

addDatasetSheet(workbook, {
  name: "darter_ontario1",
  rows: darter.map((row) => [row.id_peixe, Number(row.idade_anos), Number(row.comprimento_total_mm), row.rio]),
  headers: ["id_peixe", "idade_anos", "comprimento_total_mm", "rio"],
  tableName: "DarterOntarioTable",
  tableStyle: dataStyle,
  comments: {
    A: "Identificador criado durante a curadoria. Cada linha representa um peixe individual.",
    B: "Idade estimada pela leitura de otolitos, em anos. Variavel resposta sugerida para o teste de Mann-Whitney; ha empates, portanto usar exact = FALSE em R.",
    C: "Comprimento total do peixe, em milimetros. Variavel biologica complementar; nao combinar com idade em um unico teste simples entre rios.",
    D: "Rio de captura. Niveis: Salmon e Trent. Variavel de agrupamento para o teste de Mann-Whitney.",
  },
});

addDatasetSheet(workbook, {
  name: "truta_touro_manejo",
  rows: bull.map((row) => [row.id_peixe, row.comprimento_furcal_mm, row.massa_umida_g, row.periodo_coleta]),
  headers: ["id_peixe", "comprimento_furcal_mm", "massa_umida_g", "periodo_coleta"],
  tableName: "TrutaTouroManejoTable",
  tableStyle: dataStyle,
  comments: {
    A: "Identificador criado durante a curadoria. Cada linha representa uma truta-touro individual medida na amostragem.",
    B: "Comprimento furcal, em milimetros. Variavel resposta principal para comparar as distribuicoes de tamanho entre 1977-79 e 2001.",
    C: "Massa umida do peixe, em gramas. Variavel complementar; nao e necessaria para a atividade autonoma principal.",
    D: "Periodo de coleta. 1977-79 representa a amostragem historica anterior ao regime restritivo; 2001 representa a amostragem posterior. Os grupos sao independentes, nao pares antes/depois.",
  },
});

const infoRows = [
  ["darter_ontario_fsa_reid_2004", "darter_ontario", "Idade e comprimento da percina-do-canal em dois rios de Ontario", "Comparar a distribuicao das idades de Percina copelandi entre os rios Salmon e Trent com Mann-Whitney.", "bioecologia pesqueira; biologia de peixes", "idade; comprimento; comparacao de dois grupos; Mann-Whitney", "Mann-Whitney; graficos de distribuicao; regressao idade-comprimento", "idade_anos ~ rio", "wilcox.test(idade_anos ~ rio, data = darter_ontario, exact = FALSE)", "peixe individual", "limpo_validado", "Traducao dos nomes das variaveis e criacao de identificador; mantidos os dois rios originais.", "darter_ontario1", 54, 4, 54, 3, "FSAdata::DarterOnt; dados reconstruidos da Figura 2 de Reid (2004), DOI: 10.1080/02705060.2004.9664917.", "10.1080/02705060.2004.9664917", "https://fishr-core-team.github.io/FSAdata/reference/DarterOnt.html", "GPL-2 ou GPL-3", "atividade de consolidacao, aula, livro e pacote EAPADados, com atribuicao da fonte", "provisorios/fsa_darter_ontario/DarterOnt.csv", "Ha muitos empates em idade; usar aproximacao com exact = FALSE. A pesca eletrica pode subamostrar peixes menores e jovens."],
  ["truta_touro_manejo_fsa_parker_2007", "truta_touro_manejo", "Comprimento de trutas-touro antes e depois de restricoes de pesca", "Atividade autonoma para investigar se a distribuicao do comprimento furcal diferiu entre 1977-79 e 2001, discutindo manejo sem inferir causalidade.", "bioecologia pesqueira; manejo de pesca", "truta-touro; estrutura de tamanhos; regulacao pesqueira; comparacao temporal; Mann-Whitney", "Mann-Whitney; estatistica descritiva; boxplot; histograma/densidade", "comprimento_furcal_mm ~ periodo_coleta", "wilcox.test(comprimento_furcal_mm ~ periodo_coleta, data = truta_touro_manejo, exact = FALSE)", "truta-touro individual", "limpo_validado", "Traducao dos nomes das variaveis e criacao de identificador; os 137 registros publicados foram preservados.", "truta_touro_manejo", 137, 4, 137, 3, "FSAdata::BullTroutRML1; dados de aproximadamente a Figura 2 de Parker et al. (2007), Bull trout population responses to reductions in angler effort and retention limits.", "10.1577/M06-051.1", "https://fishr-core-team.github.io/FSAdata/reference/BullTroutRML1.html", "GPL-2 ou GPL-3", "atividade autonoma, avaliacao, aula, livro e pacote EAPADados, com atribuicao da fonte", "provisorios/fsa_truta_touro_manejo/BullTroutRML1.csv", "Base reconstruida aproximadamente de figura. O CSV nao identifica os dois lagos, portanto efeito de lago, mudancas de amostragem e outros fatores temporais nao podem ser separados da associacao com o periodo."],
];
const infoStartRow = infoSheet.getUsedRange().values.length + 1;
infoSheet.getRangeByIndexes(infoStartRow - 1, 0, infoRows.length, infoRows[0].length).values = infoRows;
infoSheet.getRange(`A${infoStartRow}:X${infoStartRow + infoRows.length - 1}`).format.wrapText = true;
infoSheet.getRange(`A${infoStartRow}:X${infoStartRow + infoRows.length - 1}`).format.borders = { preset: "inside", style: "thin", color: "#D9D9D9" };
infoSheet.getRange(`A${infoStartRow}:X${infoStartRow + infoRows.length - 1}`).format.autofitRows();

await fs.writeFile(validationPath, `${JSON.stringify(validation, null, 2)}\n`, "utf8");
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(workbookPath);
console.log(JSON.stringify(validation, null, 2));
