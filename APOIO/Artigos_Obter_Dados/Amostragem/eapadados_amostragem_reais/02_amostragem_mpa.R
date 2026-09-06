# 02_amostragem_mpa.R
# Objetivo: exemplos de AAS e amostragem estratificada proporcional com bases reais já processadas.
#
# Rode primeiro: 01_ler_padronizar_mpa.R

library(tidyverse)
library(fs)

# -------------------------------------------------------------------------
# 1. Funções de amostragem
# -------------------------------------------------------------------------

amostrar_aas <- function(dados, n, seed = 123) {
  set.seed(seed)
  dados |> dplyr::slice_sample(n = min(n, nrow(dados)))
}

plano_estratificado_prop <- function(dados, estrato, n_total) {
  estrato <- rlang::ensym(estrato)

  dados |>
    dplyr::filter(!is.na(!!estrato)) |>
    dplyr::count(!!estrato, name = "N_h") |>
    dplyr::mutate(
      N = sum(N_h),
      prop = N_h / N,
      n_h_bruto = n_total * prop,
      n_h = round(n_h_bruto)
    ) |>
    dplyr::arrange(dplyr::desc(N_h))
}

amostrar_estratificada_prop <- function(dados, estrato, n_total, seed = 123) {
  set.seed(seed)
  estrato <- rlang::ensym(estrato)
  nome_estrato <- rlang::as_string(estrato)

  plano <- plano_estratificado_prop(dados, !!estrato, n_total)

  amostra <- dados |>
    dplyr::filter(!is.na(!!estrato)) |>
    dplyr::inner_join(plano |> dplyr::select(!!estrato, n_h), by = nome_estrato) |>
    dplyr::group_by(!!estrato) |>
    dplyr::group_modify(~ {
      nh <- unique(.x$n_h)
      dplyr::slice_sample(.x, n = min(nh, nrow(.x)))
    }) |>
    dplyr::ungroup() |>
    dplyr::select(-n_h)

  list(plano = plano, amostra = amostra)
}

# -------------------------------------------------------------------------
# 2. Exemplos com embarcações autorizadas
# -------------------------------------------------------------------------

if (fs::file_exists("dados_processados/mpa_embarcacoes.rds")) {
  mpa_embarcacoes <- readRDS("dados_processados/mpa_embarcacoes.rds")

  # AAS com embarcações
  amostra_embarcacoes_aas <- amostrar_aas(mpa_embarcacoes, n = 80)

  # Estratificada por UF
  if ("uf" %in% names(mpa_embarcacoes)) {
    res_uf <- amostrar_estratificada_prop(mpa_embarcacoes, uf, n_total = 80)
    readr::write_csv(res_uf$plano, "dados_processados/plano_embarcacoes_por_uf.csv")
    saveRDS(res_uf$amostra, "dados_processados/amostra_embarcacoes_por_uf.rds")
  }

  # Estratificada por petrecho
  if ("petrecho" %in% names(mpa_embarcacoes)) {
    res_petrecho <- amostrar_estratificada_prop(mpa_embarcacoes, petrecho, n_total = 80)
    readr::write_csv(res_petrecho$plano, "dados_processados/plano_embarcacoes_por_petrecho.csv")
    saveRDS(res_petrecho$amostra, "dados_processados/amostra_embarcacoes_por_petrecho.rds")
  }

  # Estratificada por classe de comprimento
  if ("classe_comprimento" %in% names(mpa_embarcacoes)) {
    res_comp <- amostrar_estratificada_prop(mpa_embarcacoes, classe_comprimento, n_total = 80)
    readr::write_csv(res_comp$plano, "dados_processados/plano_embarcacoes_por_classe_comprimento.csv")
    saveRDS(res_comp$amostra, "dados_processados/amostra_embarcacoes_por_classe_comprimento.rds")
  }

  # Estratificada por AB
  if ("classe_ab" %in% names(mpa_embarcacoes)) {
    res_ab <- amostrar_estratificada_prop(mpa_embarcacoes, classe_ab, n_total = 80)
    readr::write_csv(res_ab$plano, "dados_processados/plano_embarcacoes_por_classe_ab.csv")
    saveRDS(res_ab$amostra, "dados_processados/amostra_embarcacoes_por_classe_ab.rds")
  }

  saveRDS(amostra_embarcacoes_aas, "dados_processados/amostra_embarcacoes_aas.rds")
}

