# =============================================================================
# gerar-projeto-exemplo.R
# -----------------------------------------------------------------------------
# Gera um Projeto R exportado COMPLETO, sem abrir a CatalyseR e sem reinstalar
# nada, para que voce possa ler o relatorio.qmd e os scripts com olho humano.
#
# Reproduz exatamente o roteiro de homologacao da V16:
#   Base Compartilhada : padronizar texto de especie/local + remover duplicatas
#   Base Derivada A    : profundidade por especie (ANOVA)
#   Base Derivada B    : biometria completa das corvinas (graficos)
#   Execucoes          : 1 ANOVA + 2 graficos de linhas (comprimento e peso)
#
# Uso, no terminal do RStudio, a partir da pasta catalyser:
#   "C:/R/R-4.6.1/bin/Rscript.exe" ../APOIO/scripts/gerar-projeto-exemplo.R > ../saida-exemplo.txt 2>&1
#
# Saida: D:/Claude/EAPA-Ecossistema/projeto-exemplo/
# =============================================================================

destino_final <- "D:/Claude/EAPA-Ecossistema/projeto-exemplo"

# --- Localizar e carregar a CatalyseR (do codigo-fonte, sem instalar) --------
localizar_app <- function() {
  candidatos <- c(".", "inst/app", "catalyser/inst/app", "../catalyser/inst/app")
  ok <- candidatos[file.exists(file.path(candidatos, "app.R"))]
  if (!length(ok)) stop("Rode a partir da pasta catalyser (a que tem DESCRIPTION).", call. = FALSE)
  normalizePath(ok[[1]], winslash = "/", mustWork = TRUE)
}
setwd(localizar_app())
cat("Pasta do app:", getwd(), "\n\n")

suppressPackageStartupMessages(source("app.R", local = TRUE))

# As funcoes de analise vem do pacote catalyser instalado. Se nao estiver
# instalado, carrega direto de R/ para o script ainda funcionar.
if (requireNamespace("catalyser", quietly = TRUE)) {
  suppressMessages(library("catalyser", character.only = TRUE))
  cat("Funcoes: pacote catalyser",
      as.character(utils::packageVersion("catalyser")), "instalado\n")
} else {
  arquivos <- list.files(file.path("..", "..", "R"), pattern = "[.]R$", full.names = TRUE)
  arquivos <- arquivos[!grepl("run_app[.]R$", arquivos)]
  for (arquivo in arquivos) sys.source(arquivo, envir = globalenv())
  cat("Funcoes: codigo-fonte de R/ (pacote nao instalado)\n")
}

# --- 1. Dados brutos ---------------------------------------------------------
arquivo <- file.path("dados", "Treino-Transformacoes.xlsx")
if (!file.exists(arquivo)) stop("Nao achei ", arquivo, call. = FALSE)
dados_brutos <- as.data.frame(readxl::read_excel(arquivo, sheet = "biometria"))
cat("Planilha lida:", nrow(dados_brutos), "linhas\n")

# --- 2. Base Compartilhada (a trilha do roteiro) -----------------------------
pipeline <- list(
  list(tipo = "padronizar_texto",   params = list(coluna = "especie", metodo = "squish"),     ativa = TRUE),
  list(tipo = "padronizar_texto",   params = list(coluna = "especie", metodo = "minusculas"), ativa = TRUE),
  list(tipo = "padronizar_texto",   params = list(coluna = "local",   metodo = "squish"),     ativa = TRUE),
  list(tipo = "padronizar_texto",   params = list(coluna = "local",   metodo = "minusculas"), ativa = TRUE),
  list(tipo = "remover_duplicatas", params = list(colunas = NULL),                            ativa = TRUE)
)
replay <- replay_pipeline(dados_brutos, pipeline)
dados_analise <- replay$df
cat("Base Compartilhada:", nrow(dados_analise), "linhas (esperado 68)\n")

