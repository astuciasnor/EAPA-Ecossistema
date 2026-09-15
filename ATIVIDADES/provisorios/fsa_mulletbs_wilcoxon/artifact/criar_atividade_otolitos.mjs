import fs from "node:fs/promises";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const rawPath = "../MulletBS.csv";
const outputPath = "../../../atividade_wilcoxon_otolitos.xlsx";
const validationPath = "../validacao_mulletbs_wilcoxon.json";

function parseCsv(text) {
  const [header, ...lines] = text.trim().split(/\r?\n/);
  const columns = header.split(",");
  return lines.map((line) => {
    const values = line.split(",");
    return Object.fromEntries(columns.map((column, index) => [column, Number(values[index]) ]));
  });
}

function quantile(values, probability) {
  const sorted = [...values].sort((a, b) => a - b);
  const position = (sorted.length - 1) * probability;
  const lower = Math.floor(position);
  const upper = Math.ceil(position);
  return sorted[lower] + (sorted[upper] - sorted[lower]) * (position - lower);
}

const raw = parseCsv(await fs.readFile(rawPath, "utf8"));
const records = raw.map((row, index) => ({
  fish_id: `MB${String(index + 1).padStart(3, "0")}`,
  whole_otolith_age: row.whole,
  broken_burnt_age: row.bb,
}));
const differences = records.map((row) => row.broken_burnt_age - row.whole_otolith_age);
const validation = {
  conjunto: "atividade_wilcoxon_otolitos",
  linhas: records.length,
  pares_completos: records.filter((row) => row.whole_otolith_age !== null && row.broken_burnt_age !== null).length,
  ausentes: Object.fromEntries(["whole_otolith_age", "broken_burnt_age"].map((field) => [field, records.filter((row) => row[field] === null).length])),
  fish_id_duplicados: records.length - new Set(records.map((row) => row.fish_id)).size,
  idades_fora_da_faixa_esperada: records.filter((row) => row.whole_otolith_age < 0 || row.broken_burnt_age < 0 || !Number.isInteger(row.whole_otolith_age) || !Number.isInteger(row.broken_burnt_age)).length,
  resumo_reservado_para_validacao: {
    mediana_otolito_inteiro: quantile(records.map((row) => row.whole_otolith_age), 0.5),
    mediana_otolito_quebrado_queimado: quantile(records.map((row) => row.broken_burnt_age), 0.5),
    mediana_diferencas: quantile(differences, 0.5),
    diferencas_positivas: differences.filter((value) => value > 0).length,
    diferencas_negativas: differences.filter((value) => value < 0).length,
    diferencas_zero: differences.filter((value) => value === 0).length,
  },
};

if (validation.linhas !== 51 || validation.pares_completos !== 51 || validation.fish_id_duplicados !== 0 || validation.idades_fora_da_faixa_esperada !== 0) {
  throw new Error(`Validacao basica falhou: ${JSON.stringify(validation)}`);
}

const workbook = Workbook.create();
workbook.comments.setSelf({ displayName: "EAPADados" });

const dataSheet = workbook.worksheets.add("Dados");
dataSheet.showGridLines = false;
const headers = ["fish_id", "whole_otolith_age", "broken_burnt_age"];
dataSheet.getRange("A1:C52").values = [
  headers,
  ...records.map((row) => headers.map((header) => row[header])),
];
const dataTable = dataSheet.tables.add("A1:C52", true, "MulletOtolithsTable");
dataTable.style = "TableStyleMedium2";
dataSheet.freezePanes.freezeRows(1);
dataSheet.getRange("A1:C52").format.autofitColumns();
dataSheet.getRange("A1:A52").format.columnWidth = 15;
dataSheet.getRange("B1:C52").format.columnWidth = 22;
dataSheet.getRange("A1:C52").format.numberFormat = [["@", "0", "0"]];
const comments = {
  A: "Identificador sequencial criado durante a curadoria somente para visualizar e preservar os 51 pares. Nao corresponde a um codigo original do estudo.",
  B: "Idade estimada a partir do otolito inteiro, em anos. Primeira medida do par.",
  C: "Idade estimada a partir do otolito quebrado e queimado, em anos. Segunda medida do par. Para a atividade, calcule diferenca = broken_burnt_age - whole_otolith_age.",
};
for (const [column, note] of Object.entries(comments)) workbook.comments.addThread({ cell: dataSheet.getRange(`${column}1`) }, note);

