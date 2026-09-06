# Conjuntos enxutos para ANOVA a dois fatores

Este material reúne duas versões reduzidas de estudos reais em aquicultura. Os nomes das variáveis foram traduzidos e padronizados para o EAPADados; títulos de artigos e referências permanecem no idioma original.

## 1. `salvelino_formalina_remocao`

**Arquivo:** `salvelino_formalina_remocao.csv`  
**Uso sugerido:** conjunto principal do EAPADados para ANOVA fatorial 2 x 2.  
**Formato:** longo; 30 linhas, uma por unidade experimental (compartimento/plot).  
**Natureza dos dados:** dados observados, reduzidos do arquivo original `Data.csv` (apenas o registro final de cada unidade experimental).

### Contexto do estudo

O experimento avaliou a sobrevivência de ovos de salvelino-do-Ártico (*Salvelinus alpinus*) em incubatório sob dois tratamentos: aplicação de formalina antes do estágio de ovo embrionado e remoção manual semanal de ovos mortos durante o estágio embrionado. A formalina foi aplicada a 380 ppm por aproximadamente 13 minutos, três vezes por semana. O desenho é fatorial 2 x 2. A distribuição de unidades pelos quatro tratamentos é desigual no arquivo original e foi preservada nesta versão.

### Pergunta didática

Em que medida a formalina, a remoção semanal de ovos mortos e a interação entre ambas se associam à sobrevivência até a eclosão?

### Variável resposta recomendada

`sobrevivencia_eclosao_pct`: proporção de ovos que eclodiram em relação ao número inicial de ovos, em porcentagem.

### Dicionário de variáveis

| Variável | Tipo | Descrição |
|---|---|---|
| `unidade_experimental` | caractere | Identificador do compartimento experimental original. |
| `formalin` | fator | Aplicação prévia de formalina: `sem` ou `com`. |
| `remocao_semanal` | fator | Remoção manual semanal de ovos mortos: `sem` ou `com`. |
| `ovos_iniciais` | inteiro | Número de ovos no início do acompanhamento da unidade experimental. |
| `ovos_eclodidos` | inteiro | Número acumulado de ovos eclodidos. |
| `mortalidade_total` | inteiro | Número acumulado de ovos mortos. |
| `sobrevivencia_eclosao_pct` | numérico | `100 × ovos_eclodidos / ovos_iniciais`. |

### Cuidados analíticos

O número de ovos iniciais varia entre unidades. Os autores transformaram a proporção acumulada de eclosão por arco-seno da raiz quadrada antes da ANOVA a dois fatores. Para uma análise inferencial aplicada à pesquisa, o desfecho também pode ser abordado como uma proporção de contagens, com avaliação de um modelo binomial. No EAPADados, este conjunto é útil para ensinar a estrutura da ANOVA a dois fatores, sua interação e a verificação de pressupostos.

### Fonte e referência

Dados: Olk, T. R.; Lydersen, E.; Wollebæk, J. (2023). *Replication data for: Formalin treatments before eyeing and hand-picking of Arctic charr (Salvelinus alpinus) eggs – re-evaluating the timing of antifungal treatments*. DataverseNO. https://doi.org/10.23642/usn.7334573. Licença CC BY 4.0.

Artigo: Olk, T. R.; Wollebæk, J.; Lydersen, E. (2019). *Formalin treatments before eyeing and hand-picking of Arctic charr (Salvelinus alpinus) eggs; re-evaluating the timing of antifungal treatments*. **VANN**, 54(1), 21–32.

## 2. `gammarus_dieta_temperatura_resumo`

**Arquivo:** `gammarus_dieta_temperatura_resumo.csv`  
**Uso sugerido:** atividade autônoma para leitura de um experimento fatorial 3 x 4, gráficos e interpretação de efeitos principais/interação.  
**Formato:** resumo por combinação de tratamentos; uma linha por dieta × temperatura.  
**Natureza dos dados:** valores reais publicados (média, desvio-padrão e `n = 4`) na Tabela 1 do artigo. Não são observações individuais.

### Contexto do estudo

Juvenis do anfípode marinho *Gammarus locusta* foram cultivados durante 21 dias em quatro temperaturas (5, 10, 15 e 20 °C) e receberam três dietas: *Fucus* spp., folhas de cenoura ou polpa de coco. Cada combinação teve quatro recipientes experimentais, inicialmente com 20 organismos. Foram avaliadas sobrevivência, biomassa, comprimento final e taxa de crescimento específico.

### Pergunta didática

Como dieta e temperatura se relacionam com o desempenho de *G. locusta* e há evidência de que o efeito de uma dieta depende da temperatura?

### Dicionário de variáveis

| Variável | Tipo | Descrição |
|---|---|---|
| `dieta` | fator | Dieta oferecida: *Fucus*, folhas de cenoura ou polpa de coco. |
| `temperatura_c` | numérico/fator | Temperatura de cultivo (°C): 5, 10, 15 ou 20. |
| `n_repeticoes` | inteiro | Número de recipientes por combinação de tratamentos. |
| `sobrevivencia_media_pct`, `sobrevivencia_dp_pct` | numérico | Média e desvio-padrão da sobrevivência (%). |
| `biomassa_media_mg`, `biomassa_dp_mg` | numérico | Média e desvio-padrão da biomassa total (mg). |
| `comprimento_final_medio_mm`, `comprimento_final_dp_mm` | numérico | Média e desvio-padrão do comprimento total final (mm). |
| `taxa_crescimento_especifica_media_pct_dia`, `taxa_crescimento_especifica_dp_pct_dia` | numérico | Média e desvio-padrão da taxa de crescimento específico (% dia⁻¹). |

### Limite importante de uso

Este arquivo não deve ser usado para recalcular ANOVA, testes de pressupostos ou pós-hoc: o artigo disponibiliza os valores agregados, não as quatro observações de cada combinação. Ele é inteiramente composto de resultados reais e é adequado para construir gráficos de médias com dispersão, discutir o delineamento e interpretar a ANOVA reportada pelos autores. Para executar uma ANOVA pelos alunos, será necessário localizar os dados por repetição ou adotar explicitamente uma base simulada/reconstruída — o que não está incluído aqui.

### Resultados que ajudam na discussão

No artigo, sobrevivência foi afetada por dieta e temperatura, sem interação; a biomassa apresentou interação dieta × temperatura. A dieta com polpa de coco teve menor desempenho de sobrevivência e biomassa.

### Fonte e referência

Ribes-Navarro, A.; Alberts-Hubatsch, H.; Monroig, Ó.; Hontoria, F.; Navarro, J. C. (2022). *Effects of diet and temperature on the fatty acid composition of the gammarid Gammarus locusta fed alternative terrestrial feeds*. **Frontiers in Marine Science**, 9, 931991. https://doi.org/10.3389/fmars.2022.931991. Dados transcritos da Tabela 1 do artigo aberto.

## Sugestão de carregamento no R

```r
library(readr)

salvelino_formalina_remocao <- read_csv("salvelino_formalina_remocao.csv")
gammarus_dieta_temperatura_resumo <- read_csv("gammarus_dieta_temperatura_resumo.csv")
```
