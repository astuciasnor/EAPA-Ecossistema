# Projeto dados — correção da combinação de arquivos, 02/10/2026

A pasta fornecida pelo autor, EAPACadernos/dados, continha R/analise.R e relatorios/relatorio.qmd da rota antiga de várias análises (teste t de Welch e regressão por tratamento), junto com relatorio_completo.qmd e relatorio_artigo.qmd de um teste t isolado. _quarto.yml apontava para estes dois últimos arquivos. Por isso o Render executava um script que criava os resultados registrados com nomes específicos, mas o documento pedia tabela_descritiva_exibir, de outro molde.

Os dois QMDs foram reconstruídos a partir do documento integrado compatível. A conferência com o script aponta explicitamente para cada QMD; as funções de sincronização adotam o caderno completo por padrão. O README orienta a abertura dos dois arquivos e registra a limitação didática. O QMD integrado anterior foi arquivado fora do projeto. Dados brutos, escolhas do teste e da regressão e o arquivo R/analise.R permaneceram byte a byte preservados.

Provas: os dois processos Quarto terminaram com código 0. HTML novo sem referências quebradas e Word íntegro em EAPACadernos/dados/saida/relatorios. Logs e ZIP original estão em APOIO/temp/correcao_dados_20261002. Esta é uma correção do projeto recebido; não houve atualização do pacote CatalyseR ou publicação de uma versão nova nesta rodada. Não declaramos um teste manual de Render no RStudio.

## Observação didática do autor

O autor apontou excesso de funções próprias, semelhante a outra linguagem dentro de R. A crítica procede neste roteiro de várias análises: ele combina código nativo para leitura com catalyser_executar() para obter os resultados e catalyser_mostrar() para apresentá-los. A rota isolada migrada mostra os cálculos em roteiro próprio; a rota de várias análises conserva uma arquitetura anterior.

A próxima revisão dessa rota deve deixar t.test(), lm(), a seleção dos dados, os pressupostos e a construção dos gráficos executáveis e visíveis no roteiro. Pequenas funções de formatação e estilo podem permanecer em funcoes.R. A reprodução do resultado não deve esconder a análise que o aluno precisa compreender. A correção funcional dos relatórios não é uma aprovação didática dessa arquitetura antiga nem uma migração já concluída do exportador de várias análises.

Para novas exportações, usar uma pasta nova: extrair sobre uma pasta de projeto anterior pode misturar arquivos de moldes diferentes. Os dois formatos novos deste projeto apresentam os mesmos resultados registrados. A revisão de estrutura científica e da narrativa específica de um artigo conjunto permanece com o autor.
