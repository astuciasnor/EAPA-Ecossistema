# =============================================================================
#  gerar_registro.R — mantém o REGISTRO_FONTES_DADOS_EAPA.xlsx
#
#  O registro vive no próprio xlsx, na aba `fontes` — é ela que se edita no
#  Excel. Este script:
#    1. lê a aba `fontes`;
#    2. conserta caminhos que envelheceram (arquivo do aluno que virou .xlsx);
#    3. regrava a aba `fontes` com os valores;
#    4. chama o formatador Python, que estiliza `fontes` e **constrói** a aba
#       `resumo` (apresentação; o writexl não formata e ainda deixava uma linha
#       vazia no topo).
#
#  Rodar da raiz de ATIVIDADES/:
#     Rscript skills/eapa-curadoria-atividades/scripts/gerar_registro.R
#
#  Requer Python com openpyxl (3.x) disponível no PATH.
# =============================================================================

saida <- "dados/REGISTRO_FONTES_DADOS_EAPA.xlsx"
fmt   <- "skills/eapa-curadoria-atividades/scripts/formatar_registro.py"

# --- 1. leitura -------------------------------------------------------------
# Tudo lido como texto para o registro nao mudar de tipo sozinho (data virando
# data, codigo virando numero) e para acentos nao se perderem.
if (!file.exists(saida)) stop("registro nao encontrado: ", saida)
fontes <- as.data.frame(readxl::read_excel(saida, sheet = "fontes", col_types = "text"))
fontes[] <- lapply(fontes, function(v) ifelse(is.na(v), "", as.character(v)))
if (ncol(fontes) != 14) stop("a aba fontes deveria ter 14 colunas; tem ", ncol(fontes))
cat("registros lidos:", nrow(fontes), "| colunas:", ncol(fontes), "\n")

# --- 2. caminhos que envelheceram ------------------------------------------
# o arquivo do aluno em ATIVIDADES/dados/ passou de .csv para .xlsx
antes <- fontes$arquivo_local
fontes$arquivo_local <- gsub("ATIVIDADES/dados/([A-Za-z_]+)\\.csv",
                             "ATIVIDADES/dados/\\1.xlsx", fontes$arquivo_local)
if (any(antes != fontes$arquivo_local)) cat("caminhos .csv corrigidos para .xlsx\n")

# o conjunto do otolito ganhou a versao reduzida
i <- grep("^morat_2020", fontes$id_fonte)
if (length(i) && !grepl("reduzido", fontes$arquivo_local[i])) {
  fontes$arquivo_local[i] <- paste0(
    fontes$arquivo_local[i],
    "; ATIVIDADES/dados/regressao_otolito_comprimento_reduzido.xlsx")
  cat("versao reduzida acrescentada ao registro do otolito\n")
}

# --- 3. grava os valores ----------------------------------------------------
writexl::write_xlsx(list(fontes = fontes), saida)
cat("gravado:", saida, "\n")

# --- 4. formata e monta o resumo -------------------------------------------
if (!file.exists(fmt)) stop("formatador nao encontrado: ", fmt)
status <- tryCatch(system2("python", fmt), error = function(e) 1L,
                   warning = function(w) 1L)
if (!identical(as.integer(status), 0L))
  stop("a formatacao falhou: verifique se o Python tem openpyxl instalado")