# --- 3. Bases Derivadas ------------------------------------------------------
ramo_anova <- bases_novo_registro(
  "base_0001", "Profundidade de captura por especie",
  "base_anova_profundidade_especie", finalidade = "anova", revisao_origem = 1L
)
ramo_anova <- bases_adicionar_etapa(
  list(ramo_anova), ramo_anova$id, "tratar_na",
  list(coluna = "profundidade_m", metodo = "remover"),
  dados_validacao = dados_analise
)[[1]]
ramo_anova$estado <- "pronta"

ramo_graf <- bases_novo_registro(
  "base_0002", "Biometria completa das corvinas",
  "base_graficos_corvina", finalidade = "graficos", revisao_origem = 1L
)
for (etapa in list(
  list("filtrar",   list(coluna = "especie", origem = "categorica", niveis = "corvina")),
  list("tratar_na", list(coluna = "comprimento_cm", metodo = "remover")),
  list("tratar_na", list(coluna = "peso_g",         metodo = "remover"))
)) {
  ramo_graf <- bases_adicionar_etapa(
    list(ramo_graf), ramo_graf$id, etapa[[1]], etapa[[2]],
    dados_validacao = dados_analise
  )[[1]]
}
ramo_graf$estado <- "pronta"

aplicar_receita <- function(base) replay_pipeline(dados_analise, base$etapas)$df
df_anova <- aplicar_receita(ramo_anova)
df_graf  <- aplicar_receita(ramo_graf)
cat("Base Derivada A (ANOVA)   :", nrow(df_anova), "linhas (esperado 68)\n")
cat("Base Derivada B (graficos):", nrow(df_graf),  "linhas (esperado 19)\n\n")

registro_bases <- list(ramo_anova, ramo_graf)
cache_bases <- list(
  base_0001 = list(df = df_anova, erros = list(), revisao_origem = 1L,
                   versao_receita = ramo_anova$versao,
                   linhas = nrow(df_anova), colunas = ncol(df_anova)),
  base_0002 = list(df = df_graf, erros = list(), revisao_origem = 1L,
                   versao_receita = ramo_graf$versao,
                   linhas = nrow(df_graf), colunas = ncol(df_graf))
)

# --- 4. Execucoes registradas ------------------------------------------------
criar <- function(id, tipo, titulo, parametros, saidas, base) list(
  id = id, analise_id = tipo, tipo = tipo, titulo = titulo,
  parametros = parametros, saidas_disponiveis = saidas,
  resultado_resumo = list(), codigo_r = NULL, revisao_origem = 1L,
  criada_em = Sys.time(), atualizada_em = Sys.time(), versao = 1L,
  base_id = base$id, base_objeto = base$nome_r, base_nome = base$nome_amigavel,
  base_tipo = "derivada", base_derivada = TRUE, base_finalidade = base$finalidade,
  base_versao_receita = base$versao, depende_origem = TRUE
)

param_grafico <- function(y, rotulo_y) list(
  x = "id", y = y, grupo = "none", mostrar_pontos = TRUE, espessura_linha = 1,
  tema = "minimal", posicao_legenda = "right", rotulo_x = "Observacao",
  rotulo_y = rotulo_y,
  titulo_grafico = sprintf("%s das corvinas por observacao",
                           if (y == "peso_g") "Peso" else "Comprimento")
)

registro_execucoes <- list(
  execucao_0001 = criar(
    "execucao_0001", "anova_um_fator", "Profundidade de captura entre especies",
    list(resposta = "profundidade_m", fator = "especie", nivel_confianca = 0.95,
         ajuste_comparacoes = "tukey", tema = "minimal",
         rotulo_x = "Especie", rotulo_y = "Profundidade (m)"),
    # Sem "console": a saida bruta nao e conteudo de relatorio. Esta lista
    # espelha o que mod_anova.R declara.
    c("narrativa", "descritivos", "tabela", "comparacoes", "grafico",
      "pressupostos", "diagnosticos"),
    ramo_anova
  ),
  execucao_0002 = criar(
    "execucao_0002", "grafico_linhas", "Comprimento das corvinas por observacao",
    param_grafico("comprimento_cm", "Comprimento (cm)"), "grafico", ramo_graf
  ),
  execucao_0003 = criar(
    "execucao_0003", "grafico_linhas", "Peso das corvinas por observacao",
    param_grafico("peso_g", "Peso (g)"), "grafico", ramo_graf
  )
)

