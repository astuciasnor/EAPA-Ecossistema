# EAPA — Ecossistema de Estatística Aplicada à Pesca e Aquicultura

Repositório-mãe (em `D:\Claude\EAPA-Ecossistema`) de **quatro subprojetos** que evoluíram
separadamente e estão sendo **entrosados**. A espinha do ecossistema é a IDE
**CatalyseR**. Use este arquivo como contexto permanente ao trabalhar em qualquer
um deles.

## Estrutura de pastas

```
EAPA-Ecossistema/              (pasta-mãe — D:\Claude\EAPA-Ecossistema)
├── catalyser/                 # IDE Shiny CatalyseR — FONTE DA VERDADE das análises
├── eapa/                      # Livro Quarto (repo: astuciasnor/eapa + GitHub Pages)
├── EAPADados/                 # pacote R — DADOS de contexto
├── EAPACaderno/    # 4º subprojeto (set/2026) — projeto-modelo de análise em R, "a pé"
└── APOIO/                    # atividades, documentação, dados e ferramentas de apoio
```

> Não se guarda amostra do Projeto R exportado pela CatalyseR na raiz: quando for
> preciso inspecionar um, `APOIO/scripts/gerar-projeto-exemplo.R` gera `projeto-exemplo/`
> na hora (e a pasta pode ser apagada depois). Não confundir com
> `EAPACaderno/`, que é o caminho manual, sem IDE.

## Repositórios

- **Livro:** https://github.com/astuciasnor/eapa · Pages: https://astuciasnor.github.io/eapa/
- **EAPADados:** https://github.com/astuciasnor/EAPADados
- **EAPACaderno:** https://github.com/astuciasnor/EAPACaderno (repositório próprio desde set/2026)
- **CatalyseR:** repositório local (ainda não publicado).

## Princípio central

A **CatalyseR é a fonte da verdade das análises**. O menu da IDE é o catálogo de
análises do curso. O **livro** (pasta `eapa/`) documenta exatamente essas mesmas
análises. O **EAPADados** é um pacote de **dados de contexto** (pesca, bioecologia
pesqueira e geral, aquicultura, tecnologia do pescado), consumido pela IDE, pelos
projetos exportados e pelo livro. A CatalyseR também **gera um Projeto R (.zip com
.qmd)** para o aluno completar no RStudio — a ponte do "mouse ao código".

## Quarto subprojeto — Projeto-modelo de análise (`EAPACaderno/`)

