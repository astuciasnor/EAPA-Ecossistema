# 01_ler_padronizar_mpa.R
# Objetivo: ler CSVs reais baixados do Dados.gov/MPA, padronizar nomes e criar bases limpas.
# Autor: EAPADados - rotina didática
#
# Como usar:
# 1) Baixe os CSVs oficiais pelo Dados.gov.
# 2) Coloque os arquivos em dados_brutos/.
# 3) Ajuste, se necessário, os padrões de nome dos arquivos na seção "Arquivos esperados".
# 4) Rode este script.
#
# Pacotes necessários:
# install.packages(c("tidyverse", "janitor", "fs", "lubridate", "readr"))

library(tidyverse)
library(janitor)
library(fs)
library(lubridate)
library(readr)

dir_create("dados_brutos")
dir_create("dados_processados")
dir_create("metadados")

# -------------------------------------------------------------------------
# 1. Links oficiais para abrir no navegador
# -------------------------------------------------------------------------

links_catalogo <- tibble::tribble(
  ~base, ~url_catalogo,
  "Embarcações autorizadas",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-das-autorizacoes-das-embarcacoes-de-pesca",

  "Mapas de Bordo",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-mapas-de-bordo",

  "Captura de pargo",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-captura-da-especie-pargo",

  "Captura de tainha",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-captura-da-especie-tainha",

  "Sardinha-verdadeira",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-da-especie-sardinha-verdadeira",

  "Registros de aquicultores",
  "https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-registros-de-aquicultores"
)

readr::write_csv(links_catalogo, "metadados/links_catalogo_mpa.csv")

abrir_links_catalogo <- function() {
  purrr::walk(links_catalogo$url_catalogo, browseURL)
}

# Descomente se quiser abrir os links:
# abrir_links_catalogo()

# -------------------------------------------------------------------------
# 2. Leitura flexível de CSV
# -------------------------------------------------------------------------

ler_csv_flex <- function(arquivo) {
  message("Lendo: ", arquivo)

  tentativas <- list(
    function(x) readr::read_csv2(x, locale = locale(encoding = "UTF-8"), show_col_types = FALSE),
    function(x) readr::read_csv2(x, locale = locale(encoding = "Latin1"), show_col_types = FALSE),
    function(x) readr::read_csv(x,  locale = locale(encoding = "UTF-8"), show_col_types = FALSE),
    function(x) readr::read_csv(x,  locale = locale(encoding = "Latin1"), show_col_types = FALSE)
  )

  for (f in tentativas) {
    out <- try(f(arquivo), silent = TRUE)
    if (!inherits(out, "try-error") && ncol(out) > 1) {
      return(out |> janitor::clean_names())
    }
  }

  stop("Não consegui ler o arquivo: ", arquivo)
}

localizar_arquivo <- function(padrao) {
  arqs <- fs::dir_ls("dados_brutos", regexp = padrao, recurse = FALSE)
  if (length(arqs) == 0) return(NA_character_)
  arqs[1]
}

# -------------------------------------------------------------------------
# 3. Funções auxiliares para padronização
# -------------------------------------------------------------------------

pegar_coluna <- function(dados, candidatos) {
  candidatos <- janitor::make_clean_names(candidatos)
  achou <- intersect(candidatos, names(dados))
  if (length(achou) == 0) return(NA_character_)
  achou[1]
}

criar_classe_comprimento <- function(x) {
  x <- readr::parse_number(as.character(x), locale = locale(decimal_mark = ","))
  dplyr::case_when(
    is.na(x) ~ NA_character_,
    x < 8 ~ "< 8 m",
    x >= 8 & x < 12 ~ "8 a <12 m",
    x >= 12 & x < 15 ~ "12 a <15 m",
    x >= 15 & x < 20 ~ "15 a <20 m",
    x >= 20 ~ ">= 20 m"
  )
}

criar_classe_ab <- function(x) {
  x <- readr::parse_number(as.character(x), locale = locale(decimal_mark = ","))
  dplyr::case_when(
    is.na(x) ~ NA_character_,
    x < 10 ~ "< 10 AB",
    x >= 10 & x < 20 ~ "10 a <20 AB",
    x >= 20 & x < 50 ~ "20 a <50 AB",
    x >= 50 ~ ">= 50 AB"
  )
}

criar_classe_quantitativa <- function(x, nome = "classe") {
  x <- readr::parse_number(as.character(x), locale = locale(decimal_mark = ","))
  q <- quantile(x, probs = c(0, .25, .50, .75, 1), na.rm = TRUE)

  # Se houver muitos valores repetidos, evita erro do cut
  q <- unique(q)
  if (length(q) < 3) {
    return(ifelse(is.na(x), NA_character_, paste0(nome, "_geral")))
  }

  cut(
    x,
    breaks = q,
    include.lowest = TRUE,
    labels = paste0(nome, "_Q", seq_len(length(q) - 1))
  ) |>
    as.character()
}

# -------------------------------------------------------------------------
# 4. Arquivos esperados
# -------------------------------------------------------------------------
# Ajuste os padrões se os nomes baixados vierem diferentes.

