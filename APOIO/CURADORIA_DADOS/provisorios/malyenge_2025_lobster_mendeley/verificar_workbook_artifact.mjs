import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const workbookPath = "../../dados_organizados_limpos_para_pacote_aulas.xlsx";
const input = await FileBlob.load(workbookPath);
const workbook = await SpreadsheetFile.importXlsx(input);

const sheetSummary = await workbook.inspect({
  kind: "sheet",
  include: "id,name",
  maxChars: 4000,
});
console.log(sheetSummary.ndjson);

const tableCheck = await workbook.inspect({
  kind: "region",
  sheetId: "lagosta_namibia1",
  range: "A1:R12",
  maxChars: 6000,
  tableMaxRows: 12,
  tableMaxCols: 18,
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
  sheetName: "lagosta_namibia1",
  range: "A1:R20",
  scale: 1,
  format: "png",
});
await fs.writeFile(
  "lagosta_namibia1_preview.png",
  new Uint8Array(await preview.arrayBuffer()),
);
