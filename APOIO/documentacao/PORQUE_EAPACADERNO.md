# EAPACaderno: por que existe

> Texto de apresentação, escrito para ser lido por quem chega ao projeto sem
> contexto, inclusive por outro assistente de IA. Set/2026.

O EAPACaderno é um projeto de análise de dados em R que roda de verdade. Não é
um exemplo ilustrativo nem um esqueleto vazio. Ele é a especificação executável
de como deve ser o Projeto R que a IDE CatalyseR entrega ao usuário no fim de
uma análise. Fica em github.com/astuciasnor/EAPACaderno e é um dos quatro
subprojetos do ecossistema EAPA, Estatística Aplicada à Pesca e Aquicultura.

A CatalyseR é uma IDE em Shiny para essa área. O usuário importa uma planilha,
trata os dados numa trilha reprodutível, escolhe análises por cliques e, no fim,
exporta dois artefatos: um relatório em Word e um Projeto R. O Projeto R é a
ponte do mouse para o código. A pergunta que o EAPACaderno responde é: com que
cara esse projeto deve chegar às mãos de quem o abre?

A resposta foi escrita de propósito como se a CatalyseR não existisse. O caderno
é o caminho a pé: uma planilha de campo suja entra, e alguém faz tudo à mão,
importando, tratando, explorando, analisando e escrevendo. Só depois de esse
caminho ficar bom é que a exportação da IDE foi ajustada para desembocar nele.
Por isso vale a regra: se os dois divergirem, o caderno manda, porque ele roda.

A forma escolhida é a programação literária. Um único documento Quarto é o
projeto inteiro. Os dados entram, são preparados e analisados ali dentro, e o
texto é escrito em cima dos resultados. Não há scripts separados. Desse mesmo
arquivo saem dois documentos. O Word é o relatório para o leitor, com estrutura
de artigo científico, resumo, tabelas, figuras e referências. O HTML é o caderno
do pesquisador, com o código dobrável ao lado do texto e as seções de exploração
e de diagnóstico dos pressupostos, que não interessam ao leitor final. A
metáfora que explica isso a um aluno é a mesma receita servida de dois jeitos: o
prato pronto na mesa e a cozinha aberta.

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
CatalyseR deve ser vista como um convite à programação, e não o contrário. O
aluno começa no mouse e termina lendo, e escrevendo, código com texto em volta.
