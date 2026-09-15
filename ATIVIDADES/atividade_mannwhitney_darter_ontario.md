# Atividade autônoma — Teste de Mann–Whitney

## A estrutura etária de uma espécie ameaçada é semelhante em dois rios?

**Dataset:** `darter_ontario` — 54 percinas-do-canal (*Percina copelandi*) dos rios Salmon e Trent (Ontário, Canadá); cada linha é um peixe.
**Fonte / licença:** reconstruído da Fig. 2 de Reid (2004), J. Freshwater Ecology 19:441–444; pacote `FSAdata` (GPL-2 | GPL-3).
**Onde estão os dados:** banco externo da disciplina — `dados/darter_ontario.xlsx` (colunas originais `age`, `tl`, `river`). Importe o arquivo e arrume no formato *tidy*.
**Habilidades avaliadas:** classificação de variáveis; estatística descritiva por grupo; escolha e execução de teste não paramétrico; leitura de empates; interpretação por posição/mediana; comunicação.
**Nível / tempo estimado:** introdutório · 2–3 h.

---

### Contexto

A *Percina copelandi* é um pequeno peixe de água doce encontrado em rios da América do Norte. Conhecer a estrutura etária de suas populações ajuda a avaliar recrutamento, sobrevivência e conservação. Um estudo coletou exemplares nos rios Salmon e Trent, em Ontário, Canadá; a idade foi estimada pela leitura dos otólitos.

### Questão central

Existem evidências de que os peixes capturados nos rios Salmon e Trent apresentam **distribuições de idade diferentes**?

Hipóteses:

- **H₀:** a distribuição das idades é a mesma nos dois rios;
- **H₁:** a distribuição das idades difere entre os dois rios.

### Orientações

> **Passo 0 — importe e arrume.** Importe `darter_ontario.xlsx` e arrume no formato *tidy*: renomeie as colunas para nomes claros (ex.: `idade_anos`, `comprimento_total_mm`, `rio`) e confira os tipos de cada variável.

1. Identifique a unidade amostral e classifique as variáveis do conjunto.
2. Verifique quantos peixes foram observados em cada rio.
3. Examine a ocorrência de valores ausentes.
4. Calcule, para cada rio: número de indivíduos; mediana da idade; primeiro e terceiro quartis; valores mínimo e máximo.
5. Construa um gráfico que permita comparar as distribuições de idade (ex.: boxplot ou histograma por rio).
6. Observe se existem **empates** (vários peixes com a mesma idade).
7. Formule as hipóteses do teste.
8. Aplique o teste de **Mann–Whitney** com α = 0,05, usando a aproximação para dados com empates (sem exigir o cálculo exato).
9. Interprete o resultado no contexto biológico.

### Produto esperado

Uma síntese contendo: pergunta de pesquisa; hipóteses estatísticas; tabela de estatísticas descritivas; gráfico; resultado do teste; conclusão biológica; e ao menos uma limitação do estudo.

### Questões para discussão

- Qual rio apresentou peixes aparentemente mais velhos?
- As distribuições possuem formatos semelhantes?
- O resultado estatístico permite afirmar que um dos rios tem peixes "maiores"?
- A ausência de peixes muito jovens significa necessariamente que eles não existem no ambiente?
- Como a seletividade do método de captura pode influenciar os resultados?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Exploração dos dados** | Não classifica variáveis nem checa grupos/ausentes. | Faz parte da exploração. | Classifica variáveis, conta por rio e verifica ausentes/empates. | Idem, com leitura clara do porquê os empates importam. |
| **Descritivas por grupo** | Ausentes ou incorretas. | Só médias/uma estatística. | Mediana, quartis, mín/máx por rio. | Idem, bem apresentadas em tabela + gráfico comparativo. |
| **Execução do teste** | Teste inadequado (ex.: teste t) ou mal feito. | Mann–Whitney sem tratar empates/α. | Mann–Whitney correto com empates e α definido. | Correto, com hipóteses explícitas e checagem da forma das distribuições. |
| **Interpretação** | Descreve como "diferença de médias". | Só relata o p-valor. | Interpreta como diferença de posição/mediana no contexto. | Idem, com cautela sobre forma das distribuições e sentido biológico. |
| **Pensamento crítico** | Não discute limitações. | Limitações genéricas. | Discute seletividade da amostragem. | Discute seletividade, causalidade e por que não misturar idade e comprimento. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

- **Unidade observacional:** peixe individual (54 no total; rios Salmon e Trent). Variáveis: `idade_anos` (discreta, poucos valores → muitos empates), `comprimento_total_mm` (numérica), `rio` (fator).
- **Preparo esperado:** contar indivíduos por rio; confirmar ausência de dados faltantes; notar os empates de idade (justifica `exact = FALSE`).
- **Teste:** após importar e arrumar, `wilcox.test(idade_anos ~ rio, data = dados, exact = FALSE)`; reportar mediana e IQR por rio; a maioria dos peixes tem 2–3 anos (Reid).
- **Armadilhas comuns:** usar teste t; descrever o resultado como "comparação de médias"; interpretar diferença de medianas quando as distribuições têm formatos distintos; comparar `comprimento_total_mm` entre rios diretamente (confundido pela idade); afirmar causalidade.
- **Viés a discutir:** a pesca elétrica pode subamostrar exemplares menores/mais jovens — diferenças podem refletir a estrutura etária real ou o método de captura.
