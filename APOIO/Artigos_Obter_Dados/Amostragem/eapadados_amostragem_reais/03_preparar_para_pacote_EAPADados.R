# 03_preparar_para_pacote_EAPADados.R
# Objetivo: criar objetos menores e seguros para entrar no pacote EAPADados.
#
# Recomendações:
# - Não incluir CPF, mesmo tarjado.
# - Remover nomes de pessoas físicas quando não forem necessários.
# - Manter variáveis de desenho amostral, localização ampla e medidas técnicas.

library(tidyverse)
library(fs)

dir_create("dados_pacote")

remover_colunas_sensiveis <- function(dados) {
  padroes <- c("cpf", "cnpj", "nome_pessoa", "nome_razao", "razao_social", "endereco", "telefone", "email")
  cols_remover <- names(dados)[stringr::str_detect(names(dados), paste(padroes, collapse = "|"))]
  dados |> dplyr::select(-dplyr::any_of(cols_remover))
}

salvar_base_pacote <- function(arquivo_rds, nome_objeto, n_max = 1000) {
  dados <- readRDS(arquivo_rds) |>
    remover_colunas_sensiveis()

  if (nrow(dados) > n_max) {
    set.seed(123)
    dados <- dados |> dplyr::slice_sample(n = n_max)
  }

  assign(nome_objeto, dados)
  save(list = nome_objeto, file = file.path("dados_pacote", paste0(nome_objeto, ".rda")))
}

if (file_exists("dados_processados/mpa_embarcacoes.rds")) {
  salvar_base_pacote("dados_processados/mpa_embarcacoes.rds", "mpa_embarcacoes", n_max = 1000)
}

if (file_exists("dados_processados/mpa_mapas_bordo.rds")) {
  salvar_base_pacote("dados_processados/mpa_mapas_bordo.rds", "mpa_mapas_bordo", n_max = 1000)
}

if (file_exists("dados_processados/mpa_pargo.rds")) {
  salvar_base_pacote("dados_processados/mpa_pargo.rds", "mpa_pargo", n_max = 1000)
}

if (file_exists("dados_processados/mpa_tainha.rds")) {
  salvar_base_pacote("dados_processados/mpa_tainha.rds", "mpa_tainha", n_max = 1000)
}

if (file_exists("dados_processados/mpa_sardinha.rds")) {
  salvar_base_pacote("dados_processados/mpa_sardinha.rds", "mpa_sardinha", n_max = 1000)
}

if (file_exists("dados_processados/mpa_aquicultores.rds")) {
  salvar_base_pacote("dados_processados/mpa_aquicultores.rds", "mpa_aquicultores", n_max = 1000)
}

message("Arquivos .rda criados em dados_pacote/.")
