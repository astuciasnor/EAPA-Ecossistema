import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const input = await FileBlob.load("../../../dados_organizados_limpos_para_pacote_aulas.xlsx");
const workbook = await SpreadsheetFile.importXlsx(input);
const preview = await workbook.render({
  sheetName: "info_conjuntos",
  range: "A10:X13",
  scale: 1.25,
  format: "png",
});
await fs.writeFile("../info_conjuntos_antes_savel.png", new Uint8Array(await preview.arrayBuffer()));
const inspect = await workbook.inspect({
  kind: "sheet,table",
  sheetId: "info_conjuntos",
  range: "A10:X13",
  maxChars: 7000,
  tableMaxRows: 4,
  tableMaxCols: 24,
});
console.log(inspect.ndjson);
