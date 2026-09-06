import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const input = await FileBlob.load("../../../dados_organizados_limpos_para_pacote_aulas.xlsx");
const workbook = await SpreadsheetFile.importXlsx(input);
const data = await workbook.inspect({
  kind: "table,thread",
  sheetId: "idades_savel_repetibilidade",
  range: "A1:H54",
  maxChars: 11000,
  tableMaxRows: 8,
  tableMaxCols: 8,
});
const info = await workbook.inspect({
  kind: "table",
  sheetId: "info_conjuntos",
  range: "A13:X13",
  maxChars: 7000,
  tableMaxRows: 1,
  tableMaxCols: 24,
});
const errors = await workbook.inspect({
  kind: "match",
  searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
  options: { useRegex: true, maxResults: 100 },
  maxChars: 3000,
});
console.log(data.ndjson);
console.log(info.ndjson);
console.log(errors.ndjson);
const preview = await workbook.render({
  sheetName: "idades_savel_repetibilidade",
  range: "A1:H22",
  scale: 1.5,
  format: "png",
});
await fs.writeFile("../idades_savel_final.png", new Uint8Array(await preview.arrayBuffer()));
