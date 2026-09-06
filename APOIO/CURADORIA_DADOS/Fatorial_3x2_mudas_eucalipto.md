# Experimento fatorial 3 × 2 em delineamento inteiramente casualizado

**Tema:** Desenvolvimento de mudas de eucalipto em função do tipo de recipiente e da espécie — reestruturação dos dados e análise da interação.

**Contexto de uso:** material didático da disciplina de Estatística Aplicada à Pesca e Aquicultura (EAPA) — FEPESCA/IECOS/UFPA, Campus Bragança. Dados do exemplo clássico de Banzatto & Kronka (1995).

**Instrução para a IA que receber este arquivo:** o problema deve ser tratado em R. Este documento fornece o enunciado, a estrutura experimental, o dicionário de variáveis, os dados em formato *tidy*, o modelo, as hipóteses e os resultados de referência (ANOVA, desdobramento e Tukey já calculados) para conferência. Não é necessário reproduzir código pronto no documento; o objetivo é orientar a análise e permitir validar os valores numéricos.

---

## 1. Contextualização do problema

Um viveiro florestal precisa decidir, simultaneamente, **em que tipo de recipiente** produzir suas mudas e **qual espécie** de eucalipto cultivar. Como as duas decisões serão tomadas ao mesmo tempo, não basta saber qual recipiente é melhor *em média* nem qual espécie cresce mais *em média*: interessa saber se o melhor recipiente **depende** da espécie escolhida. Essa dependência entre fatores é o que se denomina **interação**, e é a razão pela qual o experimento foi montado em esquema fatorial.

Instalou-se um experimento em **delineamento inteiramente casualizado (DIC)** com **esquema fatorial 3 × 2**: três tipos de recipiente e duas espécies de eucalipto, com **quatro repetições** por combinação, totalizando **24 unidades experimentais**. A variável resposta é a **altura média das mudas (cm), aos 80 dias de idade**.

> **Pergunta de pesquisa.** O efeito do tipo de recipiente sobre a altura das mudas aos 80 dias é o mesmo para as duas espécies de eucalipto? Havendo interação, qual a melhor combinação recipiente × espécie?

---

## 2. Estrutura do experimento

| Fator | Código | Nível | Descrição |
|---|---|---|---|
| **Recipiente** (fator A, 3 níveis) | R1 | Saco plástico pequeno | Menor volume de substrato |
| | R2 | Saco plástico grande | Maior volume de substrato |
| | R3 | Laminado | Recipiente rígido de lâminas |
| **Espécie** (fator B, 2 níveis) | E1 | *Eucalyptus citriodora* | Espécie 1 |
| | E2 | *Eucalyptus grandis* | Espécie 2 |

- **Delineamento:** inteiramente casualizado (DIC) — as 24 unidades experimentais são homogêneas e os tratamentos foram sorteados livremente entre elas.
- **Esquema de tratamentos:** fatorial 3 × 2 ⇒ 6 tratamentos (combinações RiEj).
- **Repetições:** r = 4 por tratamento ⇒ N = 3 × 2 × 4 = 24.
- **Unidade experimental:** um recipiente com mudas; **unidade de observação:** a altura média das mudas daquele recipiente.
- **Variável resposta:** altura média das mudas (cm), aos 80 dias de idade.

---

## 3. Dicionário de variáveis

Conjunto de dados: `mudas_eucalipto_tidy.csv`.

| Variável | Tipo | Valores admissíveis | Papel na análise |
|---|---|---|---|
| `ue` | Inteiro | 1 a 24 | Identificador da unidade experimental |
| `recipiente` | Qualitativa nominal (fator) | `R1`, `R2`, `R3` | Fator A — efeito principal |
| `recipiente_desc` | Texto | Saco pequeno; saco grande; laminado | Rótulo descritivo do fator A |
| `especie` | Qualitativa nominal (fator) | `E1`, `E2` | Fator B — efeito principal |
| `especie_desc` | Texto | *E. citriodora*; *E. grandis* | Rótulo descritivo do fator B |
| `repeticao` | Inteiro | 1 a 4 | Identifica a repetição dentro do tratamento |
| `altura_cm` | Quantitativa contínua | ℝ⁺ (cm) | **Variável resposta** |

> **Por que reestruturar?** A tabela original está em formato **largo** (cada espécie em um bloco de colunas, cada recipiente em um bloco de linhas). Esse arranjo é compacto para leitura humana, mas não é aceito diretamente por rotinas de análise: nele, uma mesma coluna mistura observações de tratamentos diferentes e os níveis dos fatores ficam implícitos na posição da célula. No formato **tidy**, *cada linha é uma observação* e *cada coluna é uma variável*: os fatores tornam-se colunas explícitas e a análise passa a ser escrita diretamente como `altura_cm ~ recipiente * especie`.

---

## 4. Dados em formato *tidy*