Desde setembro de 2026 há um quarto subprojeto, de natureza diferente dos outros
três: um **projeto-modelo de análise de dados em R**, feito de propósito **como se a
CatalyseR não existisse**, em **literate programming** (decisão de set/2026): uma
planilha entra em `dados/brutos/`, **um documento faz tudo** e um Word sai. O
`relatorios/relatorio.qmd` é o projeto inteiro, com chunks nomeados na ordem da
análise: `instalar` (eval: false, uma vez), `pacotes`, `importar-e-conferir`,
`preparo` (grava a base tratada em `dados/processados/*.csv` para o Excel),
`explora-*`, `analise` (output: false), `diagnostico-*`, e só `tbl-*`, `fig-*` e o
texto entram no Word. **Par script + relatório (set/2026):** o código mora em
`R/analise.R`, comentado passo a passo, em trechos marcados `## ---- nome ----`;
o `.qmd` recebe só as linhas de código, e a primeira linha de cada chunk diz de
quais trechos ele vem (`# fonte: tratar, tratar-biometria, ...`). Trechos
consecutivos sem texto entre eles viram um chunk só. O código se edita no script,
nunca no `.qmd`: o chunk `atualizar` (eval: false) chama `atualizar_codigo()`, que
copia o código sem comentários para os chunks; o chunk `codigo-do-script` chama
`conferir_codigo()` no Render e para se o relatório estiver atrasado. Motivo: o
`.qmd` limpo pode ser rodado chunk a chunk (e linha a linha) no RStudio, coisa que
`knitr::read_chunk` não permite; o `.qmd` fica com ~580 linhas por isso. Funções
próprias em `R/funcoes.R` (resumir_grupo, tema_projeto, cores_tratamento, fmt,
formatar_p, flextable_ocean, e a seção 5 de manutenção: atualizar_codigo,
conferir_codigo), comentadas linha a linha; `here()` resolve os caminhos. Quatro pastas: `dados/`, `R/`, `imagens/` (vazia, para
fotos e esquemas que não vêm do código), `relatorios/`, mais o `.Rproj` e o README.
Não há scripts numerados, `rodar_tudo.R` nem `resultados/`:
figuras nascem em chunks `fig-*` (o Quarto numera e legenda). O mesmo `.qmd` gera
**dois documentos**: o Word para o leitor, com estrutura de artigo (Introdução,
Material e métodos, Resultados, Discussão, Conclusão, Referências via
`referencias.bib` + CSL ABNT), e o HTML "caderno do pesquisador", com o código
dobrado (`code-fold`, `code-tools`) e as seções de exploração/diagnóstico, que só
existem no HTML (`content-visible when-format="html"`). Typst foi testado e
descartado para a v1 (saída parecida com o Word; talvez na v2). Dois CSL prontos
(ABNT padrão, APA alternativo); a CatalyseR deve exportar os mesmos dois. **Padrão
didático das seções de Exploração e Diagnóstico** (só no HTML): um chunk por
verificação, com um parágrafo curto antes dizendo o que se procura e comentários
dentro do chunk dizendo "o que conferir" e "o que é sinal de problema"; o
diagnóstico enumera os pressupostos da análise (independência pelo delineamento,
homogeneidade, normalidade dos resíduos, valores influentes), cada um com seu
gráfico. **Esse é o padrão que a exportação da CatalyseR deve seguir** nos
componentes `pressupostos`/`diagnosticos` de cada análise (Etapa 4). **Não há renv,
targets, testes nem orquestração.** Ele responde a uma pergunta simples: *do que um
aluno ou pesquisador realmente precisa para organizar uma análise em R?* Resposta:
pastas com nomes claros, scripts na ordem e disciplina — não um sistema.

**Relação com os outros três:**

- **CatalyseR:** caminhos paralelos, não concorrentes. A IDE é o ambiente integrado;
  o modelo é o caminho a pé. Quem sai da CatalyseR deve reconhecer no modelo as
  mesmas etapas (importar → tratar → analisar → comunicar) feitas à mão. Nada do
  modelo depende da CatalyseR, e a CatalyseR não precisa saber que ele existe.
  **Atenção ao ponto de partida:** a CatalyseR pressupõe planilha já *tidy*
  (cabeçalho na 1ª linha, uma linha por observação, uma coluna por variável); o
  modelo começa de uma planilha de campo suja de propósito (título acima do
  cabeçalho, unidade no nome da coluna, vírgula decimal, `-` como vazio). O que o
  script 01 do modelo resolve com `skip = 3`, na IDE o usuário resolve no Excel
  antes de importar; o script 02 do modelo corresponde à Trilha de Preparo. Na
  Fase A (exportação seguindo a árvore do modelo), o `01_importar.R` exportado é
  mais simples que o do modelo, e isso é correto, não uma divergência a corrigir.
  **Fase A aplicada em set/2026** em `exportacao_comunicacao.R` (spec: seção
  "Árvore do Projeto R exportado" em `catalyser/MODULO_COMUNICACAO_RESULTADOS.md`).
  **Fase B decidida como "relatório orgânico"** (set/2026): no projeto exportado a
  análise mora dentro do `relatorio.qmd`, em três chunks por análise (base, análise
  passo a passo com `output: false`, apresentação com parâmetros por extenso). Em
  seguida o **modelo também virou literate** (um `relatorio.qmd` faz tudo), e os dois
  convergiram. **Fase C aplicada (set/2026):** importar e tratar viraram chunks do
  `relatorio.qmd` exportado (a trilha é o chunk `tratar`, a Seção 0 do relatório)
  e a pasta `R/` saiu. O projeto exportado é planilha + qmd + `metadados/` (+
  `imagens/` vazia), a mesma árvore do EAPACaderno. Não há `rodar_tudo.R` nem
  `resultados/` em nenhum dos dois. **Fase D aplicada (set/2026):** (1) a
  CatalyseR **não gera mais o Word** — só o Projeto R; o Word e o caderno HTML
  nascem no RStudio do pesquisador, no Render, para ele ver de onde as coisas
  saem; (2) o exportado é o **par script + relatório** do EAPACaderno:
  `R/analise.R` comentado (trechos `## ---- nome ----`; é onde se explica R),
  `relatorio.qmd` com o código limpo e `# fonte:` na primeira linha de cada
  chunk (a camada didática dele, em comentários `<!-- -->`, é sobre programação
  literária, não sobre R), `R/funcoes.R` com `atualizar_codigo()`/`conferir_codigo()`
  (template `inst/app/templates/funcoes.R`, igual à seção 5 do EAPACaderno) e
  `ocean.scss`. O exportador gera o script e as cascas e chama o mesmo
  `atualizar_codigo()`. Spec: seção "Fase D" em `MODULO_COMUNICACAO_RESULTADOS.md`.
