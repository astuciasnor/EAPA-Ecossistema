# ============================================================================
# PCA | biplot + elipses | filosofia tidy | saídas gráficas para publicação
# ============================================================================

# ---- 0. Pacotes --------------------------------------------------------------
library(tidyverse)   # manipulação de dados + ggplot2
library(broom)       # resultados do PCA em tibbles (tidy/augment)
library(ggrepel)     # rótulos sem sobreposição
library(patchwork)   # composição de painéis

# ---- 1. Dados de exemplo (substitua pelos seus) ------------------------------
set.seed(42)

simula_morfometria <- function(n, centroide) {
  sigma <- matrix(0.6, nrow = 6, ncol = 6)
  diag(sigma) <- 1
  MASS::mvrnorm(n, mu = centroide, Sigma = sigma) |>   # prefixo, sem library()
    as_tibble(.name_repair = "minimal") |>
    setNames(c("comp_padrao", "altura_corpo", "comp_cabeca",
               "altura_cabeca", "diametro_olho", "comp_peitoral")) |>
    mutate(across(everything(), ~ .x * 8 + 60))        # escala aproximada em mm
}

dados_brutos <- bind_rows(
  simula_morfometria(30, c( 1.2,  0.8,  1.0,  0.9,  0.6,  1.0)) |> mutate(especie = "Tambaqui"),
  simula_morfometria(30, c(-1.2, -0.9, -1.0, -0.8, -0.7, -1.0)) |> mutate(especie = "Tilápia"),
  simula_morfometria(30, c( 0.0, -1.2,  0.1,  0.0,  0.9,  0.0)) |> mutate(especie = "Pirarucu")
) |>
  relocate(especie)

# Com dados reais:
# dados_brutos <- read_csv("dados/brutos/morfometria.csv")
# dados_brutos <- readxl::read_excel("dados/brutos/morfometria.xlsx")

# ---- 2. Tratamento -----------------------------------------------------------
dados_pca <- dados_brutos |>
  drop_na() |>                                     # ou imputação: missMDA, recipes::step_impute_*
  select(especie, where(is.numeric)) |>
  select(where(~ !is.numeric(.x) || sd(.x) > 0))   # elimina colunas constantes (variância zero)

# ---- 3. PCA (matriz de correlação: center + scale) ---------------------------
pca <- dados_pca |>
  select(where(is.numeric)) |>
  prcomp(center = TRUE, scale. = TRUE)

# ---- 4. Resultados em tibbles ------------------------------------------------
eig <- tidy(pca, matrix = "eigenvalues")        # PC, std.dev, percent, cumulative

scores <- augment(pca, data = dados_pca)        # dados + .fittedPC1, .fittedPC2, ...

# Fator de escala: ajusta o comprimento das setas à nuvem de pontos
fator <- max(abs(c(scores$.fittedPC1, scores$.fittedPC2))) * 0.9

# Rótulos bonitos das variáveis (edite ao trocar de dados)
rotulos_var <- c(
  comp_padrao   = "Comp. padrão",
  altura_corpo  = "Alt. do corpo",
  comp_cabeca   = "Comp. da cabeça",
  altura_cabeca = "Alt. da cabeça",
  diametro_olho = "Diâm. do olho",
  comp_peitoral = "Comp. peitoral"
)

loadings <- pca$rotation |>
  as_tibble(rownames = "variavel") |>
  select(variavel, PC1, PC2) |>
  mutate(PC1 = PC1 * fator,
         PC2 = PC2 * fator,
         rotulo = coalesce(rotulos_var[variavel], variavel))

# Rótulos dos eixos com % de variância calculado dinamicamente
rotulo_pc <- function(i) sprintf("PC%d (%.1f%%)", i, eig$percent[i] * 100)

eig   # confira no console: variância explicada por componente

# ---- 5. Paleta segura para daltônicos + tema de publicação -------------------
okabe_ito <- c("#E69F00", "#0072B2", "#009E73", "#D55E00",
               "#CC79A7", "#56B4E9", "#F0E442", "#000000")

