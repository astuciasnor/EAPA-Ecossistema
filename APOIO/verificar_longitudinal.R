Sys.setlocale('LC_ALL', 'Portuguese_Brazil.utf8')
setwd('D:/Claude/EAPA-Ecossistema/CATALYSER/inst/app')
library(shiny)
`%||%` <- function(a,b) if (is.null(a) || !length(a)) b else a
source('modules/ficha_planejamento.R', encoding='UTF-8')
source('modules/mod_planejamento_variaveis.R', encoding='UTF-8')
source('modules/mod_planejamento_observacional.R', encoding='UTF-8')
# Curadoria das ostras: 4 desejadas, 20% perda, 3 grupos e 4 momentos.
testServer(mod_planejamento_observacional_server, args=list(tipo='longitudinal'), {
 session$setInputs(fator_nome='estuario', fator_niveis='Caeté, Emboraí Velho, Quatipuru',
  n_uas=4, perda_pct=20, momentos='0, 60, 120, 180 dias', coluna_unidade='mesa',
  data_inicial='2027-02-01', janela_dias=3, semente_visitas=2027, n_medidas=60,
  n_vars_resposta=1, var_nome_1='altura', var_unidade_1='mm', linha_base=TRUE)
 tab <- tabela_coleta_dados()
 # Exercitar downloads reais no servidor Shiny.
 excel <- output$baixar_planilha
 word <- output$baixar_relatorio
 stopifnot(file.exists(excel), file.exists(word))
 stopifnot(identical(openxlsx::getSheetNames(excel), c('coleta','unidades','calendario','orientacoes')),
   nrow(openxlsx::read.xlsx(excel,sheet='coleta'))==60)
 doc <- officer::docx_summary(officer::read_docx(word))
 stopifnot(any(grepl('Planejamento longitudinal comparativo', doc$text)),
   !any(grepl('Planejamento_03_TRANSVERSAL',doc$text)),
   any(grepl('Planejamento_05_LONGITUDINAL',doc$text)))
 stopifnot(nrow(tab)==60, length(unique(tab$mesa))==15, !'pool' %in% names(tab),
   all(table(tab$mesa)==4), all(tab$altura==''), all(tab$n_medidas==''),
   identical(sort(names(tab)), sort(dicionario_dados()$coluna)), nrow(unidades_longitudinal())==15,
   ficha()$n_planejado$total_uas==15, is.null(ficha()$analise_sugerida))
 cal <- calendario_longitudinal()
 stopifnot(nrow(cal)==12, all(table(cal$momento)==3),
   all(vapply(split(cal$ordem_grupo, cal$momento), function(x) identical(sort(x),1:3), logical(1))),
   max(as.numeric(as.Date(cal$data_prevista[1:3])))-min(as.numeric(as.Date(cal$data_prevista[1:3])))==2)
 for (grupo in unique(paste(tab$estuario,tab$momento))) {
  idx <- paste(tab$estuario,tab$momento)==grupo
  stopifnot(identical(sort(tab$ordem_visita[idx]),1:5))
 }
 stopifnot(identical(tab,tabela_coleta_dados()), grepl('Será realizado',texto_metodologia_artigo_str()),
  !grepl('Foram acompanhadas',texto_metodologia_artigo_str()))
 ggplot2::ggsave('D:/Claude/EAPA-Ecossistema/APOIO/longitudinal_validacao.png', esquema_observacional(),width=11,height=8,dpi=110)
 session$setInputs(relogio='individual')
 stopifnot(all(tabela_coleta_dados()$data_prevista==''), all(unidades_longitudinal()$data_inicio==''))
 # Viveiros da curadoria: 6 desejados / 85% = 8 iniciais por grupo.
 session$setInputs(fator_nome='sistema',fator_niveis='Com aerador, Sem aerador',n_uas=6,perda_pct=15,
  momentos='0, 30, 60, 90, 120, 150 dias',coluna_unidade='viveiro',n_medidas=30)
 stopifnot(nrow(tabela_coleta_dados())==96, nrow(unidades_longitudinal())==16)
 # Nome de resposta reservado deve ser rejeitado antes de sobrescrever identificação.
 session$setInputs(var_nome_1='data_real')
 stopifnot(inherits(try(tabela_coleta_dados(),silent=TRUE),'try-error'))
})
# Compatibilidade com teste anterior, explicitando previsão de perdas zero.
texto <- readLines('tests/test_observacional_longitudinal.R',encoding='UTF-8')
texto <- sub('tipo_pool = "igual", pool_unico = 1,','tipo_pool = "igual", pool_unico = 1, perda_pct = 0,',texto,fixed=TRUE)
texto <- texto[seq_len(grep('^# 6[.]',texto)[1]-1)]
eval(parse(text=texto),envir=.GlobalEnv)
source('tests/test_transversal_saidas.R',encoding='UTF-8')
cat('OK: curadoria longitudinal, calendário, perdas, ficha e regressão transversal\n')

quit(save='no', status=0, runLast=FALSE)
