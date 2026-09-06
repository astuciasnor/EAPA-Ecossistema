# EAPA — Backlog

Ideias e decisões adiadas, fora do escopo enxuto da v1 (1ª edição até set/2026).
Cada item registra o contexto, as opções consideradas e a inclinação atual, para
não se perder até a retomada.

---

## B-001 · Empacotar a IDE CatalyseR para os alunos instalarem e lançarem

**Status:** Concluído (reestruturado no formato de Pacote R e publicado no GitHub em 16/06/2026).
**Registrado em:** 12/06/2026.
**Quem cuida da IDE:** Resolvido.

### Contexto
Distribuir a CatalyseR (app Shiny) inteira de forma que o aluno consiga **instalar e
abrir** na própria máquina (ou acessar pronta). Distinto do export por análise
(Projeto R em `.zip` com `.qmd`), que continua sendo a "ponte do mouse ao código".

### Opções consideradas
1. **Pacote R com `run_app()` (abordagem golem) — inclinação atual.**
   O aluno instala o pacote `CatalyseR` e roda `CatalyseR::run_app()`, que abre o app
   no navegador local. Combina com o ecossistema: versiona junto, declara
   `EAPADados (>= x.y.z)` como dependência e reaproveita a mesma mecânica de instalação.
   Limitação: exige R instalado na máquina do aluno.
2. **Hospedar online (shinyapps.io / Posit Connect / servidor).**
   Mais fácil para o aluno: só abrir um link, zero instalação. Bom para quem só quer
   *usar*. Limitação: custo/horas de hospedagem, depende de internet, questões de dados.
3. **Instalador desktop que embute o R (RInno / Electron / DesktopDeployR).**
   O mais "aplicativo de verdade" (duplo clique), para alunos sem R. Mais pesado de
   montar, instalador grande e específico por sistema operacional. **Fora da v1.**

### Inclinação para o fim do projeto
Pacote R com `run_app()` (para o aluno que tem R e está aprendendo a programar) e, se
quiser alcance amplo, uma versão **hospedada em paralelo** para acesso imediato. O
instalador desktop fica para uma versão futura.

### Dependências / pré-requisitos
- v1 das três peças (CatalyseR, EAPADados, livro) consolidada.
- EAPADados publicado, para o pacote da IDE declará-lo como dependência.

---

## B-002 · Migrar descritiva e regressão para o EAPADados (padrão canônico)

**Status:** pendente (próximo passo natural do piloto).
**Registrado em:** 12/06/2026.

### Contexto
O teste *t* já foi migrado (`EAPADados/R/relatos_teste_t.R`) com o padrão
`calcular_*` (fonte canônica) + `mostrar_*` (tabela) + `relatar_*` (texto). Falta
aplicar o mesmo às funções `funcoes_descritiva.R` e `funcoes_regressao.R` (hoje em
`catalyser/templates/`). A **descritiva** ainda recalcula em paralelo entre `mostrar_`
e `relatar_` — unificar com um `calcular_descr()`. Apontar os `.qmd` correspondentes
para `EAPADados` com fallback `source()`, como já foi feito no teste *t*.

**Regra de escopo:** migrar cada análise só quando estiver dominada e na IDE.

---

## B-003 · Bloco de pressupostos e resíduos nos relatórios

**Status:** pendente (maior lacuna frente ao escopo declarado).
**Registrado em:** 12/06/2026.

### Contexto
O resumo dos relatórios e o `CLAUDE.md` prometem "pressupostos" e, na regressão,
"resíduos", mas os relatórios atuais não testam nem reportam isso. Falta:
- teste de normalidade (Shapiro-Wilk) onde couber;
- na regressão, avaliação de homocedasticidade e **gráfico de resíduos**
  (`fig-cap-location` já está setado, mas não há nenhuma figura).

Implementar como parte da mesma fonte canônica (ex.: `relatar_pressupostos()`,
`mostrar_residuos()`), para o livro espelhar.

---

## B-004 · Pequenas correções nos motores descritiva/regressão

**Status:** pendente (baixo esforço).
**Registrado em:** 12/06/2026.

### Itens
- (a) Rótulo de IC dinâmico onde houver — **já corrigido no teste *t***; conferir nos demais.
- (b) Coluna "Valor" da tabela de métricas da regressão mistura número e texto "-",
  virando coluna de texto e perdendo o alinhamento decimal.
- (c) Opcional/cosmético: enriquecer `flextable_ocean()` com faixa zebrada (SEAFOAM)
  além do cabeçalho NAVY.
