# Gera a versão de revisão (uma linha por indivíduo) e imprime as verificações
# registradas em curadoria.md. Rodar da raiz de ATIVIDADES/.
#
#   Rscript provisorios/regressao_otolito_comprimento/artifact/gerar_revisao.R
#
# Entrada: o download original, intocado.
# Saída:   <id>_revisao.xlsx — versão analítica limpa, para conferência do autor.

original <- "provisorios/regressao_otolito_comprimento/back-calculated-size-at-age_morat-et-al_2020-09-07.csv"
saida <- "provisorios/regressao_otolito_comprimento/regressao_otolito_comprimento_revisao.xlsx"

# O CSV do deposito nao e UTF-8: a coluna Observer tem bytes latin-1 (0xE9).
# Declarar a codificacao evita mojibake nos nomes dos leitores de otolito.
d <- read.csv(original, fileEncoding = "latin1")

cat("== dimensoes ==\n"); cat("linhas:", nrow(d), "| colunas:", ncol(d), "\n")
cat("individuos unicos:", length(unique(d$ID)), "| especies:", length(unique(d$Species)), "\n")
cat("\n== linhas por individuo ==\n"); print(summary(as.integer(table(d$ID))))

cat("\n== valores ausentes ==\n")
for (v in c("Rcpt", "Lcpt", "Weight", "Agecpt", "Ri")) cat(" ", v, ":", sum(is.na(d[[v]])), "\n")

cat("\n== consistencia de Rcpt dentro do ID ==\n")
r <- tapply(d$Rcpt, d$ID, function(x) length(unique(x)))
cat(" IDs com mais de um Rcpt:", sum(r > 1), "\n")
if (any(r > 1)) cat("  ->", paste(names(r)[r > 1], collapse = ", "), "\n")

cat("\n== especies com >= 30 individuos ==\n")
u <- unique(d[, c("ID", "Species")])
tb <- sort(table(u$Species), decreasing = TRUE)
print(tb[tb >= 30])

# --- versao de revisao: uma linha por individuo, so colunas de captura ---
dd <- d[!duplicated(d$ID), ]
revisao <- data.frame(
  id = dd$ID,
  familia = dd$Family,
  genero = dd$Genus,
  especie = dd$Species,
  local = dd$Location,
  observador = dd$Observer,
  n_anulos = as.integer(table(d$ID)[dd$ID]),
  idade_captura_anos = dd$Agecpt,
  raio_otolito_captura_mm = dd$Rcpt,
  comprimento_total_captura_mm = dd$Lcpt,
  comprimento_nascimento_mm = dd$L0p,
  raio_otolito_nascimento_mm = dd$R0p,
  peso_g = dd$Weight,
  row.names = NULL
)

cat("\n== modelo de referencia (Epinephelus merra) ==\n")
s <- revisao[revisao$especie == "Epinephelus merra", ]
m <- lm(comprimento_total_captura_mm ~ raio_otolito_captura_mm, data = s)
cat("n =", nrow(s), "| R2 =", round(summary(m)$r.squared, 3),
    "| Shapiro p =", signif(shapiro.test(residuals(m))$p.value, 3),
    "| Cook D max =", round(max(cooks.distance(m)), 2), "\n")
print(round(summary(m)$coefficients, 3))

writexl::write_xlsx(revisao, saida)
cat("\ngravado:", saida, "|", nrow(revisao), "individuos\n")
