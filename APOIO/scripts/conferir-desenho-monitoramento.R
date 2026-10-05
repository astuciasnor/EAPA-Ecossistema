# Conferência visual do desenho da CatalyseR com definições ilustrativas.
# Execute a partir da pasta-mãe do ecossistema.
Sys.setlocale("LC_CTYPE", "Portuguese_Brazil.utf8")
source("catalyser/inst/app/modules/mod_monitoramento.R", encoding = "UTF-8")
destino <- "APOIO/revisao-planejamento-monitoramento"
dir.create(destino, recursive = TRUE, showWarnings = FALSE)
cfg <- montar_config(as.Date("2027-01-01"), as.Date("2030-12-01"), "mensal",
  "Baixa-mar diurna (conferir tábua de marés)", TRUE,
  c("Praia aberta", "Baía", "Estuário"), TRUE, "despescas",
  data.frame(nome = "captura", unidade = "kg"), TRUE)
ggplot2::ggsave(file.path(destino, "estrutura.png"), desenhar_plano_monitoramento(cfg),
  width = 12, height = 7.2, dpi = 150, bg = "white")
ggplot2::ggsave(file.path(destino, "calendario.png"), desenhar_calendario_monitoramento(cfg, 2027),
  width = 12, height = 3.6, dpi = 150, bg = "white")
ggplot2::ggsave(file.path(destino, "por-local.png"), desenhar_calendario_monitoramento(cfg, 2027, TRUE),
  width = 12, height = 4.5, dpi = 150, bg = "white")
# Conferimos também a densidade de uma série diária e nomes extensos.
cfg$datas <- datas_da_serie(as.Date("2028-02-15"), as.Date("2028-12-31"), "diaria")
cfg$frequencia_rotulo <- "Diária"
ggplot2::ggsave(file.path(destino, "calendario-diario.png"), desenhar_calendario_monitoramento(cfg, 2028),
  width = 12, height = 3.6, dpi = 150, bg = "white")