Altura média das mudas (cm) aos 80 dias — 24 observações em formato longo. (As colunas descritivas `recipiente_desc` e `especie_desc` constam do arquivo e foram omitidas abaixo por concisão.)

| ue | recipiente | especie | repeticao | altura_cm |
|---:|---|---|---:|---:|
| 1 | R1 | E1 | 1 | 26,2 |
| 2 | R1 | E1 | 2 | 26,0 |
| 3 | R1 | E1 | 3 | 25,0 |
| 4 | R1 | E1 | 4 | 25,4 |
| 5 | R1 | E2 | 1 | 24,8 |
| 6 | R1 | E2 | 2 | 24,6 |
| 7 | R1 | E2 | 3 | 26,7 |
| 8 | R1 | E2 | 4 | 25,2 |
| 9 | R2 | E1 | 1 | 25,7 |
| 10 | R2 | E1 | 2 | 26,3 |
| 11 | R2 | E1 | 3 | 25,1 |
| 12 | R2 | E1 | 4 | 26,4 |
| 13 | R2 | E2 | 1 | 19,6 |
| 14 | R2 | E2 | 2 | 21,1 |
| 15 | R2 | E2 | 3 | 19,0 |
| 16 | R2 | E2 | 4 | 18,6 |
| 17 | R3 | E1 | 1 | 22,8 |
| 18 | R3 | E1 | 2 | 19,4 |
| 19 | R3 | E1 | 3 | 18,8 |
| 20 | R3 | E1 | 4 | 19,2 |
| 21 | R3 | E2 | 1 | 19,8 |
| 22 | R3 | E2 | 2 | 21,4 |
| 23 | R3 | E2 | 3 | 22,8 |
| 24 | R3 | E2 | 4 | 21,3 |

---

## 5. Tabela de médias

Médias das combinações e médias marginais (cm), com desvios-padrão entre parênteses.

| Recipiente | E1 (*citriodora*) | E2 (*grandis*) | Média do recipiente |
|---|---:|---:|---:|
| R1 — saco pequeno | 25,650 (0,551) | 25,325 (0,950) | **25,488** |
| R2 — saco grande | 25,875 (0,602) | 19,575 (1,097) | **22,725** |
| R3 — laminado | 20,050 (1,850) | 21,325 (1,226) | **20,688** |
| **Média da espécie** | **23,858** | **22,075** | **22,967** |

A leitura das médias já antecipa o resultado central: no recipiente R2 a espécie E1 supera E2 em mais de 6 cm; em R3 a ordem se **inverte**; e em R1 as duas espécies praticamente se equivalem. Perfis que se cruzam são a assinatura gráfica da interação.

---

## 6. Modelo estatístico e hipóteses

Modelo do fatorial 3 × 2 em DIC, com efeitos fixos:

$$y_{ijk} = \mu + \alpha_i + \beta_j + (\alpha\beta)_{ij} + \varepsilon_{ijk}$$

com $i = 1,2,3$ (recipientes), $j = 1,2$ (espécies) e $k = 1,\dots,4$ (repetições), em que:

- $y_{ijk}$ — altura média (cm) observada na $k$-ésima repetição da combinação $R_iE_j$;
- $\mu$ — média geral;
- $\alpha_i$ — efeito do $i$-ésimo recipiente (fator A);
- $\beta_j$ — efeito da $j$-ésima espécie (fator B);
- $(\alpha\beta)_{ij}$ — efeito da interação entre recipiente e espécie;
- $\varepsilon_{ijk} \sim \mathcal{N}(0,\sigma^2)$, independentes — erro experimental.

**Hipóteses testadas**

1. **Interação (teste prioritário):** $H_0: (\alpha\beta)_{ij} = 0\ \forall\, i,j$ versus $H_1: (\alpha\beta)_{ij} \neq 0$ para algum par $(i,j)$.
2. **Efeito principal de recipientes:** $H_0: \alpha_1 = \alpha_2 = \alpha_3 = 0$.
3. **Efeito principal de espécies:** $H_0: \beta_1 = \beta_2 = 0$.

> **Ordem de leitura da ANOVA.** A interação é examinada **primeiro**. Se for significativa, os efeitos principais perdem interpretação autônoma — afirmar que "E1 é superior a E2" seria falso para R3 — e a análise deve prosseguir pelo **desdobramento** (estudo de um fator dentro de cada nível do outro). Somente quando a interação **não** é significativa faz sentido interpretar as médias marginais.

---

## 7. Quadro da análise de variância (resultados de referência)

ANOVA do fatorial 3 × 2 em DIC (α = 0,05).

| Fonte de variação | GL | SQ | QM | F | valor-p |
|---|---:|---:|---:|---:|---|
| Recipientes (A) | 2 | 92,8608 | 46,4304 | 36,20 | < 0,0001 |
| Espécies (B) | 1 | 19,0817 | 19,0817 | 14,88 | 0,0012 |
| **Interação A × B** | **2** | **63,7608** | **31,8804** | **24,85** | **< 0,0001** |
| Resíduo | 18 | 23,0900 | 1,2828 | | |
| **Total** | **23** | **198,7933** | | | |