# -------------------------------------------------------------------------
# 3. Exemplos com Mapas de Bordo
# -------------------------------------------------------------------------

if (fs::file_exists("dados_processados/mpa_mapas_bordo.rds")) {
  mpa_mapas_bordo <- readRDS("dados_processados/mpa_mapas_bordo.rds")

  amostra_mapas_aas <- amostrar_aas(mpa_mapas_bordo, n = 80)
  saveRDS(amostra_mapas_aas, "dados_processados/amostra_mapas_bordo_aas.rds")

  if ("uf" %in% names(mpa_mapas_bordo)) {
    res_mapas_uf <- amostrar_estratificada_prop(mpa_mapas_bordo, uf, n_total = 80)
    readr::write_csv(res_mapas_uf$plano, "dados_processados/plano_mapas_por_uf.csv")
    saveRDS(res_mapas_uf$amostra, "dados_processados/amostra_mapas_por_uf.rds")
  }

  if ("tipo_embarcacao" %in% names(mpa_mapas_bordo)) {
    res_mapas_tipo <- amostrar_estratificada_prop(mpa_mapas_bordo, tipo_embarcacao, n_total = 80)
    readr::write_csv(res_mapas_tipo$plano, "dados_processados/plano_mapas_por_tipo_embarcacao.csv")
    saveRDS(res_mapas_tipo$amostra, "dados_processados/amostra_mapas_por_tipo_embarcacao.rds")
  }

  if ("classe_comprimento" %in% names(mpa_mapas_bordo)) {
    res_mapas_comp <- amostrar_estratificada_prop(mpa_mapas_bordo, classe_comprimento, n_total = 80)
    readr::write_csv(res_mapas_comp$plano, "dados_processados/plano_mapas_por_classe_comprimento.csv")
    saveRDS(res_mapas_comp$amostra, "dados_processados/amostra_mapas_por_classe_comprimento.rds")
  }
}

# -------------------------------------------------------------------------
# 4. Exemplos com aquicultores
# -------------------------------------------------------------------------

if (fs::file_exists("dados_processados/mpa_aquicultores.rds")) {
  mpa_aquicultores <- readRDS("dados_processados/mpa_aquicultores.rds")

  amostra_aquic_aas <- amostrar_aas(mpa_aquicultores, n = 80)
  saveRDS(amostra_aquic_aas, "dados_processados/amostra_aquicultores_aas.rds")

  if ("uf" %in% names(mpa_aquicultores)) {
    res_aquic_uf <- amostrar_estratificada_prop(mpa_aquicultores, uf, n_total = 80)
    readr::write_csv(res_aquic_uf$plano, "dados_processados/plano_aquicultores_por_uf.csv")
    saveRDS(res_aquic_uf$amostra, "dados_processados/amostra_aquicultores_por_uf.rds")
  }

  if ("sistema_cultivo" %in% names(mpa_aquicultores)) {
    res_aquic_sistema <- amostrar_estratificada_prop(mpa_aquicultores, sistema_cultivo, n_total = 80)
    readr::write_csv(res_aquic_sistema$plano, "dados_processados/plano_aquicultores_por_sistema_cultivo.csv")
    saveRDS(res_aquic_sistema$amostra, "dados_processados/amostra_aquicultores_por_sistema_cultivo.rds")
  }
}

message("Exemplos de amostragem concluídos. Veja a pasta dados_processados/.")
