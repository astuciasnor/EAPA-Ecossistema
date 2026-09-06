# Atividades & Avaliação — o pilar de aprendizagem ativa do EAPA

Este é o **quarto ponto do ecossistema EAPA**: a **avaliação dos alunos por
aprendizagem ativa**. Enquanto a CatalyseR ensina a análise (do mouse ao código) e o
livro documenta, aqui o aluno percorre o caminho completo **sozinho, com dados reais** —
do dado bruto ao relatório — e é avaliado por rubrica.

## Como se encaixa no ecossistema

| Peça | Papel |
|------|-------|
| **CatalyseR** | a ferramenta: o aluno importa, arruma e analisa na IDE. |
| **EAPADados / banco externo** | os dados: conjuntos reais; as atividades usam o **banco externo** (CSV ou Excel), distinto dos exemplos embutidos no pacote. |
| **Livro EAPA** | a referência: teoria e exemplos guiados. |
| **Atividades & Avaliação** (esta pasta) | a avaliação: o aluno aplica tudo de forma autônoma. |

## Princípios

1. **Dados reais, no banco externo.** Cada atividade usa um conjunto real entregue como
   **arquivo tabular (CSV ou Excel)** no banco externo — o aluno **importa e arruma** (tidy) por conta
   própria, como num projeto de verdade (dado de pesquisa real raramente vem pronto num
   pacote). Um mesmo conjunto pode existir também no pacote como **exemplo** do livro/IDE,
   mas a **atividade sempre parte do Excel externo**, nunca de `data()`.
2. **Percurso completo.** O aluno faz importação → preparação (seleção, agrupamento,
   limpeza) → análise → **relatório** com interpretação. A tabela/estrutura final
   **não vem pronta**; construí-la é parte da avaliação.
3. **Autonomia com critério.** Toda decisão de preparo (excluir espécie, agrupar
   categorias) precisa ser **justificada** no relatório — não se agrupa para "dar
   significativo".
4. **Avaliação por rubrica.** Notas por critérios explícitos (preparo, execução,
   interpretação, comunicação, pensamento crítico), não só pelo "resultado certo".
5. **Contexto de pesca e aquicultura** em todos os enunciados.

## Como funciona (fluxo do aluno)

1. Recebe o **handout** da atividade (enunciado + pergunta + critérios).
2. Acessa o **conjunto no banco externo** (Excel) e o importa na CatalyseR/RStudio.
3. Prepara os dados, executa a análise e produz um **relatório** conforme os itens pedidos.
4. É avaliado pela **rubrica** da atividade.

## Como adicionar uma atividade (crescer = adicionar uma entrada)

1. Copie `_MOLDE_atividade.md` para `atividade_<tema>_<analise>.md`.
2. Preencha os campos entre `<...>` e ajuste a rubrica.
3. Coloque os dados da atividade no **banco externo** (arquivo CSV ou Excel em `dados/`), para o
   aluno importar e arrumar. O mesmo conjunto pode existir no pacote como exemplo, mas a
   atividade parte sempre do Excel.
4. Registre a atividade no índice abaixo.

## Índice de atividades

| # | Atividade | Análise | Dataset · origem | Nível |
|---|-----------|---------|------------------|-------|
| 1 | [Dieta dos grandes bagres amazônicos](atividade_qui2_dieta_bagres.md) | Qui-quadrado de independência | Bagres do Madeira (Röpke; CC BY 4.0) · banco externo | Introdutório |
| 2 | [Estrutura etária da percina-do-canal](atividade_mannwhitney_darter_ontario.md) | Mann–Whitney | `dados/darter_ontario.xlsx` (FSAdata; GPL) · banco externo | Introdutório |
| 3 | [Tamanho da truta-touro e manejo](atividade_mannwhitney_truta_touro_manejo.md) | Mann–Whitney | `dados/truta_touro_manejo.xlsx` (FSAdata; GPL) · banco externo | Introdutório–intermediário |
| 4 | [Dois métodos de leitura de otólito](atividade_wilcoxon_otolitos.md) | Wilcoxon pareado | `dados/otolitos_salmonete.xlsx` (FSAdata MulletBS; GPL) · banco externo | Introdutório–intermediário |
| 5 | [Tamanho de esturjões em quatro regiões](atividade_kruskal_esturjao_palido.md) | Kruskal–Wallis (+ Holm) | `dados/esturjao_palido.xlsx` (FSAdata Pallid; GPL) · banco externo | Introdutório–intermediário |
| 6 | [Formalina e remoção semanal no salvelino](atividade_anova_dois_fatores_salvelino_formalina.md) | ANOVA a dois fatores (interação) | `dados/salvelino_formalina_remocao.csv` (Olk et al.; DataverseNO; CC BY 4.0) · banco externo | Intermediário |
| 7 | [Dieta e temperatura em Gammarus](atividade_interpretacao_fatorial_gammarus.md) | Gráficos e interpretação de experimento fatorial | `dados/gammarus_dieta_temperatura_resumo.csv` (Ribes-Navarro et al.; Frontiers; CC BY) · banco externo | Introdutório–intermediário |