- **Livro:** o modelo é candidato a capítulo (ou apêndice) de organização de
  projetos, e a estrutura dele é a que o livro recomenda. Se divergirem, **o modelo
  dita, porque ele roda**.
- **EAPADados:** o exemplo atual usa uma planilha fictícia (densidade de tilápia em
  tanques-rede), guardada dentro do projeto para ele ser autossuficiente. Caminho
  natural: a mesma planilha entrar no EAPADados e o script 01 ganhar uma linha
  comentada mostrando como carregá-la de lá. **A cópia local fica**: o modelo tem
  que funcionar só com CRAN.

**O que pode mudar:** alinhar a paleta ao Ocean Gradient; adotar `fmt()`/`formatar_p()`
e parentes do EAPADados se couberem em `R/funcoes.R` sem inchar; acrescentar
`referencias.bib` + `.csl` em `relatorios/`; trocar o exemplo por um conjunto do
EAPADados; um segundo exemplo (regressão, qui-quadrado) na mesma estrutura; um
`criar_projeto.R` que reproduza a pasta vazia.

**O que não muda:** o caráter. Antes de qualquer alteração, a pergunta é: *isso deixa o
projeto mais fácil ou mais difícil de explicar para uma pessoa em um minuto?* Se ficar
mais difícil, não entra. Nada de infraestrutura (renv, targets, pipelines, testes, CI),
nada de abstrair os scripts em funções genéricas, nada de reescrever o que funciona
para ficar "mais elegante", nada de importar a orquestração da CatalyseR. Comentários
em português, explicando o porquê, em tom de professor conversando.

**Validação de qualquer mudança:** reiniciar o R e clicar em Render em
`relatorios/relatorio.qmd` (Windows 11 + RStudio). Passou e continua legível por um
aluno = aprovado.

A pasta do modelo **não tem `CLAUDE.md` nem `.gitignore`** de propósito: o que o
pesquisador vê é só o projeto. **O `README.md` do modelo é o manual do
pesquisador** e o documento de referência das convenções (caminhos com `here()`;
o relatório executa e `funcoes.R` só define; um chunk por etapa, nomes na ordem da
análise; dados brutos intocáveis; chunks de trabalho com `output: false`, de
exploração com `include: false`, só `tbl-*`/`fig-*` e texto no Word; um chunk
`analisar-<nome>` por análise quando há mais de uma; nomes em minúsculas, `_` em
objetos e arquivos, `-` em chunks). O README que a CatalyseR gera no Projeto R
exportado deve derivar dele, na mesma voz. Não há dicionário de dados: o "de-para"
das colunas e o motivo de cada NA ficam como comentário no chunk `tratar`. Estilo
de código: base R + tidyverse leve, pipe nativo `|>`, 2 espaços, `pacote::funcao()`
dentro de `funcoes.R`, figuras com `tema_projeto()`/`cores_tratamento` (Ocean),
tabelas do Word com `flextable_ocean()`, números com `fmt()`/`formatar_p()`. Saída
oficial: **Word** (`relatorio.qmd` → `relatorio.docx`, com o mesmo
`custom-reference.docx` da CatalyseR).

## Avaliação por aprendizagem ativa (`APOIO/atividades/`)

