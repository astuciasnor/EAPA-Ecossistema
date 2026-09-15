import fs from "node:fs/promises";
import { FileBlob, SpreadsheetFile, Workbook } from "@oai/artifact-tool";

const sourcePath = "D:/Claude/eapa/EAPADados/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx";
const activitiesDir = "D:/Claude/eapa/atividades";
const dataDir = `${activitiesDir}/dados`;

const candidates = [
  { sheet: "1_bezerro_1am", data: "bezerros_amostra_unica.xlsx", handout: "atividade_t_uma_amostra_bezerros.md", title: "Peso de bezerros em uma amostra", context: "Pesos de bezerros observados em uma unica amostra.", analysis: "Estatistica descritiva e teste t de uma amostra", question: "Como a distribuicao dos pesos dos bezerros se comporta em relacao a um valor de referencia definido no enunciado pelo professor?", tasks: "Calcule estatisticas descritivas, avalie normalidade e defina/justifique o valor de referencia antes de aplicar o teste t de uma amostra." },
  { sheet: "2_bezero_2am", data: "bezerros_racas.xlsx", handout: "atividade_t_independente_bezerros_racas.md", title: "Peso de bezerros por raca", context: "Pesos de bezerros de duas racas, Gu zera e Gir.", analysis: "Teste t para duas amostras independentes", question: "Os pesos dos bezerros diferem entre as duas racas registradas na base?", tasks: "Identifique grupos, avalie distribuicao e variancias, aplique o teste t adequado e interprete tamanho de efeito e intervalo de confianca." },
  { sheet: "4_raca_isop", data: "racao_quatro_niveis.xlsx", handout: "atividade_anova_racao_quatro_niveis.md", title: "Peso por tipo de racao", context: "Peso observado em quatro tipos de racao.", analysis: "ANOVA de um fator", question: "O peso difere entre os tipos de racao A a D?", tasks: "Verifique n por racao, explore os residuos, aplique ANOVA e Tukey quando apropriado; compare tambem medias e tamanho de efeito." },
  { sheet: "5_cult_tilapia", data: "cultivo_tilapia_produtividade.xlsx", handout: "atividade_anova_cultivo_tilapia.md", title: "Produtividade por sistema de cultivo de tilapia", context: "Produtividade observada em sistemas de cultivo de tilapia.", analysis: "ANOVA de um fator", question: "A produtividade difere entre os sistemas de cultivo registrados?", tasks: "Descreva os grupos, construa grafico comparativo, avalie pressupostos e aplique ANOVA seguida de comparacoes quando justificadas." },
  { sheet: "7_dens_tilap", data: "densidade_tilapia_taxa.xlsx", handout: "atividade_anova_densidade_tilapia.md", title: "Taxa por densidade de estocagem", context: "Taxa observada sob diferentes densidades de estocagem.", analysis: "ANOVA de um fator", question: "A taxa observada difere entre as densidades de estocagem?", tasks: "Organize os grupos, compare medias e dispersoes, avalie pressupostos e relate a ANOVA e o pos-teste pertinente." },
  { sheet: "11_leite_tuber", data: "leite_tuberculo_dbc.xlsx", handout: "atividade_dbc_leite_tuberculo.md", title: "Resposta por suplemento em blocos", context: "Resposta observada por tratamento com repeticoes que podem atuar como blocos.", analysis: "Delineamento em blocos casualizados", question: "O tratamento altera a resposta apos considerar a repeticao como bloco?", tasks: "Identifique tratamento e bloco, justifique o delineamento, ajuste ANOVA em blocos e interprete o efeito de tratamento e de bloco." },
  { sheet: "12_caixa_lagosta", data: "amostragem_estratificada_lagosta.xlsx", handout: "atividade_amostragem_estratificada_lagosta.md", title: "Amostragem estratificada de caixas de lagosta", context: "Estratos de caixas com tamanhos populacionais e amostrais distintos.", analysis: "Amostragem estratificada", question: "Como avaliar a distribuicao amostral entre os estratos de caixas de lagosta?", tasks: "Identifique estrato, tamanho populacional e amostral; calcule fracoes de amostragem e discuta alocacao e representatividade." },
  { sheet: "13_amost_dic", data: "delineamento_dic_tanques.xlsx", handout: "atividade_delineamento_dic_tanques.md", title: "Croqui de delineamento inteiramente casualizado", context: "Atribuicao de tratamentos e repeticoes a tanques.", analysis: "Planejamento experimental (DIC)", question: "O croqui representa repeticoes e tratamentos de forma compatível com um DIC?", tasks: "Decodifique tratamento e repeticao, construa o croqui, verifique balanceamento e descreva como uma resposta futura seria analisada." },
  { sheet: "15_demo_tlc", data: "demonstracao_tlc.xlsx", handout: "atividade_tlc_demonstracao.md", title: "Demonstracao do teorema do limite central", context: "Amostra numerica para explorar distribuicao e comportamento de medias amostrais.", analysis: "Distribuicao amostral e teorema do limite central", question: "Como a distribuicao das medias amostrais se comporta a partir desta variavel?", tasks: "Descreva a variavel, simule reamostragens com tamanhos definidos, compare distribuicoes de medias e discuta o TLC." },
  { sheet: "16_pulgoes", data: "pulgoes_tratamentos.xlsx", handout: "atividade_anova_pulgoes.md", title: "Resposta de pulgoes por tratamento", context: "Resposta registrada sob diferentes tratamentos.", analysis: "ANOVA de um fator", question: "A resposta difere entre os tratamentos aplicados?", tasks: "Construa tabela descritiva e grafico, avalie pressupostos, aplique ANOVA e interprete comparacoes multiplas quando cabiveis." },
  { sheet: "19_cvf", data: "cvf_pareado.xlsx", handout: "atividade_t_pareado_cvf.md", title: "Placebo versus droga nos mesmos pacientes", context: "Respostas de placebo e droga medidas nos mesmos pacientes.", analysis: "Teste t pareado", question: "A resposta difere entre placebo e droga para os mesmos pacientes?", tasks: "Confirme o pareamento por paciente, crie as diferencas, examine sua distribuicao e aplique o teste t pareado com intervalo de confianca." },
  { sheet: "20_ira", data: "ira_creatinina.xlsx", handout: "atividade_t_independente_ira.md", title: "Creatinina por grupo", context: "Creatinina observada em dois grupos identificados por IRA.", analysis: "Teste t para duas amostras independentes", question: "A creatinina difere entre os grupos S e C?", tasks: "Identifique os grupos, avalie distribuicao e variancias, escolha Student ou Welch e interprete diferenca, IC e tamanho de efeito." },
  { sheet: "21_banana_larva_chi2", data: "banana_larvas_qui2.xlsx", handout: "atividade_qui2_banana_larvas.md", title: "Larvas por variedade de banana", context: "Contagens de ocorrencia de larvas em tres variedades de banana.", analysis: "Qui-quadrado de independencia", question: "A ocorrencia de larvas esta associada a variedade de banana?", tasks: "Organize a tabela de contingencia, verifique frequencias esperadas, aplique qui-quadrado ou alternativa adequada e interprete V de Cramer." },
  { sheet: "22_moscas", data: "moscas_vegetacao_densidade.xlsx", handout: "atividade_anova_moscas.md", title: "Densidade de moscas por tipo de vegetacao", context: "Densidade de moscas observada em tipos de vegetacao.", analysis: "ANOVA de um fator", question: "A densidade de moscas difere entre os tipos de vegetacao?", tasks: "Descreva grupos e resposta, produza grafico, avalie pressupostos, aplique ANOVA e discuta a interpretacao ecologica." },
  { sheet: "23_pardais", data: "pardais_asa_idade.xlsx", handout: "atividade_regressao_pardais.md", title: "Comprimento da asa e idade de pardais", context: "Medidas de comprimento da asa associadas a idade de pardais.", analysis: "Regressao linear e correlacao", question: "Ha associacao entre idade e comprimento da asa dos pardais?", tasks: "Identifique as colunas analiticas, construa grafico de dispersao, ajuste regressao, avalie residuos e interprete inclinacao, R2 e limitacoes." },
];

