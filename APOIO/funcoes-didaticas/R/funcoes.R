# Funções didáticas de apresentação — protótipo para leitura e experimentação.
# Este arquivo só define funções. Leia AJUDA.md e experimente R/exemplos.R.
# Os comentários explicam entradas e saídas; os cálculos ficam no roteiro.

# 1. formatar_numero -------------------------------------------------------
# Recebe: valor numérico (um número ou vetor) e casas decimais (padrão: 2).
# Faz: cria texto com vírgula decimal; não altera os números originais.
# Devolve: vetor de textos; NA/NaN aparecem como "não calculado".
# Exemplo com EAPADados: formatar_numero(mean(EAPADados::artemia$taxa_crescimento_mg_dia))
formatar_numero <- function(valor, casas = 2) {
  if (!is.numeric(valor)) stop("valor deve ser numérico.", call. = FALSE)
  if (!is.numeric(casas) || length(casas) != 1 || is.na(casas) || !casas %in% 0:15) {
    stop("casas deve ser um inteiro entre 0 e 15.", call. = FALSE)
  }
  texto <- formatC(valor, format = "f", digits = casas, decimal.mark = ",")
  texto[is.na(valor)] <- "não calculado"
  texto
}

# 2. formatar_p ------------------------------------------------------------
# Recebe: p entre 0 e 1, ou vetor de p-valores; casas (padrão: 3).
# Faz: valores abaixo de 0,001 viram "< 0,001", para não mostrar p = zero.
# Devolve: textos; não acrescenta "p =" e não decide significância.
# Exemplo: teste <- t.test(taxa_crescimento_mg_dia ~ racao, data = EAPADados::artemia)
#          formatar_p(teste$p.value)
formatar_p <- function(p, casas = 3) {
  if (!is.numeric(p) || any(p < 0 | p > 1, na.rm = TRUE)) {
    stop("p deve conter números entre 0 e 1, ou NA.", call. = FALSE)
  }
  if (!is.numeric(casas) || length(casas) != 1 || is.na(casas) || !casas %in% 3:15) {
    stop("Para p-valores, casas deve ser um inteiro entre 3 e 15.", call. = FALSE)
  }
  texto <- formatar_numero(p, casas)
  texto[!is.na(p) & p < 0.001] <- "< 0,001"
  texto
}

# 3. texto_media_dp --------------------------------------------------------
# Recebe: media e dp já calculados; casas (padrão: 2).
# Faz: une os números com o símbolo ±. Não calcula o DP nem um intervalo.
# Devolve: rótulos como "4,50 ± 2,45". Os vetores devem ter o mesmo tamanho.
# Exemplo: x <- EAPADados::artemia$taxa_crescimento_mg_dia
#          texto_media_dp(mean(x), sd(x))
texto_media_dp <- function(media, dp, casas = 2) {
  if (length(media) != length(dp)) stop("media e dp devem ter o mesmo tamanho.", call. = FALSE)
  if (!is.numeric(dp) || any(dp < 0, na.rm = TRUE)) stop("dp deve ser numérico e não negativo.", call. = FALSE)
  texto <- paste(formatar_numero(media, casas), "±", formatar_numero(dp, casas))
  texto[is.na(media) | is.na(dp)] <- "não calculado"
  texto
}

# 4. texto_ic --------------------------------------------------------------
# Recebe: inferior e superior já calculados, de mesmo tamanho; casas (2).
# Faz: reúne os limites entre colchetes. Não calcula a confiança do intervalo.
# Devolve: textos como "[2,10; 6,90]"; Inf/-Inf indicam limites não finitos.
# Exemplo: teste <- t.test(EAPADados::artemia$taxa_crescimento_mg_dia)
#          texto_ic(teste$conf.int[1], teste$conf.int[2])
texto_ic <- function(inferior, superior, casas = 2) {
  if (length(inferior) != length(superior)) stop("Os limites devem ter o mesmo tamanho.", call. = FALSE)
  inicio <- formatar_numero(inferior, casas)
  fim <- formatar_numero(superior, casas)
  if (any(inferior > superior, na.rm = TRUE)) stop("O limite inferior não pode superar o superior.", call. = FALSE)
  texto <- paste0("[", inicio, "; ", fim, "]")
  texto[is.na(inferior) | is.na(superior)] <- "não calculado"
  texto
}

