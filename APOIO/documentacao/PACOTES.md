# EAPA — Inventário de pacotes R

Lista dos pacotes usados no ecossistema (livro, IDE CatalyseR e pacote EAPADados)
e o guia mínimo de instalação para o leitor. Documento vivo — atualizar conforme
novos capítulos/análises entram. Ver backlog B-012 e B-013.

> Pré-requisitos fora do R: **R (>= 4.5)**, **RStudio** e **Quarto**.

---

## 1. Pacotes por fonte

### 1.1 Livro (capítulos `.qmd`)

Levantado por varredura de `library()`/`require()`/`pkg::` nos `.qmd`, completado
à mão com os capítulos recém-escritos (correlação e multivariada).

| Finalidade | Pacotes |
|:---|:---|
| Dados do ecossistema | `EAPADados`, `catalyser` |
| Manipulação e leitura de dados | `dplyr`, `tidyr`, `stringr`, `lubridate`, `readr`, `tibble` (ou o meta-pacote `tidyverse`), `readxl`, `rio`, `arrow`, `here`, `janitor` |
| Gráficos | `ggplot2`, `scales`, `factoextra` |
| Tabelas e relatório | `flextable`, `knitr` |
| Análises específicas | `corrplot` (correlação), `FactoMineR` (PCA/multivariada), `FSAdata` (dados de pesca/amostragem), `rstatix` + `rcompanion` + `multcompView` (**Kruskal-Wallis**: pós-teste de Dunn e letras de significância), `tsibble` + `feasts` + `fabletools` + `lubridate` (**séries temporais** — tidyverts: gg_season, STL, ACF) |
| Layout/PDF | `float` |
| Instalação/ferramentas | `remotes`, `pkgbuild` |

### 1.2 Pacote EAPADados (`DESCRIPTION`)

- **Imports:** `dplyr`, `flextable`, `magrittr`, `stats`, `tibble`, `utils`
- **Suggests:** `ggplot2`, `QFASA`
- **Depends:** R (>= 4.5.0)
- A acrescentar quando as funções canônicas chegarem (ver B-010/B-011):
  `corrplot`, `FactoMineR`, `factoextra`.

### 1.3 IDE CatalyseR (`DESCRIPTION`)

- **Imports:** `shiny`, `bslib`, `ggplot2`, `DT`, `readxl`, `markdown`, `zip`, `writexl`
- **Suggests (por análise/módulo):** mapas — `geobr`, `sf`, `ggspatial`,
  `RColorBrewer`, `ggrepel`, `cowplot`, `hexbin` (e `leaflet`, parqueado);
  **Kruskal-Wallis** — `rstatix`, `rcompanion`, `multcompView`;
  **séries temporais** — `tsibble`, `feasts`, `fabletools`, `lubridate`;
  **arrumação largo→longo** — `tidyr`, `tidyselect` (`pivot_longer`/`pivot_wider`).
- **Depends:** R (>= 4.0.0)
- Conferir também os pacotes usados nos templates de relatório (`flextable`,
  `tibble`, e o motor `quarto`).

---

## 2. Lista mínima para o leitor instalar

Bloco enxuto para rodar os exemplos do livro. O `tidyverse` já cobre
`dplyr`/`ggplot2`/`tidyr`/`readr`/`stringr`/`lubridate`/`tibble`/`scales`.

```r
# 1. ferramenta para instalar a partir do GitHub
install.packages("remotes")

# 2. nucleo de manipulacao e graficos
install.packages(c("tidyverse", "here", "janitor", "readxl", "rio"))

# 3. tabelas e relatorios (knitr/rmarkdown acompanham o Quarto/RStudio)
install.packages("flextable")

# 4. analises especificas do livro
install.packages(c("corrplot", "FactoMineR", "factoextra", "FSAdata"))
# Kruskal-Wallis (nao parametrico): pos-teste de Dunn + letras de significancia
install.packages(c("rstatix", "rcompanion", "multcompView"))
# Series temporais (tidyverts): tsibble, feasts (gg_season/STL/ACF), fabletools
install.packages(c("tsibble", "feasts", "fabletools", "lubridate"))

# 5. dados do ecossistema (puxa as dependencias do EAPADados)
remotes::install_github("astuciasnor/EAPADados")
```

> A IDE CatalyseR, quando empacotada (B-001), declara suas próprias dependências
> e instala o que precisa; o leitor do livro não precisa instalá-las à mão.

---

## 3. Manutenção

Para evitar defasagem, o ideal é um script que varre os `.qmd` e os `DESCRIPTION`
e regenera a seção 1 automaticamente. Enquanto isso, atualizar este arquivo a
cada análise nova (a última rodada acrescentou `corrplot`, `FactoMineR` e
`factoextra`).
