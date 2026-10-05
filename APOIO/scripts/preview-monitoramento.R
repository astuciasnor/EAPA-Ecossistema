# Servidor local para conferir o painel isoladamente, sem carregar dados pessoais.
Sys.setlocale("LC_CTYPE", "Portuguese_Brazil.utf8")
library(shiny)
`%||%` <- function(a, b) if (is.null(a) || !length(a)) b else a
source("catalyser/inst/app/modules/mod_monitoramento.R", encoding = "UTF-8")
ui <- bslib::page_fluid(theme = bslib::bs_theme(version = 5),
  mod_monitoramento_ui("monitoramento"))
server <- function(input, output, session) mod_monitoramento_server("monitoramento")
shiny::runApp(shiny::shinyApp(ui, server), host = "127.0.0.1", port = 3891, launch.browser = FALSE)
