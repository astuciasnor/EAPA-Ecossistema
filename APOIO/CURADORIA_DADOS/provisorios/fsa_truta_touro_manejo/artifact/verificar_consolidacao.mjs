import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const path = "../../../dados_organizados_limpos_para_pacote_aulas.xlsx";
const input = await FileBlob.load(path);
const workbook = await SpreadsheetFile.importXlsx(input);

const sheets = await workbook.inspect({ kind: "sheet", maxChars: 4000 });
const info = await workbook.inspect({ kind: "table,thread", sheetId: "info_conjuntos", range: "A9:X12", maxChars: 10000, tableMaxRows: 4, tableMaxCols: 24 });
const darter = await workbook.inspect({ kind: "table,thread", sheetId: "darter_ontario1", range: "A1:D55", maxChars: 8000, tableMaxRows: 6, tableMaxCols: 4 });
const bull = await workbook.inspect({ kind: "table,thread", sheetId: "truta_touro_manejo", range: "A1:D138", maxChars: 8000, tableMaxRows: 6, tableMaxCols: 4 });
const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  maxChars: 3000,
});
console.log(sheets.ndjson);
console.log(info.ndjson);
console.log(darter.ndjson);
console.log(bull.ndjson);
console.log(errors.ndjson);

for (const [sheetName, fileName, range] of [
  ["info_conjuntos", "info_conjuntos_final.png", "A9:X12"],
  ["darter_ontario1", "darter_ontario_final.png", "A1:D20"],
  ["truta_touro_manejo", "truta_touro_final.png", "A1:D24"],
]) {
  const preview = await workbook.render({ sheetName, range, scale: 1.5, format: "png" });
  await fs.writeFile(`../${fileName}`, new Uint8Array(await preview.arrayBuffer()));
}
