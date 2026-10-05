# Adaptar a análise sem copiar sua estatística

Leia o roteiro inicial e somente as seções pertinentes ao método solicitado.
Esta referência orienta a seleção de conteúdo; não substitui o delineamento,
a documentação dos dados ou a consulta às funções efetivamente usadas.

## Antes de implementar

Responda, em linguagem concreta:

1. O que se quer estimar, descrever ou comparar?
2. O que representa uma linha? Qual unidade foi amostrada ou recebeu tratamento?
3. Existem pares, blocos, populações, tanques ou observações repetidas?
4. Quais colunas entram, em que escala, com quais faltantes e níveis?
5. Qual método/variante responde à pergunta e corresponde à implementação canônica?
6. O que o artigo precisa apresentar para sustentar a conclusão?

Tipos de coluna são evidência parcial: duas colunas numéricas podem representar
medidas pareadas, uma associação ou identificadores, conforme a coleta.
Se o delineamento não couber no método solicitado, explique a incompatibilidade
antes de produzir uma inferência inadequada. Continue o que for seguro, como
inventariar dados e documentar a dúvida; não invente independência ou pareamento.

Defina escolhas no script antes dos resultados: variáveis, referência, grupos,
ordem de contrastes, confiança e hipótese unilateral/bilateral. Não escolha
entre testes percorrendo opções até encontrar significância. Alterações
posteriores precisam de justificativa e revisão do texto dos dois relatórios.

## Estatística descritiva: primeiro degrau

**Quando e dados:** descrever uma amostra. Uma medida quantitativa permite
resumos e histograma; uma variável categórica pede contagens e proporções.
Identifique denominadores e faltantes. Não calcule médias de códigos de categorias.

**Verificações:** tipos, unidade, amplitude, faltantes, valores impossíveis,
duplicação de unidades e agrupamentos. Não exigir normalidade para calcular
média, mediana ou DP. O limite de dois valores do exemplo atual serve ao seu
DP e conjunto de resumos; não é uma regra universal para qualquer descrição.

**Artigo:** tamanho analisado, faltantes, resumos pertinentes, unidade/escala,
uma figura informativa e conclusão restrita à amostra. Para o primeiro exemplo
quantitativo, uma tabela e um histograma bastam. Não invente teste ou p-valor.

**Adaptação:** use [descritiva-barbo](../../../EAPACadernos/descritiva-barbo/README.md)
como exemplo de redução de extensão. Preserve os papéis dos arquivos, não a
quantidade de objetos, figuras ou seções da regressão.

## Regressão linear simples: referência didática

**Quando e dados:** estimar a relação média linear de uma resposta quantitativa
com um preditor quantitativo. Explicite direção Y em função de X, unidades e
faixa observada. Ajustar uma reta não demonstra causalidade.

**Verificações:** linearidade, variância, distribuição dos resíduos para a
inferência usual, influência e independência fundamentada na coleta. O
normalmente examinado não é a normalidade isolada de X ou Y. Não transportar
VIF para um único preditor nem testar autocorrelação numa ordem arbitrária.

**Artigo:** n, estimativas do intercepto e inclinação, EP/IC, t/gl/p,
R²/R² ajustado, teste F com graus de liberdade e figura do ajuste. Mostre a
incerteza com significado claro; IC da média e intervalo de predição são
diferentes. Resuma diagnósticos e limitações que afetem a inferência.

**Adaptação:** derive tabela, reta e intervalo do mesmo modelo. A suavização
exploratória de resíduos não é um segundo modelo para relatar. Os dados do
barbo têm correção alométrica e populações identificadas; não transfira esses
fatos para outro conjunto nem interprete a reta desse exemplo como crescimento
individual. Referência de implementação: [documentação de lm](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/lm.html).

## Testes t: a variante pertence ao desenho

| Variante | Dados e pergunta | Conferência que muda o roteiro |
|---|---|---|
| Uma amostra | Medida quantitativa e referência justificada | Escala, independência e distribuição da medida |
| Independentes | Medida e dois grupos independentes | Tamanhos, dispersões, ordem dos grupos e escolha entre Welch e variância comum |
| Pareado | Duas medidas ligadas à mesma unidade | IDs, pares completos, sentido da diferença e distribuição das diferenças |

O padrão de `t.test()` para dois grupos é Welch (`var.equal = FALSE`);
`var.equal = TRUE` adota variância comum. Faça a escolha corresponder ao
estudo e à especificação canônica. Não a mude silenciosamente.

No artigo, apresente n pertinente, médias/DP, diferença estimada e IC,
t, graus de liberdade e p. Em uma amostra, informe a referência; no pareado,
número de pares e ordem da subtração. Se incluir efeito padronizado, declare
a definição e a variante apropriada; não trate todos os índices como o mesmo d.

Uma figura por grupos ou de pares pode sustentar a leitura. Não acrescente
R², Cook ou pós-teste de Tukey para imitar regressão/ANOVA.
Consulte [t.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/t.test.html).

## ANOVA de um fator

**Quando e dados:** comparar médias de uma resposta quantitativa entre níveis
de um fator, frequentemente três ou mais grupos. Identifique a unidade que
recebeu o tratamento: peixes medidos no mesmo tanque podem ser subamostras,
e a linha da base pode já representar uma média por tanque.

