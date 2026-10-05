# Arquitetura e exemplos de decisões

Leia este arquivo ao criar ou reorganizar um projeto. Os exemplos de código
ilustram o contrato; não são uma análise pronta para copiar sem adaptação.

## Árvore do projeto

```text
EAPACadernos/
└── analise-dados/
    ├── analise-dados.Rproj
    ├── README.md
    ├── _quarto.yml
    ├── dados/
    │   ├── brutos/planilha.xlsx
    │   └── processados/base_<analise>.csv
    ├── R/
    │   ├── analise.R
    │   └── funcoes.R
    ├── imagens/
    ├── relatorios/
    │   ├── relatorio_completo.qmd
    │   ├── relatorio_artigo.qmd
    │   ├── referencias.bib
    │   ├── apa.csl
    │   ├── custom-reference.docx
    │   └── ocean.scss
    └── saida/
        ├── tabelas/
        ├── figuras/
        ├── relatorios/
        └── sessionInfo.txt
```

Pasta e `.Rproj` têm o mesmo nome, com análise e dados reconhecíveis, minúsculas
e hífens. Objetos e arquivos analíticos usam `_`; chunks usam `-`.
`imagens/` recebe fotos e esquemas fornecidos pelo pesquisador, podendo ficar
vazia. Figuras calculadas são objetos no script e cópias em `saida/figuras/`.
Não crie pastas genéricas adicionais, outro `.Rproj` na raiz da coleção ou
subpastas provisórias como parte da entrega final.

Uma base processada por análise costuma bastar. Várias bases só se houver uma
necessidade real, com identidades e relações explícitas. Não separe uma tabela
de identificadores de outra de medidas apenas para selecionar números.

## Fluxo de execução e dependências

```text
dados/brutos + escolhas declaradas no script
                     ↓
                 analise.R ← funções de apresentação em funcoes.R
                     ↓
       base, modelo/teste, tabelas, gráficos e textos em memória
                     ↓
         apresentação no QMD que chamou o script
                     ↓
             HTML completo OU Word de artigo

O script também grava cópias em dados/processados/ e saida/.
Essas cópias não voltam como entradas dos QMDs.
```

Cada documento executa esse percurso por conta própria. Abrir o Word não
exige renderizar o HTML antes. Esclareça ao aluno que `include: false` executa
o chunk, mas oculta seu código e sua saída; não significa `eval: false`.

O projeto de referência usa este `_quarto.yml`:

```yaml
project:
  type: default
  output-dir: saida
  execute-dir: project
  render:
    - relatorios/relatorio_completo.qmd
    - relatorios/relatorio_artigo.qmd

lang: pt-BR
bibliography: relatorios/referencias.bib
csl: relatorios/apa.csl
link-citations: true
execute:
  cache: false
  freeze: false
  echo: false
  message: false
  warning: true
```

Preserve a hierarquia dos documentos ao conferir os caminhos finais:
`saida/relatorios/relatorio_completo.html` e
`saida/relatorios/relatorio_artigo.docx` são os destinos esperados neste modelo.
Se uma versão do Quarto produzir outro destino, inspecione-o e alinhe o README;
não presuma atualização de um arquivo antigo só por ele existir.

Cada QMD declara sua própria localização. No completo, o primeiro chunk é:

````markdown
```{r}
#| label: executar-analise
#| include: false
here::i_am("relatorios/relatorio_completo.qmd")
source(here::here("R", "analise.R"), encoding = "UTF-8")
```
````

No artigo, use `relatorios/relatorio_artigo.qmd` em `i_am()`.
No script, use `here::i_am("R/analise.R")`. O aluno abre primeiro o `.Rproj`;
`i_am()` localiza a raiz a partir da posição declarada, não substitui abrir o
projeto nem permite executar de qualquer pasta arbitrária do computador.

## Sequência prática para construir um novo roteiro

1. Entenda a pergunta e os dados seguindo a referência de adaptação estatística.
   Identifique quais resultados pertencem ao artigo e quais servem ao estudo.
2. Crie a pasta e os arquivos essenciais; reutilize apenas os ativos de estilo
   pertinentes. Escreva o nome definitivo do `.Rproj` nos lugares que o mencionam.
3. Desenvolva `analise.R` por seções, conferindo a base, o teste/modelo e seus
   objetos antes de escrever os relatórios. Defina em `funcoes.R` somente os
   recursos pequenos de apresentação necessários.
4. Para cada tabela, figura ou frase composta, identifique o objeto que a
   produzirá. Esse inventário pode ficar no cabeçalho do script; não exige
   um arquivo de controle novo. Use os mesmos objetos nos dois QMDs.
5. Escreva primeiro o percurso explicativo do HTML; selecione e adapte sua
   comunicação para o artigo. Revise os dados biológicos e bibliográficos,
   em vez de apenas trocar o nome da análise num texto copiado.
6. Complete o README com o fluxo que realmente foi implementado e execute a
   validação. Quando modificar um cálculo após escrever o texto, confira
   novamente os objetos e os trechos dos dois documentos que dependem dele.
7. Apresente o script e as saídas verificadas ao autor para revisão didática.

Em projeto existente, faça somente as etapas afetadas pela alteração pedida.
Uma melhoria de exibição não exige reescrever um roteiro já aprovado.

## Como reduzir a distância entre código e entendimento

Compare estes estilos para o mesmo teste ilustrativo:

