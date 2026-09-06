# Atividade autônoma — Teste de Kruskal–Wallis

## O tamanho dos esturjões-pálidos difere entre quatro regiões?

**Dataset:** `esturjao_palido.xlsx` — 30 esturjões-pálidos (*Scaphirhynchus albus*) do sistema do rio Missouri (EUA); cada linha é um peixe.
**Fonte / licença:** dados da Tabela 1 de Keenlyne & Maxwell (1993), N. Am. J. Fish. Manag. 13:395–397; pacote `FSAdata` (`Pallid`, GPL ≥ 2).
**Onde estão os dados:** banco externo da disciplina — `dados/esturjao_palido.xlsx` (aba **Dados**; a aba **Contexto_Dicionario** traz o dicionário). Importe e confira.
**Habilidades avaliadas:** import; identificação de resposta × grupos; descritivas por grupo; Kruskal–Wallis; pós-teste com correção (Holm); interpretação por medianas; distinção associação × causa; comunicação.
**Nível / tempo estimado:** introdutório–intermediário · 2–3 h.

---

### Contexto

O esturjão-pálido é uma espécie de grande porte associada à bacia do rio Missouri. Num estudo sobre conversões entre medidas de comprimento e relações comprimento–peso, foram reunidas informações biométricas de indivíduos capturados em **Nebraska (NB)**, **Dakota do Sul (SD)**, **Dakota do Norte (ND)** e **Montana (MT)**. A comparação **não** pretende demonstrar que o local, isoladamente, determina o tamanho: as coletas ocorreram em datas distintas e podem refletir idade, recrutamento, época do ano e características locais das populações.

### Questão central

A distribuição do **comprimento total** dos esturjões-pálidos difere entre Nebraska, Dakota do Sul, Dakota do Norte e Montana?

Resposta: `total_length_mm`. Grupos: `location` (NB, SD, ND, MT).

Hipóteses:

- **H₀:** as distribuições do comprimento total são iguais nos quatro locais;
- **H₁:** pelo menos um local apresenta distribuição de comprimento total diferente.

### Orientações

> **Passo 0 — importe e confira.** Importe `esturjao_palido.xlsx` (aba **Dados**), confira os tipos e identifique a resposta (`total_length_mm`) e o agrupamento (`location`).

1. Identifique a unidade amostral, a variável resposta e a variável de agrupamento.
2. Verifique o número de peixes em cada local e a existência de valores ausentes.
3. Para cada região, calcule: número de peixes; mediana do comprimento total; 1º e 3º quartis; mínimo e máximo.
4. Construa um gráfico comparando o comprimento total entre os quatro locais (ex.: boxplot).
5. Formule as hipóteses.
6. Aplique o teste de **Kruskal–Wallis**, com α = 0,05.
7. Se o teste for significativo, faça **comparações múltiplas pós-hoc** entre os locais, com correção para múltiplos testes (preferencialmente **Holm**).
8. Interprete com base nas **medianas**, nos gráficos e nas comparações pós-hoc — não apenas no valor de *p*.

### Produto esperado

Relatório curto com: pergunta e hipóteses; tabela descritiva por local; gráfico comparativo; resultado do Kruskal–Wallis; resultado do pós-teste (quando aplicável); conclusão biológica cuidadosa; e **ao menos duas limitações** do estudo.

### Questões para discussão

- Quais locais parecem diferir e em que direção (com base nas medianas e no pós-teste)?
- O Kruskal–Wallis global significativo permite dizer *quais* locais diferem sem pós-teste?
- Como o tamanho pequeno e desigual dos grupos afeta a leitura de um resultado não significativo?
- Por que não faz sentido analisar comprimento e massa como respostas independentes?
- O "local" pode ser interpretado como causa isolada do tamanho? O que mais poderia explicar as diferenças?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Import e organização** | Não importa/identifica resposta e grupos. | Importa, identificação parcial. | Importa, identifica resposta/grupos, checa n e ausências. | Idem, com tipos conferidos e leitura do desbalanceamento. |
| **Descritivas por grupo** | Ausentes/incorretas. | Só uma estatística. | n, mediana, Q1, Q3, mín/máx por local. | Idem, em tabela + boxplot claro. |
| **Kruskal–Wallis** | Teste inadequado (ex.: ANOVA). | KW sem α/hipóteses. | KW correto, com α e hipóteses. | Correto e seguido de **pós-teste com Holm** quando significativo. |
| **Interpretação** | Só o *p*-valor. | Descreve global sem localizar. | Interpreta por medianas + pós-teste. | Idem, com leitura biológica e cautela sobre grupos pequenos. |
| **Pensamento crítico** | Sem limitações. | Uma limitação genérica. | Duas limitações relevantes. | Idem, discutindo confusão local × data/idade e comprimento × massa. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

- **Unidade observacional:** peixe individual (30 no total). Grupos **desbalanceados e pequenos**: NB = 4, SD = 8, ND = 7, MT = 11.
- **Padrão esperado:** medianas de `total_length_mm` ≈ NB 1020, SD 1308, ND 1543, MT 1480 — **NB claramente menor**; Kruskal–Wallis tende a dar significativo. Pós-teste (Dunn com Holm) deve destacar NB vs ND/MT.
- **Teste:** `kruskal.test(total_length_mm ~ location, data = dados)`; pós-hoc, ex.: `FSA::dunnTest(total_length_mm ~ location, data = dados, method = "holm")` ou `pairwise.wilcox.test(..., p.adjust.method = "holm")`.
- **Cuidados a cobrar:** grupos pequenos/desiguais reduzem poder — não-significância não prova estruturas iguais; `location` está confundido com data/idade/recrutamento (não é causa isolada); comprimento e massa descrevem o mesmo porte (não tratar como respostas independentes).
- **Armadilhas comuns:** usar ANOVA; parar no *p* global sem pós-teste; interpretar sem as medianas; afirmar causalidade do local.
- **Nota de escopo:** atividade **só externa** — não entra no pacote; o exemplo de Kruskal do pacote é o `cpue_tubarao`.
