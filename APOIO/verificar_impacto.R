Sys.setlocale("LC_ALL", "Portuguese_Brazil.utf8")
setwd("D:/Claude/EAPA-Ecossistema/catalyser/inst/app")
library(shiny)
`%||%` <- function(a, b) if (is.null(a) || !length(a)) b else a
source("modules/ficha_planejamento.R", encoding = "UTF-8")
source("modules/mod_planejamento_variaveis.R", encoding = "UTF-8")
source("modules/mod_planejamento_observacional.R", encoding = "UTF-8")
destino <- "D:/Claude/EAPA-Ecossistema/APOIO/revisao-planejamento-impacto"
dir.create(destino, showWarnings = FALSE)
testServer(mod_planejamento_observacional_server, args = list(tipo = "impacto"), {
  session$setInputs(tipo_impacto = "baci", fator_nome = "condicao", fator_niveis = "Impacto, Referência",
    coluna_unidade = "sitio", n_uas = 4, n_referencia = 4, impacto_antes = 6, impacto_depois = 6,
    impacto_subamostras = 3, n_vars_resposta = 1, var_nome_1 = "cpue", var_unidade_1 = "kg/arrasto",
    impacto_protocolo = "Três arrastos padronizados por sítio e campanha.")
  tab <- tabela_coleta_dados()
  stopifnot(nrow(tab) == 288, length(unique(tab$sitio)) == 8,
    all(table(tab$sitio) == 36), all(tab$cpue == ""), !"pool" %in% names(tab),
    identical(names(tab), dicionario_dados()$coluna), !anyDuplicated(tab[c("sitio", "campanha", "subamostra")]),
    is.null(ficha()$analise_sugerida))
  texto <- texto_metodologia_artigo_str()
  stopifnot(grepl("Será realizado", texto), !grepl("Foram amostrados|foi conduzida", texto),
    grepl("Três arrastos", texto))
  excel <- output$baixar_planilha
  word <- output$baixar_relatorio
  stopifnot(file.exists(excel), file.exists(word),
    identical(openxlsx::getSheetNames(excel), c("coleta", "sitios", "campanhas", "orientacoes")),
    nrow(openxlsx::read.xlsx(excel, "coleta")) == 288,
    any(grepl("word/media/.*png", unzip(word, list = TRUE)$Name)))
  doc <- officer::docx_summary(officer::read_docx(word))
  stopifnot(any(grepl("Planejamento de estudo de impacto BACI", doc$text)),
    !any(grepl("Planejamento_03_TRANSVERSAL", doc$text)))
  file.copy(excel, file.path(destino, "coleta_impacto_baci.xlsx"), overwrite = TRUE)
  file.copy(word, file.path(destino, "metodologia_impacto_baci.docx"), overwrite = TRUE)
  ggplot2::ggsave(file.path(destino, "esquema_impacto_baci.png"), esquema_observacional(), width = 11, height = 7.5, dpi = 130)
  # Um impacto específico com referências múltiplas não exige contagens iguais.
  session$setInputs(n_uas = 1, n_referencia = 3)
  stopifnot(nrow(sitios_impacto()) == 4, nrow(tabela_coleta_dados()) == 144)
  session$setInputs(tipo_impacto = "ba")
  stopifnot(nrow(tabela_coleta_dados()) == 36, !"condicao" %in% names(tabela_coleta_dados()))
  invisible(ggplot2::ggplot_build(esquema_observacional()))
  session$setInputs(tipo_impacto = "ci")
  stopifnot(nrow(tabela_coleta_dados()) == 72, all(campanhas_impacto()$periodo == "Depois"))
  invisible(ggplot2::ggplot_build(esquema_observacional()))
  session$setInputs(tipo_impacto = "baci", impacto_primeira_antes = "2028-02-01")
  stopifnot(inherits(try(tabela_coleta_dados(), silent = TRUE), "try-error"))
  session$setInputs(impacto_primeira_antes = "2027-01-15", var_nome_1 = "subamostra")
  stopifnot(inherits(try(tabela_coleta_dados(), silent = TRUE), "try-error"))
})
for (tipo in c("impacto", "gradiente", "longitudinal", "transversal_comparativo")) {
  ui <- as.character(mod_planejamento_observacional_ui("teste", tipo))
  ids <- regmatches(ui, gregexpr(' id="[^"]+"', ui))[[1]]
  stopifnot(!anyDuplicated(ids))
}
cat("OK: BACI, BA, CI, sítios desiguais, datas inválidas, nomes reservados, Excel, Word e desenho.\n")
quit(save = "no", status = 0, runLast = FALSE)