Além dos subprojetos, o ecossistema tem um pilar pedagógico de **avaliação**: a
**avaliação dos alunos por aprendizagem ativa**, na pasta `APOIO/atividades/`. Aqui o aluno
percorre o ciclo completo sozinho — **importar → arrumar → analisar → relatório** — com
**dados reais do banco externo, distintos** dos exemplos do pacote e do livro, avaliado
por **rubrica**. Encaixe: CatalyseR = ferramenta; EAPADados/banco externo = dados; livro =
referência; `APOIO/atividades/` = avaliação (o "do dado ao relatório"). Crescer = copiar
`APOIO/atividades/_MOLDE_atividade.md` e registrar no índice de `APOIO/atividades/README.md` (o charter
do pilar). Regra: dado de atividade é real e **diferente** dos exemplos do pacote/livro.

## Concepção, diferenciais e reflexões (o "porquê" do projeto)

**A CatalyseR é a espinha do ecossistema — e o seu diferencial.** A IDE é a fonte da
verdade das análises; o menu é o catálogo do curso. O livro espelha a IDE, o
EAPADados a alimenta, e a IDE exporta um **Projeto R (.zip com .qmd)** para o aluno
completar no RStudio. É a ponte concreta do **"mouse ao código"**: cada clique gera o
R canônico.

O que torna este ecossistema raro (diferenciais a preservar):

1. **Trilha de preparo reprodutível.** TODO o tratamento de dados (limpeza, tipagem,
   filtros, cálculo, reescala, NA, dicotomização, padronização, classes, duplicatas,
   texto, arrumação largo/longo) vira uma **trilha única, ordenada, capturável e
   reordenável**. A ordem é **lógica** (reordenar re-deriva tudo), não cronológica —
   dá para "voltar do futuro ao passado" e o pipeline fica como se sempre tivesse
   sido planejado. Essa trilha vira ao mesmo tempo a **Seção 0 (Métodos)** do
   relatório e espelha a unidade "Antes da análise" do livro. Nem os *recipes* do
   tidymodels, nem o fluxo do JASP/jamovi fecham **preparo → relatório → livro**.
2. **Modelo base/ramos (estrela).** Uma base tratada compartilhada e, dela, ramos
   `base_<analise>` por análise (um salto) — preparo específico sem intercalar com a
   análise (guarda contra p-hacking).
3. **Comunicação de Resultados como PROJETO.** Um estúdio único que reúne
   Mouse → Código → Relatório e entrega um `.docx` (tema Ocean, narrativa em PT) e um
   Projeto R `.zip`.
4. **Filosofia Viewer-first + narrativa automática em português** (`relatar_*`,
   `exibir_*`, tabelas Ocean), com o console cru mostrado ao menos uma vez para o
   aluno não se perder fora do ecossistema.
5. **Entrosamento real:** uma definição canônica por análise da qual a IDE gera o
   código e o livro deriva os exemplos; o EAPADados fornece os dados.
6. **Postura científica honesta:** log cronológico opcional (anti-p-hacking),
   pressupostos explícitos, "planejar a coleta é escolher o teste".
7. **Contexto de pesca e aquicultura** em todos os exemplos.
8. **Programação literária no fim do caminho.** O projeto-modelo e o Projeto R
   exportado são um único documento Quarto que analisa e comunica: o mesmo `.qmd`
   gera o Word para o leitor e o caderno HTML com o código. É o encontro do aluno
   com a programação, mas de forma literária.

**Frase-síntese do ecossistema (set/2026, para o prefácio do livro):** o
tratamento de dados como trilha reprodutível; o planejamento experimental e
observacional antes do primeiro teste; as análises por cliques, com o motor do R
rodando por baixo dos panos; e, no fim, o encontro com a programação, mas
literária: o mesmo documento que analisa é o que comunica. O aluno começa no mouse
e termina lendo, e escrevendo, código com texto em volta. **A CatalyseR deve ser
vista como um convite à programação, e não o contrário.**

**Reflexão de escopo (a regra de ouro da v1):** entra só o que já é dominado e
frequente; **o resto o usuário faz no Excel**. Crescer = adicionar uma entrada num
registro (tratamentos, análises), sem tocar no resto. Enxuto, exequível, mas já um
portfólio sólido.

## Estrutura do livro — a unidade "Antes da análise"

