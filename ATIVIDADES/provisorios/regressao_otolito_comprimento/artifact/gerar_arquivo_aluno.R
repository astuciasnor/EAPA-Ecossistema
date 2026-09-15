# Gera o arquivo do aluno a partir do download original, sem alterá-lo.
# Rodar da raiz de ATIVIDADES/:
#
#   Rscript provisorios/regressao_otolito_comprimento/artifact/gerar_arquivo_aluno.R
#
# Regras (ver curadoria.md, seção 10):
# - base inteira: 6.320 linhas e 51 espécies, uma linha por anulo;
# - só colunas brutas: saem os resultados derivados Li_sp_* e Li_sploc_*;
# - nomes de coluna originais em inglês;
# - aba `origem` com fonte, DOI, licença e unidade observacional.

original <- "provisorios/regressao_otolito_comprimento/back-calculated-size-at-age_morat-et-al_2020-09-07.csv"
saida <- "dados/regressao_otolito_comprimento.xlsx"

# ATENCAO a codificacao: o CSV do deposito NAO e UTF-8. A coluna Observer traz
# bytes latin-1 (0xE9 = e acute) em 1.199 linhas ("Guillemette de Synety and
# Jeremy Wicquart"). Ler sem declarar a codificacao produz mojibake no arquivo do
# aluno, entao o latin-1 e convertido para UTF-8 aqui.
d <- read.csv(original, fileEncoding = "latin1")

# colunas de resultados dos autores: não são dados brutos
derivadas <- c("Li_sp_m", "Li_sp_sd", "Li_sploc_m", "Li_sploc_sd")
stopifnot(all(derivadas %in% names(d)))

aluno <- d[, setdiff(names(d), derivadas)]

origem <- data.frame(
  Campo = c("Conjunto", "Fonte", "Página", "DOI", "Licença", "Como citar",
            "Unidade observacional", "Localidades", "Observação"),
  Informação = c(
    "Raio do otólito e comprimento de peixes recifais do Pacífico",
    "figshare — Individual back-calculated size-at-age based on otoliths from Pacific coral reef fish species",
    "https://figshare.com/articles/dataset/Individual_back-calculated_size-at-age_based_on_otoliths_from_Pacific_coral_reef_fish_species/12156159",
    "https://doi.org/10.6084/m9.figshare.12156159.v5",
    "CC BY 4.0 — https://creativecommons.org/licenses/by/4.0/",
    "Morat, F. et al. (2020). Scientific Data, 7, 370. https://doi.org/10.1038/s41597-020-00711-y",
    "Peixe individual (coluna ID). Cada linha corresponde a um anulo (idade) lido no otólito: um mesmo peixe aparece em várias linhas.",
    "Manuae, Gambiers, Moorea e Marquesas",
    "Dados de campo. Comprimento e raio em milímetros; massa em gramas."
  )
)

writexl::write_xlsx(list(dados = aluno, origem = origem), saida)

cat("gravado:", saida, "\n")
cat("linhas:", nrow(aluno), "| colunas:", ncol(aluno), "\n")
cat("colunas:", paste(names(aluno), collapse = ", "), "\n")
cat("individuos:", length(unique(aluno$ID)), "| especies:", length(unique(aluno$Species)), "\n")
cat("ausentes em Rcpt:", sum(is.na(aluno$Rcpt)), "| em Lcpt:", sum(is.na(aluno$Lcpt)), "\n")