```r
# Evitar: mistura preparo, teste e extração sem permitir examinar as etapas.
p <- t.test(na.omit(dados$peso_g), mu = 100)$p.value

# Preferir: torna visíveis a população analisada e o objeto do teste.
# O valor 100 só pode ser usado se for a referência justificada para o estudo.
valor_referencia <- 100
valores <- dados$peso_g
presentes <- !is.na(valores)
valores_analisados <- valores[presentes]
teste_media <- t.test(valores_analisados, mu = valor_referencia)
p_valor <- teste_media$p.value
```

Isso não prescreve um objeto para cada símbolo. Separe operações quando o
objeto intermediário ensina algo ou será consultado. A versão final também
precisa conferir tipos, valores válidos e unidade amostral, conforme o estudo.
Não copie o valor hipotético do exemplo para dados novos.

Comentário fraco: `# remove NA`. Comentário útil: `# Retiramos apenas pares
incompletos nas duas medidas da reta; NA em outras colunas não exclui o peixe.`
Quando aparece uma operação nova, uma explicação como `# [[variavel]] busca
a coluna cujo nome foi guardado acima` ajuda a acompanhar a execução.

A extensão acompanha a pergunta. Na regressão, o roteiro é:
ambiente → escolhas/importação → base → exploração → ajuste → diagnóstico →
tabelas → gráficos → textos → cópias → ambiente computacional.
Na descritiva, ambiente/importação → seleção → resumo → gráfico → cópias/registro
já resolve. Não acrescente ajuste, teste, resíduos ou pós-teste sem necessidade.

## Divisão entre os documentos

| Conteúdo | Caderno HTML | Artigo Word |
|---|---|---|
| Pergunta, fonte e unidade amostral | Explicadas para estudo | Relatadas de modo científico e conciso |
| Código da análise | Estudado no script, com orientação no texto | Não impresso |
| Saída bruta do método | Uma vez, com explicação dos campos | Normalmente substituída pela apresentação organizada |
| Exploração e diagnósticos | Detalhes pertinentes, com orientação de leitura | Síntese dos achados que afetam a conclusão |
| Tabelas e figuras principais | Objetos da mesma análise | Objetos da mesma análise, selecionados para o artigo |
| Sugestões de redação | Podem aparecer como orientação | Comentários invisíveis na saída |
| Discussão e conclusão | Estudo, limites e interpretação | Argumentação científica revisada pelo pesquisador |

O HTML usa `echo: true`, código dobrável e “Ver código de apresentação”.
O Word usa `reference-doc: custom-reference.docx` e oculta código.
Não prometa que o botão do HTML abre todo o script analítico: ele mostra o
código dos chunks do QMD. Diga onde estudar `R/analise.R`.

Exemplos adequados de conteúdo dos chunks de apresentação:

```r
summary(modelo_lm)                        # Consulta o modelo já ajustado.
flextable_ocean(tabela_coeficientes_exibir) # Apresenta uma tabela já preparada.
grafico_regressao                         # Exibe o objeto gráfico já criado.
```

Não execute um novo `lm()` ou `aov()` nesses chunks. Não leia um CSV exportado
nem uma figura gerada na execução anterior. Fotos externas em `imagens/` são
outro caso: elas são entradas do pesquisador e podem ser incluídas diretamente.

Textos numéricos usam os objetos do script. Frases extensas podem ser montadas
com `stringr::str_glue()` e impressas para conferência antes da exportação.
Frases curtas podem usar, por exemplo, `r fmt(media)` como expressão inline
entre crases no QMD. Não digite manualmente o valor da média no parágrafo.

## Estilo e ativos existentes

Reutilize do projeto de regressão, depois de inspecionar: `R/funcoes.R`,
`relatorios/ocean.scss`, `relatorios/custom-reference.docx` e `relatorios/apa.csl`.
Não copie sua planilha, referências bibliográficas, texto biológico ou saídas
para outro estudo como se lhe pertencessem. Se os ativos não estiverem acessíveis,
declare a falta; não afirme que reproduziu fielmente o tema.

Ocean: navy `#0F3B5F`, teal `#2E7D8F`, seafoam `#62B6B7`, amber `#E89B3C`,
coral `#E76F51`. O HTML usa as fontes definidas no SCSS; o Word usa os estilos
do documento de referência, atualmente Times New Roman. Não imponha a fonte
da marca sobre os estilos já aprovados do artigo. APA é o CSL fornecido nesta
família; mudar norma bibliográfica depende do pedido, não da análise estatística.

`flextable_ocean()` formata tabelas e `tema_projeto()` formata gráficos.
As funções preservam números e não inferem conclusões. No próprio `funcoes.R`,
use `pacote::funcao()` e mantenha somente definições. `analise.R` é quem executa.

## O README é o manual do pesquisador

Explique pergunta/dados, árvore e papéis dos arquivos, pacotes necessários,
abertura do `.Rproj`, execução por seções no script e Render dos dois QMDs.
Indique onde mudar variável, rótulo e interpretação; identifique entradas
preservadas e saídas substituíveis. Documente fonte/licença, unidades,
faltantes e limites relevantes. Cite a base externa com os metadados reais.

Não transforme o README em instruções internas para IA. Não acrescente
`AGENTS.md`, `CLAUDE.md`, skills ou ferramentas de manutenção ao projeto do aluno.
Esta skill permanece na raiz do ecossistema, fora dos projetos individuais.
