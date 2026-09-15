# Código que Fala

**Guia de estilo do EAPA/CatalyseR para escrever R que o aluno lê como raciocínio.**

Humanizar o código não é enfeitá-lo. É organizá-lo de modo que a sequência das
linhas siga a sequência do pensamento: primeiro o que se tem, depois o que se
decide, por fim o que se conclui. O aluno que lê um código assim não precisa
executar mentalmente cada função para entender a intenção, porque a intenção já
está escrita.

As dez regras a seguir foram destiladas de revisões reais de scripts do curso.
Cada uma traz um *antes* e um *depois* com o mesmo comportamento estatístico,
para deixar claro que legibilidade não custa correção. Elas se somam às
convenções do ecossistema (vírgula decimal, funções `mostrar_*()` e
`relatar_*()`, seções e arquivos `.R` autossuficientes) reunidas ao final.

---

## As dez regras

### 01. Uma frase acima da linha

O comentário não repete o que o código já diz; ele conta a **intenção**.
"Ordena o vetor" é redundante. "Ordena os grupos da maior para a menor média,
para as letras começarem pelo maior" ensina o porquê.

**Antes** — comentário que só repete o código:

```r
# ordena
ordem <- names(sort(medias, decreasing = TRUE))
```

**Depois** — comentário que explica a decisão:

```r
# Ordena os grupos da maior para a menor média,
# para as letras começarem pelo grupo de maior produção.
ordem <- names(sort(medias, decreasing = TRUE))
```

### 02. Decisões como lista de casos

Uma cadeia de `if / else if` aninhada obriga o leitor a guardar cada "senão" na
cabeça enquanto desce. `case_when()` se lê como enunciamos regras em português:
se isto, então aquilo.

**Antes** — encadeamento aninhado:

```r
classe <- if (is.na(eta)) "indeterminado" else
  if (eta < 0.01) "muito pequeno" else
  if (eta < 0.06) "pequeno" else
  if (eta < 0.14) "médio" else "grande"
```

**Depois** — lista de casos, de cima para baixo:

```r
classe <- dplyr::case_when(
  is.na(eta)   ~ "indeterminado",
  eta < 0.01   ~ "muito pequeno",
  eta < 0.06   ~ "pequeno",
  eta < 0.14   ~ "médio",
  TRUE         ~ "grande"
)
```

### 03. Trate primeiro o caso que falha

O ponto onde a conta não fecha é onde o aluno mais trava. Colocar o `is.na()` na
frente, escrito como uma orientação, ensina a lidar com o resultado ausente em
vez de esconder o problema.

**Antes** — ignora o caso sem p-valor:

```r
frase <- if (p < 0.05)
  "houve diferença" else
  "não houve diferença"
```

**Depois** — o caso ausente vem primeiro, como fala honesta:

```r
frase <- dplyr::case_when(
  is.na(p) ~ "a ANOVA não forneceu p-valor válido; verifique o preparo",
  p < 0.05 ~ "houve evidência de diferença entre os grupos",
  TRUE     ~ "não houve evidência de diferença entre os grupos"
)
```

### 04. Erros que orientam

Uma checagem pode apenas interromper, ou pode **ensinar**. A mensagem que diz
qual variável falhou e o que conferir transforma o erro em uma instrução de
conserto.

**Antes** — interrompe sem dizer o quê:

```r
stopifnot(is.numeric(dados$Producao))
```

**Depois** — diz o que fazer para corrigir:

```r
if (!is.numeric(dados$Producao)) {
  stop("A resposta (Producao) precisa ser numérica. ",
       "Confira a tipagem no preparo antes da ANOVA.")
}
```

### 05. Dê nome ao valor antes de reusá-lo

Uma expressão aninhada em três níveis se lê de dentro para fora, ao contrário do
pensamento. Fatiada em passos, **cada linha faz uma coisa e recebe um nome**, e o
leitor acompanha o raciocínio na ordem certa.

**Antes** — três funções aninhadas numa linha:

```r
ordem <- names(sort(tapply(dados$Taxa, dados$Densidade, mean), decreasing = TRUE))
```

**Depois** — uma etapa por linha, cada uma nomeada:

