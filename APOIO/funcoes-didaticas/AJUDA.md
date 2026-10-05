# Ajuda das funções didáticas

Abra o .Rproj e prepare os exemplos uma vez:

```r
source("R/funcoes.R", encoding = "UTF-8")
dados <- as.data.frame(EAPADados::artemia)
x <- dados$taxa_crescimento_mg_dia
```

`dados` é um data.frame. Cada linha é uma observação do exemplo fictício; `racao` identifica A ou B, e `taxa_crescimento_mg_dia` contém o crescimento em mg/dia. As chamadas abaixo usam essa mesma base. A execução completa e comentada está em R/exemplos.R.

## 1. formatar_numero(valor, casas = 2)

Use para apresentar números com vírgula decimal. Você fornece `valor`, um número ou vetor numérico, e `casas`, um inteiro entre 0 e 15. A função devolve texto, sem modificar o valor numérico fornecido. NA e NaN aparecem como “não calculado”; limites infinitos continuam como Inf ou -Inf.

```r
media <- mean(x, na.rm = TRUE)
formatar_numero(valor = media, casas = 2)
# Você também pode formatar vários valores de uma vez.
formatar_numero(valor = x[1:3], casas = 1)
```

Faça contas com `media`, que continua numérica. O texto formatado é para rótulos, tabelas e narrativa.

## 2. formatar_p(p, casas = 3)

Use para apresentar o p-valor de um teste já realizado. `p` aceita um número ou vetor entre 0 e 1, além de NA; `casas` aceita de 3 a 15. Valores menores que 0,001 são apresentados como “< 0,001”. Os demais usam o número de casas solicitado. A saída é texto, sem o prefixo “p =”.

```r
teste <- stats::t.test(taxa_crescimento_mg_dia ~ racao, data = dados,
  var.equal = FALSE, alternative = "two.sided")
formatar_p(p = teste$p.value, casas = 3)
```

O exemplo realiza um teste bilateral de Welch. A função de formatação não escolhe hipótese, método ou nível de significância. Compare o p-valor numérico original ao seu alfa; não use o texto arredondado para decidir. O mínimo de três casas ajuda a distinguir valores próximos do limite de apresentação de 0,001.

## 3. texto_media_dp(media, dp, casas = 2)

Use para formar um rótulo de média ± desvio padrão. `media` e `dp` são valores numéricos já calculados, ou vetores de mesmo tamanho; DP não pode ser negativo. `casas` controla a apresentação dos dois valores. A saída é texto. Se faltar um dos valores, o rótulo será “não calculado”.

```r
x_a <- dados$taxa_crescimento_mg_dia[dados$racao == "A"]
x_a <- x_a[!is.na(x_a)]
media_a <- mean(x_a)
dp_a <- stats::sd(x_a)
texto_media_dp(media = media_a, dp = dp_a, casas = 2)
```

O desvio padrão descreve a dispersão dos indivíduos da ração A. Média ± DP não é um intervalo de confiança. Aqui usamos `sd()`, o desvio padrão amostral do R.

## 4. texto_ic(inferior, superior, casas = 2)

Use para escrever limites já calculados entre colchetes, separados por ponto e vírgula. `inferior` e `superior` são números ou vetores de mesmo tamanho. O limite inferior não pode exceder o superior. `casas` controla os dois limites. A função devolve texto; se faltar um limite, devolve “não calculado”.

```r
teste <- stats::t.test(taxa_crescimento_mg_dia ~ racao, data = dados,
  var.equal = FALSE, conf.level = .95)
texto_ic(inferior = teste$conf.int[1], superior = teste$conf.int[2], casas = 2)
```

Neste exemplo, os limites descrevem o IC de 95% da diferença entre as médias A − B, conforme a ordem dos níveis da ração no teste. A função não calcula o IC nem identifica o parâmetro: explique essas informações no texto que acompanha o intervalo. Inf e -Inf podem ocorrer em intervalos unilaterais e significam um limite não finito.

