# Instalação da CatalyseR para o autor ou para os alunos -----------------------
#
# Antes de executar: no RStudio, escolha Session > Restart R.
# Altere o modo para "github" ao preparar este arquivo para um aluno.

modo_instalacao <- "local"

if (identical(modo_instalacao, "local")) {
  # Usa a pasta local e as dependências já instaladas neste computador.
  # repos = NULL evita a consulta ao GitHub e aos repositórios de pacotes.
  install.packages(
    "D:/Claude/EAPA-Ecossistema/catalyser",
    repos = NULL,
    type = "source"
  )
} else if (identical(modo_instalacao, "github")) {
  # Instala a versão publicada no GitHub, sem atualizar dependências.
  if (!requireNamespace("remotes", quietly = TRUE)) {
    install.packages("remotes", type = "binary")
  }

  remotes::install_github(
    "astuciasnor/catalyser",
    build = FALSE,
    upgrade = "never",
    type = "binary"
  )
} else {
  stop("Use modo_instalacao = 'local' ou 'github'.", call. = FALSE)
}

# Confere a instalação usada antes de abrir a aplicação.
cat("Versão instalada:", as.character(packageVersion("catalyser")), "\n")
caminho_app <- system.file("app", "app.R", package = "catalyser")
cat("Arquivo da aplicação:", caminho_app, "\n")
cat("Data do arquivo:", format(file.info(caminho_app)$mtime), "\n")

# Abre a CatalyseR no navegador.
catalyser::run_app(launch.browser = TRUE)