```r
medias_por_grupo <- tapply(dados$Taxa, dados$Densidade, mean)
ordem            <- names(sort(medias_por_grupo, decreasing = TRUE))
```

### 06. Números com significado ganham nome

Um `0.05` espalhado pelo script é um número mágico: quem lê não sabe se todos são
o mesmo limite. Nomeado uma vez, o significado fica explícito, e mudar para 0,01
é mexer em um lugar só.

**Antes** — o mesmo 0,05 repetido, sem nome:

```r
if (p_anova   < 0.05) ...
if (p_shapiro < 0.05) ...
if (p_levene  < 0.05) ...
```

**Depois** — um limite com nome, definido uma vez:

```r
nivel_significancia <- 0.05

if (p_anova   < nivel_significancia) ...
if (p_shapiro < nivel_significancia) ...
if (p_levene  < nivel_significancia) ...
```

### 07. O pipe conta a receita

Chamadas aninhadas se executam de dentro para fora; o pipe `|>` as endireita na
ordem de leitura. O aluno lê de cima para baixo como uma receita: pegue os dados,
agrupe, resuma, ordene.

**Antes** — aninhamento de dentro para fora:

```r
resumo <- arrange(
  mutate(
    summarise(group_by(dados, Especie), media = mean(Peso)),
    destaque = media > 10
  ),
  desc(media)
)
```

**Depois** — etapas na ordem em que acontecem:

```r
resumo <- dados |>
  group_by(Especie) |>
  summarise(media = mean(Peso)) |>
  mutate(destaque = media > 10) |>
  arrange(desc(media))
```

### 08. Nomes que falam português

Um nome como `f1` obriga a abrir a função para saber o que ela faz. Um nome que é
verbo ou substantivo diz a intenção já na chamada, e a linha se lê quase como uma
frase.

**Antes** — nomes que não dizem nada:

```r
r <- f1(d, "Peso", "Especie")
f2(m)
```

**Depois** — nomes que anunciam o papel:

```r
resumo <- resumir_grupo(dados, Peso, Especie, conf = 0.95)
relatar_anova(modelo)
```

### 09. Busque pelo nome, não pela posição

Juntar valores pela posição na tabela se quebra em silêncio quando a ordem muda.
Buscar pelo **nome do grupo** garante que a letra certa acompanhe o grupo certo,
sempre.

**Antes** — junta pela posição; frágil:

```r
# quebra se a ordem das linhas mudar
resumo$letra <- letras[seq_len(nrow(resumo))]
```

**Depois** — junta pelo nome do grupo:

```r
resumo <- resumo |>
  dplyr::mutate(letra = letras[as.character(Densidade)])
```

### 10. Prefira a função que já pensa como o analista

Antes de montar uma matriz à mão, vale procurar a função feita para a tarefa.
`multcompLetters4()` pareia os grupos e ordena pelas médias sozinha: o código
passa a dizer a intenção, não o mecanismo.

**Antes** — matriz de p-valores montada à mão:

```r
grupo_nomes <- levels(dados$Densidade)
pares <- combn(grupo_nomes, 2)
p_pares <- matrix(1, length(grupo_nomes), length(grupo_nomes),
                  dimnames = list(grupo_nomes, grupo_nomes))
nomes <- paste(pares[2, ], pares[1, ], sep = "-")
p_pares[cbind(pares[1, ], pares[2, ])] <- tukey[[1]][nomes, "p adj"]
p_pares[cbind(pares[2, ], pares[1, ])] <- tukey[[1]][nomes, "p adj"]
ordem <- names(sort(tapply(dados$Taxa, dados$Densidade, mean),
                    decreasing = TRUE))
letras <- multcompView::multcompLetters(p_pares[ordem, ordem])$Letters
```

**Depois** — a função certa faz tudo (níveis sem hífen):

```r
# Pareia os grupos e ordena pelas médias sozinha.
letras <- multcompView::multcompLetters4(modelo, tukey)$Densidade$Letters
```

---

## Checklist de humanização

- **Todo passo tem nome.** Nenhuma expressão importante fica aninhada dentro de
  outra sem antes receber um nome que a descreva.