theme_pub <- theme_classic(base_size = 10) +
  theme(
    axis.line       = element_line(linewidth = 0.4),
    axis.ticks      = element_line(linewidth = 0.3),
    legend.position = "top",
    legend.title    = element_text(face = "bold", size = 9),
    plot.margin     = margin(6, 6, 6, 6)
  )

# ---- 6. Biplot com elipses de 95% --------------------------------------------
p_biplot <- ggplot(scores, aes(.fittedPC1, .fittedPC2)) +
  geom_hline(yintercept = 0, linetype = "dashed", linewidth = 0.3, colour = "grey75") +
  geom_vline(xintercept = 0, linetype = "dashed", linewidth = 0.3, colour = "grey75") +
  stat_ellipse(aes(colour = especie), type = "norm", level = 0.95,
               linewidth = 0.7, show.legend = FALSE) +
  geom_point(aes(colour = especie, shape = especie), size = 2.2, alpha = 0.9) +
  geom_segment(data = loadings,
               aes(x = 0, y = 0, xend = PC1, yend = PC2),
               arrow = arrow(length = unit(2, "mm"), type = "closed"),
               linewidth = 0.5, colour = "grey20") +
  geom_text_repel(data = loadings,
                  aes(x = PC1, y = PC2, label = rotulo),
                  size = 3.2, colour = "grey20",
                  min.segment.length = 0, segment.color = "grey70",
                  seed = 123) +
  scale_colour_manual(values = okabe_ito) +
  scale_shape_manual(values = c(16, 17, 15)) +
  labs(x = rotulo_pc(1), y = rotulo_pc(2), colour = "Espécie", shape = "Espécie") +
  theme_pub

p_biplot

# ---- 7. Scree plot: variância individual (barras) + acumulada (linha) --------
p_scree <- eig |>
  slice_head(n = 6) |>
  mutate(PC = factor(PC)) |>
  ggplot(aes(PC, percent)) +
  geom_col(fill = "grey55", width = 0.65) +
  geom_line(aes(y = cumulative, group = 1, linetype = "Acumulada"),
            colour = "#0072B2", linewidth = 0.4) +
  geom_point(aes(y = cumulative, shape = "Acumulada"),
             colour = "#0072B2", size = 1.6) +
  scale_linetype_manual(name = NULL, values = c("Acumulada" = "dashed")) +
  scale_shape_manual(name = NULL, values = c("Acumulada" = 17)) +
  scale_y_continuous(labels = scales::label_percent(accuracy = 1),
                     expand = expansion(mult = c(0, 0.08))) +
  labs(x = "Componente", y = "Variância explicada") +
  theme_pub

p_scree

# ---- 8. Painel composto (scree + biplot) -------------------------------------
p_final <- p_scree + p_biplot +
  plot_layout(widths = c(1, 1.7)) +
  plot_annotation(tag_levels = "A",
                  theme = theme(plot.tag = element_text(face = "bold", size = 12)))

p_final

# ---- 9. Exportação em padrão de revista --------------------------------------
dir.create("figuras", showWarnings = FALSE)

# Biplot isolado (largura de 1,5 coluna: 114 mm)
ggsave("figuras/fig_PCA_biplot.pdf", p_biplot,
       width = 114, height = 100, units = "mm", device = cairo_pdf)
ggsave("figuras/fig_PCA_biplot.tiff", p_biplot,
       width = 114, height = 100, units = "mm", dpi = 600, compression = "lzw")

# Painel composto (página inteira: 169 mm)
ggsave("figuras/fig_PCA_painel.pdf", p_final,
       width = 169, height = 95, units = "mm", device = cairo_pdf)
ggsave("figuras/fig_PCA_painel.tiff", p_final,
       width = 169, height = 95, units = "mm", dpi = 600, compression = "lzw")

# Complemento inferencial sugerido para o manuscrito:
# vegan::adonis2(select(dados_pca, where(is.numeric)) ~ especie, data = dados_pca)