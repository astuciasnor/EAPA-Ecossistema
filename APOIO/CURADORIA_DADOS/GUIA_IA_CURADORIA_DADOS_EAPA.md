# Guia para IA — Curadoria de dados do ecossistema EAPA

> **Público:** uma IA assistente (ChatGPT, Gemini, Claude) que vai ajudar a
> transformar dados reais em **datasets do pacote R `EAPADados`** e a montar a
> **planilha Excel de avaliação** para as aulas. Este guia é **autocontido**:
> assuma que a IA não conhece o repositório. Siga-o à risca.

---

## 1. O que é o ecossistema EAPA (contexto mínimo)

O EAPA — *Estatística Aplicada à Pesca e Aquicultura com R* — tem três peças que se
entrosam:

- **CatalyseR** — uma IDE (app Shiny) onde o aluno faz as análises "no mouse" e leva
  para casa o script `.R` ("do mouse ao código").
- **Livro** (Quarto) — documenta exatamente as análises da CatalyseR.
- **`EAPADados`** — um **pacote R só de dados** (dados de contexto de pesca,
  bioecologia pesqueira, aquicultura e tecnologia do pescado). É consumido pela IDE,
  pelo livro e pelos projetos exportados. **É aqui que os datasets curados entram.**

Regra de ouro do ecossistema: **os dados vivem no `EAPADados`** e são acessados por
`data(nome)` ou `EAPADados::nome`. Nada de `iris`/`mtcars`; sempre contexto de pesca e
aquicultura, de preferência **amazônico** (costa norte / estuário do Caeté, Bragança-PA).

---

## 2. Princípios (valem para todo dataset)

1. **Tidy (arrumado):** cada **linha** é uma observação, cada **coluna** é uma
   variável, **um valor por célula**. Sem totais no meio das observações, sem unidades
   misturadas na mesma coluna, sem cor/negrito carregando informação.
2. **Contexto amazônico e realista:** espécies, locais e faixas de valores plausíveis.
3. **Reprodutível:** todo dataset nasce de um script em `data-raw/` que qualquer pessoa
   roda para regerar o `.rda`.
4. **Documentado e com fonte:** toda base tem documentação (roxygen) e **`@source`**
   com a origem (URL, instituição, artigo) e a licença/uso quando aplicável.
5. **Aberto:** pensado para compartilhar e ensinar.

---

## 3. Estrutura do pacote `EAPADados` (o que a IA precisa saber)

```
EAPADados/
├── DESCRIPTION            # metadados do pacote (nome, versão, deps, LazyData: true)
├── NAMESPACE              # gerado pelo roxygen (não editar à mão)
├── R/                     # DOCUMENTAÇÃO dos dados (um arquivo por dataset)
│   └── data_<nome>.R      # roxygen que descreve o dataset (NÃO contém os dados)
├── data/                  # os DADOS em si, um .rda por dataset
│   └── <nome>.rda
├── data-raw/              # scripts que GERAM os .rda a partir dos dados brutos
│   ├── <nome>.R           # lê o bruto, arruma/tipa e roda usethis::use_data()
│   └── <nome>_bruto.xlsx  # (opcional) o arquivo bruto original
└── man/                   # .Rd gerados por devtools::document() (não editar à mão)
    └── <nome>.Rd
```

Pontos que a IA erra se não souber:

- **`data/` guarda `.rda`**, não `.csv`. O `.rda` é gerado por
  `usethis::use_data(<nome>, overwrite = TRUE)` a partir de um objeto R com o **nome
  exato** do dataset.
- **`LazyData: true`** no `DESCRIPTION` faz os datasets ficarem disponíveis por
  `data(<nome>)` sem carregar nada à mão. (Existe porque há a pasta `data/`.)
- **A documentação fica em `R/data_<nome>.R`** (roxygen), separada dos dados.
  `devtools::document()` transforma isso em `man/<nome>.Rd`.
- **`data-raw/` fica fora do build** (está no `.Rbuildignore`); é onde mora o processo
  de curadoria (script + arquivo bruto).

---

## 4. Convenções obrigatórias

- **Nomes de coluna e de dataset:** `snake_case`, **sem acento e sem espaço**, ASCII
  (ex.: `comprimento_cm`, `peso_g`, `estacao`, `exportacao_pargo`). Unidade no nome
  quando útil.
- **Acentuação:** o **texto da documentação (roxygen) usa português acentuado** e
  declara `@encoding UTF-8`; **nomes de coluna e código ficam em ASCII**. (Datasets de
  dados reais podem ter acento nos *valores* — ex.: nomes de espécies/locais — mas
  evite acento nos *nomes das colunas*.)
- **Tipos:** texto→`character`, categórico→`factor` (quando a ordem/níveis importam),
  contagem→`integer`, medida→`numeric`, data→`Date`. Deixe explícito no script.
- **Tamanho:** datasets didáticos pequenos/médios (dezenas a poucos milhares de linhas).
  Se muito grande, amostre e documente que é uma amostra.
