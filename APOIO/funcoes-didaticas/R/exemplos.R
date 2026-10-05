# Exemplos das funções didáticas — execute a partir deste .Rproj.
# Usamos artemia: dados fictícios de crescimento (mg/dia), por ração A ou B.
# A origem e as variáveis podem ser consultadas com ?EAPADados::artemia.
# Estes exemplos ensinam apresentação; não constituem uma análise completa.

# 1. Carregar as funções e os dados ---------------------------------------
source("R/funcoes.R", encoding = "UTF-8")
dados <- as.data.frame(EAPADados::artemia)
str(dados)

# 2. Formatar um número ---------------------------------------------------
# mean() calcula; formatar_numero() recebe esse valor e devolve só texto.
x <- dados$taxa_crescimento_mg_dia
media_geral <- mean(x, na.rm = TRUE)
print(formatar_numero(media_geral, casas = 2))

# 3. Apresentar o p-valor -------------------------------------------------
# Fazemos um teste bilateral de Welch de propósito neste exemplo.
# formatar_p() recebe o p-valor do teste; não muda a hipótese nem escolhe o método.
teste <- stats::t.test(taxa_crescimento_mg_dia ~ racao, data = dados,
  var.equal = FALSE, alternative = "two.sided", conf.level = .95)
print(teste) # Conheça também a saída original do R.
print(formatar_p(teste$p.value, casas = 3))

# 4. Escrever média ± DP de uma ração -------------------------------------
# Selecionamos A explicitamente para não misturar os grupos.
x_a <- dados$taxa_crescimento_mg_dia[dados$racao == "A"]
x_a <- x_a[!is.na(x_a)]
media_a <- mean(x_a)
dp_a <- stats::sd(x_a)
# texto_media_dp() recebe média e DP já calculados e devolve um rótulo.
print(texto_media_dp(media_a, dp_a, casas = 2))

# 5. Escrever os limites do IC -------------------------------------------
# Aqui mostramos o IC da diferença entre as médias, fornecido pelo teste.
# texto_ic() recebe dois limites e devolve um texto entre colchetes.
print(texto_ic(teste$conf.int[1], teste$conf.int[2], casas = 2))
# O DP acima descreve dispersão individual; este IC descreve incerteza da diferença.

# 6. Escolher cores por grupo --------------------------------------------
# cores_grupos() recebe a coluna de rações e devolve cores identificadas por nome.
# Guarde o vetor para reutilizar as mesmas cores em todos os gráficos do estudo.
paleta <- cores_grupos(dados$racao)
print(paleta)

# 7. Aplicar o tema a um gráfico -----------------------------------------
# O tema recebe o tamanho da fonte e devolve a aparência comum do gráfico.
# Todas as camadas e escolhas do desenho continuam visíveis abaixo.
grafico <- ggplot2::ggplot(dados,
  ggplot2::aes(x = racao, y = taxa_crescimento_mg_dia, colour = racao)) +
  ggplot2::geom_point(position = ggplot2::position_jitter(width = .06, height = 0, seed = 123)) +
  ggplot2::scale_colour_manual(values = paleta) +
  ggplot2::labs(title = "Crescimento de Artemia por ração",
    subtitle = "Dados fictícios para aprendizagem", x = "Ração", y = "Crescimento (mg/dia)") +
  tema_projeto(tamanho_fonte = 12)
print(grafico)

# 8. Apresentar uma tabela ------------------------------------------------
# aggregate() calcula a média por ração, de modo visível no roteiro.
tabela <- stats::aggregate(taxa_crescimento_mg_dia ~ racao, data = dados, FUN = mean)
names(tabela) <- c("Ração", "Média (mg/dia)")
# flextable_ocean() recebe o data.frame e devolve sua versão de apresentação.
# casas controla a exibição de todas as colunas numéricas; não altera tabela.
tabela_exibir <- flextable_ocean(tabela, casas = 2)
print(tabela_exibir)
