# Inventário — Análises da CatalyseR × dados no EAPADados × atividades

Cruza o **catálogo de análises da IDE** com (a) se há **dataset no EAPADados** servindo de
exemplo e qual, e (b) se já existe **atividade** no pilar de avaliação (`atividades/`).
Legenda: ✅ tem · ⚠️ parcial/a confirmar · ❌ não/teórico.

## Descrição e exploração

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Estatística descritiva | ✅ geral | vários (ex.: `tilapia_crescimento`, `biometria_caranguejos`) | ❌ |
| Tabela de frequência | ✅ geral | ex.: `captura_petrechos` | ❌ |
| Histograma | ✅ geral | qualquer numérico | ❌ |
| Boxplot | ✅ geral | qualquer numérico × grupo | ❌ |
| Gráfico de pizza | ✅ geral | qualquer categórica | ❌ |
| Dispersão | ✅ | `camarao_vannamei_biometria` | ❌ |
| Linhas | ✅ | `captura_pescada_amarela` (série) | ❌ |
| Barras | ✅ geral | — | ❌ |

## Regressão

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Correlação (Pearson/Spearman) *(candidato v1)* | ✅ | `morfometria_barbo` (mesmo par da regressão) | ❌ |
| Descobrir o modelo | ✅ usa vários | — | ❌ |
| Linear simples | ✅ | **`morfometria_barbo`** (canônico); `crabs_morfometria`; `cangulo_crescimento` | ✅ **#9 otólito × comprimento** |
| Logística | ⚠️ a confirmar | sem dataset dedicado claro | ❌ |
| Não linear (crescimento: von Bertalanffy etc.) | ✅ | `cangulo_crescimento`; `tilapia_crescimento` | ❌ |
| Linear múltipla *(em dev)* | ✅ | `truta_riacho_crescimento`; `tilapia_microalgas` | ✅ **#10 mercúrio (Great Slave Lake)** |

**Canônico da regressão linear simples: `morfometria_barbo`** (15/09/2026). Recorte
de *Barbus petenyi* (Bánó & Takács, 2022; CC BY 4.0), 100 indivíduos em cinco
populações de 20, **sem valor ausente**. O par canônico é
`comprimento_cabeca ~ distancia_pre_peitoral`: R² = 0,897, Shapiro *p* = 0,44,
Breusch-Pagan *p* = 0,43, sem curvatura (*p* = 0,63), Cook máximo 0,10. É o
**único** conjunto do pacote que passa os três testes ao mesmo tempo. As cinco
populações cobrem faixas de comprimento **sobrepostas** (27–36 mm), então agrupar
não confunde tamanho com grupo — ao contrário do camarão. *Atenção:* as medidas já
foram corrigidas alometricamente pelo comprimento padrão, então a inclinação
descreve associação entre medidas de forma, não crescimento.

**`crabs_morfometria` foi avaliado e não adotado** (15/09/2026), apesar de ter duas
categorias balanceadas de 100 (`forma_cor`) e retas com R² de 0,985 e 0,980: o
Shapiro rejeita no modelo global (*p* = 0,0009) e dentro do grupo laranja
(*p* = 0,0016), e há curvatura na laranja (*p* = 0,013). Fica como conjunto de
amostragem e como alternativa para comparar **retas por grupo**.

**`camarao_vannamei_biometria` não é canônico da regressão** e serve de exemplo de
**diagnóstico e influência**: `lm(peso_g ~ comprimento_cm)` tem R² = 0,899 com
Shapiro *p* = 8,3 × 10⁻⁶, Cook máximo 1,38 (limite 4/n = 0,024), lacuna entre 9 e
10 cm e origem confundida com o tamanho (o viveiro acadêmico cobre só
7,25–9,00 cm). É o caso que ensina quando **não** usar a reta.

## Testes paramétricos

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Teste t | ⚠️ a confirmar canônico | candidatos: `artemia`; `captura_pescada_amarela` | ❌ |
| ANOVA (um fator) | ✅ | `isoproteica_bagre` | ✅ **#8 anestesia da tilápia** |
| ANOVA (dois fatores) | ✅ | `salvelino_formalina_remocao` | ✅ **#6 formalina e remoção** |
| ANCOVA | ✅ | `bagley_lwr_central_america` | ❌ |

## Testes não paramétricos

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Qui-quadrado (independência) | ✅ | `camaroes_sexo`; `lagostas_kelp_sexo` | ✅ **#1 dieta dos bagres** |
| Mann–Whitney | ✅ | `darter_ontario` | ✅ **#2 darter · #3 truta-touro** |
| Wilcoxon pareado | ✅ | `idades_savel_repetibilidade` | ✅ **#4 otólitos salmonete** |
| Kruskal–Wallis | ✅ | `cpue_tubarao` | ✅ **#5 esturjão-pálido** |

