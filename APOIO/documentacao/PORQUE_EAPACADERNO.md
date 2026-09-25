# EAPACaderno: por que existe

> Texto de apresentação, escrito para ser lido por quem chega ao projeto sem
> contexto, inclusive por outro assistente de IA. Set/2026.

O EAPACaderno é um projeto de análise de dados em R que roda de verdade. Não é
um exemplo ilustrativo nem um esqueleto vazio. Ele é a especificação executável
de como deve ser o Projeto R que a IDE CatalyseR entrega ao usuário no fim de
uma análise. Fica em github.com/astuciasnor/EAPACaderno e é um dos quatro
subprojetos do ecossistema EAPA, Estatística Aplicada à Pesca e Aquicultura.

A CatalyseR é uma IDE em Shiny para essa área. O usuário importa uma planilha,
registra o preparo numa trilha reprodutível, escolhe análises por cliques e, no
fim, exporta um Projeto R. É no RStudio que esse projeto gera o caderno HTML e o
relatório em Word. O Projeto R é a ponte do mouse para o código. A pergunta que
o EAPACaderno responde é: com que cara esse projeto deve chegar às mãos de quem
o abre?

A resposta foi escrita de propósito como se a CatalyseR não existisse. O caderno
é o caminho a pé: uma planilha de campo suja entra, e alguém faz tudo à mão,
importando, tratando, explorando, analisando e escrevendo. Só depois de esse
caminho ficar bom é que a exportação da IDE foi ajustada para desembocar nele.
Por isso vale a regra: se os dois divergirem, o caderno manda, porque ele roda.

A forma amadureceu para um **script analítico e dois documentos Quarto**. O
`R/analise.R` é a fonte da verdade: lê e prepara os dados, ajusta o modelo,
verifica os pressupostos, constrói tabelas e gráficos e, ao final, organiza a
síntese estatística em objetos de texto. O `relatorio_completo.qmd` apresenta o
percurso em HTML, com exploração e diagnósticos; o `relatorio_artigo.qmd`
apresenta em Word a versão voltada ao leitor, com estrutura de artigo
científico. Os dois relatórios consomem a mesma análise e não repetem os seus
cálculos.

Essa arquitetura dá uma função clara a cada arquivo. O script ensina como os
resultados foram construídos. A seção final de textos faz a passagem entre
calcular e comunicar: recolhe números antes espalhados pelo console e prepara
frases para os relatórios. O HTML funciona como a cozinha aberta, na qual o
pesquisador acompanha o percurso; o Word é o prato servido ao leitor. A
interpretação biológica, a discussão e a conclusão científica continuam sendo
escritas e revistas pelo pesquisador.

## Uma escada de aprendizagem

O ecossistema não precisa apresentar toda essa estrutura de uma vez. Um projeto
curto de estatística descritiva pode ser o primeiro degrau: uma variável, uma
tabela, um gráfico e textos breves. Nele, o aluno aprende a reconhecer as
pastas, abrir o script, examinar objetos e renderizar os dois relatórios. A
regressão linear simples acrescenta exploração, modelo, pressupostos,
diagnósticos e síntese estatística, sem mudar os papéis dos arquivos. Análises
posteriores acrescentam novos conhecimentos sobre uma estrutura que já se tornou
familiar.

Essa progressão preserva o interesse pelo código. A CatalyseR oferece uma
entrada segura pela interface, mas o projeto exportado deixa os cálculos
visíveis, com nomes compreensíveis, funções simples e comentários em português.
O aluno não recebe uma caixa-preta: recebe um roteiro que um professor consegue
percorrer com ele.

## Do preparo à comunicação

O valor da CatalyseR está no encadeamento. O menu de preparo não apenas modifica
uma tabela: registra as transformações numa trilha que pode ser refeita. Uma
Base Compartilhada conserva a origem comum do estudo, enquanto Bases Derivadas
permitem preparar ramos para perguntas específicas sem alterar essa origem. O
mesmo Projeto R pode reunir várias análises e mostrar de qual base cada uma
partiu.

Ao final, código e comunicação continuam ligados. O script analítico preserva o
percurso; a seção de textos retoma os resultados; os relatórios apresentam cada
coisa ao público adequado. Assim, preparar dados, analisar e escrever deixam de
ser tarefas soltas e passam a formar um fluxo científico verificável.

O caráter do projeto é a parte que não se negocia. Ele roda só com pacotes do
CRAN, não depende da CatalyseR e não tem infraestrutura: nada de renv, targets,
testes automatizados ou orquestração. Os comentários são em português e explicam
o porquê, não o quê, em tom de professor conversando. O critério para aceitar
qualquer mudança é uma pergunta: isso deixa o projeto mais fácil ou mais difícil
de explicar para uma pessoa em um minuto? Se ficar mais difícil, não entra, por
melhor que seja a ideia.

Para quem for trabalhar nele, a ordem é ler o README primeiro, porque ele é o
manual do pesquisador e o documento de referência das convenções. Antes de mexer
na exportação da CatalyseR, olhar o caderno. E validar qualquer alteração do
jeito mais simples: reiniciar o R e renderizar. Se passa com a memória limpa e
continua legível por um aluno, está aprovado.

No fundo, o EAPACaderno existe para sustentar uma ideia do ecossistema: a
CatalyseR deve ser vista como um convite à programação. Ela ocupa uma ponte
entre o estudo dos métodos estatísticos e a prática da pesquisa reprodutível. O
aluno começa no mouse, acompanha o preparo e a análise e termina lendo — e,
depois, escrevendo — código com texto em volta.
