invisible(Sys.setlocale("LC_ALL", "Portuguese_Brazil.utf8"))
setwd("D:/Claude/EAPA-Ecossistema/CATALYSER/inst/app")
# Os arquivos antigos permanecem intactos. As cópias em memória usam os
# inputs atuais de quantidade e pool por grupo.
for (nome in c("test_observacional_longitudinal.R", "test_observacional_gradiente.R")) {
  linhas <- readLines(file.path("tests", nome), encoding = "UTF-8")
  if (nome == "test_observacional_longitudinal.R") {
    linhas <- sub('tipo_pool = "igual", pool_unico = 1,',
      'tipo_pool = "igual", pool_unico = 1, perda_pct = 0,', linhas, fixed = TRUE)
  } else {
    linhas <- sub('tipo_pool = "igual", pool_unico = 3,',
      paste0(paste(paste0('pool_grupo_', 1:8, ' = 3'), collapse = ', '), ','), linhas, fixed = TRUE)
    linhas <- sub('grepl("estudo de gradiente observacional", txt, fixed = TRUE)',
      'grepl("estudo observacional com", txt, fixed = TRUE)', linhas, fixed = TRUE)
    linhas <- sub('grepl("regressão linear simples", txt, fixed = TRUE)',
      'grepl("relacionar a resposta ao gradiente", txt, fixed = TRUE)', linhas, fixed = TRUE)
  }
  linhas <- sub('fator_niveis = "A, B", n_uas = 2,',
    'fator_niveis = "A, B", uas_grupo_1 = 2, uas_grupo_2 = 2, pool_grupo_1 = 1, pool_grupo_2 = 1,', linhas, fixed = TRUE)
  linhas <- sub('identical(names(f$eixos), "grupos")',
    '"grupos" %in% names(f$eixos)', linhas, fixed = TRUE)
  eval(parse(text = linhas), envir = .GlobalEnv)
  cat("PASSOU com inputs atuais:", nome, "\n")
}
quit(save = "no", status = 0, runLast = FALSE)
