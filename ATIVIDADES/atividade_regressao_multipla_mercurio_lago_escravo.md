# Atividade autônoma — Regressão linear múltipla

## O mercúrio no peixe depende da idade, do tamanho — ou do que ele come?

**Dataset:** `mercurio_lago_escravo.xlsx`, aba `dados`. Cada linha é um **peixe**
(258 peixes de 13 espécies). As abas `especies` e `origem` trazem o código das
espécies e a procedência.
**Fonte / licença:** Rohonczy, J.; Cott, P. A.; Benwell, A.; Forbes, M. R.;
Robinson, S. A.; Rosabal, M.; Amyot, M.; Chételat, J. (2020). *Trophic structure and
mercury transfer in the subarctic fish community of Great Slave Lake, Northwest
Territories, Canada* — [Dryad, DOI 10.5061/dryad.59zw3r23g](https://doi.org/10.5061/dryad.59zw3r23g),
**CC0 1.0** (domínio público).
**Onde estão os dados:** `dados/mercurio_lago_escravo.xlsx` (banco externo da
disciplina).
**Habilidades avaliadas:** importação e conferência de tipos; escolha de preditores
colineares; regressão múltipla; transformação da resposta; comparação entre recortes;
verificação de pressupostos; interpretação de coeficientes parciais; comunicação.
**Nível / tempo estimado:** intermediário–avançado · 4–5 h.

---

### Contexto

O mercúrio chega aos peixes pela cadeia alimentar e se acumula no músculo. Como o
consumo de peixe é a principal via de exposição humana ao mercúrio, saber **o que
explica a concentração no peixe** é uma questão de saúde pública e de manejo — e não
apenas de ecologia.

Em lagos subárticos, o mercúrio em peixes tem aumentado. O Great Slave Lake, no
Canadá, sustenta pesca recreativa, de subsistência e comercial, e ali foram medidos,
em peixes capturados entre 2013 e 2015: **comprimento, massa, idade, mercúrio total no
músculo e isótopos estáveis de nitrogênio (δ15N)**, que indicam a **posição trófica**
— quanto mais alto na cadeia alimentar, maior o δ15N.

### Problema de pesquisa

Investigue: **quanto da concentração de mercúrio no músculo é explicada pela idade,
pelo tamanho e pela posição trófica do peixe — e esses preditores são redundantes
entre si?**

Hipóteses para a resposta `Hg_muscle_mg_g_dw`:

- **H₀:** nenhum dos preditores contribui (todos os coeficientes parciais são nulos);
- **H₁:** pelo menos um preditor contribui para explicar a concentração de mercúrio.

Perguntas secundárias: a escolha do recorte (todas as espécies juntas ou uma espécie
por vez) muda a conclusão? A resposta pede transformação?

> A base tem **idade faltando em 55 peixes** e duas variáveis de tamanho
> (`Length_mm` e `Weight_g`) que medem quase a mesma coisa. Decidir o recorte, os
> preditores e o tratamento dos ausentes — e justificar — faz parte da atividade.

### Etapas

1. **Importe e confira**: tipos das colunas (número é número, identificador é texto),
   quantos peixes, quantas espécies, quantos por espécie, ausentes por coluna.
2. **Trate os ausentes e o sinal de alerta da base**: veja a coluna
   `Hg_muscle_estimado` na aba `origem` e decida, com justificativa, o que fazer com
   aqueles peixes.
3. **Decida o recorte e justifique antes de ajustar**: uma espécie ou todas? Se todas,
   a espécie entra no modelo? O que muda na pergunta?
4. **Ajuste o modelo principal** com idade, tamanho e δ15N: equação, coeficientes com
   IC 95%, erros-padrão, R², R² ajustado, erro residual, F e p.
5. **Enfrente a colinearidade**: `Length_mm` e `Weight_g` medem o tamanho; `Age_years`
   e `Length_mm` crescem juntos. Ajuste o modelo trocando um pelo outro, compare e
   calcule o **VIF**. Diga qual conjunto de preditores você defende.
6. **Decida sobre a resposta**: compare o modelo com `Hg` e com `log(Hg)`. Qual
   respeita melhor os pressupostos? Quais coeficientes mudam de significado?
7. **Verifique os pressupostos**: linearidade, normalidade dos resíduos, homogeneidade,
   independência e pontos influentes (Cook).
8. **Compare recortes**: rode o mesmo modelo para duas ou três espécies com n
   suficiente e compare os coeficientes. O que vale para o conjunto vale para cada
   espécie?
9. **Use o modelo**: preveja a concentração para dois ou três peixes dentro da faixa
   observada e traduza os coeficientes em unidades do problema.
10. **Comunique**: relatório com preparo → análise → interpretação, figuras e o Projeto
    R reproduzível.

### Produto esperado (relatório)

1. pergunta, hipóteses e unidade de observação;
2. conferência dos tipos e dos ausentes, com a decisão sobre os 28 valores estimados;
3. critério do recorte escolhido (espécies) e dos preditores, com o VIF;
4. tabela do modelo principal: coeficientes, IC 95%, erro-padrão, R², F e p;
5. comparação entre os modelos com `Length_mm` e com `Weight_g`, e entre `Hg` e `log(Hg)`;
6. diagnóstico dos pressupostos;
7. o mesmo modelo em pelo menos duas espécies, com a comparação comentada;
8. interpretação aplicada, limitações e a distância entre associação e causalidade.

### Questões para discussão

- Idade e comprimento explicam o mercúrio, mas crescem juntos. Como decidir qual fica
  no modelo? O que o VIF diz?
- Por que `log(Hg)` melhora tanto o ajuste? O que isso revela sobre a escala da
  resposta?
- No conjunto, a idade não contribui; em uma das espécies, é ela que manda. Como
  conciliar as duas leituras?
- Os 28 peixes com mercúrio estimado do corpo inteiro deveriam entrar na análise? O que
  se ganha e o que se perde ao tirá-los?
- A posição trófica (δ15N) é um preditor ou uma variável mediadora? Que diferença isso
  faz na interpretação?
- Estes são dados observacionais de campo. Até onde vai a afirmação causal?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Preparação dos dados** | Não confere tipos nem ausentes. | Confere parte das colunas; ausentes tratados sem justificativa. | Tipos, ausentes e valores estimados tratados com justificativa. | Idem, com a distinção entre tamanho medido e tamanho estimado documentada e a trilha registrada. |
| **Escolha e execução da análise** | Modelo inadequado ou sem diagnóstico. | Modelo correto, execução com falhas. | Modelo múltiplo correto, com IC, R² e comparação de preditores. | Idem, com colinearidade diagnosticada (VIF) e decisão sobre a transformação da resposta fundamentada. |
| **Interpretação** | Confunde coeficiente parcial com efeito isolado ou afirma causalidade. | Lê apenas p-valor e R². | Interpreta os coeficientes parciais no contexto da bioacumulação. | Integra coeficientes, IC, escala da resposta e a diferença entre o conjunto e cada espécie. |
| **Comunicação / relatório** | Desorganizado; faltam itens pedidos. | Cobre parte dos itens. | Relatório completo e claro. | Completo, com preparo, figuras e Projeto R plenamente reproduzíveis. |
| **Pensamento crítico** | Não discute limitações. | Limitações genéricas. | Discute medição estimada, ausentes e limites do dado observacional. | Discute também a mediação pelo crescimento e o risco de ler o conjunto como se valesse para cada espécie. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

**Arquivo.** 258 peixes × 14 colunas, uma linha por peixe, da aba `Fish` do depósito.
Cabeçalho de duas linhas achatado; `-` virou célula vazia; **28 peixes** marcados com
`Hg_muscle_estimado = SIM` (os autores os marcaram em vermelho: mercúrio do músculo
**estimado** a partir do corpo inteiro). Ausentes: idade 55, comprimento e peso 12,
Hg do músculo 2, δ15N 1.

**Espécies com n suficiente:** BURB 65, LKWH 58, NRPK 38, LNSC 16 (das 202 linhas
completas em idade + comprimento + Hg + δ15N); as outras nove têm 12 ou menos.

**Modelos no conjunto** (202 peixes completos):

| Modelo | n | R² | Leitura |
|---|---|---|---|
| `Hg ~ Age + Length` | 202 | 0,555 | só o comprimento contribui (p < 0,0001); idade p = 0,17 |
| `Hg ~ Age + Length + d15N` | 202 | 0,564 | comprimento p < 0,0001; δ15N p = 0,044; idade p = 0,17 |
| `Hg ~ Age + Weight + d15N` | 202 | 0,564 | **ajuste idêntico** trocando comprimento por peso; idade p = 0,83 |
| `log(Hg) ~ Age + Length + d15N` | 202 | **0,804** | a transformação resolve: comprimento e δ15N p < 0,0001; idade p = 0,98 |
| `Hg ~ Age + Length + d15N` sem os 28 estimados | 186 | 0,569 | conclusões iguais; δ15N p = 0,0096 |

VIF: `Age` 1,6 · `Length` 3,3 · `d15N` 2,7 (colinearidade moderada, não crítica);
com `Weight` no lugar de `Length`, todos ≈ 1,5. Shapiro nos resíduos: 1,2 × 10⁻¹⁴ no
modelo com `Hg` e 0,037 com `log(Hg)`. Cook máximo 0,54 (sem ponto influente).

**O achado central — o preditor que manda muda com a espécie** (`Hg ~ Age + Length`):

| Espécie | n | R² | Idade | Comprimento |
|---|---|---|---|---|
| LKWH (corégono-branco) | 77 | 0,575 | p = 0,19 | **p < 0,0001** |
| BURB (burbot) | 69 | 0,511 | **p < 0,001** | p = 0,88 |
| NRPK (lúcio) | 50 | 0,749 | **p < 0,001** | p = 0,045 |
| LNSC (sucker) | 20 | 0,459 | p = 0,83 | **p = 0,010** |

Ou seja: no conjunto a idade não contribui, mas no burbot ela é o preditor; no
corégono-branco é o comprimento. É a melhor discussão que este conjunto oferece —
agrupar espécies com histórias de vida diferentes esconde justamente o mecanismo.

**Armadilhas comuns**

- Deixar idade e comprimento no modelo sem olhar a colinearidade, e depois interpretar
  cada coeficiente como efeito isolado.
- Trocar `Length_mm` por `Weight_g` sem notar que o ajuste é o mesmo (os dois medem
  tamanho) — e que a significância da idade muda só por causa da escala.
- Não testar `log(Hg)`, perdendo a melhora de 0,56 para 0,80 e ficando com resíduos
  claramente não normais.
- Tratar os 28 valores **estimados** como se fossem medidas de músculo.
- Concluir pelo conjunto o que só vale por espécie (ou o contrário).
- Ler o δ15N como causa: ele é marcador de posição trófica, e o artigo mostra que o
  caminho do mercúrio passa pelo crescimento.