function cellMatrixTrim(values) {
  let lastRow = -1;
  let lastColumn = -1;
  for (let row = 0; row < values.length; row += 1) {
    for (let column = 0; column < (values[row]?.length ?? 0); column += 1) {
      const value = values[row][column];
      if (value !== null && value !== undefined && value !== "") {
        lastRow = Math.max(lastRow, row);
        lastColumn = Math.max(lastColumn, column);
      }
    }
  }
  if (lastRow < 0 || lastColumn < 0) return [["sem_dados"]];
  return values.slice(0, lastRow + 1).map((row) => Array.from({ length: lastColumn + 1 }, (_, index) => row[index] ?? null));
}

function handout(meta) {
  const dataLink = `dados/${meta.data}`;
  return `# Atividade autonoma - ${meta.title}\n\n**Dados:** [${meta.data}](${dataLink})\n\n**Origem interna:** aba \`${meta.sheet}\` de \`dados_brutos_eapadados.xlsx\`.\n\n**Situacao da fonte:** conjunto reservado para atividade. A procedencia bibliografica/licenca especifica desta aba ainda precisa ser rastreada antes de qualquer redistribuicao publica.\n\n**Analise-alvo:** ${meta.analysis}.\n\n## Contexto\n\n${meta.context}\n\n## Problema de pesquisa\n\nInvestigue: **${meta.question}**\n\n> A estrutura final de analise deve ser conferida e preparada pelo estudante antes da aplicacao do procedimento estatistico.\n\n## Etapas\n\n1. Importe o arquivo [${meta.data}](${dataLink}) e identifique a unidade observacional, as variaveis e os possiveis valores ausentes ou inconsistentes.\n2. Documente qualquer recodificacao, filtro ou reorganizacao necessaria.\n3. ${meta.tasks}\n4. Produza graficos e tabelas adequados antes de concluir.\n\n## Produto esperado\n\n- pergunta de pesquisa e justificativa da analise;\n- preparo dos dados e verificacoes realizadas;\n- estatisticas descritivas e grafico adequado;\n- resultado da analise, com medida de efeito quando aplicavel;\n- interpretacao no contexto e limitacoes do conjunto.\n\n## Questoes para discussao\n\n- Qual e a unidade observacional e quais sao as principais limitacoes do delineamento?\n- A diferenca ou associacao observada pode ser interpretada como causal?\n- Como tamanho amostral, variabilidade e possiveis dados ausentes afetam a conclusao?\n\n## Observacoes ao professor\n\nHandout inicial gerado a partir do indice do arquivo conteiner. Revisar contexto, fonte e rubrica antes de uso avaliativo formal.\n`;
}