**Verificações:** replicação, perdas, desbalanceamento, independência pela
coleta, variâncias e resíduos, além de observações influentes quando relevante.
Não complete réplicas perdidas com valores inventados. Não pressuponha que
ANOVA de um fator resolve blocos, medidas repetidas ou múltiplos fatores.

**Artigo:** n e resumos por grupo, tabela ANOVA com SQ/gl/QM/F/p apropriados,
estimativas e incerteza das comparações relevantes, figura com pontos e resumo
identificado e síntese dos diagnósticos. Um F global não identifica os pares.
Defina a família de comparações e a correção; letras não substituem estimativas.

Tukey pertence ao modelo que o sustenta, não a qualquer comparação de grupos.
Uma ANOVA de Welch muda o procedimento e as comparações; não acople
`TukeyHSD()` mecanicamente. Trate tendências com doses quantitativas apenas
quando houver pergunta e níveis numéricos legítimos.

Referências: [aov](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/aov.html)
e [oneway.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/oneway.test.html).

## Qui-quadrado de independência

**Quando e dados:** investigar associação entre categorias a partir de
contagens; uma linha pode ser um indivíduo ou uma célula agregada, conforme a
base. Não entregue porcentagens à função como se fossem frequências absolutas.

**Verificações:** exclusividade das categorias, independência das unidades,
contagens, margens e frequências esperadas. Dados repetidos ou pareados não
se tornam independentes por serem organizados numa tabela.

**Artigo:** tabela de contagens e proporções com denominadores claros,
χ²/gl/p quando aplicáveis, tamanho amostral, correção ou simulação utilizada
e medida de associação pertinente se prevista. Na simulação, não invente um
grau de liberdade que o procedimento não fornece.

A adequação da aproximação depende das frequências esperadas. Se precisar
outro procedimento, verifique a especificação e explique a escolha. Simulação
requer semente e número de repetições documentados. Não aplique Shapiro nem
Q-Q de resíduos normais às contagens para autorizar o teste.

Qui-quadrado de aderência responde a outra pergunta, com proporções esperadas
especificadas; confirme seu escopo antes de incluí-lo.
Referência: [chisq.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html).

## Testes baseados em postos

Mann–Whitney compara grupos independentes; Wilcoxon de postos sinalizados
serve ao contexto pareado/uma amostra com condições próprias, incluindo
simetria para a interpretação usual de localização. Preserve o pareamento
e verifique empates e zeros conforme a implementação.

Apresente n, resumos adequados, a estatística com o nome retornado, p, método
exato ou aproximado e estimativa/IC quando justificáveis. Não renomeie a
estatística W automaticamente como U nem trate uma estimativa de deslocamento
como diferença de medianas. “Não paramétrico” não significa sem pressupostos.
Consulte [wilcox.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html).

Kruskal–Wallis trata vários grupos independentes. Examine as distribuições:
uma interpretação puramente como comparação de medianas exige condições
adicionais sobre suas formas. Relate n, resumos, estatística/gl/p e, se fizerem
parte da pergunta, comparações múltiplas coerentes com o método e ajuste de
multiplicidade. Não reaproveite Tukey só porque há vários grupos.
Consulte [kruskal.test](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/kruskal.test.html).

## Outras análises já disponíveis na CatalyseR

Não derive um roteiro completo apenas dos nomes desta tabela. Leia o módulo
canônico, a documentação da função e os dados; construa uma especificação
curta no raciocínio de trabalho antes de implementar.

| Método | O que precisa mudar em relação à regressão simples |
|---|---|
| Regressão logística | Resposta/evento e codificação explícitos; escala de probabilidades/log-odds; diagnósticos e estimativas próprios. Não exigir resíduos normais. |
| ANOVA de dois fatores / ANCOVA | Delineamento, interação, contrastes, covariável e significado das estimativas condicionais; não repetir várias ANOVAs simples como substituto. |
| Regressão não linear | Função e parâmetros biologicamente justificados, valores iniciais, convergência e incerteza; não transplantar interpretação da inclinação linear. |
| PCA | Matriz de variáveis, identificadores preservados, decisão de centralizar/padronizar, variância explicada, cargas e escores; não tratar como teste de efeito de tratamento. |
| Agrupamentos | Variáveis, escala, distância e método de ligação explícitos; justificar interpretação dos grupos sem apresentá-los como verdade biológica demonstrada. |

Se o método ultrapassar o escopo dominado e autorizado da v1, registre a
necessidade e esclareça a direção com o autor. Não acrescente um módulo novo
à CatalyseR como consequência automática de criar um caderno.

## Transferir a forma, não os resultados

Ao adaptar, percorra: nomes de objetos, pergunta, variáveis, unidades, dados,
amostra, hipóteses, cálculos, diagnósticos, tabelas, figuras, textos e referências.
Retire peças que só existiam pelo estudo anterior. Não deixe “população”,
“comprimento da cabeça”, “crescimento”, “reta” ou números do barbo num estudo
novo se esses elementos não lhe pertencem.

Verifique discrepâncias entre a documentação e os dados: número de réplicas,
unidade experimental, níveis, perdas e totais precisam concordar. Busque a
fonte pertinente quando houver conflito; não escolha a versão mais conveniente.
Os exemplos desta skill não constituem autorização para alterar os dados ou
adaptar uma pasta específica que aguarda instruções do autor.
