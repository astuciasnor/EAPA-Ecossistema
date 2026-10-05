invisible(Sys.setlocale("LC_ALL", "Portuguese_Brazil.utf8"))
setwd("D:/Claude/EAPA-Ecossistema/CATALYSER/inst/app")
library(shiny)
`%||%` <- function(a, b) if (is.null(a) || !length(a)) b else a
source("modules/ficha_planejamento.R", encoding = "UTF-8")
source("modules/mod_planejamento_variaveis.R", encoding = "UTF-8")
source("modules/mod_planejamento_observacional.R", encoding = "UTF-8")

# As escolhas novas devem mudar orientação e alcance, preservando dados e fórmula.
for (tipo_atual in c("longitudinal", "transversal_comparativo")) {
  testServer(mod_planejamento_observacional_server, args = list(tipo = tipo_atual), {
    session$setInputs(fator_nome = "ambiente", fator_niveis = "A, B", n_uas = 4,
      perda_pct = 0, momentos = "0, 60 dias", coluna_unidade = "tanque",
      n_vars_resposta = 1, var_nome_1 = "peso", var_unidade_1 = "g",
      n_medidas = 10, comparacao_ambiental = "na", tipo_unidade = "")
    original <- tabela_coleta_dados()
    formula_original <- output$card_modelo_estatistico
    session$setInputs(comparacao_ambiental = "categorias", tipo_unidade = "instaladas")
    stopifnot(identical(original, tabela_coleta_dados()),
      identical(formula_original, output$card_modelo_estatistico),
      grepl("ambientes distintos", texto_metodologia_artigo_str()),
      !grepl("[n]", texto_metodologia_artigo_str(), fixed = TRUE))
    excel <- output$baixar_planilha
    word <- output$baixar_relatorio
    orientacoes <- openxlsx::read.xlsx(excel, sheet = "orientacoes")$orientacao
    doc <- officer::docx_summary(officer::read_docx(word))$text
    stopifnot(any(grepl("Zero observado", orientacoes)),
      any(grepl("mensurativo", orientacoes)),
      any(grepl("confinamento", orientacoes)),
      any(grepl("ambientes distintos", doc)))
    if (tipo_atual == "longitudinal") {
      stopifnot(any(grepl("n_medidas", orientacoes)),
        identical(openxlsx::getSheetNames(excel), c("coleta", "unidades", "calendario", "orientacoes")))
      session$setInputs(conferir_locais = 1)
      session$setInputs(conferir_locais = 2)
      # O botão pode navegar sem alterar os registros.
      stopifnot(identical(original, tabela_coleta_dados()))
    }
    session$setInputs(comparacao_ambiental = "especificos", tipo_unidade = "naturais")
    stopifnot(grepl("ambientes estudados", texto_metodologia_artigo_str()),
      identical(original, tabela_coleta_dados()))
  })
  cat("OK: escolhas opcionais, fórmula preservada, Excel e Word -", tipo_atual, "\n")
}

# Construir as interfaces exercita condições R e conserva as abas existentes.
for (tipo in c("transversal_comparativo", "longitudinal", "gradiente", "impacto")) {
  html <- as.character(mod_planejamento_observacional_ui("obs", tipo = tipo))
  stopifnot(grepl("Definições", html), grepl("Modelo e cuidados", html))
  if (tipo == "gradiente") stopifnot(!grepl('id="obs-tipo_unidade"', html, fixed = TRUE))
}
source("modules/mod_experimental_design.R", encoding = "UTF-8")
stopifnot(grepl("Exemplo híbrido", as.character(mod_experimental_design_ui("split", tipo_fixo = "split_plot"))),
  !grepl("Exemplo híbrido", as.character(mod_experimental_design_ui("dic", tipo_fixo = "DIC"))))
cat("OK: interfaces e exemplo híbrido condicionado a Parcelas Subdivididas\n")

# Manter os testes existentes como evidência, registrando cada resultado.
resultados <- vapply(c("test_observacional_longitudinal.R", "test_observacional_gradiente.R",
  "test_observacional_impacto.R", "test_monitoramento.R", "test_transversal_saidas.R"), function(nome) {
  tryCatch({source(file.path("tests", nome), encoding = "UTF-8"); "PASSOU"},
    error = function(e) paste("FALHOU:", conditionMessage(e)))
}, character(1))
writeLines(paste(names(resultados), resultados, sep = ": "),
  "D:/Claude/EAPA-Ecossistema/APOIO/resultado_independencia_v1.txt", useBytes = TRUE)
print(resultados)
quit(save = "no", status = if (all(resultados == "PASSOU")) 0 else 1, runLast = FALSE)