A **Unidade II · "Antes da análise"** reúne tudo o que precede o primeiro teste: o
capítulo de **planejamento da pesquisa** (planejar a coleta é escolher o teste) e, na
sequência, o de **análise exploratória** — este reorientado: não é "descrever por
descrever", e sim **preparar as análises seguintes**. Cada resumo e gráfico é o
rascunho de um teste adiante (boxplot → *t*, dispersão → regressão, tabela cruzada →
qui-quadrado). A ordem interna é **planejar → explorar**.

Esse recorte espelha, no livro, a **etapa de preparo compartilhada** da CatalyseR
(importar → arrumar → filtrar → tipar → recodificar, com dicotomização 0/1 quando a
análise exige) — uma etapa que deve ser **explícita e comum a todos os módulos**.
Ponto de entrosamento a reforçar no texto: uma planilha Excel bem-arrumada (*tidy*,
cada linha uma observação, cada coluna uma variável) chega **pronta** a esse painel de
seleção/filtragem/tipagem, sem retrabalho.

## Preparo de dados na CatalyseR — a Trilha (features implementadas)

O preparo evoluiu de "ilhas" para uma **Trilha de Preparo** capturável (pipeline
reprodutível): `dados_analise` = *replay* das etapas sobre a base. A ordem é
**lógica** (reordenar re-deriva tudo), não cronológica. Specs canônicas:
`catalyser/EVOLUCAO_TRATAMENTO_DADOS.md` (a trilha, ordem lógica × cronológica,
modelo base/ramos em estrela, fases) e `catalyser/MODULO_COMUNICACAO_RESULTADOS.md`
(o relatório integrado que consome o preparo como Seção 0).

Menus de preparo (em **Preparando Dados**):

- **Calcular / Reescalar Variável** (`mod_calcular.R`): variável calculada (modo
  guiado + expressão livre) e reescala por prefixo SI (k, M, m, µ…), sempre criando
  coluna nova.
- **Trilha de Preparo** (`mod_tratar.R` + `registro_tratamentos.R`): pipeline com
  **desenho ao vivo em SVG** e **6 tratamentos** — dados faltantes (NA:
  remover/imputar média/mediana/moda/constante), dicotomizar 0/1 (limiar numérico
  ou níveis categóricos), padronizar (z-score/centralizar/normalizar 0–1), classes
  de tamanho (binning igual/quantis), remover duplicatas (distinct), padronizar
  texto (squish/caixa/título). Cada tratamento é uma entrada do registro (contrato
  `rotulo`/`validar`/`aplicar`/`codigo`); **crescer = adicionar uma entrada**.
- **Arrumar** (empilhar/separar/alargar) e **Contingência** (ramo do qui-quadrado).

Escopo v1 (jul/2026): esses tratamentos cobrem o **frequente**; **qualquer outra
transformação o usuário faz no Excel**. Box-Cox, joins, datas e group/summarise
ficam para a versão avançada.

Modelo **base/ramos**: a Trilha produz a **base** compartilhada (todas as análises
leem); ramos `base_<analise>` (topologia em estrela, um salto) são sub-preparos por
análise — Fase 3. **Fases 1 e 2 já implementadas** (trilha linear + replay como
`dados_analise` global; leem a `base_resolvida` para não aplicar a trilha duas vezes).

Dataset de treino: `catalyser/inst/app/dados/Treino-Transformacoes.xlsx` (abas
`biometria`, `desembarques_largo`, `guia`) — bagunçado de propósito (NA, duplicatas,
texto inconsistente, escalas diversas, formato largo, coluna composta) para exercitar
todos os tratamentos; a aba `guia` mapeia feature → coluna.

## Capítulo de mapas (cap. 15) — única figura pré-gerada

O capítulo **"Criação de Mapas em R"** (`eapa/capitulos/capitulo15`) é o **único** cujo
gráfico **não renderiza sozinho** no Quarto: os chunks de mapa ficam com `#| eval:
false` (mostram só o código) e o resultado entra como **imagem estática**. Motivo: o
`geobr` baixa os limites do IBGE na hora do render (internet + pacotes pesados —
`geobr`, `sf`, `ggspatial`), o que fragilizaria a build automática (GitHub Pages). O
`leaflet` ficou **fora do livro** (é interativo, só HTML) — vive apenas na CatalyseR.

