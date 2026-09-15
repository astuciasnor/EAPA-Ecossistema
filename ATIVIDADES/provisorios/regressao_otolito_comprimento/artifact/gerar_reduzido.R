# Gera a versão reduzida do conjunto (uma linha por peixe, só as espécies com
# n >= 30). Rodar da raiz de ATIVIDADES/:
#
#   Rscript provisorios/regressao_otolito_comprimento/artifact/gerar_reduzido.R
#
# A versão completa (6.320 linhas, 51 espécies) é o arquivo de avaliação; esta
# versão reduzida é o arquivo que "dá certo" de imediato, para praticar a
# regressão sem a etapa de seleção de espécie.

original <- "provisorios/regressao_otolito_comprimento/back-calculated-size-at-age_morat-et-al_2020-09-07.csv"
saida <- "dados/regressao_otolito_comprimento_reduzido.xlsx"

# O CSV do deposito nao e UTF-8: a coluna Observer tem bytes latin-1 (0xE9).
# Declarar a codificacao evita mojibake nos nomes dos leitores de otolito.
d <- read.csv(original, fileEncoding = "latin1")

# uma linha por peixe: as leituras de anulo sao repeticao, nao replica
dd <- d[!duplicated(d$ID), ]

# especies com n suficiente para uma regressao (n >= 30 individuos)
n_por_especie <- table(dd$Species)
manter <- names(n_por_especie)[n_por_especie >= 30]

reduzido <- dd[dd$Species %in% manter, ]
reduzido <- data.frame(
  id_peixe                     = reduzido$ID,
  especie                      = reduzido$Species,
  familia                      = reduzido$Family,
  local                        = reduzido$Location,
  observador                   = reduzido$Observer,
  n_anulos                     = as.integer(table(d$ID)[reduzido$ID]),
  idade_captura_anos           = reduzido$Agecpt,
  raio_otolito_mm              = reduzido$Rcpt,
  comprimento_total_mm         = reduzido$Lcpt,
  peso_g                       = reduzido$Weight,
  row.names = NULL
)

origem <- data.frame(
  Campo = c("Conjunto", "Fonte", "Página", "DOI", "Licença", "Como citar",
            "Unidade observacional", "Localidades", "Versão",
            "Observação"),
  Informação = c(
    "Raio do otólito e comprimento de peixes recifais do Pacífico",
    "figshare — Individual back-calculated size-at-age based on otoliths from Pacific coral reef fish species",
    "https://figshare.com/articles/dataset/Individual_back-calculated_size-at-age_based_on_otoliths_from_Pacific_coral_reef_fish_species/12156159",
    "https://doi.org/10.6084/m9.figshare.12156159.v5",
    "CC BY 4.0 — https://creativecommons.org/licenses/by/4.0/",
    "Morat, F. et al. (2020). Scientific Data, 7, 370. https://doi.org/10.1038/s41597-020-00711-y",
    "Um peixe por linha (a leitura de cada anulo já foi colapsada).",
    "Manuae, Gambiers, Moorea e Marquesas",
    "Reduzida: uma linha por peixe e apenas as 8 espécies com 30 indivíduos ou mais.",
    "Use dentro de uma espécie (filtre a coluna especie). Analisar as 8 juntas dá R² = 0,10; a relação vale por espécie."
  )
)

writexl::write_xlsx(list(dados = reduzido, origem = origem), saida)

cat("gravado:", saida, "\n")
cat("linhas:", nrow(reduzido), "| especies:", length(unique(reduzido$especie)), "\n")
cat("ausentes em peso_g:", sum(is.na(reduzido$peso_g)),
    "| em raio_otolito_mm:", sum(is.na(reduzido$raio_otolito_mm)),
    "| em comprimento_total_mm:", sum(is.na(reduzido$comprimento_total_mm)), "\n")
cat("\n--- por especie ---\n")
print(table(reduzido$especie))
