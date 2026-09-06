import fs from "node:fs/promises";

const activitiesDir = "D:/Claude/eapa/atividades";
const entries = [
  ["Teste t de uma amostra: pesos de bezerros", "atividade_t_uma_amostra_bezerros.md", "bezerros_amostra_unica.xlsx", "Teste t (uma amostra)"],
  ["Teste t independente: pesos por raca", "atividade_t_independente_bezerros_racas.md", "bezerros_racas.xlsx", "Teste t independente"],
  ["ANOVA: peso por racao", "atividade_anova_racao_quatro_niveis.md", "racao_quatro_niveis.xlsx", "ANOVA (um fator)"],
  ["ANOVA: produtividade de tilapia", "atividade_anova_cultivo_tilapia.md", "cultivo_tilapia_produtividade.xlsx", "ANOVA (um fator)"],
  ["ANOVA: densidade de estocagem", "atividade_anova_densidade_tilapia.md", "densidade_tilapia_taxa.xlsx", "ANOVA (um fator)"],
  ["DBC: suplemento e repeticao", "atividade_dbc_leite_tuberculo.md", "leite_tuberculo_dbc.xlsx", "ANOVA em blocos"],
  ["Amostragem estratificada de lagosta", "atividade_amostragem_estratificada_lagosta.md", "amostragem_estratificada_lagosta.xlsx", "Amostragem estratificada"],
  ["Delineamento inteiramente casualizado", "atividade_delineamento_dic_tanques.md", "delineamento_dic_tanques.xlsx", "Delineamento (DIC)"],
  ["Demonstracao do TLC", "atividade_tlc_demonstracao.md", "demonstracao_tlc.xlsx", "Distribuicao amostral / TLC"],
  ["ANOVA: resposta de pulgoes", "atividade_anova_pulgoes.md", "pulgoes_tratamentos.xlsx", "ANOVA (um fator)"],
  ["Teste t pareado: placebo e droga", "atividade_t_pareado_cvf.md", "cvf_pareado.xlsx", "Teste t pareado"],
  ["Teste t independente: creatinina", "atividade_t_independente_ira.md", "ira_creatinina.xlsx", "Teste t independente"],
  ["Qui-quadrado: larvas e variedades de banana", "atividade_qui2_banana_larvas.md", "banana_larvas_qui2.xlsx", "Qui-quadrado"],
  ["ANOVA: densidade de moscas", "atividade_anova_moscas.md", "moscas_vegetacao_densidade.xlsx", "ANOVA (um fator)"],
  ["Regressao: asa e idade de pardais", "atividade_regressao_pardais.md", "pardais_asa_idade.xlsx", "Regressao / correlacao"],
];
const marker = "## Atividades reservadas (triagem inicial)";
const table = entries.map(([title, handout, data, analysis]) => `| [${title}](${handout}) | ${analysis} | [dados/${data}](dados/${data}) | Fonte interna a rastrear |`).join("\n");
const section = `\n\n${marker}\n\nEstas atividades foram desmembradas de abas ainda nao incorporadas ao EAPADados. Sao rascunhos didaticos: revisar fonte, licenca e rubrica antes de distribuicao publica.\n\n| Atividade | Analise | Dados | Situacao |\n|---|---|---|---|\n${table}\n`;

for (const fileName of ["README.md", "INVENTARIO_analises_dados_atividades.md"]) {
  const path = `${activitiesDir}/${fileName}`;
  const content = await fs.readFile(path, "utf8");
  if (content.includes(marker)) throw new Error(`Indice ja contem a secao provisoria: ${fileName}`);
  await fs.writeFile(path, `${content.trimEnd()}${section}`, "utf8");
}
console.log(`Indices atualizados com ${entries.length} atividades.`);
