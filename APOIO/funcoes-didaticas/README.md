# Funções didáticas de apresentação — primeira proposta

Esta é uma pasta para experimentar e revisar sete funções pequenas de apresentação. Elas ainda não estão integradas à CatalyseR, ao EAPADados ou aos projetos dos alunos. Não há compromisso de adotar todas: vamos avaliar se cada uma poupa repetição e continua fácil de explicar.

Abra `funcoes-didaticas.Rproj` no RStudio. Leia o [guia de ajuda](AJUDA.md) e abra [R/exemplos.R](R/exemplos.R). Execute o roteiro por partes. As definições estão em [R/funcoes.R](R/funcoes.R), com explicações de entrada, ação, saída e exemplos junto ao código.

Você precisa de EAPADados, ggplot2 e flextable instalados. O EAPADados vem do repositório do ecossistema; os outros dois são pacotes do CRAN. Se faltar algum, instale antes de executar os exemplos, em uma sessão própria de instalação. Nada é instalado automaticamente pelo roteiro.

```r
# Execute a partir da pasta aberta pelo .Rproj.
source("R/funcoes.R", encoding = "UTF-8")
dados <- as.data.frame(EAPADados::artemia)
texto_media_dp(mean(dados$taxa_crescimento_mg_dia),
               sd(dados$taxa_crescimento_mg_dia))
```

Para experimentar todas as funções de uma vez:

```r
source("R/exemplos.R", encoding = "UTF-8")
```

O exemplo usa `artemia`, um data.frame de **dados fictícios**, com ração A (farelo de arroz), ração B (farelo de babaçu) e taxa de crescimento em mg/dia. Consulte `?EAPADados::artemia` para conhecer o conjunto. Os dados foram escolhidos para ensinar o uso das funções; o roteiro não pretende substituir uma análise científica completa.

## Como usar a ajuda

[AJUDA.md](AJUDA.md) é o manual desta coleção: cada função tem seus parâmetros, a saída esperada, um exemplo com o data.frame e uma observação sobre interpretação. Os comentários antes de cada definição apresentam a mesma orientação curta. Em R/exemplos.R, cada chamada também explica o que recebe e o que devolve.

Para copiar uma função para um projeto, copie sua definição e os comentários. `formatar_p()`, `texto_media_dp()`, `texto_ic()` e `flextable_ocean()` também usam `formatar_numero()`; copie essa função junto. `tema_projeto()` e `cores_grupos()` podem ser usadas separadamente.

## Critérios para a revisão

O tamanho é adequado quando você consegue seguir o código e explicar os argumentos. Os cálculos permanecem no roteiro: `mean()`, `sd()` e `t.test()` aparecem à vista. As funções recebem números ou objetos já preparados e cuidam de sua apresentação. Os números originais continuam com sua precisão; os textos e tabelas exibidos podem ter menos casas decimais.

A paleta usa as cores Ocean do ecossistema. O tema cuida da aparência, mas não desenha automaticamente barras, intervalos ou pontos: essas camadas continuam explícitas no script.

A implementação destas funções ainda é uma proposta para sua revisão didática. Data da primeira proposta: 02/10/2026.

## Verificação desta proposta

Os sete exemplos foram executados em uma sessão nova de R 4.6.1, usando EAPADados 0.1.14. Foram conferidos a conservação dos valores numéricos originais, dados ausentes, p-valores pequenos, limites infinitos e mensagens para argumentos incompatíveis. O gráfico e a tabela HTML foram gerados durante a verificação. As ferramentas de validação ficaram fora desta pasta.

A execução foi verificada; a aprovação da clareza do código continua dependendo de sua leitura como professor.