**Fluxo obrigatório antes de renderizar o livro:** rodar, a partir da pasta `eapa/`,
`source("images/gerar_mapa_cap15.R")` para (re)gerar `images/mapa_aquicultura_2023.png`
(coroplético da produção aquícola por estado, 2023). Requer o dataset `aquicultura_br`
do EAPADados já instalado. O `read_state()` do geobr **precisa do argumento `year`**
(ex.: `year = 2020`) — sem ele, dá erro de "argumento de comprimento zero".

**Guia do menu Mapas:** o arquivo `APOIO/mapas.md` (raiz do projeto) é a especificação
canônica do menu **Mapas**. Escopo **v1 (set/2026) = 3 mapas estáticos** (`ggplot`/PNG):
**Coroplético · Pontos/estações · Bolhas proporcionais**. Organizam-se por propósito:
**analisar quantidades** (coroplético, bolhas) e **apoiar a amostragem** de pontos de
coleta (pontos/estações — este com nível de publicação: rótulos, grade em graus,
escala/Norte e inset de localização). Daqui até set/2026 só se **melhoram esses 3** —
nada de novo tipo de mapa. **Parqueados** (fora do menu, arquivos preservados e
`source()` comentado no `app.R`): **Densidade/heatmap** (`mod_mapa_densidade`),
`leaflet` interativo e o **raster ambiental isolado** (`mod_mapa_raster`). Krigagem e
cartograma seguem no backlog. Datasets: `aquicultura_br` (coroplético, real — Peixe-BR),
`estacoes_ictiofauna` (pontos/bolhas); `ocorrencias_peixes` (densidade, parqueado) e
`sst_costa_norte` (raster, parqueado) — estes três são **exemplos sintéticos** (B-020).

## Meta: 1ª edição até setembro de 2026

Escopo de v1 deliberadamente **enxuto e exequível**: entram apenas análises que o autor
**já domina e que já estão na CatalyseR**. Fácil de transitar, mas já um portfólio sólido.

- **Livro EAPA — 1ª edição:** capítulos com as análises já consolidadas.
- **CatalyseR — v1:** as análises dominadas, disponíveis no menu.
- **EAPADados — v1:** datasets de contexto documentados por domínio.
- **Comunicação de resultados (.docx) — v1:** exportação de relatório Word com narrativa
  automática em português (p-valor, IC, pressupostos) e tabelas `flextable` no tema
  Ocean Gradient. Cobre os módulos: estatística descritiva, teste t (uma amostra,
  independentes, pareadas) e regressão linear simples (coeficientes, R², resíduos).
- **Projeto-modelo — v1:** `relatorios/relatorio.qmd` renderizando do zero, com um
  exemplo completo (DIC de densidade de tilápia: ANOVA + Tukey + tendência).

Regra de escopo: ao propor incluir uma análise, verifique se ela já existe na CatalyseR
e se é de baixo esforço de implementação. Se não, registre como ideia para versões futuras.

### Motor de exportação (já prototipado)

O relatório `.docx` é gerado por um pipeline: a IDE reúne, num diretório temporário, o
template `.qmd` + `custom-reference.docx` + dados (`.rda`) + scripts, substitui as
variáveis e roda `quarto render --to docx`. As peças-semente já existem (de prototipagem
anterior) e devem ser integradas — idealmente nascendo do EAPADados ou de um gerador
comum, para que o livro espelhe o mesmo código:
- `relatar_teste_t()` — frase-relatório em português (com *d* de Cohen e interpretação).
- `mostrar_teste_t()` / `flextable_ocean()` — tabela estruturada no tema Ocean Gradient.
- `custom-reference.docx` — template Quarto→Word (TNR 12, justificado, A4 ABNT, sumário,
  títulos numerados, número de página).

## Convenções de entrosamento

1. **Análises (a verdade) vivem na CatalyseR.** O código que a IDE exporta é a forma
   canônica de cada análise.
2. **O livro espelha a CatalyseR** — exemplos reproduzem as análises da IDE, idealmente
   derivando do mesmo gerador de código.
