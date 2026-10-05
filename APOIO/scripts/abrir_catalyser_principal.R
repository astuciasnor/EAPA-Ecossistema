# Reinicie o R antes de executar este arquivo, para carregar a versão atualizada.
biblioteca <- 'C:/R/R-4.6.1/library'
.libPaths(c(biblioteca, .libPaths()))
Sys.setenv(R_LIBS_USER = biblioteca)
if (utils::packageVersion('catalyser') < '0.1.18') {
  stop('A instalação padrão ainda não contém a CatalyseR 0.1.18.')
}
if ('catalyser' %in% loadedNamespaces() && getNamespaceVersion('catalyser') < '0.1.18') {
  stop('Reinicie o R antes de abrir: esta sessão ainda carregou uma CatalyseR antiga.')
}
message('CatalyseR disponível: ', utils::packageVersion('catalyser'), ' em ', find.package('catalyser'))
shiny::runApp('D:/Claude/EAPA-Ecossistema/catalyser/inst/app', launch.browser = TRUE)
