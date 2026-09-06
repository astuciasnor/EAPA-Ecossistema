import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const path = "../../../dados_organizados_limpos_para_pacote_aulas.xlsx";
const input = await FileBlob.load(path);
const workbook = await SpreadsheetFile.importXlsx(input);
const sheet = workbook.worksheets.getItem("info_conjuntos");
const used = sheet.getUsedRange().values;
const row = used.findIndex((values) => values[0] === "idades_savel_repetibilidade_fsa_mcbride_2005") + 1;
if (row < 2) throw new Error("Registro de idades_savel_repetibilidade nao encontrado.");
sheet.getRange(`S${row}`).values = [["10.1577/1548-8446(2005)30[10:TTVOCM]2.0.CO;2"]];
const output = await SpreadsheetFile.exportXlsx(workbook);
await output.save(path);
console.log(`DOI registrado em S${row}.`);