- **Encoding UTF-8** em tudo.
- **Fonte e licença:** registre no `@source` (URL/instituição/artigo). Só inclua dados
  cujo uso educacional seja permitido.
- **Domínios** (para organizar mentalmente): pesca, bioecologia pesqueira e geral,
  aquicultura, tecnologia do pescado.

---

## 5. Passo a passo para ADICIONAR um dataset (com templates)

Suponha o dataset chamado `<nome>` (ex.: `morfometria_peixes`).

### Passo 1 — Colocar o bruto em `data-raw/`
Salve o arquivo original em `data-raw/<nome>_bruto.xlsx` (ou `.csv`). Não mexa no
original; toda limpeza vai no script.

### Passo 2 — Escrever `data-raw/<nome>.R` (gera o `.rda`)

Template (adapte colunas/tipos):

```r
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
#   PREPARACAO DO DATASET: <nome>
#   <uma linha dizendo o que e, a fonte e para que serve>
#   Rode a partir da raiz do pacote EAPADados:
#       source("data-raw/<nome>.R")
# xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

if (!requireNamespace("readxl", quietly = TRUE)) install.packages("readxl")

tb <- readxl::read_excel("data-raw/<nome>_bruto.xlsx", sheet = "Planilha1")

# Preserva nomes NAO sintaticos, se houver (ex.: "2025 - Valor"); senao, ignore.
nomes <- names(tb)
<nome> <- as.data.frame(tb, stringsAsFactors = FALSE, check.names = FALSE)
names(<nome>) <- nomes

# Tipagem explicita de cada coluna:
<nome>$especie          <- as.character(<nome>$especie)
<nome>$comprimento_cm   <- as.numeric(<nome>$comprimento_cm)
<nome>$peso_g           <- as.numeric(<nome>$peso_g)
# ... (uma linha por coluna)

str(<nome>)
usethis::use_data(<nome>, overwrite = TRUE)
cat("OK: data/<nome>.rda gerado (", nrow(<nome>), " x ", ncol(<nome>), ").\n", sep = "")
```

### Passo 3 — Escrever `R/data_<nome>.R` (documentação roxygen)

Template (o **nome do objeto**, `@name` e `@usage` têm de bater com `<nome>`):

```r
#' <Titulo curto e descritivo do dataset>
#'
#' @encoding UTF-8
#' @description
#' <Paragrafo em portugues acentuado: o que e, de onde vem, o que representa,
#'  e para qual analise do ecossistema serve (ex.: regressao peso-comprimento,
#'  comparacao entre grupos, agrupamento...).>
#'
#' @format Um data frame com <N> observacoes e <M> variaveis:
#' \describe{
#'   \item{especie}{Especie (character; \emph{Lutjanus purpureus} etc.).}
#'   \item{comprimento_cm}{Comprimento total, em cm (numeric).}
#'   \item{peso_g}{Peso, em gramas (numeric).}
#'   \item{...}{...}
#' }
#'
#' @source <Origem: instituicao/portal, URL, artigo. Ex.: Comex Stat (MDIC),
#'   \\url{http://comexstat.mdic.gov.br}; ou dados de campo do IECOS/UFPA.>
#' @docType data
#' @keywords datasets
#' @name <nome>
#' @usage data(<nome>)
#'
#' @examples
#' data(<nome>)
#' str(<nome>)
#' # <exemplo minimo da analise-alvo, ex.: plot(peso_g ~ comprimento_cm, data = <nome>)>
#'
NULL
```

### Passo 4 — Gerar a documentação e registrar
Na raiz do pacote, no R:
```r
source("data-raw/<nome>.R")   # gera data/<nome>.rda
devtools::document()          # gera man/<nome>.Rd e atualiza o NAMESPACE
```
Bumpe a versão no `DESCRIPTION` (ex.: `Version: 0.1.11`). Se o exemplo usar um pacote
extra (ex.: `ggplot2`, `rstatix`), adicione-o em **`Suggests:`** do `DESCRIPTION`.

### Passo 5 — Conferir
`data(<nome>); str(<nome>)` carrega e mostra a estrutura certa. `R CMD check` sem erros.

---

## 6. Dados "limpos" vs dados "de treino" (sujos de propósito)

Nem todo dataset deve ser tidy perfeito. O ecossistema tem **datasets de treino**
propositalmente **mal-arrumados**, para o aluno praticar o menu **Arrumar** da IDE:

- **Formato largo** (uma coluna por ano, ano/medida presos no cabeçalho — ex.:
  `2025 - Valor US$ FOB`). Exemplos: `exportacao_pargo` (real), `treino_desembarque`
  (sintético).
- **Coluna composta** (várias infos numa célula — ex.: `PARGO-2023-BRA`). Exemplo:
  `treino_coletas`.

Ao curar, decida o papel: **dataset de análise** (entregue tidy) ou **dataset de
arrumação** (entregue com o "defeito" real, e documente isso no `@description`). Ambos
são válidos e úteis.

---

## 7. Checklist antes de fechar um dataset