- (d) Deduplicar `fmt()`, `interpretar_d()` e `flextable_ocean()` ao consolidar tudo
  no EAPADados (hoje repetidas em cada arquivo de funções).

---

## B-005 · Incorporar datasets de contexto ao EAPADados (.rda)

**Status:** pendente (à medida que cada análise chega à IDE).
**Registrado em:** 12/06/2026.

### Contexto
Bases como `dados_t_pareado.xlsx` (barragens, metano) devem virar datasets `.rda`
documentados em `EAPADados/R/dados.R` quando a análise de teste *t* pareado for
consolidada na IDE — fechando o ciclo "artigo → dado de contexto → exemplo no livro".

**Regra acordada:** passar dado ao EAPADados só conforme construímos a IDE para a
referida análise (não adiantar).

---

## B-006 · Livro: enfoque em coleta amostral e planejamento experimental

**Status:** ideia para a fase do livro.
**Registrado em:** 12/06/2026.

### Contexto / motivação
Dar destaque no livro ao **plano de coleta de dados amostrais** e ao **planejamento
experimental**. Premissa do autor: dados bem coletados e bons experimentos são um dos
maiores passos da estatística aplicada — muitas vezes mais decisivos que a análise em si.

### Abordagem editorial (escopo enxuto, alinhado à v1)
- **Pouca teoria dos métodos** de amostragem/delineamento — citar livros mais teóricos
  como referência, sem reproduzi-los.
- Focar nos **pontos práticos que afetam a análise**: pressupostos, condições de
  validade, e a **interpretação** dos resultados.
- Ideia de fio condutor: amarrar cada capítulo de análise à pergunta "como esses dados
  foram (ou deveriam ser) coletados?" — conectando coleta/delineamento → pressupostos →
  análise → interpretação.

### A definir quando chegarmos ao livro
- Se vira um capítulo introdutório próprio, uma seção recorrente em cada análise, ou os dois.
- Quais referências teóricas citar (amostragem, DOE).

---

## B-007 · Livro: capítulo de referência (molde flexível)

**Status:** estrutura definida; primeiro capítulo a escrever na fase do livro.
**Registrado em:** 12/06/2026.

### Contexto
Um capítulo de referência que sirva de **molde NÃO-rígido** para os demais — cada
análise pega o que precisa e adapta as especificações.

### Consideração de escopo
A **ANOVA ainda não está no motor da IDE** (v1 = descritiva, teste *t*, regressão; o
`isoproteica_bagre` é dataset planejado para ANOVA). Como o livro espelha a CatalyseR, a ANOVA
serve para **desenhar a estrutura**, mas o conteúdo executável (código + tabela +
narrativa) só espelha de verdade quando a função existir na IDE/EAPADados. Já prontos
ponta a ponta: **teste *t*** e **regressão** — candidatos ao primeiro capítulo real.

### Esqueleto (9 seções, flexível)
1. Contexto pesqueiro — a pergunta real que a análise responde.
2. Quando usar — leve, sem teoria pesada.
3. De onde vêm os dados — coleta/delineamento que valida a análise (ver [[B-006]]).
4. Os dados — dataset do EAPADados (`glimpse`).
5. **Pressupostos** — o que precisa valer, como checar, o que fazer se falhar (ver B-003).
6. A análise na prática — código da CatalyseR/EAPADados + tabela Ocean + narrativa.
7. **Interpretação** — p-valor, tamanho de efeito, IC, de volta à pergunta pesqueira.
8. Comunicar o resultado — relatório `.docx` (ABNT).
9. **Para aprofundar** — citações aos livros teóricos.

Itens 5, 7 e 9 concentram o foco editorial (pouca teoria, muito uso e interpretação).

### A definir
- Qual análise vira o primeiro capítulo real (sugestão: teste *t* ou regressão).
- Política de quanto código R mostrar (ver B-008).

---

## B-008 · Livro: política de quanto código R mostrar

**Status:** política definida; aplicar a partir do molde (B-007).
**Registrado em:** 12/06/2026.

### Princípio
Nos capítulos de análise, **código é meio, não conteúdo**. Mostrar o mínimo de alto
valor (as linhas que o aluno de fato roda); a página foca no resultado e na interpretação.