## 5. tema_projeto(tamanho_fonte = 12)

Use para acrescentar a aparência comum do projeto a um gráfico ggplot2. `tamanho_fonte` é um número positivo, em pontos. A função devolve um tema que se acrescenta com `+`. Os títulos usam a cor NAVY, as legendas ficam embaixo e o fundo é branco.

```r
ggplot2::ggplot(dados, ggplot2::aes(x = racao, y = taxa_crescimento_mg_dia)) +
  ggplot2::geom_point() +
  ggplot2::labs(x = "Ração", y = "Crescimento (mg/dia)") +
  tema_projeto(tamanho_fonte = 12)
```

Este exemplo simples pode ter pontos sobrepostos. O roteiro completo mostra como acrescentar deslocamento horizontal. O tema não altera escalas, dados, limites dos eixos nem o significado dos gráficos.

## 6. cores_grupos(grupos)

Use para obter um vetor de cores identificado pelos nomes dos grupos. `grupos` pode ser a coluna inteira, um vetor de textos ou um fator. A função remove NA e repetições e mantém a ordem de primeira aparição. A paleta Ocean desta proposta atende até cinco grupos; mais grupos produzem uma mensagem para você rever a escolha.

```r
paleta <- cores_grupos(grupos = dados$racao)
paleta
ggplot2::ggplot(dados,
  ggplot2::aes(x = racao, y = taxa_crescimento_mg_dia, colour = racao)) +
  ggplot2::geom_point() +
  ggplot2::scale_colour_manual(values = paleta) +
  tema_projeto()
```

Guarde `paleta` e reutilize esse vetor em todos os gráficos do estudo. Se recalcular a paleta depois de filtrar ou ordenar os dados, a associação de cores pode mudar. Para preenchimentos de barras, use `scale_fill_manual(values = paleta)` e o mapeamento `fill = racao`.

## 7. flextable_ocean(tabela, casas = 2)

Use para apresentar uma tabela no Viewer ou no Quarto. `tabela` deve ser um data.frame com pelo menos uma coluna. `casas` define a apresentação de todas as colunas numéricas, entre 0 e 15. A função devolve uma flextable com cabeçalho Ocean, texto do cabeçalho branco e fonte Calibri. A tabela de entrada mantém seus valores e tipos.

```r
tabela <- stats::aggregate(taxa_crescimento_mg_dia ~ racao, data = dados, FUN = mean)
names(tabela) <- c("Ração", "Média (mg/dia)")
tabela_exibir <- flextable_ocean(tabela = tabela, casas = 2)
tabela_exibir
```

O cálculo das médias está em `aggregate()`. A função só apresenta o resultado. Neste protótipo, a mesma quantidade de casas é aplicada a todas as colunas numéricas, inclusive contagens; tabelas que precisem de formatos diferentes por coluna poderão receber uma adaptação posterior. No Quarto, a legenda e a numeração pertencem ao chunk da tabela.

## Resultados para você conferir

Na validação com EAPADados 0.1.14, os exemplos produziram:

| Chamada do exemplo | Texto apresentado |
|---|---|
| Média geral com duas casas | `3,78` |
| p-valor do teste bilateral de Welch | `0,014` |
| Média ± DP da ração A | `4,09 ± 0,40` |
| IC de 95% da diferença A − B | `[0,15; 1,08]` |

Esses valores ajudam a conferir a execução desta base; não são constantes gravadas nas funções. Eles continuam sendo calculados a partir de `dados`. A média da ração B na tabela é apresentada como `3,47`.

## Antes de copiar para um projeto

Estas funções são uma primeira proposta. Leia os comentários, experimente mudar os argumentos e observe o resultado. Conserve uma explicação curta ao lado de cada chamada no script do aluno. Quando uma função usar `formatar_numero()`, copie essa definição junto. As definições não fazem uma análise ao serem carregadas com `source()`.
