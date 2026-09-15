import fs from "node:fs";
import path from "node:path";

const packageRoot = "D:/Claude/eapa/EAPADados";
const destinationDir = path.join(packageRoot, "CURADORIA_DADOS", "fontes_containers_originais");
const rawFiles = [
  path.join(packageRoot, "brutos.xlsx"),
  path.join(packageRoot, "data-raw", "aulas_bioestatistica_ORIGINAL.xlsx"),
  path.join(packageRoot, "data-raw", "dados_brutos_eapadados.xlsx"),
];
const oldReference = "data-raw/dados_brutos_eapadados.xlsx";
const newReference = "CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx";
const referenceFiles = [
  "data-raw/aquicultura_br.R",
  "data-raw/treino_desembarque.R",
  "data-raw/treino_coletas.R",
  "data-raw/sst_costa_norte.R",
  "data-raw/preparar_dados.R",
  "data-raw/ocorrencias_peixes.R",
  "data-raw/estacoes_ictiofauna.R",
  "data-raw/cpue_tubarao.R",
  "R/data_artemia.R",
  "man/artemia.Rd",
];

for (const file of rawFiles) {
  if (!fs.existsSync(file)) throw new Error(`Fonte ausente: ${file}`);
  if (fs.existsSync(path.join(destinationDir, path.basename(file)))) {
    throw new Error(`Destino ja existe: ${path.join(destinationDir, path.basename(file))}`);
  }
}

const replacements = referenceFiles.map((relative) => {
  const file = path.join(packageRoot, relative);
  const original = fs.readFileSync(file, "utf8");
  if (!original.includes(oldReference)) throw new Error(`Referencia esperada ausente: ${file}`);
  return { file, original, updated: original.split(oldReference).join(newReference) };
});

fs.mkdirSync(destinationDir, { recursive: true });
const moved = [];
try {
  for (const source of rawFiles) {
    const target = path.join(destinationDir, path.basename(source));
    fs.renameSync(source, target);
    moved.push({ source, target });
  }
  for (const replacement of replacements) fs.writeFileSync(replacement.file, replacement.updated, "utf8");

  fs.writeFileSync(
    path.join(destinationDir, "README.md"),
    `# Contêineres originais de dados\n\n` +
      `Esta pasta centraliza os arquivos-fonte históricos usados na curadoria do EAPADados. ` +
      `Eles não são conjuntos prontos para distribuição: contêm múltiplas abas, versões anteriores e material de trabalho.\n\n` +
      `- \`brutos.xlsx\`: contêiner histórico inicial.\n` +
      `- \`aulas_bioestatistica_ORIGINAL.xlsx\`: planilha original de aulas, preservada sem alterações.\n` +
      `- \`dados_brutos_eapadados.xlsx\`: fonte consolidada ainda lida pelos scripts em \`data-raw/\`.\n\n` +
      `Os scripts que usam a fonte consolidada devem referenciá-la a partir da raiz do pacote como ` +
      `\`${newReference}\`.\n`,
    "utf8",
  );
} catch (error) {
  for (const replacement of replacements) fs.writeFileSync(replacement.file, replacement.original, "utf8");
  for (const entry of moved.reverse()) {
    if (fs.existsSync(entry.target) && !fs.existsSync(entry.source)) fs.renameSync(entry.target, entry.source);
  }
  throw error;
}

console.log(JSON.stringify({ destinationDir, moved: moved.map(({ target }) => target), updatedReferences: referenceFiles }, null, 2));