### Estratégia em três camadas
1. **EAPADados absorve o encanamento.** O capítulo chama a função de alto nível
   (ex.: `relatar_teste_t(...)`) em vez de `t.test` + formatação + montagem da frase.
   - **A ajuda do pacote (roxygen) é onde o detalhe mora** — precisa estar bem escrita,
     e o livro pode pedir ao leitor: "veja `?relatar_teste_t`". Isso reforça a
     importância de docs roxygen completas (ver B-002 e B-004).
2. **Quarto dobra o secundário.** `code-fold: true` para limpeza de dados / tema do
   gráfico; `echo: false` para mostrar a figura/tabela sem o código que a gerou.
3. **Projeto R (.zip) da IDE = casa do código completo**, rodável. O livro ensina a
   ler e interpretar; o zip é para fazer e editar (a ponte "mouse → código").

### Destaque no "Sobre" do livro
Uma seção do "Sobre" explicando **o que a CatalyseR faz pelo leitor**: gerar o `.zip`
com o código completo de cada análise. Posiciona a terceira camada como um recurso do
próprio livro, não como algo à parte.

### Regra prática
Código com valor didático direto **aparece**; encanamento **some no pacote**, **dobra
no Quarto**, ou **vai para o zip**.

---

## B-009 · CatalyseR: ajuda de uso dentro do app (com screenshots leves)

**Status:** decisão de design para a fase da IDE (coordenar com a outra IA).
**Registrado em:** 12/06/2026.

### Decisão
A ajuda de uso vive **dentro do app Shiny** (uma aba/painel "Ajuda"), não em programa
separado — o aluno não troca de contexto. Sidebar com o menu das análises; cada seção
aponta o **dataset do EAPADados** a usar e a **ajuda da função** (`?relatar_teste_t` etc.).
A versão para o Viewer do RStudio (HTML autocontido aberto por uma função) fica como
plano B / uso fora do app.

### Peso das imagens — manter leve
- **Recortar apertado**: só a aba/botão relevante, não a janela inteira; redimensionar
  para ~800 px de largura. (Maior ganho.)
- **Formato**: WebP (bem menor que PNG) ou PNG otimizado (`pngquant`); alvo < ~100 KB cada.
- **Servir de `www/`** como arquivos estáticos (cacheados pelo navegador), não base64
  embutido; `loading="lazy"` — carregam só ao abrir a aba Ajuda, sem pesar na abertura.
- **Poucos screenshots-chave** por análise; para o conceitual (fluxos, menus), preferir
  **diagramas SVG** (vetor, poucos KB, sempre nítidos).

### Trade-off
Se a IDE virar pacote R, imagens em `inst/www` somam ao tamanho do pacote — otimizadas
ficam pequenas e são ajuda essencial, então compensa.

### Relação
Implementa a "primeira camada" do B-008 (ajuda bem explicada) dentro do app; complementa
a ajuda roxygen do EAPADados. Ver também B-001 (empacotar a IDE).

---

## B-010 · Família canônica de correlação (EAPADados + CatalyseR)

**Status:** pendente (nova análise; hoje o capítulo usa `corrplot` direto).
**Registrado em:** 28/06/2026.

### Contexto
O capítulo "Análise de Correlação e Associação" (pasta `capitulo10`, renderizado como
cap. 9) já foi rascunhado, mas usa `cor()` + `corrplot::corrplot()` e `chisq.test()`
**diretamente** — fora do padrão canônico. A correlação ainda **não é uma análise da
CatalyseR** (a IDE só usa matriz de correlação por dentro da PCA e faz correlação
bivariada dentro da regressão). Pelo princípio de entrosamento, falta a fonte única.

### O que criar (quando a análise entrar na IDE)
- `calcular_correlacao()` — recebe um data.frame/colunas numéricas e devolve a matriz
  (Pearson/Spearman), com p-valores e IC dos pares.
- `mostrar_correlacao()` — tabela da matriz no tema Ocean (`flextable_ocean()`).
- `grafico_correlacao()` — embrulha o `corrplot` na identidade Ocean Gradient.
- `relatar_correlacao()` — frase em português para o par principal (r, IC, p).
- Para a **associação**: par análogo para qui-quadrado/contingência
  (`calcular_associacao()` / `mostrar_contingencia()` / `relatar_associacao()` com V de Cramér).

### Regra de escopo
Só migrar para canônico quando a análise estiver dominada e na CatalyseR (mesma regra
do B-002). Por ora, `corrplot` direto no capítulo é aceitável e foi decisão consciente.

### Dependência
Adicionar `corrplot` ao `Suggests` do projeto/livro (e do EAPADados, se a função
canônica nascer lá).