- **Toda decisão se lê de cima para baixo.** Cadeias de condições viram
  `case_when()`, com o caso que falha em primeiro lugar.
- **Todo comentário explica o porquê.** A frase acima da linha diz a intenção,
  não repete o que o código já mostra.
- **Todo número com significado tem nome.** O limite de 0,05, o tamanho da
  amostra: constantes nomeadas, definidas uma vez.
- **Toda busca é pelo nome, não pela posição.** Vetores nomeados no lugar de
  índices, para o valor certo acompanhar o grupo certo.
- **Todo erro orienta.** A mensagem diz o que fazer para corrigir, não apenas que
  algo deu errado.
- **A função certa faz o trabalho pesado.** Antes de montar algo à mão, verifique
  se já existe uma função que pensa como o analista.

---

## Convenções do EAPA/CatalyseR

O pano de fundo sobre o qual estas regras se aplicam.

**Números em português.** Toda saída para o leitor passa por `fmt()` (vírgula
decimal) e `formatar_p()` (escrita convencional de p). O aluno lê 0,05 e
p < 0,001, como no texto de um artigo.

**Funções que anunciam o papel.** Nomes no padrão `mostrar_*()` e `relatar_*()`
dizem, já na chamada, se a função exibe algo na tela ou devolve um texto de
resultado.

**Seções que dividem a leitura.** Rótulos como `## ---- analisar-tukey ----`
separam o script em blocos com um propósito único, na mesma lógica dos capítulos.

**Arquivos autossuficientes.** Cada `.R` roda sozinho com `source()`, é bem
comentado e reutilizável, e os gráficos seguem a paleta Ocean Gradient para a
identidade visual permanecer coerente.

---

## Identidade visual (para reaproveitar nos slides)

O formato de fontes e cores usado neste guia, reunido para você repaginar as
apresentações da CatalyseR mais adiante.

### Paleta Ocean Gradient

| Nome    | Hex       | Papel sugerido                                  |
|---------|-----------|-------------------------------------------------|
| Navy    | `#0F3B5F` | Títulos, texto de destaque, tema do flextable   |
| Teal    | `#2E7D8F` | Cor de ênfase principal, links, rótulos "depois"|
| Seafoam | `#62B6B7` | Marcadores, numeração de seções, apoios         |
| Amber   | `#E89B3C` | Destaque quente pontual, strings no código      |
| Coral   | `#E76F51` | Alerta ou contraste, rótulos "antes"            |

Barra de gradiente decorativa (cabeçalhos e capas): sequência
Navy → Teal → Seafoam → Amber → Coral.

Neutros do guia (fundo claro): fundo `#F1F4F5`, superfície `#FFFFFF`, texto
`#13272F`, texto secundário `#586A72`, linhas `#D9E2E4`. Nos slides, manter o
fundo totalmente branco, como já é padrão.

### Fontes

| Papel            | Fonte           | Alternativa nos slides (offline) |
|------------------|-----------------|----------------------------------|
| Títulos          | Spectral        | Cambria                          |
| Corpo de texto   | Source Sans 3   | Calibri                          |
| Código           | JetBrains Mono  | Consolas                         |

A ideia por trás do trio: um serifado acadêmico para os títulos (Spectral), um
sem serifa humanista e legível para o corpo (Source Sans 3) e um monoespaçado
técnico para o código (JetBrains Mono). É a própria tese do guia em forma
tipográfica: linguagem humana e código convivendo lado a lado. As alternativas
Cambria, Calibri e Consolas já são o padrão dos seus decks e mantêm a coerência
quando as fontes web não estão disponíveis.

### Bloco de código (o "editor")

Para trechos de R nos slides, um bloco escuro em contraste com o fundo branco:
fundo `#0E2A3A`, texto `#E7EEF0`. Realce: comentários em `#7FA9AC` (itálico),
strings em `#E8B87C`, números em `#8FD0C4`, palavras-chave em `#F0937A`,
operadores (`<-`, `|>`, `~`) em `#67C0C1`. Corpo mínimo de 18 pt para código em
tela, seguindo o padrão de tamanho das apresentações.