arq_embarcacoes <- localizar_arquivo("(?i)embarc|autoriza")
arq_mapas      <- localizar_arquivo("(?i)mapa.*bordo|bordo")
arq_pargo      <- localizar_arquivo("(?i)pargo")
arq_tainha     <- localizar_arquivo("(?i)tainha")
arq_sardinha   <- localizar_arquivo("(?i)sardinha")
arq_aquic      <- localizar_arquivo("(?i)aquicult")

# -------------------------------------------------------------------------
# 5. Leitura e padronização
# -------------------------------------------------------------------------

if (!is.na(arq_embarcacoes)) {
  mpa_embarcacoes <- ler_csv_flex(arq_embarcacoes)

  col_compr <- pegar_coluna(mpa_embarcacoes, c("comprimento", "comprimento_total", "comprimento_m"))
  col_ab    <- pegar_coluna(mpa_embarcacoes, c("ab", "arqueacao_bruta", "arqueacao"))

  if (!is.na(col_compr)) {
    mpa_embarcacoes <- mpa_embarcacoes |>
      mutate(classe_comprimento = criar_classe_comprimento(.data[[col_compr]]))
  }

  if (!is.na(col_ab)) {
    mpa_embarcacoes <- mpa_embarcacoes |>
      mutate(classe_ab = criar_classe_ab(.data[[col_ab]]))
  }

  saveRDS(mpa_embarcacoes, "dados_processados/mpa_embarcacoes.rds")
}

if (!is.na(arq_mapas)) {
  mpa_mapas_bordo <- ler_csv_flex(arq_mapas)

  col_compr <- pegar_coluna(mpa_mapas_bordo, c("comprimento", "comprimento_total", "comprimento_m"))

  if (!is.na(col_compr)) {
    mpa_mapas_bordo <- mpa_mapas_bordo |>
      mutate(classe_comprimento = criar_classe_comprimento(.data[[col_compr]]))
  }

  saveRDS(mpa_mapas_bordo, "dados_processados/mpa_mapas_bordo.rds")
}

if (!is.na(arq_pargo)) {
  mpa_pargo <- ler_csv_flex(arq_pargo)

  col_prod <- pegar_coluna(mpa_pargo, c("producao_t", "producao", "captura", "quantidade", "peso_kg"))

  if (!is.na(col_prod)) {
    mpa_pargo <- mpa_pargo |>
      mutate(classe_producao = criar_classe_quantitativa(.data[[col_prod]], "producao"))
  }

  saveRDS(mpa_pargo, "dados_processados/mpa_pargo.rds")
}

if (!is.na(arq_tainha)) {
  mpa_tainha <- ler_csv_flex(arq_tainha)

  col_cap <- pegar_coluna(mpa_tainha, c("captura_total_tainha_kg", "captura_total", "peso_tainha_recebido_kg", "peso_kg"))

  if (!is.na(col_cap)) {
    mpa_tainha <- mpa_tainha |>
      mutate(classe_captura = criar_classe_quantitativa(.data[[col_cap]], "captura"))
  }

  saveRDS(mpa_tainha, "dados_processados/mpa_tainha.rds")
}

if (!is.na(arq_sardinha)) {
  mpa_sardinha <- ler_csv_flex(arq_sardinha)

  col_qtd <- pegar_coluna(mpa_sardinha, c("quantidade_capturada_kg", "quantidade", "captura_kg"))
  col_val <- pegar_coluna(mpa_sardinha, c("valor_pago_kg", "valor_kg", "preco_kg"))

  if (!is.na(col_qtd)) {
    mpa_sardinha <- mpa_sardinha |>
      mutate(classe_quantidade = criar_classe_quantitativa(.data[[col_qtd]], "quantidade"))
  }

  if (!is.na(col_val)) {
    mpa_sardinha <- mpa_sardinha |>
      mutate(classe_valor_kg = criar_classe_quantitativa(.data[[col_val]], "valor"))
  }

  saveRDS(mpa_sardinha, "dados_processados/mpa_sardinha.rds")
}

if (!is.na(arq_aquic)) {
  mpa_aquicultores <- ler_csv_flex(arq_aquic)
  saveRDS(mpa_aquicultores, "dados_processados/mpa_aquicultores.rds")
}

# -------------------------------------------------------------------------
# 6. Junção possível: pargo + embarcações
# -------------------------------------------------------------------------

if (file_exists("dados_processados/mpa_pargo.rds") && file_exists("dados_processados/mpa_embarcacoes.rds")) {
  mpa_pargo <- readRDS("dados_processados/mpa_pargo.rds")
  mpa_embarcacoes <- readRDS("dados_processados/mpa_embarcacoes.rds")

  chave_pargo <- pegar_coluna(mpa_pargo, c("id_embarcacao", "id_embarcacao_pesca"))
  chave_emb   <- pegar_coluna(mpa_embarcacoes, c("id_embarcacao", "id_embarcacao_pesca"))

  if (!is.na(chave_pargo) && !is.na(chave_emb)) {
    mpa_embarcacoes_pargo <- mpa_pargo |>
      left_join(
        mpa_embarcacoes,
        by = setNames(chave_emb, chave_pargo),
        suffix = c("_pargo", "_embarcacao")
      )

    saveRDS(mpa_embarcacoes_pargo, "dados_processados/mpa_embarcacoes_pargo.rds")
  }
}

message("Processamento concluído. Veja a pasta dados_processados/.")
