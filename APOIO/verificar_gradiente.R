Sys.setlocale("LC_ALL", "Portuguese_Brazil.utf8")
setwd("D:/Claude/EAPA-Ecossistema/catalyser/inst/app")
library(shiny)
`%||%` <- function(a, b) if (is.null(a) || !length(a)) b else a
source("modules/ficha_planejamento.R", encoding = "UTF-8")
source("modules/mod_planejamento_variaveis.R", encoding = "UTF-8")
source("modules/mod_planejamento_observacional.R", encoding = "UTF-8")
# Validar as saídas reais e os casos que afetam o infográfico.
testServer(mod_planejamento_observacional_server, args = list(tipo = "gradiente"), {
  session$setInputs(gradiente_nome = "distancia_fonte", gradiente_unidade = "m",
    modo_estacoes = "igual", estacao_inicio = 50, estacao_fim = 400, n_estacoes = 8,
    pool_grupo_1 = 3, pool_grupo_2 = 3, pool_grupo_3 = 3, pool_grupo_4 = 3,
    pool_grupo_5 = 3, pool_grupo_6 = 3, pool_grupo_7 = 3, pool_grupo_8 = 3, n_vars_resposta = 1,
    var_nome_1 = "abundancia", var_unidade_1 = "ind", gradiente_ambiente = "Estuário",
    gradiente_protocolo = "Esforço padronizado por estação")
  excel <- output$baixar_planilha
  word <- output$baixar_relatorio
  stopifnot(file.exists(excel), file.exists(word),
    identical(openxlsx::getSheetNames(excel), c("coleta", "estacoes", "orientacoes")),
    nrow(openxlsx::read.xlsx(excel, sheet = "estacoes")) == 8,
    identical(estacoes_gradiente()$valor_previsto, tabela_coleta_dados()$distancia_fonte),
    any(orientacoes_gradiente()$orientacao == "Esforço padronizado por estação"))
  doc <- officer::docx_summary(officer::read_docx(word))
  stopifnot(any(grepl("Delineamento observacional de gradiente", doc$text)),
    !any(grepl("Planejamento_03_TRANSVERSAL", doc$text)))
  # A figura também deve estar incorporada no Word.
  stopifnot(any(grepl("word/media/.*png", unzip(word, list = TRUE)$Name)))
  destino <- "D:/Claude/EAPA-Ecossistema/APOIO"
  file.copy(excel, file.path(destino, "gradiente_validacao.xlsx"), overwrite = TRUE)
  file.copy(word, file.path(destino, "gradiente_validacao.docx"), overwrite = TRUE)
  ggplot2::ggsave(file.path(destino, "gradiente_infografico.png"), esquema_observacional(),
    width = 11, height = 7.5, dpi = 120)
  for (n in c(2, 6, 12, 30)) {
    session$setInputs(n_estacoes = n)
    stopifnot(nrow(tabela_coleta_dados()) == n)
    invisible(ggplot2::ggplot_build(esquema_observacional()))
  }
  session$setInputs(modo_estacoes = "livre", valores_livres = "10, 10, 20, 80",
    tipo_pool = "desigual", pool_grupo_1 = 1, pool_grupo_2 = 2, pool_grupo_3 = 3, pool_grupo_4 = 4)
  stopifnot(identical(tabela_coleta_dados()$pool, 1:4))
  invisible(ggplot2::ggplot_build(esquema_observacional()))
  session$setInputs(modo_estacoes = "geometrico", estacao_inicio = 1, estacao_fim = 1000, n_estacoes = 8)
  invisible(ggplot2::ggplot_build(esquema_observacional()))
  session$setInputs(modo_estacoes = "geometrico", estacao_inicio = 50, estacao_fim = 400,
    n_estacoes = 8)
  grafico <- esquema_observacional()
  pontos <- ggplot2::ggplot_build(grafico)$data
  camada_pontos <- which(vapply(grafico$layers, function(x) inherits(x$geom, "GeomPoint"), logical(1)))
  pontos <- pontos[[camada_pontos]]$x
  esperado <- 1.3 + (estacoes_valores() - 50) / 350 * 13.4
  stopifnot(isTRUE(all.equal(pontos, esperado)), diff(pontos)[1] < diff(pontos)[7])
  word_escala <- output$baixar_relatorio
  stopifnot(file.exists(word_escala))
  ggplot2::ggsave(file.path(destino, "gradiente_infografico_escala.png"), grafico,
    width = 11, height = 7.5, dpi = 120)
  ggplot2::ggsave(file.path(destino, "gradiente_infografico.png"), esquema_observacional(),
    width = 11, height = 7.5, dpi = 120)
  session$setInputs(modo_estacoes = "livre", valores_livres = "10, 10, 10")
  invisible(ggplot2::ggplot_build(esquema_observacional()))
})
for (tipo in c("gradiente", "longitudinal", "transversal_comparativo", "impacto")) {
  ui <- as.character(mod_planejamento_observacional_ui("teste", tipo))
  ids <- regmatches(ui, gregexpr(' id="[^"]+"', ui))[[1]]
  stopifnot(!anyDuplicated(ids))
}
cat("OK: gradiente, sub-abas, Excel, Word com imagem e casos do desenho\n")
quit(save = "no", status = 0, runLast = FALSE)