---

## B-011 · Migrar PCA e HCA canônicas para o EAPADados

**Status:** pendente (análises já existem na CatalyseR; faltam no pacote).
**Registrado em:** 28/06/2026.

### Contexto
A **PCA** e a **AAH/HCA** já são análises canônicas da CatalyseR (módulos `mod_pca`
e `mod_hca`, com `calcular_pca()`, `mostrar_pca_var()` etc. e templates
`relatorio_pca.qmd` / `relatorio_hca.qmd`). Porém essas funções moram em
`catalyser/inst/app/templates/` (`funcoes_pca.R`, `funcoes_hca.R`), **não** no
EAPADados — o relatório as carrega por `source()` como fallback. O capítulo de
multivariada (pasta `capitulo13`) foi escrito com **FactoMineR + factoextra**
diretamente, para os gráficos (biplot, círculo, dendrograma), e ainda não chama
as funções canônicas.

### O que fazer
- Migrar `funcoes_pca.R` e `funcoes_hca.R` para `EAPADados/R/` (padrão
  `calcular_*` / `mostrar_*` / `relatar_*`), como foi feito no teste *t*.
- Decidir a relação com FactoMineR/factoextra: ou as funções canônicas passam a
  usar FactoMineR por baixo (uniformizando com o livro), ou o livro ganha um
  `grafico_pca()`/`grafico_dendrograma()` que embrulha o factoextra no tema Ocean.
- Adicionar `FactoMineR` e `factoextra` ao `Suggests`.

### Regra de escopo
Mesma do B-002: consolidar conforme a análise estiver dominada e estável na IDE.

---

## B-012 · Inventário completo de pacotes (livro + IDE)

**Status:** iniciado (primeiro levantamento abaixo; completar e manter vivo).
**Registrado em:** 28/06/2026.

### Contexto
Ter uma lista única de **todos** os pacotes R usados no ecossistema — livro
(`.qmd`), IDE CatalyseR e pacote EAPADados — para gerir dependências, fixar
versões (`renv`) e montar o guia de instalação do usuário (ver B-013).

### Primeiro levantamento (a conferir/completar)
**Livro (capítulos `.qmd`):** EAPADados, ggplot2, flextable, dplyr, tidyr,
stringr, readr, lubridate, tibble, tidyverse, here, janitor, readxl, rio, arrow,
knitr, scales, FSAdata, **corrplot** (cap. correlação), **FactoMineR** e
**factoextra** (cap. multivariada); utilitários: remotes, pkgbuild; e a própria
`catalyser`.

**EAPADados (DESCRIPTION):** Imports — dplyr, flextable, magrittr, stats, tibble,
utils. Suggests — ggplot2, QFASA. (A acrescentar quando as funções canônicas
chegarem: corrplot, FactoMineR, factoextra — ver B-010 e B-011.)

**CatalyseR (DESCRIPTION):** Imports — shiny, bslib, ggplot2, DT, readxl,
markdown, zip, writexl (conferir o DESCRIPTION completo; provavelmente há mais,
ex.: quarto/flextable).

### Como manter
Idealmente um script que varre os `library()`/`require()`/`pkg::` dos `.qmd` e
os `DESCRIPTION`, gerando a lista automaticamente (evita defasagem). Observação:
o levantamento manual acima pode ter ficado incompleto por desync de leitura nos
capítulos recém-escritos; regerar com os arquivos já salvos.

---

## B-013 · Lista mínima de pacotes para o usuário instalar

**Status:** proposta inicial (derivar de B-012 quando fechado).
**Registrado em:** 28/06/2026.

### Contexto
Um bloco enxuto de instalação para o leitor rodar o livro sem instalar dezenas de
pacotes à toa. Pré-requisitos fora do R: **R (>= 4.5)** e **Quarto**.

### Proposta (rascunho)
```r
# 1. ferramenta de instalação a partir do GitHub
install.packages("remotes")

# 2. nucleo de manipulacao e graficos (tidyverse cobre dplyr/ggplot2/tidyr/
#    readr/stringr/lubridate/tibble/scales)
install.packages(c("tidyverse", "here", "janitor", "readxl", "rio"))

# 3. tabelas e relatorios
install.packages("flextable")   # knitr/rmarkdown vem com o Quarto/RStudio

# 4. analises especificas do livro
install.packages(c("corrplot", "FactoMineR", "factoextra", "FSAdata"))

# 5. dados do ecossistema (puxa as dependencias do EAPADados)
remotes::install_github("astuciasnor/EAPADados")
```
A revisar conforme B-012 e conforme novas análises entrarem no livro.

