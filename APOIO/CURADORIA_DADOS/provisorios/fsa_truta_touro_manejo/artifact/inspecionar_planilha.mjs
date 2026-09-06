import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const inputPath = "../../../dados_organizados_limpos_para_pacote_aulas.xlsx";
const input = await FileBlob.load(inputPath);
const workbook = await SpreadsheetFile.importXlsx(input);

const overview = await workbook.inspect({
  kind: "workbook,sheet,table",
  maxChars: 12000,
  tableMaxRows: 5,
  tableMaxCols: 24,
});
console.log(overview.ndjson);

const info = await workbook.inspect({
  kind: "table,computedStyle",
  sheetId: "info_conjuntos",
  range: "A1:W6",
  maxChars: 12000,
  tableMaxRows: 6,
  tableMaxCols: 24,
});
console.log(info.ndjson);
