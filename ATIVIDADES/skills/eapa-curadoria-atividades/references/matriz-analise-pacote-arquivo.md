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
| Dispersão, correlação e regressão linear simples | **`morfometria_barbo`** | [regressao_otolito_comprimento.xlsx](../../../dados/regressao_otolito_comprimento.xlsx) · [versão reduzida](../../../dados/regressao_otolito_comprimento_reduzido.xlsx) | **Canônico definido em 15/09/2026.** `morfometria_barbo` (Bánó & Takács, 2022; CC BY 4.0): 100 indivíduos de *Barbus petenyi* em cinco populações de 20, sem NA. Par canônico `comprimento_cabeca ~ distancia_pre_peitoral`: R² = 0,897, Shapiro *p* = 0,44, Breusch-Pagan *p* = 0,43, sem curvatura (*p* = 0,63), Cook máximo 0,10 — o **único** conjunto do pacote que passa os três testes ao mesmo tempo, com faixas de comprimento sobrepostas (27–36 mm). As medidas já são corrigidas pelo comprimento padrão, então a inclinação é associação entre medidas de forma, não crescimento. **Falta o arquivo externo** para a IDE. O arquivo externo da atividade #9 é o do otólito (raio × comprimento, 6.320 linhas, 855 peixes, 51 espécies), que exige colapsar leituras de anulo e filtrar uma espécie; a versão **reduzida** (281 peixes, uma linha por peixe, 8 espécies com n ≥ 30) serve quando o objetivo é praticar só a regressão. |
| Regressão linear simples, retas por grupo | `crabs_morfometria` | A criar | Avaliado para canônico e **não adotado** em 15/09/2026: o Shapiro rejeita no modelo global (*p* = 0,0009) e no grupo laranja (*p* = 0,0016), com curvatura na laranja (*p* = 0,013). Como tem duas categorias balanceadas de 100 (`forma_cor`) e retas com R² de 0,985 e 0,980, serve para comparar **retas por grupo**. |
| Regressão linear simples, caso de diagnóstico | `camarao_vannamei_biometria` | A criar | **Não é canônico.** Fica como exemplo de diagnóstico e influência: `peso_g ~ comprimento_cm` tem R² = 0,899, Shapiro *p* = 8,3 × 10⁻⁶, Cook máximo 1,38 (limite 4/n = 0,024), lacuna entre 9 e 10 cm e origem confundida com o tamanho (viveiro acadêmico só de 7,25 a 9,00 cm). Ensina quando **não** usar a reta. |
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
