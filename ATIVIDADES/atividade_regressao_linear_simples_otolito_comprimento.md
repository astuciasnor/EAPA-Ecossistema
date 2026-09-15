# Atividade autônoma — Regressão linear simples

## O raio do otólito prevê o comprimento do peixe?

**Dataset:** `regressao_otolito_comprimento.xlsx`, aba `dados`. Cada linha é um
**anulo (idade) lido no otólito** de um peixe: 6.320 linhas para **855 peixes** de
**51 espécies**. A aba `origem` traz fonte, DOI, licença e unidade observacional.
**Fonte / licença:** Morat, F. et al. (2020). *Individual back-calculated
size-at-age based on otoliths from Pacific coral reef fish species*. Scientific
Data, 7, 370 —
[figshare, DOI 10.6084/m9.figshare.12156159.v5](https://doi.org/10.6084/m9.figshare.12156159.v5),
CC BY 4.0.
**Onde estão os dados:** `dados/regressao_otolito_comprimento.xlsx` (banco externo
da disciplina).
**Habilidades avaliadas:** importação; identificação da unidade de observação;
seleção justificada de espécie; colapso de leituras repetidas; análise exploratória;
ajuste e leitura de um modelo linear; diagnóstico de resíduos e pontos influentes;
predição; comunicação.
**Nível / tempo estimado:** intermediário · 4–5 h.

---

### Contexto

Otólitos são estruturas calcárias que crescem depositando anéis ao longo da vida do
peixe. Contando esses anulos estima-se a **idade**; medindo o **raio do otólito** em
cada anulo, estima-se o **comprimento que o peixe tinha naquela idade**. Essa
operação — o retrocálculo de comprimento (*back-calculation*) — é uma das
ferramentas mais usadas na avaliação de estoques, e ela depende inteiramente de uma
suposição: que o raio do otólito e o comprimento do peixe caminhem juntos, de forma
previsível.

Os dados vêm de uma amostragem de campo de peixes recifais em quatro ilhas do
Pacífico (Manuae, Gambiers, Moorea e Marquesas). De cada peixe registraram-se o
comprimento total e a massa na captura; os otólitos foram seccionados e lidos, anulo
por anulo, para idade e raio.

### Problema de pesquisa

Investigue: **é possível prever o comprimento total de um peixe a partir do raio do
seu otólito, e a relação é linear e forte o bastante para sustentar o retrocálculo?**

Hipóteses para a resposta `Lcpt` (comprimento total na captura, mm), tendo
`Rcpt` (raio do otólito na captura, mm) como variável explicativa:

- **H₀:** β₁ = 0 — não há relação linear entre o raio do otólito e o comprimento;
- **H₁:** β₁ ≠ 0 — há relação linear.

> A base **não vem pronta para a análise**: tem mais de uma linha por peixe e 51
> espécies. Definir a estrutura — **uma linha por peixe** e **uma única espécie** —
> faz parte da atividade, e cada escolha precisa ser justificada **antes** de
> qualquer resultado.

### Etapas

1. **Explore a estrutura** antes de tudo: quantas linhas e colunas, **quantos peixes
   distintos** (coluna `ID`), quantas espécies, quantos valores ausentes por coluna,
   e — o ponto central — **o que exatamente cada linha representa**.
2. **Escolha uma espécie** para a análise e justifique: número de indivíduos
   disponíveis, coerência biológica e amplitude de tamanhos. Registre quantos peixes
   ficaram de fora e por quê. **A escolha não pode ser feita olhando o R²** — ela
   vem antes, e o critério é o desenho da coleta, não o resultado.
3. **Prepare a base da análise:** uma linha por peixe. Explique, no relatório, por
   que usar a base como ela está inflaria o número de observações e violaria a
   independência entre elas. Registre cada decisão na trilha de preparo.
4. **Explore a relação:** gráfico de dispersão do comprimento contra o raio do
   otólito, com a reta ajustada. Decida, pelo gráfico, se a reta é um resumo
   adequado — antes de olhar qualquer p-valor.
5. **Ajuste o modelo linear simples** e apresente: equação, coeficientes com
   intervalos de confiança, erros-padrão, R², estatística F e p-valor.
6. **Verifique os pressupostos:** linearidade (resíduos versus ajustados),
   normalidade dos resíduos (QQ-plot e Shapiro-Wilk), homocedasticidade (resíduos
   versus ajustados), independência (pelo delineamento) e **pontos influentes**
   (distância de Cook). Se houver ponto influente, ajuste o modelo com e sem ele e
   comente o que muda.
7. **Use o modelo:** preveja o comprimento para dois ou três valores de raio de
   otólito, com intervalo de predição, e interprete o intercepto — lembrando que ele
   é uma extrapolação fora da faixa observada.
8. **Comunique:** relatório com preparo → análise → interpretação, figuras e o
   Projeto R reproduzível.

### Produto esperado (relatório)

1. pergunta, hipóteses e unidade de observação;
2. critério de escolha da espécie, com o número de peixes incluídos e excluídos;
3. explicação e justificativa do colapso das leituras de anulo (uma linha por peixe);
4. gráfico de dispersão com a reta ajustada;
5. tabela do modelo: coeficientes, IC 95%, erro-padrão, R², F e p;
6. diagnóstico dos pressupostos, incluindo pontos influentes;
7. uma previsão com intervalo de predição e a leitura do intercepto;
8. interpretação aplicada, limitações e a distinção entre predição e causalidade.

### Questões para discussão

- O que aconteceria com o resultado se as 6.320 linhas fossem tratadas como 6.320
  peixes independentes? Por que isso é pseudorrepetição?
- Por que a relação fica mais fraca quando se juntam espécies diferentes? O que isso
  revela sobre a forma do corpo e do otólito entre os táxons?
- O intercepto tem significado biológico? O que significaria prever o comprimento de
  um peixe com raio de otólito igual a zero?
- O raio do otólito **causa** o comprimento do peixe? Que tipo de afirmação este
  modelo autoriza?
- A leitura do otólito tem erro, e a coluna `Observer` registra quem leu. Como isso
  afeta a estimativa e o que seria preciso para quantificar esse erro?
- Um R² alto basta para considerar o modelo adequado ao retrocálculo? Que outras
  checagens você exigiria antes de usar o modelo em um estoque real?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Preparação dos dados** | Usa a base crua como se cada linha fosse um peixe. | Colapsa por peixe, com pouca justificativa. | Uma linha por peixe, espécie escolhida e justificada. | Idem, com o critério de escolha declarado antes da análise e a trilha de preparo documentada. |
| **Escolha e execução da análise** | Modelo inadequado ou sem diagnóstico. | Regressão correta, execução com falhas. | Modelo correto, com dispersão e tabela completas. | Correto, com pressupostos verificados, influentes tratados e previsão com intervalo. |
| **Interpretação** | Confunde correlação com causalidade ou ignora a escala. | Lê apenas o p-valor e o R². | Interpreta a relação no contexto do retrocálculo. | Usa coeficientes, IC, R², resíduos e influentes, e discute a extrapolação do intercepto. |
| **Comunicação / relatório** | Desorganizado; faltam itens pedidos. | Cobre parte dos itens. | Relatório completo e claro. | Completo, com preparo, figuras e Projeto R plenamente reproduzíveis. |
| **Pensamento crítico** | Não discute limitações. | Limitações genéricas. | Discute erro de leitura, amostragem de campo e limites de generalização. | Discute pseudorrepetição, heterogeneidade entre espécies, erro de leitura e o que falta para validar um retrocálculo. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

**Arquivo.** A aba `dados` foi montada a partir do depósito do figshare (CC BY 4.0)
**sem alterar os dados**: 6.320 linhas, 14 colunas, 855 peixes, 51 espécies. Saíram
apenas as quatro colunas de resultados derivados pelos autores (`Li_sp_m`,
`Li_sp_sd`, `Li_sploc_m`, `Li_sploc_sd`), que entregariam a análise pronta.
`Rcpt` e `Lcpt` **não têm valores ausentes**; `Weight` tem 603 (9,5%) e `Ri` tem 387
(o raio no anulo 0, ausente por definição).

**Contagens.** Linhas por peixe: mínimo 1, mediana 6, média 7,4, máximo 31. Há 51
espécies, mas apenas **8 têm 30 indivíduos ou mais**:

| Espécie | Indivíduos |
|---|---|
| Epinephelus merra | 46 |
| Cephalopholis argus | 41 |
| Lutjanus kasmira | 37 |
| Chlorurus spilurus | 34 |
| Pristiapogon taeniopterus | 32 |
| Plectropomus laevis | 31 |
| Myripristis berndti | 30 |
| Ostorhinchus apogonoides | 30 |

**Resultado esperado** (uma linha por peixe, as 8 espécies com n ≥ 30):

| Espécie | n | R² | Shapiro p | Cook máx | Leitura |
|---|---|---|---|---|---|
| Plectropomus laevis | 31 | **0,908** | 0,541 | 0,96 | limpa e forte — melhor escolha |
| Pristiapogon taeniopterus | 32 | 0,837 | 0,962 | 0,37 | limpa e forte |
| Ostorhinchus apogonoides | 30 | 0,823 | 0,810 | 0,10 | limpa e forte |
| Lutjanus kasmira | 37 | 0,809 | 0,0001 | **36,95** | R² alto sustentado por **um ponto extremo** — ótimo para diagnóstico |
| Epinephelus merra | 46 | 0,615 | 0,162 | 2,02 | relação moderada, com ponto influente a discutir |
| Myripristis berndti | 30 | 0,387 | 0,123 | 0,13 | relação fraca |
| Cephalopholis argus | 41 | 0,291 | 0,259 | 0,66 | relação fraca |
| Chlorurus spilurus | 34 | 0,173 | 0,098 | 0,15 | relação fraca |

Recortes **errados**, para comparação:

| Recorte | n | R² | Shapiro p | Por que está errado |
|---|---|---|---|---|
| As 8 espécies juntas | 281 | 0,101 | 3,1 × 10⁻¹⁰ | agrupar espécies destrói a relação |
| As 8 juntas + espécie como fator | 281 | 0,913 | — | mostra que a relação é específica de cada táxon |
| Todas as 51 espécies | 855 | 0,199 | 1,1 × 10⁻²² | mesma coisa, com mais ruído |
| Base crua (linhas = anulos) | 6.320 | — | — | pseudorrepetição: n inflado ~7,4× |

**Atenção ao critério:** a espécie **não** pode ser escolhida pelo R² — isso é p-hacking. O critério é o número de indivíduos, a coerência biológica e a ausência de problemas. As três primeiras servem a quem quer um ajuste limpo; *Lutjanus kasmira* é o caso perfeito para discutir um ponto extremo (um único peixe com Cook ≈ 37 sustenta o R² de 0,809).

Modelo de referência para *Epinephelus merra*: comprimento = **109,6 + 77,6 × raio
do otólito** (IC 95% da inclinação: 59,0 a 96,3 mm/mm); erro residual 29,2 mm;
F(1, 44) = 70,3; p = 1,1 × 10⁻¹⁰. Previsões (IC de predição 95%): raio 0,5 mm →
148,4 mm (88,1–208,7); 1,0 mm → 187,2 mm (127,8–246,7); 1,5 mm → 226,0 mm
(165,9–286,1).

**Armadilhas comuns**

- Analisar a base crua: cada linha é um anulo, não um peixe (pseudorrepetição).
- Juntar as 51 espécies: R² cai para 0,20 e os resíduos ficam péssimos — a relação é
  específica de cada táxon (forma do corpo e do otólito).
- Escolher a espécie pelo R² (p-hacking): o critério tem de ser o n e a coerência
  biológica, declarados antes.
- Ler o intercepto como se fosse biológico: não há peixe com raio zero na amostra.
- Tratar R² alto como validação do retrocálculo, sem checar resíduos e influentes.
- Afirmar causalidade: otólito e comprimento crescem juntos; um não causa o outro.

**Ponto influente:** em *Epinephelus merra* há um ponto com distância de Cook ≈ 2,0.
Vale pedir o modelo com e sem ele — os coeficientes mudam e isso é discutível em
sala. A leitura do otólito também tem erro, registrado na coluna `Observer`, mas sem
réplicas de leitura não se estima.

**Inconsistência real nos dados:** o peixe `GAM18_B123` (*Monotaxis grandoculis*)
aparece com dois valores de `Rcpt` (2,127416 e 1,763287 mm) e idades duplicadas.
Não afeta as espécies acima, mas serve de exemplo de que dado real precisa de
conferência antes da análise.
