# Matriz análise → pacote → arquivo externo

Referência da skill de curadoria. A estante dos arquivos que o aluno abre no Excel
ou importa na CatalyseR é `ATIVIDADES/dados/`, e ela guarda **apenas `.xlsx`**.
O **EAPADados** continua sendo a cópia canônica, documentada e curada para uso no R.
Quando o mesmo conjunto existe nos dois lugares, os dois arquivos são intencionais:
o pacote atende o código e o arquivo externo permite que o aluno pratique
importação e preparo.

| Análise na CatalyseR | Conjunto canônico no EAPADados | Arquivo externo para importar | Situação |
|---|---|---|---|
| Preparar dados: limpeza, tipos e transformações | `treino_coletas`; `treino_desembarque` | [preparar_dados_treino.xlsx](../../../dados/preparar_dados_treino.xlsx) | Arquivo único reunindo as planilhas de treino da IDE (Trilha de Preparo, Calcular, Arrumar e Contingência). **Sintético de propósito**: cada imperfeição foi plantada para exercitar um tratamento, porque dado real não concentra todas ao mesmo tempo. É o aquecimento do menu, de uso temporário; as atividades avaliadas usam dado real. Ver `provisorios/preparar_dados_treino/origem.md`. |
| Estatística descritiva, histograma e boxplot | `biometria_caranguejos` | A criar | Falta arquivo externo de teste. |
| Frequência, pizza e barras | `captura_petrechos` | A criar | Falta arquivo externo de teste. |
| Dispersão, correlação e regressão linear simples | `camarao_vannamei_biometria` | [regressao_otolito_comprimento.xlsx](../../../dados/regressao_otolito_comprimento.xlsx) · [versão reduzida](../../../dados/regressao_otolito_comprimento_reduzido.xlsx) | Arquivo externo real aprovado: raio do otólito × comprimento, 6.320 linhas, 855 peixes e 51 espécies. Atividade #9 consolidada; exige colapsar as leituras de anulo e filtrar uma espécie. A versão **reduzida** (281 peixes, uma linha por peixe, 8 espécies com n ≥ 30) serve quando o objetivo é praticar só a regressão; dentro de cada espécie o R² vai de 0,17 a 0,91, e juntá-las derruba para 0,10. |
| Linhas e série de capturas | `captura_pescada_amarela` | A criar | Falta arquivo externo de teste. |
| Regressão não linear | `cangulo_crescimento`; `tilapia_crescimento` | A criar | Escolher um conjunto canônico para o teste da IDE. |
| Regressão logística | A definir | A criar | Falta conjunto canônico no pacote. |
| Regressão linear múltipla | `truta_riacho_crescimento`; `tilapia_microalgas` | [mercurio_lago_escravo.xlsx](../../../dados/mercurio_lago_escravo.xlsx) | Arquivo externo real aprovado (Dryad, CC0) e **distinto do pacote**: 258 peixes de 13 espécies, com Hg no músculo, idade, tamanho e δ15N. Atividade #10 consolidada. O canônico do pacote segue sendo a truta, usada no livro/IDE. |
| Teste *t* | `artemia` | A criar | Falta pareamento externo aprovado. |
| ANOVA de um fator | `isoproteica_bagre` | [anova_tilapia_anestesia.xlsx](../../../dados/anova_tilapia_anestesia.xlsx) | Arquivo externo real aprovado: 36 peixes, três tratamentos e resposta em tempo de anestesia. O conjunto canônico do pacote continua distinto. Atividade #8 consolidada. |
| ANOVA de dois fatores | `salvelino_formalina_remocao` | [salvelino_formalina_remocao.xlsx](../../../dados/salvelino_formalina_remocao.xlsx) | Par equivalente confirmado: 30 × 7. |
| Leitura de experimento fatorial | `gammarus_dieta_temperatura_resumo` | [gammarus_dieta_temperatura_resumo.xlsx](../../../dados/gammarus_dieta_temperatura_resumo.xlsx) | Par equivalente confirmado: 12 × 11. É um **resumo** por combinação de tratamentos (média, DP e n = 4): sustenta gráficos e interpretação, não o recálculo da ANOVA. Atividade #7 consolidada. |
| ANCOVA | `bagley_lwr_central_america` | A criar | Falta arquivo externo de teste. |
| Qui-quadrado de independência | `lagostas_kelp_sexo` | Banco externo: bagres do Madeira | A atividade usa dados externos distintos; o arquivo local ainda não foi incorporado. |
| Mann–Whitney | `darter_ontario` | [darter_ontario.xlsx](../../../dados/darter_ontario.xlsx) | Par equivalente confirmado: 54 × 3; a planilha preserva cabeçalhos originais. |
| Mann–Whitney, segundo contexto | `darter_ontario` | [truta_touro_manejo.xlsx](../../../dados/truta_touro_manejo.xlsx) | Atividade externa distinta, mantida para variar o contexto. |
| Wilcoxon pareado | `idades_savel_repetibilidade` | [otolitos_salmonete.xlsx](../../../dados/otolitos_salmonete.xlsx) | Atividade externa distinta, mantida para partir da base bruta. |
| Kruskal–Wallis | `cpue_tubarao` | [esturjao_palido.xlsx](../../../dados/esturjao_palido.xlsx) | Atividade externa distinta. |
| PCA | `peixes_nutricao_portugal`; `peixes_morfometria_multivariada` | A criar | Escolher um conjunto canônico e exportar a planilha. |
| Agrupamentos (HCA) | `morfometria_barbo`; `brine_carbonatos` | A criar | Escolher um conjunto canônico e exportar a planilha. |
| Heatmap | `recifes_ostras_heatmap` | A criar | Falta arquivo externo de teste. |
| Mapa coroplético | `aquicultura_br` | A criar | Falta arquivo externo de teste. |
| Mapas de pontos e bolhas | `estacoes_ictiofauna` | A criar | Um mesmo arquivo externo pode atender os dois mapas. |
| Séries temporais | `captura_pescada_amarela` | A criar | Falta arquivo externo de teste. |
| Distribuições normal e binomial | Não se aplica | Não se aplica | São visualizadores conceituais, sem planilha. |

## Regra para completar a matriz

1. Escolha **um** dataset canônico do EAPADados para a análise.
2. Salve o arquivo externo em `ATIVIDADES/dados/`, **sempre em `.xlsx`** — é o único
   formato da pasta. Um `.csv` de origem deve ser convertido, não arquivado ali.
3. Preserve os cabeçalhos e as pequenas imperfeições que o aluno deve reconhecer e
   arrumar; o objeto do pacote é a versão curada.
4. Registre o par nesta tabela e crie o handout a partir de
   [`_MOLDE_atividade.md`](../../../_MOLDE_atividade.md) quando ele se tornar uma
   atividade avaliada.

Assim, a CatalyseR pode ser testada pela importação do arquivo externo e o
EAPADados pelo dataset canônico, sem que um substitua o outro.
