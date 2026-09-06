import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const activitiesDir = "D:/Claude/eapa/atividades";
const created = JSON.parse(await fs.readFile("../desmembramento_criado.json", "utf8"));
for (const item of created) {
  const path = `${activitiesDir}/dados/${item.data}`;
  const file = await FileBlob.load(path);
  const workbook = await SpreadsheetFile.importXlsx(file);
  const sheet = workbook.worksheets.getItem("Dados");
  const used = sheet.getUsedRange();
  const headers = used.values[0] ?? [];
  for (let column = 0; column < headers.length; column += 1) {
    const header = String(headers[column] ?? "");
    const width = Math.max(15, Math.min(28, header.length + 3));
    sheet.getRangeByIndexes(0, column, used.values.length, 1).format.columnWidth = width;
  }
  const output = await SpreadsheetFile.exportXlsx(workbook);
  await output.save(path);
}
console.log(`Larguras ajustadas em ${created.length} arquivos.`);
