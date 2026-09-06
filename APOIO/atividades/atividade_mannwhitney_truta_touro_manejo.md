# Atividade autônoma — Teste de Mann–Whitney

## O tamanho das trutas-touro mudou após alterações no manejo pesqueiro?

**Dataset:** `truta_touro_manejo` — 137 trutas-touro (*Salvelinus confluentus*) de lagos de Alberta, Canadá, em dois períodos (`1977-79` e `2001`); cada linha é um peixe.
**Fonte / licença:** digitalizado (~) da Fig. 2 de Parker et al. (2007), N. Am. J. Fish. Manag. 27:848–859; pacote `FSAdata` (GPL-2 | GPL-3). Valores aproximados, não medições de campo.
**Onde estão os dados:** banco externo da disciplina — `dados/truta_touro_manejo.xlsx` (colunas originais `fl`, `mass`, `era`). Importe o arquivo e arrume no formato *tidy*.
**Habilidades avaliadas:** classificação de variáveis; estatística descritiva por grupo; escolha e execução de teste não paramétrico; leitura de forma/dispersão/assimetria; distinção associação × causalidade; comunicação.
**Nível / tempo estimado:** introdutório–intermediário · 2–3 h.

---

### Contexto

Populações de truta-touro são sensíveis à exploração pesqueira porque apresentam crescimento relativamente lento, maturação tardia e populações geralmente pequenas. Em determinados lagos de Alberta, foram adotadas medidas mais restritivas (nos anos 1990) para reduzir a mortalidade causada pela pesca recreativa. O conjunto reúne peixes amostrados em **1977–1979** e em **2001**.

### Questão central

A distribuição do comprimento furcal das trutas-touro foi diferente em 2001 quando comparada ao período de 1977–1979?

Hipóteses:

- **H₀:** a distribuição do comprimento furcal é a mesma nos dois períodos;
- **H₁:** a distribuição do comprimento furcal difere entre os períodos.

### Orientações

> **Passo 0 — importe e arrume.** Importe `truta_touro_manejo.xlsx` e arrume no formato *tidy*: renomeie as colunas para nomes claros (ex.: `comprimento_furcal_mm`, `massa_g`, `periodo`) e confira os tipos.

1. Identifique a unidade amostral.
2. Verifique o número de peixes em cada período.
3. Analise valores ausentes ou biologicamente improváveis.
4. Calcule, por período: número de indivíduos; mediana; intervalo interquartil; mínimo e máximo.
5. Construa um gráfico comparativo dos comprimentos (ex.: boxplot ou histograma por período).
6. Examine a assimetria, a dispersão e a presença de valores extremos.
7. Formule as hipóteses estatísticas.
8. Aplique o teste de **Mann–Whitney** com α = 0,05.
9. Apresente uma conclusão estatística e uma interpretação relacionada ao manejo.

> Priorize o **comprimento furcal**. A massa está fortemente relacionada ao comprimento — testá-la à parte seria redundante; ela fica para uma atividade de relação peso–comprimento.

### Produto esperado

Um relatório curto contendo: contextualização do problema; pergunta de pesquisa; hipóteses; estatísticas descritivas; gráfico; resultado do teste; interpretação biológica; e a **distinção entre associação temporal e causalidade**.

### Questões para discussão

- Em qual período foram observados os maiores comprimentos?
- A diferença representa apenas mudança na mediana ou uma alteração mais ampla na estrutura de tamanhos?
- O resultado permite afirmar que a regulamentação causou a mudança?
- Uma população com maior proporção de peixes pequenos está necessariamente em pior condição?
- Quais fatores poderiam explicar uma mudança na distribuição dos comprimentos?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Exploração dos dados** | Não classifica variáveis nem checa grupos/ausentes. | Exploração parcial. | Classifica variáveis, conta por período e checa ausentes/valores improváveis. | Idem, com leitura de assimetria, dispersão e extremos. |
| **Descritivas por grupo** | Ausentes ou incorretas. | Só uma estatística. | Mediana, IQR, mín/máx por período. | Idem, em tabela + gráfico comparativo claro. |
| **Execução do teste** | Teste inadequado ou mal feito. | Mann–Whitney sem α/pressupostos. | Mann–Whitney correto, com α e hipóteses. | Correto, discutindo a forma das distribuições. |
| **Interpretação** | Ausente ou como "diferença de médias". | Só o p-valor. | Diferença de posição no contexto do manejo. | Idem, distinguindo mudança de mediana × de estrutura de tamanhos. |
| **Pensamento crítico** | Não discute causalidade/limitações. | Menção genérica. | Distingue associação temporal de causalidade. | Idem, com fatores alternativos (recrutamento, densidade, seletividade). |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

- **Unidade observacional:** peixe individual (137 no total; períodos `1977-79` e `2001`). Variáveis: `comprimento_furcal_mm`, `massa_g`, `periodo` (fator).
- **Preparo esperado:** contar por período; confirmar consistência; **usar comprimento furcal**, não a massa (redundante); notar que os dados foram **digitalizados de figura** (aproximados).
- **Teste:** após importar e arrumar, `wilcox.test(comprimento_furcal_mm ~ periodo, data = dados, exact = FALSE)`; reportar mediana e IQR por período.
- **Ponto central de discussão:** um resultado significativo indica **associação temporal**, não que a regulamentação causou a mudança — o estudo original associa maior abundância a mudanças de crescimento/estrutura (crescimento dependente da densidade). Peixes menores em 2001 não implicam piora.
- **Armadilhas comuns:** usar teste t; interpretar como "médias"; afirmar causalidade; testar massa e comprimento separadamente como se fossem independentes.
