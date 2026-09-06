# Atividade autônoma — leitura de um experimento fatorial publicado

## Dieta e temperatura: como ler médias, dispersão e interação?

**Dataset:** `gammarus_dieta_temperatura_resumo.csv`; cada linha representa uma
combinação de dieta e temperatura, resumida por média, desvio-padrão e quatro
recipientes.
**Fonte / licença:** Ribes-Navarro, A. et al. (2022), *Frontiers in Marine
Science*, 9, 931991, [DOI 10.3389/fmars.2022.931991](https://doi.org/10.3389/fmars.2022.931991),
CC BY.
**Onde estão os dados:** `dados/gammarus_dieta_temperatura_resumo.csv` (banco
externo da disciplina; resumo transcrito da Table 1).
**Habilidades avaliadas:** leitura de delineamento, gráfico de médias com erro,
comparação de respostas, interpretação de interação e honestidade sobre dados
agregados.
**Nível / tempo estimado:** introdutório–intermediário · 2–3 h.

---

### Contexto

Juvenis do anfípode marinho *Gammarus locusta* foram mantidos por 21 dias sob
três dietas (Fucus, folhas de cenoura e polpa de coco) e quatro temperaturas
(5, 10, 15 e 20 °C), com quatro recipientes por combinação. A tabela fornecida
contém somente médias, desvios-padrão e `n`, não os valores de cada recipiente.

### Problema de pesquisa

Investigue: **quais combinações de dieta e temperatura parecem favorecer a
sobrevivência e o crescimento, e que padrão de interação é visível nos gráficos?**

Não é objetivo desta atividade recalcular a ANOVA do artigo. O objetivo é
aprender a distinguir uma base no nível da repetição de um resumo publicado e
ler o resultado sem inventar precisão que os dados não oferecem.

### Etapas

1. **Importe e confira** as 12 linhas, três dietas, quatro temperaturas e
   `n_repeticoes = 4` em todas as células.
2. **Prepare gráficos** de sobrevivência média e biomassa média por temperatura,
   com uma linha por dieta e barras de erro usando os desvios-padrão publicados.
   Faça pelo menos um segundo gráfico para comprimento final ou taxa de
   crescimento específico.
3. **Descreva padrões:** compare dietas dentro de cada temperatura e temperaturas
   dentro de cada dieta. Procure linhas que não sejam aproximadamente paralelas
   e indique onde a interação poderia ser biologicamente interessante.
4. **Leia o artigo:** confronte seus gráficos com a ANOVA reportada pelos autores
   (sobrevivência, biomassa e demais respostas). Separe claramente o que o
   gráfico sugere do que o teste publicado permite concluir.
5. **Limite inferencial:** explique por que médias, DP e `n` não permitem refazer
   os resíduos, pressupostos, ANOVA ou Tukey. Não replique cada linha quatro
   vezes e não trate médias como observações independentes.
6. **Relate:** entregue os gráficos, uma tabela curta de diferenças descritivas,
   a fonte/licença e um parágrafo de limitações.

### Produto esperado (relatório)

1. delineamento 3 × 4 e unidade da repetição;
2. gráficos com barras de erro e legendas claras;
3. leitura de efeitos aparentes e possível interação;
4. comparação com as conclusões publicadas;
5. explicação explícita de por que não se recalcula a ANOVA com o resumo;
6. limitações e proposta de quais dados faltariam para uma análise completa.

### Questões para discussão

- Uma diferença entre duas médias é evidência de efeito estatístico? O que falta
  para responder?
- Por que o desvio-padrão não recupera a posição de cada recipiente?
- O padrão da biomassa é igual ao da sobrevivência? Que hipótese biológica isso
  sugere?
- Como uma interação poderia aparecer em um gráfico de linhas?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Leitura/preparo** | Confunde média com observação. | Confere parte do delineamento. | Identifica células, n e unidades. | Documenta a estrutura e a fonte de forma reproduzível. |
| **Gráficos** | Gráfico inadequado ou sem unidades. | Gráfico legível, com erros incompletos. | Gráficos corretos e comparáveis. | Escolhas visuais e barras de erro são justificadas. |
| **Interpretação** | Afirma significância a partir de médias. | Descreve diferenças sem interação. | Distingue padrão descritivo de teste publicado. | Integra padrão, interação e contexto biológico com cautela. |
| **Comunicação / relatório** | Não informa fonte ou limitações. | Relato parcial. | Completo e claro. | Narrativa enxuta, legendas e limitações exemplares. |
| **Pensamento crítico** | Replica médias para forçar uma ANOVA. | Reconhece a limitação sem explicar. | Explica quais dados faltam. | Discute agregação, incerteza e alternativas de delineamento. |

**Nota = soma dos critérios (0–15).**

### Observações ao professor (não distribuir)

O arquivo é deliberadamente agregado: 12 combinações, `n = 4` por combinação.
Pode ser usado em uma aula de gráficos de interação e leitura de artigos, mas
não deve alimentar o módulo de ANOVA como se cada média fosse uma repetição. A
atividade fica aberta para uma versão futura caso os autores disponibilizem os
48 valores por recipiente.
