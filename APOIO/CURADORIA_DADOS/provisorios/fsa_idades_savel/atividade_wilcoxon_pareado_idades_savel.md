# Atividade de consolidacao: as duas leituras do leitor A diferem sistematicamente?

O conjunto `idades_savel_repetibilidade` apresenta idades de 53 savel-americanos (*Alosa sapidissima*) conhecidas por marcacao previa. Tres leitores examinaram as escamas dos mesmos peixes em dois momentos independentes. Nesta atividade, avalie a repetibilidade do leitor A.

## Pergunta de pesquisa

As estimativas de idade realizadas pelo leitor A diferem sistematicamente entre a primeira e a segunda leitura?

## Orientacoes

1. Identifique a unidade amostral e explique por que as leituras de `reader_a_1` e `reader_a_2` sao pareadas.
2. Verifique o numero de pares completos e os valores ausentes nas duas colunas.
3. Calcule `diferenca = reader_a_2 - reader_a_1` apenas para pares completos.
4. Descreva as diferencas: mediana, minimo, maximo, frequencia de diferencas nulas e porcentagem de concordancia exata.
5. Construa um grafico de pontos ligados ou um grafico das diferencas.
6. Avalie a simetria aproximada das diferencas nao nulas.
7. Formule as hipoteses e aplique o teste de Wilcoxon pareado com alpha = 0,05.
8. Use `wilcox.test(reader_a_2, reader_a_1, paired = TRUE, exact = FALSE)`.
9. Interprete o resultado em termos de vies sistematico, sem confundir ausencia de vies com concordancia perfeita.

## Hipoteses

- H0: a distribuicao de `reader_a_2 - reader_a_1` esta centrada em zero; nao ha diferenca sistematica entre as leituras.
- H1: a distribuicao de `reader_a_2 - reader_a_1` nao esta centrada em zero; ha diferenca sistematica entre as leituras.

## Discussao

- Uma diferenca nao significativa demonstra concordancia perfeita?
- Por que as diferencas iguais a zero e os empates nos postos exigem `exact = FALSE`?
- Como a idade verdadeira (`true_age`) pode complementar a avaliacao de repetibilidade?
- O que distingue precisao, vies e acuracia neste contexto?

## Produto esperado

Produza um relatorio curto com contexto, pergunta, definicao do pareamento, tratamento das ausencias, estatisticas descritivas, grafico, teste de Wilcoxon, interpretacao biologica e uma discussao sobre repetibilidade versus acuracia.