---

## B-014 · Reduzir espaços vazios nas páginas no formato Typst (PDF)

**Status:** pendente (ajuste de layout do PDF).
**Registrado em:** 28/06/2026.

### Contexto
No PDF via Typst sobram **espaços vazios** em algumas páginas (figuras que
"empurram" texto para a página seguinte, blocos com folga excessiva, triângulo
vazio do `corrplot` afastando a legenda etc.). Melhorar o aproveitamento da página.

### Levers já identificados / a explorar
- **Figuras grandes**: reduzir `fig-height`/`fig-width` e zerar margens internas
  (ex.: `mar = c(0,0,0,0)` no `corrplot`); o triângulo vazio do `type = "upper"`
  pode virar `"lower"` para colar na legenda.
- **Tabelas/figuras sem legenda** saem como `#box(image())` inline e colam no texto
  — já contornado com `#v(0.8em)` pontual (cap. 7); avaliar regra global no
  `estilo-typst.typ`.
- **Posicionamento de floats**: testar `fig-pos`/placement e o comportamento de
  quebra de página do Quarto→Typst.
- **Espaçamento de blocos/parágrafos e títulos** no `estilo-typst.typ`
  (`show heading`, `block(spacing:)`), controle de órfãs/viúvas.
- Conferir página a página após o render e tratar os piores casos primeiro.

---

## B-015 · Estilo de referências: adotar o da revista Food Chemistry

**Status:** Concluído (28/06/2026).
**Registrado em:** 28/06/2026.

### Contexto
Hoje o livro usa **`abnt.csl`** (definido no `_quarto.yml`: `csl: abnt.csl`). O
objetivo é que as referências sigam o estilo da revista **Food Chemistry**
(Elsevier) — estilo autor–data da família "Elsevier (Harvard)".

### O que fazer
- Obter o **CSL correto** do estilo da Food Chemistry (do repositório oficial de
  estilos CSL / Zotero Style Repository; conferir o "Guide for Authors" da revista
  para o formato exato de citação no texto e da lista de referências).
- Adicionar o arquivo `.csl` ao projeto do livro e trocar `csl:` no `_quarto.yml`.
- Revisar a `references.bib`: o estilo Elsevier/Harvard exige campos completos
  (autores, ano, título, periódico, volume, páginas, DOI) — conferir todas as
  entradas (incl. as recém-adicionadas: kassambara2017, le2008, davis2002).
- Renderizar e conferir citações no texto e a formatação da lista final.

### Resolução (28/06/2026)
- **Descoberta:** a "Food Chemistry" no repositório CSL é um estilo *dependente*
  (stub de 14 linhas) cujo `independent-parent` é o **APA** (autor-data). O
  Quarto/Pandoc não resolve estilos dependentes, então usa-se o estilo-pai.
- **Aplicado:** baixado o `apa.csl` (APA 7th, ~2.273 linhas) e salvo em
  `eapa/apa.csl`; `_quarto.yml` agora com `csl: apa.csl`. Descartados o
  `food-chemistry.csl` (stub) e o `Food Chemistry.ens` (formato EndNote, inútil
  no Quarto).
- **Pendência menor:** conferir, após o render, campos completos na
  `references.bib` (autores, ano, título, periódico, volume, páginas, DOI),
  especialmente kassambara2017, le2008 e davis2002.

---

## B-016 · Decisão: bibliografia única ao fim do livro

**Status:** Concluído (28/06/2026).
**Registrado em:** 28/06/2026.

### Contexto
O livro mostrava **duas** entradas de referência no sumário ("References" e
"Bibliografia"), por haver dois mecanismos ativos ao mesmo tempo: a página global
`references.qmd` (com `::: {#refs}`) **e** blocos `## Referências` + `::: {#refs}`
no fim de vários capítulos (cap. 9, 10 e 13).

### Decisão e aplicação
Adotada **uma bibliografia única ao fim do livro** (padrão de livro, não de
coletânea). Em 28/06/2026:
- Removidos os blocos `## Referências` + `::: {#refs}` dos capítulos 9, 10 e 13.
- Num livro, o Quarto **gera a bibliografia automaticamente** ao fim; por isso a
  página `references.qmd` aparecia **vazia** (duplicando com a seção automática
  "Bibliografia"). Removida do `_quarto.yml` (o arquivo pode ser apagado).