estado <- comunicacao_sincronizar(comunicacao_estado_vazio(), registro_execucoes)
estado <- comunicacao_definir_item(
  estado, "execucao_0001",
  saidas_selecionadas = registro_execucoes$execucao_0001$saidas_disponiveis,
  saidas_disponiveis  = registro_execucoes$execucao_0001$saidas_disponiveis
)
manifesto <- comunicacao_manifesto(
  estado, registro_execucoes,
  stats::setNames(as.list(rep("Atualizada", 3L)), names(registro_execucoes)),
  list(
    introducao = "Exemplo gerado para inspecao humana do projeto exportado.",
    metodos = "ANOVA de um fator e dois graficos de linhas sobre bases derivadas.",
    conclusao = "Documento de teste; nao e um resultado cientifico."
  )
)

# --- 5. Gerar o projeto ------------------------------------------------------
# Limpeza defensiva, na ordem certa: TESTAR e so entao apagar.
#
# No Windows, uma pasta aberta no Explorer ou no RStudio segura um handle. O
# unlink() nesse caso apaga o CONTEUDO e falha em remover o diretorio - ou seja,
# destroi o projeto antigo sem conseguir gerar o novo. Renomear, ao contrario, e
# atomico: falha inteiro se houver trava, sem tocar em nada.
pasta_projeto <- file.path(destino_final, "projeto_exemplo_v16")
if (dir.exists(pasta_projeto)) {
  sonda <- file.path(destino_final, paste0(".remover_", as.integer(Sys.time())))
  if (!file.rename(pasta_projeto, sonda)) {
    stop(
      paste0(
        "A pasta '", pasta_projeto, "' esta em uso e nao pode ser substituida.\n",
        "  Causa provavel: ela esta aberta no Explorer, ou o projeto esta\n",
        "  aberto no RStudio.\n",
        "  Solucao: feche essas janelas e rode de novo.\n",
        "  (Nada foi apagado: o projeto anterior continua intacto.)"
      ),
      call. = FALSE
    )
  }
  unlink(sonda, recursive = TRUE, force = TRUE)
}
dir.create(destino_final, recursive = TRUE, showWarnings = FALSE)

projeto <- exportacao_criar_projeto(
  destino = destino_final,
  nome_projeto = "exemplo_v16",
  dados_brutos = dados_brutos,
  base_resolvida = dados_brutos,
  dados_analise = dados_analise,
  pipeline = pipeline,
  base_externa = NULL,
  registro_bases = registro_bases,
  cache_bases = cache_bases,
  registro_execucoes = registro_execucoes,
  manifesto = manifesto,
  revisao_origem = 1L,
  import_info = list(source = "local", file_name = "Treino-Transformacoes.xlsx",
                     excel_sheet = "biometria"),
  templates_dir = "templates"
)

cat("\n=======================================================================\n")
cat("PROJETO GERADO EM:\n  ", normalizePath(projeto, winslash = "/"), "\n")
cat("=======================================================================\n\n")

cat("Arquivos em dados/:\n")
for (f in list.files(file.path(projeto, "dados"))) cat("  -", f, "\n")
cat("\nArquivos em R/:\n")
for (f in list.files(file.path(projeto, "R"))) cat("  -", f, "\n")

cat("\nPara ler com olho humano, abra nesta ordem:\n")
cat("  1.", file.path(projeto, "README.md"), "\n")
cat("  2.", file.path(projeto, "R", "01_importar.R"), "e", file.path(projeto, "R", "02_tratar.R"), "\n")
cat("  3.", file.path(projeto, "relatorios", "relatorio.qmd"), "\n")
cat("  4. qualquer R/04_analisar_*.R\n")
cat("\nPara gerar o Word: abra projeto_analise.Rproj no RStudio, abra\n")
cat("relatorios/relatorio.qmd e clique Render.\n")
