# Atividade autonoma: o tamanho das trutas-touro mudou apos alteracoes no manejo pesqueiro?

Populacoes de truta-touro sao sensiveis a exploracao pesqueira porque apresentam crescimento relativamente lento, maturacao tardia e populacoes geralmente pequenas. Em lagos de Alberta, Canada, foram adotadas medidas mais restritivas para reduzir a mortalidade associada a pesca recreativa.

O conjunto `truta_touro_manejo` contem dados de peixes amostrados em 1977-1979 e em 2001. Investigue se a distribuicao do comprimento furcal mudou entre esses dois periodos.

## Questao central

A distribuicao do comprimento furcal das trutas-touro foi diferente em 2001 quando comparada ao periodo de 1977-1979?

## Orientacoes

1. Identifique a unidade amostral.
2. Verifique o numero de peixes em cada periodo.
3. Analise valores ausentes ou biologicamente improvaveis.
4. Calcule, por periodo, numero de individuos, mediana, intervalo interquartil, minimo e maximo.
5. Construa um grafico comparativo dos comprimentos.
6. Examine a assimetria, a dispersao e a presenca de valores extremos.
7. Formule as hipoteses estatisticas.
8. Aplique o teste de Mann-Whitney com alpha = 0,05, usando `exact = FALSE`.
9. Apresente uma conclusao estatistica e uma interpretacao relacionada ao manejo.

## Questoes para discussao

- Em qual periodo foram observados os maiores comprimentos?
- A diferenca encontrada representa apenas mudanca na mediana ou uma alteracao mais ampla na estrutura de tamanhos?
- O resultado permite afirmar que a regulamentacao causou a mudanca?
- Uma populacao com maior proporcao de peixes pequenos esta necessariamente em pior condicao?
- Quais fatores, alem do manejo, poderiam explicar uma mudanca na distribuicao dos comprimentos?

## Produto esperado

Produza um relatorio curto contendo contextualizacao do problema, pergunta de pesquisa, hipoteses, estatisticas descritivas, grafico, resultado do teste, interpretacao biologica e uma distincao explicita entre associacao temporal e causalidade.

## Nota metodologica

Cada linha corresponde a uma truta-touro individual. Os grupos de periodo sao independentes, e nao medidas pareadas antes/depois. A versao publicada pelo FSAdata foi reconstruida aproximadamente da Figura 2 de Parker et al. (2007) e nao identifica os dois lagos de origem; portanto, nao permite separar efeitos de lago, de amostragem e de outras mudancas temporais do efeito associado ao periodo.
