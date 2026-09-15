import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const input = await FileBlob.load("../../../atividade_kruskal_esturjao_palido.xlsx");
const workbook = await SpreadsheetFile.importXlsx(input);
const sheets = await workbook.inspect({ kind: "sheet", maxChars: 3000 });
const data = await workbook.inspect({
  kind: "table,thread",
  sheetId: "Dados",
  range: "A1:G31",
  maxChars: 9000,
  tableMaxRows: 8,
  tableMaxCols: 7,
});
const context = await workbook.inspect({
  kind: "table",
  sheetId: "Contexto_Dicionario",
  range: "A1:B27",
  maxChars: 9000,
  tableMaxRows: 27,
  tableMaxCols: 2,
});
const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  maxChars: 3000,
});
console.log(sheets.ndjson);
console.log(data.ndjson);
console.log(context.ndjson);
console.log(errors.ndjson);
for (const [sheetName, fileName, range] of [
  ["Dados", "dados_esturjao_final.png", "A1:G24"],
  ["Contexto_Dicionario", "contexto_esturjao_final.png", "A1:B27"],
]) {
  const preview = await workbook.render({ sheetName, range, scale: 1.5, format: "png" });
  await fs.writeFile(`../${fileName}`, new Uint8Array(await preview.arrayBuffer()));
}