3. **EAPADados = dados.** Datasets em `EAPADados/data/` (`.rda`), documentados em
   `EAPADados/R/dados.R`. Acessados por `data(nome)` ou `EAPADados::nome`.
4. **Meta de entrosamento real:** uma definição canônica de cada análise da qual a IDE
   gera o código e o livro deriva os exemplos.
5. **Versionamento:** cada consumidor declara `EAPADados (>= x.y.z)` e fixa com `renv`.

## Identidade visual (Ocean Gradient)

| Token | NAVY | TEAL | SEAFOAM | AMBER | CORAL |
|-------|------|------|---------|-------|-------|
| Hex   | #0F3B5F | #2E7D8F | #62B6B7 | #E89B3C | #E76F51 |

Tipografia: Cambria (títulos) + Calibri (corpo). Logo CatalyseR sobre fundo #01031A.
Exemplos contextualizados à pesca (ex.: regressão peso × comprimento por sexo).

## Convenção de tabelas (livro)

Duas funções do `EAPADados` apresentam tabelas; a escolha depende de a tabela ser
**referenciada** (citada por número) ou não:

- **`flextable_cinza()`** — saída-padrão no corpo do texto, para **mimetizar uma
  saída de console, porém organizada**: fonte monoespaçada, fundo cinza,
  centralizada e **sem linhas de grade**. Usar **sem legenda** (rótulo de chunk
  neutro, sem `tbl-cap`). Ex.: `arrumar_teste_t(teste) |> flextable_cinza()`.
- **`flextable_ocean()`** — para tabelas **referenciadas/numeradas** (citadas com
  `@tbl-...`): tema Ocean de marca, com rótulo `tbl-` + `tbl-cap`. É também o tema
  das tabelas no relatório `.docx` exportado pela CatalyseR.

Regra prática: tabela só para "ver o resultado" → `flextable_cinza()`; tabela que
você cita por número no texto → `flextable_ocean()` com legenda.

Complemento: `arrumar_teste_t()` recebe o objeto do `t.test()` (classe `htest`) e
devolve um `data.frame` enxuto em português; `exibir_teste_t()` é o atalho de
uma chamada que faz `arrumar_teste_t() |> flextable_cinza()` de uma vez.

Cores: a `flextable_cinza()` usa **fundo verde acinzentado** (sage: corpo
`#E7EFEA`, cabeçalho `#C5D8CF`), cabeçalho em negrito e sem linhas de grade. O
tom verde é proposital — distingue, de relance, três coisas: **(a)** uma
exibição de resultado no Viewer (verde sage), **(b)** um bloco de código/saída
de console (fundo cinza), e **(c)** uma tabela referenciada no tema Ocean
(`flextable_ocean()`, com legenda numerada).

## Filosofia de saída: Viewer por padrão, console uma vez

Mudança de filosofia adotada para o livro e a IDE: a saída-padrão de um teste é
a **tabela arrumada no Viewer** (`exibir_*`), não o despejo cru do console. O
objetivo é um ambiente mais amigável e moderno — legível, em português,
alinhado ao "do mouse ao código" e ao que a CatalyseR entrega. O console
continua sendo usado, mas com menos frequência.

Duas regras para isso não virar faca de dois gumes:

1. **O console cru aparece pelo menos uma vez, de propósito** — no capítulo onde
   cada análise é introduzida, mostra-se a saída bruta (ex.: `t.test()`) e
   explica-se o que cada parte significa. A partir daí, padroniza-se com
   `exibir_*`. Assim o aluno não fica perdido quando topar o console puro fora
   do ecossistema (ajuda do R, outro pacote, script fora do RStudio).
2. **A camada reprodutível mora embaixo** — `arrumar_*` devolve um `data.frame`
   que imprime em qualquer lugar (terminal, `.R` fora do RStudio); `exibir_*`/
   `flextable_*` é só a camada de apresentação (HTML/Viewer/Quarto). Mantenha
   sempre a `arrumar_*` por baixo da `exibir_*`.

Escopo: construir a família `arrumar_`/`exibir_` **conforme cada análise é
consolidada** (hoje: teste *t*; depois: descritiva, regressão), respeitando o
escopo enxuto da v1. Não prometer cobertura total antes da hora.

