import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const activitiesDir = "D:/Claude/eapa/atividades";
const previewDir = "../previews_atividades_reservadas";
const created = JSON.parse(await fs.readFile("../desmembramento_criado.json", "utf8"));
await fs.mkdir(previewDir, { recursive: true });
const results = [];
for (const item of created) {
  const workbookPath = `${activitiesDir}/dados/${item.data}`;
  const handoutPath = `${activitiesDir}/${item.handout}`;
  const [file, handout] = await Promise.all([FileBlob.load(workbookPath), fs.readFile(handoutPath, "utf8")]);
  const workbook = await SpreadsheetFile.importXlsx(file);
  const sheet = workbook.worksheets.getItem("Dados");
  const used = sheet.getUsedRange().values;
  const errors = await workbook.inspect({
    kind: "match",
    searchTerm: "#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A",
    options: { useRegex: true, maxResults: 50 },
    maxChars: 1000,
  });
  const preview = await workbook.render({ sheetName: "Dados", range: sheet.getUsedRange().address, scale: 1, format: "png" });
  const previewName = item.data.replace(/\.xlsx$/i, ".png");
  await fs.writeFile(`${previewDir}/${previewName}`, new Uint8Array(await preview.arrayBuffer()));
  results.push({
    data: item.data,
    handout: item.handout,
    rows_expected: item.rows,
    rows_found: used.length,
    columns_expected: item.columns,
    columns_found: used[0]?.length ?? 0,
    handout_links_data: handout.includes(`dados/${item.data}`),
    formula_errors: errors.ndjson.includes("Cell search matched 0 entries.") ? 0 : 1,
  });
}
await fs.writeFile("../validacao_atividades_reservadas.json", `${JSON.stringify(results, null, 2)}\n`, "utf8");
console.log(JSON.stringify(results, null, 2));
