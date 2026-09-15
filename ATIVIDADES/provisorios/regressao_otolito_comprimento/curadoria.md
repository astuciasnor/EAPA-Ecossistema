# Curadoria — otólito × comprimento (peixes recifais do Pacífico)

1. IDENTIFICAÇÃO E FONTE

Nome didático: regressao_otolito_comprimento

Conjunto original:
Individual back-calculated size-at-age based on otoliths from Pacific coral reef
fish species

Autores: Fabien Morat, Jérémy Wicquart, Nina M. D. Schiettekatte, Guillemette de
Sinéty, Jean Bienvenu, Jordan M. Casey, Simon J. Brandl, Jason Vii, Jérémy Carlot,
Samuel Degregori, Alexandre Mercière, Pauline Fey, René Galzin, Yves Letourneur,
Pierre Sasal, Valeriano Parravicini.

Repositório: figshare
Página original: https://figshare.com/articles/dataset/Individual_back-calculated_size-at-age_based_on_otoliths_from_Pacific_coral_reef_fish_species/12156159
DOI: https://doi.org/10.6084/m9.figshare.12156159.v5
Versão consultada: 5 (publicada em 07/09/2020)
Licença: Creative Commons Attribution 4.0 International — CC BY 4.0
Licença completa: https://creativecommons.org/licenses/by/4.0/

A licença permite adaptação e redistribuição, desde que a fonte e a autoria sejam
atribuídas. O arquivo original baixado está preservado sem alterações nesta pasta,
com o nome recebido do repositório e md5 conferido contra o registrado pelo
depósito (ad3658157eeced791f9e115b3ede213e).

