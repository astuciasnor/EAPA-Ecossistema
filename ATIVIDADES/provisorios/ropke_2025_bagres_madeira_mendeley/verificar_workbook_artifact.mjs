import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const input = await FileBlob.load("../../dados_organizados_limpos_para_pacote_aulas.xlsx");
const workbook = await SpreadsheetFile.importXlsx(input);

const sheetSummary = await workbook.inspect({
  kind: "sheet",
  include: "id,name",
  maxChars: 5000,
});
console.log(sheetSummary.ndjson);

const tableCheck = await workbook.inspect({
  kind: "region",
  sheetId: "bagres_dieta_madeira1",
  range: "A1:Y16",
  maxChars: 7000,
  tableMaxRows: 16,
  tableMaxCols: 25,
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
  sheetName: "bagres_dieta_madeira1",
  range: "A1:Y20",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  "bagres_dieta_madeira1_preview.png",
  new Uint8Array(await preview.arrayBuffer()),
);