const contextSheet = workbook.worksheets.add("Contexto_Dicionario");
contextSheet.showGridLines = false;
contextSheet.mergeCells("A1:B1");
contextSheet.getRange("A1").values = [["Atividade autonoma: comparacao de dois metodos de leitura de otolitos"]];
contextSheet.getRange("A1:B1").format = {
  fill: "#0F5F7A",
  font: { bold: true, color: "#FFFFFF", fontSize: 14 },
  horizontalAlignment: "center",
  verticalAlignment: "center",
  wrapText: true,
};
contextSheet.getRange("A1:B1").format.rowHeight = 32;
const contextRows = [
  ["titulo_do_conjunto", "Comparacao de dois metodos de leitura de otolitos de salmonete"],
  ["especie", "Mullus barbatus ponticus (salmonete do Mar Negro)"],
  ["origem_dos_dados", "FSAdata::MulletBS; dados da Figura 3 de Polat, Bostanci e Yilmaz (2005)."],
  ["unidade_amostral", "Peixe individual. Cada linha representa o mesmo peixe avaliado por dois metodos."],
  ["pareamento", "As duas idades pertencem ao mesmo peixe. O pareamento e definido pela linha/fish_id, nao apenas pelo numero igual de observacoes."],
  ["fish_id", "Identificador sequencial criado na curadoria; nao e um identificador original do estudo."],
  ["whole_otolith_age", "Idade estimada pelo otolito inteiro, em anos."],
  ["broken_burnt_age", "Idade estimada pelo otolito quebrado e queimado, em anos."],
  ["dados_ausentes", "Nao ha valores ausentes: os 51 peixes possuem as duas estimativas."],
  ["pergunta_de_pesquisa", "A idade estimada pelo otolito inteiro difere sistematicamente daquela estimada pelo metodo do otolito quebrado e queimado?"],
  ["variavel_calculada", "diferenca = broken_burnt_age - whole_otolith_age"],
  ["hipotese_nula", "A distribuicao das diferencas entre os metodos esta centrada em zero."],
  ["hipotese_alternativa", "A distribuicao das diferencas entre os metodos nao esta centrada em zero."],
  ["analise_sugerida", "Teste de Wilcoxon pareado, alpha = 0,05. Em R: wilcox.test(broken_burnt_age, whole_otolith_age, paired = TRUE, exact = FALSE)."],
  ["procedimentos_solicitados", "Identifique unidade amostral, variaveis numericas e fator de pareamento; verifique pares completos; crie diferenca; calcule medianas, IQR, sinais e concordancia exata; construa grafico que preserve os pares; examine as diferencas; formule hipoteses; aplique Wilcoxon pareado; interprete o resultado."],
  ["questoes_para_interpretacao", "Qual metodo produziu maiores idades? Quantos peixes receberam exatamente a mesma idade? O sentido das diferencas foi consistente? A diferenca estatistica seria biologicamente relevante? Ausencia de significancia indicaria concordancia perfeita? Qual a consequencia de subestimar peixes mais velhos em avaliacao de estoque?"],
  ["produto_esperado", "Sintese com contextualizacao, pergunta de pesquisa, justificativa do pareamento, estatisticas descritivas, grafico, hipoteses, resultado do teste, conclusao tecnica e uma limitacao da analise."],
  ["cuidados", "Examine as diferencas, os empates e a concordancia exata. Ausencia de significancia nao demonstra concordancia perfeita; avalie tambem a relevancia biologica."],
  ["referencia", "Polat, N.; Bostanci, D.; Yilmaz, S. (2005). Differences between whole otolith and broken-burnt otolith ages of red mullet (Mullus barbatus ponticus Essipov, 1927) sampled from the Black Sea (Samsun, Turkey). Turkish Journal of Veterinary and Animal Science, 29, 429-433."],
  ["url_documentacao", "https://fishr-core-team.github.io/FSAdata/reference/MulletBS.html"],
  ["licenca", "FSAdata: GPL (>= 2)."],
  ["destino", "Atividade didatica autonoma em Excel; nao incorporar ao EAPADados para evitar duplicacao com ShadCR."],
];
contextSheet.getRangeByIndexes(2, 0, contextRows.length, 2).values = contextRows;
contextSheet.getRange(`A3:A${contextRows.length + 2}`).format = {
  fill: "#DDEBF7",
  font: { bold: true, color: "#17365D" },
  verticalAlignment: "top",
  wrapText: true,
};
contextSheet.getRange(`B3:B${contextRows.length + 2}`).format = { verticalAlignment: "top", wrapText: true };
contextSheet.getRange(`A3:B${contextRows.length + 2}`).format.borders = { preset: "inside", style: "thin", color: "#C9D6E1" };
contextSheet.getRange(`A1:A${contextRows.length + 2}`).format.columnWidth = 25;
contextSheet.getRange(`B1:B${contextRows.length + 2}`).format.columnWidth = 100;
contextSheet.getRange(`A1:B${contextRows.length + 2}`).format.autofitRows();
contextSheet.freezePanes.freezeRows(2);

await fs.writeFile(validationPath, `${JSON.stringify(validation, null, 2)}\n`, "utf8");
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(outputPath);
console.log(JSON.stringify(validation, null, 2));