- Título da seção definido com `reference-section-title: "Referências
  Bibliográficas"` no `_quarto.yml` (renomeia a seção automática).
- **Referências justificadas:** `#set par(justify: true)` no `estilo-typst.typ`
  (PDF/Typst) e `.csl-entry { text-align: justify; }` no `custom.scss` (HTML).

### Regra para os próximos capítulos
**Não** acrescentar bloco de referências por capítulo. As citações (`@chave`) ao
longo do texto são coletadas automaticamente na página única `references.qmd`.
(Atualizar a estrutura-modelo no skill `redacao-eapa`, que ainda lista o bloco
por capítulo.)

---

## B-017 · CatalyseR: etapa de preparo explícita e compartilhada por todos os módulos

**Status:** A fazer (parqueado a pedido do autor — retomar em conversa dedicada).
**Registrado em:** 04/07/2026.

### Contexto
Hoje a seleção de variáveis, o filtro e a tipagem funcionam bem no menu, mas o
**preparo dos dados** está implícito e espalhado. A ideia é torná-lo uma etapa
**explícita e comum a todos os módulos**, na ordem:

    importar → arrumar (checagem *tidy*) → filtrar → tipar → recodificar → analisar

Dois pontos a cobrir: **(a)** a recodificação de categórica para **dicotômica (0/1)**
como um passo nomeado, para as análises que exigem; **(b)** uma **checagem *tidy***
que alerta os vícios que o livro já enumera (totais no meio das observações,
unidades misturadas, cor como informação) — a IDE passa a policiar o que o livro
prega.

### Entrosamento
Espelha, no software, a unidade **"Antes da análise"** do livro (planejar → conhecer).
Reforçar a ponte: uma planilha Excel bem-arrumada (*tidy*) chega **pronta** a esse
painel, sem retrabalho.

---

## B-018 · CatalyseR: relatório .docx modular (escolher as saídas a incluir)

**Status:** A fazer (o autor vai atacar todos os módulos numa etapa dedicada, com calma).
**Registrado em:** 04/07/2026.

### Contexto
Hoje cada módulo gera um relatório `.docx` com um conjunto fixo de saídas. A ideia é
deixar o pesquisador **montar o relatório**: como a ANOVA (e outros) tem várias abas
de resultados (tabela, gráfico, pressupostos, relato, pós-teste…), oferecer
**caixas de seleção** para escolher quais dessas saídas entram no documento final.

### Como implementar (esboço, para a etapa dedicada)
- É uma feature **transversal** a todos os módulos, não só ao qui-quadrado.
- UI: um grupo de `checkboxGroupInput` com as saídas disponíveis do módulo ativo.
- QMD: cada seção do template vira **condicional** (`#| eval: !expr params$inc_grafico`
  etc.), acionada pelos flags passados como parâmetros.
- Manter o padrão Ocean e o relato automático em PT-BR; o default marca as saídas
  essenciais (tabela + relato), e o resto é opcional.

### Entrosamento
Fecha a promessa da v1 de **comunicação de resultados**: um `.docx` que o pesquisador
considera útil e relevante, sem excesso. Espelhar no livro o mesmo conjunto de saídas.

---

## B-019 · CatalyseR Mapas: cortes de classe editáveis pelo usuário

**Status:** A fazer (versão futura). Hoje o módulo já **isola outliers** por padrão.
**Registrado em:** 04/07/2026.

### Contexto
No mapa coroplético, a distribuição de uma variável muitas vezes tem **outliers**
(ex.: o Paraná na produção aquícola, > 2× o 2º colocado) que achatam a escala de
cores. Já resolvido para o caso comum: o módulo, no modo "Classes", tem a opção
**"Isolar outliers (faixa própria no topo)"** (ligada por padrão), que usa a **regra
do IQR** (cerca superior = Q3 + 1,5·IQR) para dar aos outliers uma faixa só deles —
genérico, funciona para qualquer variável. Isso reproduz, sozinho, a escolha do
livro (Paraná na faixa "acima de ~100.000").

### Ideia para a versão futura
Permitir ao usuário **redefinir manualmente os valores de corte** (breaks) — um campo
de texto para digitar os limites (ex.: `0, 5000, 15000, 30000, 100000`) ou controles
deslizantes —, para ajustar as faixas à mão quando o IQR não for o ideal. Fecharia o
controle fino sobre outliers e sobre a mensagem cartográfica. Espelhar no livro a
ideia de "cortes por quantis vs. à mão vs. isolando outlier".