## Atividades reservadas (triagem inicial)

Estas atividades foram desmembradas de abas ainda nao incorporadas ao EAPADados. Sao rascunhos didaticos: revisar fonte, licenca e rubrica antes de distribuicao publica. Para não misturá-las às cinco atividades consolidadas, os enunciados e planilhas ficam em `_preliminares/`.

| Atividade | Analise | Dados | Situacao |
|---|---|---|---|
| [Teste t de uma amostra: pesos de bezerros](_preliminares/atividade_t_uma_amostra_bezerros.md) | Teste t (uma amostra) | [_preliminares/dados/bezerros_amostra_unica.xlsx](_preliminares/dados/bezerros_amostra_unica.xlsx) | Fonte interna a rastrear |
| [Teste t independente: pesos por raca](_preliminares/atividade_t_independente_bezerros_racas.md) | Teste t independente | [_preliminares/dados/bezerros_racas.xlsx](_preliminares/dados/bezerros_racas.xlsx) | Fonte interna a rastrear |
| [ANOVA: peso por racao](_preliminares/atividade_anova_racao_quatro_niveis.md) | ANOVA (um fator) | [_preliminares/dados/racao_quatro_niveis.xlsx](_preliminares/dados/racao_quatro_niveis.xlsx) | Fonte interna a rastrear |
| [ANOVA: produtividade de tilapia](_preliminares/atividade_anova_cultivo_tilapia.md) | ANOVA (um fator) | [_preliminares/dados/cultivo_tilapia_produtividade.xlsx](_preliminares/dados/cultivo_tilapia_produtividade.xlsx) | Fonte interna a rastrear |
| [ANOVA: densidade de estocagem](_preliminares/atividade_anova_densidade_tilapia.md) | ANOVA (um fator) | [_preliminares/dados/densidade_tilapia_taxa.xlsx](_preliminares/dados/densidade_tilapia_taxa.xlsx) | Fonte interna a rastrear |
| [DBC: suplemento e repeticao](_preliminares/atividade_dbc_leite_tuberculo.md) | ANOVA em blocos | [_preliminares/dados/leite_tuberculo_dbc.xlsx](_preliminares/dados/leite_tuberculo_dbc.xlsx) | Fonte interna a rastrear |
| [Amostragem estratificada de lagosta](_preliminares/atividade_amostragem_estratificada_lagosta.md) | Amostragem estratificada | [_preliminares/dados/amostragem_estratificada_lagosta.xlsx](_preliminares/dados/amostragem_estratificada_lagosta.xlsx) | Fonte interna a rastrear |
| [Delineamento inteiramente casualizado](_preliminares/atividade_delineamento_dic_tanques.md) | Delineamento (DIC) | [_preliminares/dados/delineamento_dic_tanques.xlsx](_preliminares/dados/delineamento_dic_tanques.xlsx) | Fonte interna a rastrear |
| [Demonstracao do TLC](_preliminares/atividade_tlc_demonstracao.md) | Distribuicao amostral / TLC | [_preliminares/dados/demonstracao_tlc.xlsx](_preliminares/dados/demonstracao_tlc.xlsx) | Fonte interna a rastrear |
| [ANOVA: resposta de pulgoes](_preliminares/atividade_anova_pulgoes.md) | ANOVA (um fator) | [_preliminares/dados/pulgoes_tratamentos.xlsx](_preliminares/dados/pulgoes_tratamentos.xlsx) | Fonte interna a rastrear |
| [Teste t pareado: placebo e droga](_preliminares/atividade_t_pareado_cvf.md) | Teste t pareado | [_preliminares/dados/cvf_pareado.xlsx](_preliminares/dados/cvf_pareado.xlsx) | Fonte interna a rastrear |
| [Teste t independente: creatinina](_preliminares/atividade_t_independente_ira.md) | Teste t independente | [_preliminares/dados/ira_creatinina.xlsx](_preliminares/dados/ira_creatinina.xlsx) | Fonte interna a rastrear |
| [Qui-quadrado: larvas e variedades de banana](_preliminares/atividade_qui2_banana_larvas.md) | Qui-quadrado | [_preliminares/dados/banana_larvas_qui2.xlsx](_preliminares/dados/banana_larvas_qui2.xlsx) | Fonte interna a rastrear |
| [ANOVA: densidade de moscas](_preliminares/atividade_anova_moscas.md) | ANOVA (um fator) | [_preliminares/dados/moscas_vegetacao_densidade.xlsx](_preliminares/dados/moscas_vegetacao_densidade.xlsx) | Fonte interna a rastrear |
| [Regressao: asa e idade de pardais](_preliminares/atividade_regressao_pardais.md) | Regressao / correlacao | [_preliminares/dados/pardais_asa_idade.xlsx](_preliminares/dados/pardais_asa_idade.xlsx) | Fonte interna a rastrear |