ATENÇÃO — CÓPIA SEM LICENÇA: o repositório GitHub dos autores
(https://github.com/JWicquart/fish_growth) publica um CSV bruto com as mesmas
variáveis, mas o repositório não declara licença. Esse arquivo foi usado apenas
para conferência técnica e não pode ser redistribuído. Todo material de aluno
deriva do arquivo do figshare.


2. ORGANISMO E CONTEXTO

Organismo: 51 espécies de peixes recifais do Pacífico (por exemplo Epinephelus
merra, Cephalopholis argus, Lutjanus kasmira, Chlorurus spilurus).

Delineamento: coleta de campo em quatro localidades (Manuae, Gambiers, Moorea e
Marquesas). Os peixes foram medidos (comprimento total, massa) e seus otólitos
foram extraídos, seccionados e lidos para determinação de idade, com o raio do
otólito medido em cada anulo.

Unidade observacional: peixe individual (coluna ID).
Número de peixes: 855.
Número de linhas: 6.320 — cada linha é um anulo (idade) do mesmo peixe; a mediana
é de 6 anulos por peixe (mínimo 1, máximo 31, média 7,4).

Esta é a diferença central em relação às outras atividades do pilar: aqui a
planilha **não tem uma linha por unidade observacional**. Reduzir a base a uma
linha por peixe é parte do preparo, não um detalhe de execução.

O par de variáveis da atividade:

- Rcpt — raio do otólito na captura (mm), variável explicativa;
- Lcpt — comprimento total na captura (mm), variável resposta.

Essa é a relação usada na retrocálculo de comprimento (back-calculation): a partir
do raio do otólito medido em um anulo, estima-se o comprimento que o peixe tinha
naquela idade. É uma das aplicações mais clássicas da regressão linear em
biologia pesqueira.


3. PERGUNTA DIDÁTICA

O raio do otólito permite prever o comprimento total do peixe? A relação é
suficientemente forte e linear para ser usada como ferramenta de retrocálculo?

Variável explicativa: raio_otolito_captura_mm.
Variável resposta: comprimento_total_captura_mm.
Recorte: **uma espécie** com número adequado de indivíduos (mínimo sugerido: 30).


4. DICIONÁRIO DA VERSÃO DE REVISÃO

A versão de revisão (regressao_otolito_comprimento_revisao.xlsx) tem uma linha por
peixe (855 linhas):

id
    Identificador único do peixe no arquivo original (coluna ID).

familia, genero, especie
    Classificação taxonômica; especie é o filtro da atividade.

local
    Ilha da amostragem (Manuae, Gambiers, Moorea, Marquesas).

observador
    Responsável pela leitura do otólito. Relevante para discutir erro de leitura.

n_anulos
    Número de anulos lidos no otólito (equivale ao número de linhas daquele peixe
    no arquivo original). Permite mostrar, de forma explícita, quantas linhas
    foram colapsadas em cada peixe.

idade_captura_anos
    Idade estimada na captura (anos).

raio_otolito_captura_mm
    Raio do otólito na captura (mm). Variável explicativa.

comprimento_total_captura_mm
    Comprimento total na captura (mm). Variável resposta.

comprimento_nascimento_mm, raio_otolito_nascimento_mm
    Valores no nascimento (L0p, R0p). Constantes no arquivo (1,7 mm para o
    comprimento); preservados por transparência, não entram no modelo.

peso_g
    Massa úmida na captura (g). Tem 603 ausentes (9,5%) no arquivo original.
    Não entra no modelo principal; serve para discutir um modelo com duas
    variáveis explicativas ou uma ANCOVA, se a turma for avançada.


5. AJUSTES FEITOS NA PLANILHA ORIGINAL (versão de revisão)

- Uma linha por peixe, obtida eliminando as repetições de ID (as leituras de anulo
  permanecem no arquivo original e na coluna n_anulos).
- Exclusão das colunas de resultados derivados: Li_sp_m, Li_sp_sd, Li_sploc_m,
  Li_sploc_sd (comprimento médio retrocalculado por espécie e por espécie × local,
  calculados pelos autores com modelo bayesiano).
- Preservação das colunas de captura e de leitura (Family, Genus, Species, ID,
  Agecpt, Rcpt, Lcpt, L0p, R0p, Weight, Location, Observer).
- Nomes de coluna traduzidos para português apenas na versão de revisão, para
  conferência do autor; o arquivo do aluno mantém os nomes originais em inglês,
  como no restante do pilar.
- Nenhum valor foi imputado, arredondado ou removido.

Nenhuma média de grupo foi usada para substituir observações individuais.


6. VERIFICAÇÕES FEITAS NO ARQUIVO

Dimensões: 6.320 linhas e 18 colunas (o artigo documenta 6.320 observações).
Indivíduos únicos: 855. Espécies: 51.
Linhas por indivíduo: mínimo 1, mediana 6, máximo 31.

Valores ausentes:
- Rcpt: 0
- Lcpt: 0
- Agecpt: 0
- Weight: 603 (9,5%)
- Ri: 387 (raio no anulo 0, ausente por definição)

Consistência:
- Rcpt constante dentro de cada ID: 854 de 855. A exceção é GAM18_B123
  (Monotaxis grandoculis), com dois valores (2,127416 e 1,763287 mm) e idades
  duplicadas — provável erro de digitação na planilha de origem.
- Lcpt constante dentro de cada ID: 855 de 855.

Codificação (achado na conferência): o CSV do depósito **não é UTF-8**. A coluna
`Observer` traz bytes latin-1 (0xE9 = "é") em **1.199 linhas** — o valor
"Guillemette de Synéty and Jérémy Wicquart". Lido sem declarar a codificação, o
arquivo exibe mojibake ("Syn\ufffdty", "J\ufffdr\ufffdmy"). Os dois geradores leem
com `fileEncoding = "latin1"` e gravam UTF-8; os arquivos do aluno e reduzido foram
conferidos depois e não têm nenhuma string inválida. As demais colunas são ASCII e
não são afetadas.

Espécies com pelo menos 30 indivíduos (8 de 51):

| Espécie | Indivíduos |
|---|---|
| Epinephelus merra | 46 |
| Cephalopholis argus | 41 |
| Lutjanus kasmira | 37 |
| Chlorurus spilurus | 34 |
| Pristiapogon taeniopterus | 32 |
| Plectropomus laevis | 31 |
| Myripristis berndti | 30 |
| Ostorhinchus apogonoides | 30 |

Dispersão do preditor e da resposta (uma linha por peixe, arquivo inteiro):
Rcpt de 0,15 a 3,86 mm; Lcpt de 28,1 a 984,7 mm. Amplitude ampla, sem
concentração em uma faixa.


7. MODELO DIDÁTICO

Código de referência (arquivo do aluno, uma linha por peixe):

  library(tidyverse)

  peixes <- readxl::read_excel("regressao_otolito_comprimento.xlsx", sheet = "dados")

  # escolher UMA especie com n adequado, justificando a escolha
  merra <- peixes |>
    filter(especie == "Epinephelus merra") |>
    distinct(id, .keep_all = TRUE)

  modelo <- lm(comprimento_total_mm ~ raio_otolito_mm, data = merra)
  summary(modelo)
  confint(modelo)

Resultado de referência, conferido no arquivo real (Epinephelus merra, n = 46):

| Termo | Estimativa | EP | IC 95% |
|---|---|---|---|
| Intercepto | 109,6 mm | 10,5 | 88,5 a 130,7 |
| Rcpt (mm) | 77,6 mm/mm | 9,3 | 59,0 a 96,3 |

- R² = 0,615; R² ajustado = 0,606; erro residual = 29,2 mm
- F(1, 44) = 70,3; p = 1,1 × 10⁻¹⁰
- Shapiro-Wilk nos resíduos: p = 0,162 (sem problema)
- Cook's D máximo: 2,02 — **há um ponto influente** a ser discutido
- Leitura: cada milímetro de raio do otólito corresponde, em média, a cerca de
  78 mm de comprimento total

Previsões que servem de checagem (IC de predição de 95%):

| Raio do otólito | Comprimento previsto |
|---|---|
| 0,5 mm | 148,4 mm (88,1 a 208,7) |
| 1,0 mm | 187,2 mm (127,8 a 246,7) |
| 1,5 mm | 226,0 mm (165,9 a 286,1) |

Espécies com 30 indivíduos ou mais, uma linha por peixe (as 8 com n suficiente):

| Espécie | n | R² | Shapiro p | Cook máx | Observação |
|---|---|---|---|---|---|
| Plectropomus laevis | 31 | 0,908 | 0,541 | 0,96 | limpa e forte |
| Pristiapogon taeniopterus | 32 | 0,837 | 0,962 | 0,37 | limpa e forte |
| Ostorhinchus apogonoides | 30 | 0,823 | 0,810 | 0,10 | limpa e forte |
| Lutjanus kasmira | 37 | 0,809 | 0,0001 | 36,95 | R² sustentado por um ponto extremo |
| Epinephelus merra | 46 | 0,615 | 0,162 | 2,02 | relação moderada, com influente |
| Myripristis berndti | 30 | 0,387 | 0,123 | 0,13 | relação fraca |
| Cephalopholis argus | 41 | 0,291 | 0,259 | 0,66 | relação fraca |
| Chlorurus spilurus | 34 | 0,173 | 0,098 | 0,15 | relação fraca |

Se as 8 espécies forem analisadas juntas (281 peixes, uma linha por peixe):

  R² = 0,101; Shapiro p = 3,1 × 10⁻¹⁰

Com a espécie como fator (Lcpt ~ Rcpt + Species): R² = 0,913 — isto é, a relação é
específica de cada táxon. Se as 855 linhas (uma por peixe, todas as espécies) forem
analisadas juntas:

  R² = 0,199; r = 0,446; Shapiro p = 1,1 × 10⁻²²

Ou seja: **agrupar espécies destrói o modelo**. É a principal armadilha da
atividade e a justificativa científica do filtro por espécie.


8. PSEUDORREPETIÇÃO E COLUNAS QUE NÃO FORAM INCLUÍDAS

A planilha original traz uma linha por anulo, não por peixe. As 6.320 linhas
correspondem a 855 peixes: usar a base crua infla o n em quase oito vezes e trata
leituras do mesmo otólito como réplicas independentes.

As colunas Li_sp_m, Li_sp_sd, Li_sploc_m e Li_sploc_sd são resultados do modelo
bayesiano de crescimento ajustado pelos autores (von Bertalanffy). Não são dados
brutos e não entram na atividade: se ficassem, o aluno poderia "analisar" o
resultado pronto de outra análise.

O arquivo também permite a curva de crescimento em função da idade (Ri e Agei por
anulo) — que é a análise não linear dos autores. A atividade usa deliberadamente
apenas o par de captura (Rcpt, Lcpt), que é linear.


9. CUIDADOS DE INTERPRETAÇÃO

- A regressão é uma ferramenta de **predição**, não de causalidade: o otólito e o
  comprimento crescem juntos, mas um não causa o outro.
- O intercepto (109,6 mm) é uma extrapolação: não há peixe com raio de otólito
  zero na amostra (mínimo 0,49 mm). Discutir isso é parte do exercício.
- Os dados são de **campo**, não de experimento: as espécies foram amostradas nas
  ilhas disponíveis, sem delineamento balanceado. Comparar espécies ou locais exige
  cautela.
- Cada espécie tem sua própria relação (a forma do otólito e do corpo varia entre
  táxons). Por isso o filtro por espécie, e por isso a relação agrupada é fraca.
- A leitura do otólito tem erro: a coluna Observer registra quem leu. Sem réplicas
  de leitura não se estima esse erro, mas ele deve ser citado como limitação.
- O ponto de Cook's D > 2 em Epinephelus merra deve ser identificado e discutido —
  estimar o modelo com e sem ele e mostrar o quanto os coeficientes mudam.
- Existe uma inconsistência real em Monotaxis grandoculis (GAM18_B123, dois Rcpt).
  Serve para mostrar que dado real precisa de conferência; não afeta Epinephelus
  merra.
- Não transformar a resposta em log "para melhorar o R²" sem justificativa
  biológica; e não escolher a espécie pelo R² — a escolha deve ser anterior e
  justificada por n e por coerência biológica.


10. PARECER SOBRE O USO DIDÁTICO

APROVAR COM AJUSTES.

O conjunto é adequado à regressão linear simples: duas variáveis numéricas medidas
no mesmo indivíduo, sem valores ausentes justamente nessas duas colunas, amplitude
ampla no preditor (0,49 a 2,56 mm em Epinephelus merra) e uma relação linear
consistente (R² = 0,615; resíduos normais). O que o torna especialmente bom para o
pilar é que ele obriga duas decisões de preparo com consequência real —
**colapsar as leituras de anulo em um registro por peixe** e **filtrar uma
espécie** — e as duas podem ser conferidas no resultado: usar a base crua ou
agrupar espécies leva a números claramente errados.

Ajustes exigidos:
- manter no arquivo do aluno apenas as colunas brutas, sem os resultados derivados
  (Li_sp_* e Li_sploc_*);
- manter os nomes de coluna originais em inglês, com o dicionário no enunciado;
- declarar no enunciado que a base tem mais de uma linha por peixe, sem dizer como
  resolver;
- exigir a justificativa do filtro de espécie antes de qualquer resultado.


## Arquivos do ecossistema

- `back-calculated-size-at-age_morat-et-al_2020-09-07.csv`: download original,
  preservado sem alterações (md5 conferido).
- `regressao_otolito_comprimento_revisao.xlsx`: versão limpa, uma linha por peixe,
  colunas em português, para conferência do autor e validação técnica.
- `artifact/gerar_revisao.R`: script que gera a versão de revisão e imprime as
  verificações deste documento.
- A criar: `ATIVIDADES/dados/regressao_otolito_comprimento.xlsx` — versão do aluno,
  em inglês, com a base crua (uma linha por anulo) e sem as colunas derivadas.