---

## B-020 · Substituir dados SINTÉTICOS dos mapas por dados reais da região

**Status:** A fazer. Rascunhos aceitos para a v1; trocar antes da produção final.
**Registrado em:** 04/07/2026.

### Contexto
Para destravar os módulos de mapas (Pontos/estações, Ambiente em grade) foram
criados datasets de **exemplo** com valores **sintéticos**. Precisam ser trocados
por **dados reais da região** (costa norte / Bragança-PA) antes de ir para os
capítulos finais.

- **`estacoes_ictiofauna`** — coordenadas plausíveis, mas **CPUE e abundância são
  sintéticas**. Buscar dados reais de coleta de ictiofauna do estuário do Caeté /
  Bragança (ex.: projetos do IECOS/UFPA, dissertações, artigos).
- **`sst_costa_norte`** — grade **totalmente sintética**. Substituir por produto
  real recortado na costa norte: TSM (MODIS/OSTIA), clorofila-a (Copernicus Marine /
  NASA OceanColor) ou dados de campo; ou batimetria (GEBCO).
- **`ocorrencias_peixes`** — quando o Módulo 4 (Densidade) for criado, também deve
  nascer de dado real (OBIS, GBIF, SpeciesLink) ou de campo.

Obs.: o `aquicultura_br` **já é real** (anuários da Revista PEIXE BR) — não precisa troca.

---

## B-021 · Mapas parqueados para a v2: leaflet e raster ambiental

**Status:** Parqueado (fora da v1 por decisão da `mapas.md`; arquivos preservados).
**Registrado em:** 04/07/2026.

### Contexto
A `mapas.md` redefiniu o menu **Mapas** da v1 para **4 mapas estáticos**: Coroplético,
Pontos/estações, Bolhas proporcionais e Densidade/heatmap. Dois módulos saíram do menu
principal, mas **não foram apagados** — ficam desligados no `app.R` (linhas `source()`
comentadas) para retomar na v2:

- **`mod_leaflet.R`** (mapa interativo) — ótimo em HTML, mas não entra no livro/PDF e
  cria descompasso IDE↔Quarto. Retomar como recurso opcional/experimental.
- **`mod_mapa_raster.R`** (raster ambiental isolado) — só deve voltar como **camada de
  contexto** para pontos/CPUE/ocorrência (ex.: pontos de coleta sobre TSM, ocorrência
  sobre clorofila), não como "retângulo colorido" sem pontos nem pergunta. O dataset
  `sst_costa_norte` fica guardado para esse uso.
- **`mod_mapa_densidade.R`** (densidade/heatmap de ocorrências) — decisão de 04/07/2026:
  **fora da v1** (set/2026). A v1 fecha com **3 tipos** (coroplético, pontos/estações,
  bolhas); daqui até a entrega só se **melhoram esses 3**. Módulo e dataset
  `ocorrencias_peixes` preservados para retomar na v2.

### Também no backlog de mapas (mapas.md §4)
Krigagem/interpolação, cartograma, mapas 3D e análises espaciais avançadas — fora da v1.

---

## B-022 · Livro: guia de regex na unidade "Antes da análise"

**Status:** Ideia registrada (aguardando ver a evolução do módulo de Arrumação).
**Registrado em:** 06/07/2026.

### Contexto
O módulo **Arrumação (Largo → Longo)** da CatalyseR usa regex para extrair metadados do
nome das colunas (ex.: `^(\d{4}) - (.*)$` sobre `2025 - Valor US$ FOB` → `ano`, `metrica`).
Já existe, **dentro do app**, um guia rápido de regex acessível por um "?" ao lado do
seletor "Padrão de extração" (tabela das peças, padrões prontos, exemplos, regra de ouro).

### Ideia
Levar esse mesmo material para uma **seção da Unidade II · "Antes da análise"** do livro,
espelhando a IDE (convenção de entrosamento: o livro documenta o que a CatalyseR faz).
Encaixe natural: no capítulo de arrumação/preparo, junto do fluxo *largo → longo* e do
princípio *tidy*. Manter o tom "do mouse ao código": a regex escrita no mouse vira o
`names_pattern`/`extract` no script `.R` gerado.

