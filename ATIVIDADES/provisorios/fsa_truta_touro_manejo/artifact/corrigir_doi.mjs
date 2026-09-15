import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const path = "../../../dados_organizados_limpos_para_pacote_aulas.xlsx";
const input = await FileBlob.load(path);
const workbook = await SpreadsheetFile.importXlsx(input);
const sheet = workbook.worksheets.getItem("info_conjuntos");
const used = sheet.getUsedRange().values;
const row = used.findIndex((values) => values[0] === "truta_touro_manejo_fsa_parker_2007") + 1;
if (row < 2) throw new Error("Registro de truta_touro_manejo nao encontrado.");
sheet.getRange(`S${row}`).values = [["10.1577/M06-051.1"]];
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(path);
console.log(`DOI corrigido em S${row}.`);