Média geral = 22,967 cm • CV = 4,93% • F_tab(2; 18; 0,05) = 3,55 • F_tab(1; 18; 0,05) = 4,41.

A interação recipiente × espécie é altamente significativa (F = 24,85; p < 0,0001). Portanto, os efeitos principais **não** devem ser interpretados isoladamente: passa-se ao desdobramento. O CV de 4,93% indica excelente precisão experimental.

---

## 8. Desdobramento da interação (resultados de referência)

### 8.1 Espécies dentro de cada recipiente

| Fonte de variação | GL | SQ | QM | F | valor-p |
|---|---:|---:|---:|---:|---|
| Espécies dentro de R1 | 1 | 0,2113 | 0,2113 | 0,16 | 0,6897 (ns) |
| Espécies dentro de R2 | 1 | 79,3800 | 79,3800 | 61,88 | < 0,0001 |
| Espécies dentro de R3 | 1 | 3,2513 | 3,2513 | 2,54 | 0,1288 (ns) |
| Resíduo | 18 | 23,0900 | 1,2828 | | |

Conferência: 0,2113 + 79,3800 + 3,2513 = 82,8425 = SQ_Espécies + SQ_Interação = 19,0817 + 63,7608.

As espécies diferem **apenas** no saco plástico grande (R2), onde *E. citriodora* (25,875 cm) supera *E. grandis* (19,575 cm). Nos demais recipientes as duas espécies apresentam desempenho estatisticamente equivalente.

### 8.2 Recipientes dentro de cada espécie

| Fonte de variação | GL | SQ | QM | F | valor-p |
|---|---:|---:|---:|---:|---|
| Recipientes dentro de E1 | 2 | 87,1217 | 43,5608 | 33,96 | < 0,0001 |
| Recipientes dentro de E2 | 2 | 69,5000 | 34,7500 | 27,09 | < 0,0001 |
| Resíduo | 18 | 23,0900 | 1,2828 | | |

Ambos os desdobramentos são significativos; aplica-se o teste de Tukey entre os três recipientes, separadamente para cada espécie:

$$\Delta_{\text{Tukey}} = q_{(3;18;0,05)}\sqrt{\text{QM}_{\text{res}}/r} = 3,609 \times \sqrt{1,2828/4} = 2,044\ \text{cm}$$

### 8.3 Comparação de médias pelo teste de Tukey a 5%

| Recipiente | E1 — *citriodora* | E2 — *grandis* |
|---|---|---|
| R1 — saco plástico pequeno | 25,650 **a** | 25,325 **a** |
| R2 — saco plástico grande | 25,875 **a** | 19,575 **b** |
| R3 — laminado | 20,050 **b** | 21,325 **b** |

Médias seguidas da mesma letra, na coluna, não diferem entre si pelo teste de Tukey a 5% de probabilidade.

---

## 9. Interpretação e recomendação

1. **Há interação significativa** entre recipiente e espécie (p < 0,0001): o desempenho relativo dos recipientes **depende** da espécie cultivada. Interpretar apenas as médias marginais levaria a conclusão equivocada.
2. **Para *E. citriodora* (E1)**, os sacos plásticos — pequeno ou grande — são equivalentes entre si e superiores ao laminado.
3. **Para *E. grandis* (E2)**, apenas o saco plástico pequeno se destaca; o saco grande e o laminado não diferem entre si e produzem mudas mais baixas.
4. **Recomendação prática:** se o viveiro trabalha com as duas espécies e deseja um único recipiente, o **saco plástico pequeno (R1)** é a escolha robusta — é o único que figura no grupo superior para ambas as espécies, com a vantagem adicional de menor consumo de substrato.

---

## 10. Nota metodológica sobre o desdobramento

Ao analisar cada fator dentro de subconjuntos, o quadrado médio do resíduo é recalculado com menos graus de liberdade. Para manter o $\text{QM}_{\text{res}}$ e os 18 GL da análise global — procedimento recomendado — os testes F de cada efeito devem usar o **quadrado médio do resíduo global**, isto é, $F = \text{QM}_{\text{efeito}} / \text{QM}_{\text{res, global}}$, como foi feito nas Seções 8.1 e 8.2. Esse é o ponto em que uma implementação ingênua costuma divergir dos valores de referência acima.

---

## Referência

BANZATTO, D. A.; KRONKA, S. N. **Experimentação agrícola**. 3. ed. Jaboticabal: FUNEP, 1995.

---

*Documento preparado para a disciplina de Estatística Aplicada (EAPA) — FEPESCA/IECOS/UFPA, Campus Bragança.*