### Pendências antes de escrever
- Ver como o módulo de Arrumação evolui (inclui agora o modo **"Separar uma coluna
  existente"** — `tidyr::extract`, sem pivô). O guia do livro deve cobrir os dois usos:
  extrair do **nome da coluna** (pivot_longer + names_pattern) e extrair de **valores de
  uma coluna** (extract/separate).
- Decidir a profundidade (mini-guia prático vs. seção mais completa).

---

## B-023 · Livro: consolidar o conteúdo *tidy* num só capítulo (3 ou 5)

**Status:** Ideia registrada (revisar perto da versão final da v1).
**Registrado em:** 06/07/2026.

### Contexto
O conceito de dados *tidy* aparece hoje em dois capítulos: o **Cap. 3** (Unidade I —
organização de projeto, importação e **limpeza/tipagem**) apresenta a régua *tidy*
(três regras + `@fig-tidy`); o **Cap. 5** (Unidade II — **arrumação/reshape**:
empilhar, alargar, separar, regex) a retoma. Em 06/07/2026 fizemos uma **deduplicação
leve**: cada assunto com um dono — *tidy*/importação/tipagem no Cap. 3, *reshape*/regex
no Cap. 5 — com o Cap. 5 relembrando a régua em uma frase e uma seta Cap. 3 → Cap. 5.

### A ideia a revisitar
O autor levantou uma possibilidade mais forte: como **limpar, tipar e reformatar são,
no fundo, todas operações de *tidy***, talvez valha **concentrar todo o conteúdo
conceitual de *tidy* no Cap. 5** (o capítulo de preparo da Unidade II), deixando o
*tidy* documentado **num lugar só**. O Cap. 3 ficaria com a organização de projeto e a
mecânica de leitura/gravação, apenas **referenciando** o *tidy* do Cap. 5.

### Tensão a pesar (na decisão)
- **A favor de mover tudo para o Cap. 5:** um único lugar canônico para *tidy*; coerência
  ("tudo é operação de tidy"); o Cap. 5 já é o capítulo de preparo.
- **Contra / cuidado:** o Cap. 3 está na Unidade I e o leitor encontra *tidy* **cedo**,
  quando aprende a digitar/ler dados — antes da Unidade II. Mover para o Cap. 5 adia o
  conceito; talvez o Cap. 3 ainda precise de uma noção mínima de *tidy* na entrada.
  Possível meio-termo: Cap. 3 mantém só a `@fig-tidy` + 1 parágrafo, e o Cap. 5 vira o
  dono do desenvolvimento completo.

### Quando decidir
**Perto da versão final da v1** (set/2026), com os dois capítulos já maduros, para
avaliar a leitura de ponta a ponta antes de mexer na divisão.

---

## B-024 · CatalyseR: Exportação Consolidada deve usar o dataset ATIVO, não os importados

**Status:** A fazer (limitação conhecida do "dataset ativo").
**Registrado em:** 07/07/2026.

### Contexto
Em 07/07/2026 implementamos o **dataset ativo explícito** (ver
[[eapa-dataset-ativo-catalyser]]): as análises passaram a ler `dados_analise` —
por padrão os dados importados (`current_data`), ou o **resultado promovido** de um
módulo Arrumar quando o usuário clica "Usar este resultado nas análises". Um
indicador no painel de dados mostra qual está ativo, com botão "Voltar aos
importados".

### A pendência
Duas peças ainda apontam para os **dados importados**, não para o dataset ativo/
promovido:
1. **Exportação Consolidada** (o `.zip` do projeto R): empacota os dados e scripts a
   partir de `current_data` (importados). Se o usuário promoveu um arrumado e rodou
   as análises sobre ele, o pacote exportado fica **incoerente** com o que foi
   analisado na tela.
2. **`import_info`**: o trecho "ler os dados" do script gerado por cada análise
   referencia a origem importada (arquivo/aba ou `data(...)`), não o arrumado
   promovido.

### O que fazer (quando retomar)
- A Exportação Consolidada deve empacotar o **dataset ativo** (se houver promoção,
  gravar a tabela arrumada e ajustar o script de leitura para ela; idealmente,
  **encadear o script do Arrumar** — `pivot_*`/`separate_*` — antes das análises,
  fechando "do mouse ao código" de ponta a ponta).
- Alinhar `import_info` para refletir a fonte ativa (ou injetar o passo de arrumação
  no cabeçalho dos scripts das análises).

### Relação
Continuação natural de [[eapa-dataset-ativo-catalyser]] e do B-017 (etapa de preparo
compartilhada). Também conversa com a ideia de **encadeamento entre menus** (Empilhar
promovido virar entrada do Separar), hoje não suportado — cada Arrumar parte dos
importados.