## Multivariada

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| PCA | ✅ | `peixes_nutricao_portugal`; `peixes_morfometria_multivariada`; `cabritos_fa_coltro`; `brine_carbonatos`; `pinguins` | ❌ |
| HCA (agrupamentos) | ✅ | `morfometria_barbo`; `brine_carbonatos`; `cabritos_fa_coltro`; `pinguins` | ❌ |
| Heatmap | ✅ | `recifes_ostras_heatmap` | ❌ |

## Mapas

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Coroplético | ✅ | `aquicultura_br` | ❌ |
| Pontos/estações | ✅ | `estacoes_ictiofauna` | ❌ |
| Bolhas proporcionais | ✅ | `estacoes_ictiofauna` | ❌ |

## Séries temporais

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Séries temporais | ✅ | `cpue_tubarao` (provisório); `captura_pescada_amarela` | ❌ |

## Probabilidades / Laboratório de Conceitos

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Distribuição normal | ❌ teórico | — | ❌ |
| Distribuição binomial | ❌ teórico | — | ❌ |

## Candidatos v1 (ainda sem canônico)

| Análise (IDE) | Dataset no EAPADados? | Nome do dataset | Atividade? |
|---|---|---|---|
| Normalidade (Shapiro-Wilk) + QQ-plot | ⚠️ a definir | — | ❌ |
| Qui-quadrado de aderência (razão 1:1) | ⚠️ a definir | `lagostas_kelp_sexo` serve p/ 1:1 | ❌ |
| Intervalo de confiança (média/proporção) | ❌ teórico/geral | — | ❌ |
| Teste de proporções (prop.test) | ⚠️ a definir | — | ❌ |

---

## Pares pacote ↔ banco externo conferidos

A atividade sempre preserva seu arquivo externo, mesmo quando o conjunto também
está no EAPADados: importar e arrumar fazem parte da aprendizagem. A duplicação
só é removível quando se tratar de cópia técnica, nunca deste par didático.

| Atividade | Dataset no EAPADados | Conferência |
|---|---|---|
| Mann–Whitney: percina-do-canal | `darter_ontario` | Mesmo conteúdo (54 × 3); a planilha mantém os nomes originais `age`, `tl`, `river`. |
| ANOVA dois fatores: salvelino | `salvelino_formalina_remocao` | Mesmo conteúdo (30 × 7); XLSX externo e objeto curado diferem apenas na tipagem de fatores. |
| Fatorial: Gammarus | `gammarus_dieta_temperatura_resumo` | Mesmo conteúdo (12 × 11); XLSX externo e objeto curado diferem apenas na tipagem de `dieta`. |
| Múltipla: mercúrio do Great Slave Lake | Não está no pacote | Conjunto **distinto** do EAPADados (Dryad, CC0): 258 peixes de 13 espécies, com Hg, idade, tamanho e isótopos. A truta-de-riacho (`truta_riacho_crescimento`) segue apenas como exemplo canônico do pacote. |
| Demais quatro atividades consolidadas | Dataset canônico da análise, mas não o mesmo arquivo | Permanecem como bases externas distintas; não são cópias a apagar. |

## Leitura rápida

- **Atividades hoje (10):** cobrem qui-quadrado, Mann–Whitney, Wilcoxon, Kruskal–Wallis, ANOVA de um fator, ANOVA de dois fatores, leitura de experimento fatorial, regressão linear simples e regressão linear múltipla. Descrição, teste t, ANCOVA, multivariada, mapas e séries ainda não têm atividade consolidada.
- **Dataset no pacote — convenção "1 canônico por teste":** Kruskal=`cpue_tubarao` · qui-quadrado=`lagostas_kelp_sexo` · Mann–Whitney=`darter_ontario` · Wilcoxon=`idades_savel_repetibilidade` · ANCOVA=`bagley_lwr_central_america`.
- **Lacunas de dataset a fechar:** teste t (definir o canônico), regressão logística, correlação, e os candidatos v1 (normalidade, proporções).
- **Próximas atividades naturais:** ANCOVA (já tem `bagley` no pacote → dá um Excel externo distinto), regressão não linear (crescimento), PCA/HCA e teste t — cada uma sai do molde.

## Atividades reservadas (triagem inicial)

Estas atividades foram desmembradas de abas ainda nao incorporadas ao EAPADados. Sao rascunhos didaticos: revisar fonte, licenca e rubrica antes de distribuicao publica. Os enunciados e dados preliminares ficam em `_preliminares/`.

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