## Stack

- **CatalyseR:** Shiny; menus de análise; exporta Projeto R (.zip) com `.qmd`.
- **Livro:** Quarto book (`_quarto.yml`); capítulos `.qmd` espelhando a IDE; GitHub Pages.
- **EAPADados:** pacote R de dados — `usethis`, `roxygen2`, `testthat`; `R CMD check`.

## Inventário de análises (atualizado em set/2026)

**Já na IDE (v1):**
- *Preparo:* importação, empilhar/separar/alargar (Arrumar), calcular/reescalar,
  Trilha de Preparo (6 tratamentos), tabela de contingência.
- *Planejamento:* amostragem AAS/AEP/AS; planejamentos experimentais.
- *Descrição/exploração:* estatística descritiva, tabela de frequência, histograma,
  boxplot, pizza, dispersão, linhas, barras.
- *Regressão:* descobrir o modelo, linear simples, logística; não linear
  (exponencial, potência, von Bertalanffy, polinomial, logarítmica, logística).
  Linear múltipla: em desenvolvimento.
- *Testes paramétricos:* teste t, ANOVA de um fator, ANOVA de dois fatores com
  interação e ANCOVA (car/emmeans/effectsize).
- *Não paramétricos:* qui-quadrado (independência), Mann-Whitney, Wilcoxon, Kruskal-Wallis.
- *Multivariada:* PCA, agrupamentos (HCA).
- *Mapas:* coroplético, pontos/estações, bolhas.
- *Probabilidades:* distribuição normal, binomial.
- *Séries temporais* (provisoriamente em Modelos de Regressão).
- *Comunicação de Resultados* (casca).

**Candidatos fáceis e frequentes (2–3 entram na v1):**
- **Correlação (Pearson/Spearman)** — r, p-valor, IC; ponte natural dispersão →
  regressão. (lacuna mais clara)
- **Teste de normalidade (Shapiro-Wilk) + QQ-plot** — checagem de pressuposto,
  central ao livro.
- **Qui-quadrado de aderência / proporção esperada** (ex.: razão sexual 1:1) —
  domínio pesqueiro, fácil.
- **Intervalo de confiança (média/proporção)** — inferência fundamental.
- **Teste de proporções (prop.test)** — frequente.

**Planejado — Laboratório de Conceitos** (repurpose de "Calculando Probabilidades"):
pilar pedagógico com visualizadores interativos — TLC, Lei dos Grandes
Números, cobertura do IC, distribuição sob H0/p-valor, curvas z/t/F/qui-quadrado
(+ as distribuições Normal/Binomial atuais). Spec: `catalyser/MODULO_LABORATORIO_CONCEITOS.md`.

**Backlog (versão avançada):** regressão linear múltipla (finalizar), homogeneidade de variâncias (Levene/Bartlett), matriz de
correlação/heatmap, Box-Cox, joins/datas.

## Plano de trabalho (rumo a set/2026)

1. **Inventário.** Listar as análises já prontas na CatalyseR e confrontar com os
   capítulos do livro — o que já está coberto, o que falta escrever.
2. **Congelar o escopo de v1** nessas análises dominadas; o resto vira backlog.
3. **Espelhar.** Garantir que cada análise da IDE tenha capítulo correspondente no livro.
4. **Escopar o EAPADados** como pacote de dados; documentar datasets por domínio.
5. **Apontar consumidores** ao pacote (`EAPADados::` / `data(...)`); remover duplicatas.
6. **Fixar versões** (`renv`) e marcar as v1 (o projeto-modelo fica fora do `renv`,
   de propósito).
7. **Projeto-modelo → livro.** Decidir se vira capítulo ou apêndice de organização
   de projetos; o texto do livro segue a estrutura do modelo.

## Diretrizes para o agente

- A CatalyseR manda nas análises; o livro segue; o EAPADados fornece dados.
- Respeite o escopo de v1: só o que já está dominado e na IDE.
- No `EAPACaderno/`, simplicidade manda: sem infraestrutura, sem
  abstrações, sem dependência da CatalyseR, sem arquivos de agente lá dentro.
- Comente em português; mantenha os exemplos contextualizados à pesca e aquicultura.
