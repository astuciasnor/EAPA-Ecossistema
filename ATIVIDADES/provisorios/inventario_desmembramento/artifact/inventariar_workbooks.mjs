import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile } from "@oai/artifact-tool";

const sources = [
  "D:/Claude/eapa/EAPADados/CURADORIA_DADOS/fontes_containers_originais/brutos.xlsx",
  "D:/Claude/eapa/EAPADados/CURADORIA_DADOS/fontes_containers_originais/aulas_bioestatistica_ORIGINAL.xlsx",
  "D:/Claude/eapa/EAPADados/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx",
];
const outputPath = "../inventario_abas_fontes.json";

function asText(value) {
  if (value === null || value === undefined) return "";
  if (value instanceof Date) return value.toISOString().slice(0, 10);
  return String(value).replace(/\s+/g, " ").trim();
}

const inventory = [];
for (const sourcePath of sources) {
  try {
    console.log(`LENDO ${sourcePath}`);
    const file = await FileBlob.load(sourcePath);
    const workbook = await SpreadsheetFile.importXlsx(file);
    const sheets = Array.from(workbook.worksheets);
    for (let index = 0; index < sheets.length; index += 1) {
      const sheet = sheets[index];
      const used = sheet.getUsedRange();
      const values = used ? used.values : [];
      const preview = values.slice(0, 8).map((row) => row.slice(0, 12).map(asText));
      inventory.push({
        source_file: sourcePath,
        sheet_index: index + 1,
        sheet_name: sheet.name,
        used_range: used ? used.address : null,
        rows: values.length,
        columns: values[0]?.length ?? 0,
        preview,
      });
    }
  } catch (error) {
    inventory.push({ source_file: sourcePath, error: error instanceof Error ? error.message : String(error) });
  }
}
await fs.writeFile(outputPath, `${JSON.stringify(inventory, null, 2)}\n`, "utf8");
console.log(JSON.stringify(inventory, null, 2));
