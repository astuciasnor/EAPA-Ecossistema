import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const file = await FileBlob.load("D:/Claude/eapa/EAPADados/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx");
const workbook = await SpreadsheetFile.importXlsx(file);
const sheet = workbook.worksheets.getItem("Índice");
const values = sheet.getRange("A1:F41").values;
console.log(JSON.stringify(values, null, 2));