const blob = await FileBlob.load(sourcePath);
const sourceWorkbook = await SpreadsheetFile.importXlsx(blob);
await fs.mkdir(dataDir, { recursive: true });
const created = [];
for (const meta of candidates) {
  const sourceSheet = sourceWorkbook.worksheets.getItem(meta.sheet);
  const matrix = cellMatrixTrim(sourceSheet.getUsedRange().values);
  const targetData = `${dataDir}/${meta.data}`;
  const targetHandout = `${activitiesDir}/${meta.handout}`;
  try {
    await fs.access(targetData);
    throw new Error(`Arquivo ja existe: ${targetData}`);
  } catch (error) {
    if (error?.code !== "ENOENT") throw error;
  }
  try {
    await fs.access(targetHandout);
    throw new Error(`Arquivo ja existe: ${targetHandout}`);
  } catch (error) {
    if (error?.code !== "ENOENT") throw error;
  }
  const workbook = Workbook.create();
  const sheet = workbook.worksheets.add("Dados");
  sheet.getRangeByIndexes(0, 0, matrix.length, matrix[0].length).values = matrix;
  sheet.showGridLines = false;
  sheet.freezePanes.freezeRows(1);
  sheet.getRangeByIndexes(0, 0, 1, matrix[0].length).format = { fill: "#0F5F7A", font: { bold: true, color: "#FFFFFF" }, wrapText: true };
  sheet.getRangeByIndexes(0, 0, matrix.length, matrix[0].length).format.autofitColumns();
  sheet.getRangeByIndexes(0, 0, matrix.length, matrix[0].length).format.autofitRows();
  const output = await SpreadsheetFile.exportXlsx(workbook);
  await output.save(targetData);
  await fs.writeFile(targetHandout, handout(meta), "utf8");
  created.push({ sheet: meta.sheet, data: meta.data, handout: meta.handout, rows: matrix.length, columns: matrix[0].length });
}

await fs.writeFile("../desmembramento_criado.json", `${JSON.stringify(created, null, 2)}\n`, "utf8");
console.log(JSON.stringify(created, null, 2));
