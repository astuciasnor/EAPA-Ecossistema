import fs from "node:fs/promises";
import { SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const rawPath = "../Pallid.csv";
const outputPath = "../../../atividade_kruskal_esturjao_palido.xlsx";
const validationPath = "../validacao_pallid_kruskal.json";

const monthIndex = {
  Jan: 0, Feb: 1, Mar: 2, Apr: 3, May: 4, Jun: 5,
  Jul: 6, Aug: 7, Sep: 8, Oct: 9, Nov: 10, Dec: 11,
};

function parseDate(value) {
  const [day, month, year] = value.split("-");
  return new Date(Date.UTC(1900 + Number(year), monthIndex[month], Number(day)));
}

function parseCsv(text) {
  const [header, ...lines] = text.trim().split(/\r?\n/);
  const columns = header.split(",");
  return lines.map((line) => {
    const values = line.split(",");
    return Object.fromEntries(columns.map((column, index) => [column, values[index]]));
  });
}

const raw = parseCsv(await fs.readFile(rawPath, "utf8"));
const records = raw.map((row) => ({
  date: parseDate(row.date),
  standard_length_mm: Number(row.sl),
  fork_length_mm: Number(row.fl),
  total_length_mm: Number(row.tl),
  weight_g: Number(row.w),
  status: row.status,
  location: row.loc,
}));
const expectedLocations = ["NB", "SD", "ND", "MT"];
const countsByLocation = Object.fromEntries(expectedLocations.map((location) => [location, records.filter((row) => row.location === location).length]));
const validation = {
  conjunto: "atividade_kruskal_esturjao_palido",
  linhas: records.length,
  colunas: 7,
  ausentes: Object.fromEntries(Object.keys(records[0]).map((field) => [field, records.filter((row) => row[field] === null || row[field] === "").length])),
  grupos: countsByLocation,
  locais_inesperados: [...new Set(records.map((row) => row.location).filter((location) => !expectedLocations.includes(location)))],
  medidas_invalidas: records.filter((row) => [row.standard_length_mm, row.fork_length_mm, row.total_length_mm, row.weight_g].some((value) => !Number.isFinite(value) || value <= 0)).length,
  decisao_curadoria: "Os 30 peixes e as sete variaveis do FSAdata foram preservados. O conjunto e destinado somente a atividade autonoma em Excel, sem inclusao na planilha-mae EAPADados.",
};
if (validation.linhas !== 30 || Object.values(countsByLocation).some((count) => count === 0) || validation.medidas_invalidas !== 0 || validation.locais_inesperados.length !== 0) {
  throw new Error(`Validacao basica falhou: ${JSON.stringify(validation)}`);
}

const workbook = Workbook.create();
workbook.comments.setSelf({ displayName: "EAPADados" });

const dataSheet = workbook.worksheets.add("Dados");
dataSheet.showGridLines = false;
const headers = ["date", "standard_length_mm", "fork_length_mm", "total_length_mm", "weight_g", "status", "location"];
dataSheet.getRange("A1:G31").values = [headers, ...records.map((row) => headers.map((header) => row[header]))];
const table = dataSheet.tables.add("A1:G31", true, "PallidSturgeonTable");
table.style = "TableStyleMedium2";
dataSheet.freezePanes.freezeRows(1);
dataSheet.getRange("A1:G31").format.autofitColumns();
dataSheet.getRange("A1:A31").format.columnWidth = 14;
dataSheet.getRange("B1:E31").format.columnWidth = 19;
dataSheet.getRange("F1:G31").format.columnWidth = 13;
dataSheet.getRange("A2:A31").format.numberFormat = "yyyy-mm-dd";
dataSheet.getRange("B2:E31").format.numberFormat = "#,##0";
const comments = {
  A: "Data de coleta. A data pode estar associada a diferencas sazonais e nao deve ser interpretada como efeito do local isoladamente.",
  B: "Comprimento padrao do peixe, em milimetros.",
  C: "Comprimento furcal do peixe, em milimetros.",
  D: "Comprimento total do peixe, em milimetros. Variavel resposta principal da atividade de Kruskal-Wallis.",
  E: "Massa corporal do peixe, em gramas. Nao analisar conjuntamente com comprimento como se fossem respostas independentes.",
  F: "Condicao do peixe no momento da coleta. Niveis na fonte: Frozen, Live e Dead.",
  G: "Local de coleta. Grupos independentes: NB = Nebraska; SD = Dakota do Sul; ND = Dakota do Norte; MT = Montana.",
};
for (const [column, note] of Object.entries(comments)) workbook.comments.addThread({ cell: dataSheet.getRange(`${column}1`) }, note);

const contextSheet = workbook.worksheets.add("Contexto_Dicionario");
contextSheet.showGridLines = false;
contextSheet.mergeCells("A1:B1");
contextSheet.getRange("A1").values = [["Atividade autonoma: tamanho de esturjoes-palidos em quatro regioes"]];
contextSheet.getRange("A1:B1").format = {
  fill: "#0F5F7A",
  font: { bold: true, color: "#FFFFFF", fontSize: 14 },
  horizontalAlignment: "center",
  verticalAlignment: "center",
  wrapText: true,
};
contextSheet.getRange("A1:B1").format.rowHeight = 32;
const contextRows = [
  ["titulo_do_conjunto", "Tamanho de esturjoes-palidos em quatro regioes"],
  ["objetivo", "Investigar se a distribuicao do comprimento total difere entre quatro locais de coleta no sistema do rio Missouri."],
  ["especie", "Scaphirhynchus albus (esturjao-palido)"],
  ["origem_dos_dados", "FSAdata::Pallid; dados da Tabela 1 de Keenlyne e Maxwell (1993)."],
  ["unidade_amostral", "Peixe individual capturado. Cada linha representa um peixe."],
  ["grupos_independentes", "NB = Nebraska; SD = Dakota do Sul; ND = Dakota do Norte; MT = Montana. Os peixes de locais distintos nao formam pares."],
  ["date", "Data de coleta, no formato ano-mes-dia."],
  ["standard_length_mm", "Comprimento padrao, em milimetros."],
  ["fork_length_mm", "Comprimento furcal, em milimetros."],
  ["total_length_mm", "Comprimento total, em milimetros. Variavel resposta principal."],
  ["weight_g", "Massa corporal, em gramas."],
  ["status", "Condicao do peixe no momento da coleta: Frozen, Live ou Dead."],
  ["location", "Codigo do local de coleta: NB, SD, ND ou MT."],
  ["dados_ausentes", "Nao ha valores ausentes nas sete variaveis."],
  ["pergunta_de_pesquisa", "A distribuicao do comprimento total dos esturjoes-palidos difere entre Nebraska, Dakota do Sul, Dakota do Norte e Montana?"],
  ["hipotese_nula", "As distribuicoes do comprimento total sao iguais nos quatro locais."],
  ["hipotese_alternativa", "Pelo menos um local apresenta distribuicao do comprimento total diferente."],
  ["analise_sugerida", "Kruskal-Wallis com alpha = 0,05. Se significativo, realizar comparacoes pos-hoc pareadas com correcao de Holm. Em R: kruskal.test(total_length_mm ~ location, data = dados)."],
  ["procedimentos_solicitados", "Identifique unidade, resposta e agrupamento; conte peixes e ausencias por local; calcule n, mediana, Q1, Q3, minimo e maximo; construa grafico comparativo; aplique Kruskal-Wallis; se significativo, realize pos-hoc com Holm; interprete medianas, graficos e comparacoes."],
  ["cuidados", "O teste compara postos e nao identifica os locais diferentes sem pos-teste. Tamanhos de grupo pequenos e desiguais reduzem o poder. Local nao deve ser interpretado como causa isolada: data, idade, recrutamento e ambiente podem explicar diferencas. Comprimento e massa descrevem o porte do mesmo peixe."],
  ["produto_esperado", "Relatorio curto com pergunta e hipoteses, tabela descritiva por local, grafico, Kruskal-Wallis, pos-teste quando aplicavel, conclusao biologica cuidadosa e ao menos duas limitacoes."],
  ["referencia", "Keenlyne, K. D.; Maxwell, S. J. (1993). Length conversions and length-weight relations for pallid sturgeon. North American Journal of Fisheries Management, 13, 395-397."],
  ["url_documentacao", "https://fishr-core-team.github.io/FSAdata/reference/Pallid.html"],
  ["licenca", "FSAdata: GPL (>= 2)."],
  ["destino", "Atividade didatica autonoma em Excel; nao incorporar ao EAPADados."],
];
contextSheet.getRangeByIndexes(2, 0, contextRows.length, 2).values = contextRows;
contextSheet.getRange(`A3:A${contextRows.length + 2}`).format = { fill: "#DDEBF7", font: { bold: true, color: "#17365D" }, verticalAlignment: "top", wrapText: true };
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