# 5. tema_projeto ----------------------------------------------------------
# Recebe: tamanho_fonte positivo, em pontos (padrão: 12).
# Faz: define eixos, títulos e fundo. Não muda dados, escalas ou limites.
# Devolve: tema ggplot2, que se acrescenta ao gráfico com +.
# Exemplo: ggplot2::ggplot(EAPADados::artemia, ggplot2::aes(racao, taxa_crescimento_mg_dia)) +
#          ggplot2::geom_point() + tema_projeto(tamanho_fonte = 12)
tema_projeto <- function(tamanho_fonte = 12) {
  if (!is.numeric(tamanho_fonte) || length(tamanho_fonte) != 1 ||
      !is.finite(tamanho_fonte) || tamanho_fonte <= 0) stop("tamanho_fonte deve ser um número positivo.", call. = FALSE)
  ggplot2::theme_classic(base_size = tamanho_fonte) +
    ggplot2::theme(
      plot.title = ggplot2::element_text(face = "bold", colour = "#0F3B5F"),
      plot.title.position = "plot",
      legend.position = "bottom",
      plot.background = ggplot2::element_rect(fill = "white", colour = NA)
    )
}

# 6. cores_grupos ----------------------------------------------------------
# Recebe: nomes dos grupos, como texto ou fator; aceita a coluna inteira.
# Faz: retira repetições e NA, mantendo a ordem de primeira aparição.
# Devolve: vetor de cores nomeado; este protótipo atende até cinco grupos.
# Exemplo: cores_grupos(EAPADados::artemia$racao)
#          Use o vetor em scale_colour_manual(values = ...) ou scale_fill_manual().
cores_grupos <- function(grupos) {
  if (!is.character(grupos) && !is.factor(grupos)) stop("grupos deve ser texto ou fator.", call. = FALSE)
  nomes <- unique(as.character(grupos[!is.na(grupos)]))
  paleta <- c("#0F3B5F", "#E89B3C", "#2E7D8F", "#62B6B7", "#E76F51")
  if (length(nomes) > length(paleta)) stop("Esta paleta atende até cinco grupos.", call. = FALSE)
  stats::setNames(paleta[seq_along(nomes)], nomes)
}

# 7. flextable_ocean --------------------------------------------------------
# Recebe: tabela (data.frame com pelo menos uma coluna) e casas (2).
# Faz: formata as colunas numéricas e aplica o estilo Ocean.
# Devolve: flextable para Viewer ou Quarto; a tabela original continua numérica.
# Exemplo: tabela <- aggregate(taxa_crescimento_mg_dia ~ racao, EAPADados::artemia, mean)
#          flextable_ocean(tabela, casas = 2)
flextable_ocean <- function(tabela, casas = 2) {
  if (!is.data.frame(tabela) || ncol(tabela) == 0) stop("tabela deve ser um data.frame com colunas.", call. = FALSE)
  formatar_numero(0, casas) # Confere a escolha de casas antes de formatar.
  numericas <- names(tabela)[vapply(tabela, is.numeric, logical(1))]
  saida <- flextable::flextable(tabela) |> flextable::theme_booktabs()
  if (length(numericas)) {
    saida <- flextable::colformat_num(saida, j = numericas, digits = casas,
      decimal.mark = ",", big.mark = ".", na_str = "não calculado")
  }
  saida |>
    flextable::bg(bg = "#0F3B5F", part = "header") |>
    flextable::color(color = "white", part = "header") |>
    flextable::bold(part = "header") |>
    flextable::font(fontname = "Calibri", part = "all") |>
    flextable::fontsize(size = 11, part = "all") |>
    flextable::align(align = "center", part = "all") |>
    flextable::align(j = 1, align = "left", part = "all") |>
    flextable::autofit()
}
