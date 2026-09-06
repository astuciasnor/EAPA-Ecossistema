import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const input = await FileBlob.load("../../dados_organizados_limpos_para_pacote_aulas_com_darter_ontario.xlsx");
const workbook = await SpreadsheetFile.importXlsx(input);

const sheetSummary = await workbook.inspect({
  kind: "sheet",
  include: "id,name",
  maxChars: 6000,
});
console.log(sheetSummary.ndjson);

const tableCheck = await workbook.inspect({
  kind: "region",
  sheetId: "darter_ontario1",
  range: "A1:D20",
  maxChars: 4000,
  tableMaxRows: 20,
  tableMaxCols: 4,
});
console.log(tableCheck.ndjson);

const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  summary: "final formula error scan",
});
console.log(errors.ndjson);

const preview = await workbook.render({
  sheetName: "darter_ontario1",
  range: "A1:D20",
  scale: 1,
  format: "png",
});
await fs.writeFile("darter_ontario1_preview.png", new Uint8Array(await preview.arrayBuffer()));