- [ ] Nome do dataset e colunas em `snake_case` ASCII, sem espaço/acento.
- [ ] Tidy (ou "sujo de propósito" declarado), um valor por célula.
- [ ] Tipos corretos e explícitos no `data-raw/<nome>.R`.
- [ ] `usethis::use_data()` gerou `data/<nome>.rda`.
- [ ] `R/data_<nome>.R` com `@encoding UTF-8`, `@format \describe{}`, `@source`,
      `@name`/`@usage` batendo com o nome, e `@examples` da análise-alvo.
- [ ] `devtools::document()` rodou; `man/<nome>.Rd` existe.
- [ ] Versão do `DESCRIPTION` incrementada; deps do exemplo em `Suggests`.
- [ ] `data(<nome>); str(<nome>)` funciona.

---

## 8. PARTE B — Planilha Excel de AVALIAÇÃO (dados reais)

Objetivo: uma **planilha de avaliação** com **dados reais diferentes** dos exemplos
usados em aula, para o aluno **importar na CatalyseR, analisar e entregar um relatório**.
A curadoria dos dados reais é feita pela equipe/IA; aqui está a **especificação** que a
IA deve seguir.

### Formato
- **Um arquivo `.xlsx`**, com **várias abas (sheets)**, cada uma **tidy** (uma linha =
  uma observação; uma coluna = uma variável; um valor por célula). **Somente valores**,
  sem fórmulas, sem células mescladas, sem totais no meio.
- Cabeçalho na primeira linha; nomes de coluna em `snake_case` ASCII; unidades no nome.
- **Dados reais** (não sintéticos), com fonte registrada.

### Abas mínimas
1. **`Leia-me`** — instruções ao aluno: o que fazer, quais análises, e que o
   **entregável é um relatório** (o exportado em `.docx` da CatalyseR serve). Prazo e
   critérios de avaliação.
2. **`Dicionario`** — uma linha por variável de cada aba de dados, com colunas:
   `aba`, `variavel`, `tipo`, `unidade`, `descricao`, `fonte`.
3. **Uma aba de dados por cenário/análise** (nomes claros, ex.: `biometria`,
   `desembarque`, `qualidade_agua`). Cada aba tidy, com a **estrutura estatística** que
   a análise pedida exige (ver abaixo).

### Estrutura estatística por tipo de análise (para escolher/recortar os dados reais)
- **Descritiva + Tabela de Frequência:** uma variável numérica contínua (para classes)
  e/ou uma discreta/categórica; N suficiente (≥ 30).
- **Comparação de grupos:** uma resposta numérica + um fator (2 níveis → teste *t*/
  Mann-Whitney; 3+ níveis → ANOVA/Kruskal; dois fatores → ANOVA de 2 fatores). Para
  pareado (Wilcoxon/*t* pareado): duas medições da mesma unidade (antes/depois).
- **Regressão:** resposta numérica + um ou vários preditores numéricos (múltipla).
  Para curva de crescimento: comprimento/idade ou peso × comprimento.
- **Associação:** duas variáveis categóricas (qui-quadrado) ou duas numéricas
  (correlação).

### Como se encaixa no fluxo EAPA
O aluno abre a aba na CatalyseR (menu **Importar e Visualizar** → escolher a aba),
opcionalmente **arruma/tipa**, faz a análise no menu correspondente e **exporta o
relatório `.docx`**. A avaliação testa o fluxo completo "do mouse ao código".

### Regra de ouro da avaliação
Os dados da planilha de avaliação **não podem ser os mesmos** dos exemplos de aula
(nem do `EAPADados`). Devem ser **reais**, de outra fonte/espécie/região, para o aluno
**aplicar** o que aprendeu, não repetir.

---

## 9. Onde buscar dados reais (fontes)

Biodiversidade/ocorrência: **OBIS**, **GBIF**, **SpeciesLink**, **FishBase**.
Comércio: **Comex Stat (MDIC)**. Ambiental/hidrologia: **ANA/HidroWeb**, **INMET**,
**Copernicus Marine**, **NASA OceanColor**. Batimetria: **GEBCO**. Institucional/local:
projetos e dissertações do **IECOS/UFPA** (Bragança-PA), boletins de desembarque,
artigos. Anuários de aquicultura: **Peixe BR**. Sempre cite a fonte no `@source` /
na aba `Dicionario` e respeite a licença.

*(Prompts prontos por análise, para pedir a busca/geração a um assistente, estão em
`../documentacao/PROMPT_DADOS_EAPA.md`.)*

---

## 10. Anti-padrões (não faça)

- `.csv` dentro de `data/` (lá vai `.rda`); dados brutos fora de `data-raw/`.
- Nome de coluna com acento/espaço; `iris`/`mtcars`/dados genéricos.
- Totais/subtotais no meio das observações; unidades misturadas na mesma coluna;
  cor/negrito como informação; células mescladas na planilha.
- Documentar em `man/*.Rd` à mão (é gerado); editar `NAMESPACE` à mão.
- Esquecer `@source`, a fonte real, ou a licença.
- Usar na avaliação os mesmos dados dos exemplos de aula.
