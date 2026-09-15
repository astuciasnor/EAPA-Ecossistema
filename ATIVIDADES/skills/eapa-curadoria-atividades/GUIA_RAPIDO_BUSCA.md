# Buscar dados para uma atividade EAPA

Use qualquer IA que navegue na internet. O objetivo da IA é encontrar fontes;
a decisão de uso é feita depois de abrir o repositório original.

## Em quatro passos

1. Abra uma IA com busca na web e cole o **Prompt 1** da análise desejada.
2. Escolha no máximo dois candidatos da lista. Abra a página original de cada
   um e confirme que existe arquivo baixável e licença explícita.
3. Baixe o original sem modificá-lo em `ATIVIDADES/provisorios/<id>/`.
4. Peça à IA os três arquivos de apoio do candidato e baixe o arquivo original
   para a pasta indicada. Só depois o conjunto poderá ganhar uma versão final
   em `ATIVIDADES/dados/`.

Se o repositório não informar licença, o candidato fica pendente. Não use a
resposta da IA como prova de licença ou de delineamento.

## Prompt 1 — ANOVA de um fator

```text
Pesquise dados reais, públicos e baixáveis para uma atividade de ANOVA de um
fator em pesca, aquicultura ou biologia aquática.

Preciso de uma resposta numérica, um tratamento categórico com pelo menos três
níveis, réplicas reais por tratamento e arquivo CSV ou Excel. Priorize
experimentos controlados de dieta, densidade, manejo, salinidade, temperatura ou
suplementação. Aceite somente fontes com licença explícita, de preferência CC0
ou CC BY.

Mostre apenas três candidatos. Para cada um, informe: organismo e contexto,
resposta, tratamento, unidade experimental, número de réplicas, página original,
link de download, DOI e licença. Escreva “não confirmado” em vez de adivinhar.
Não recomende dados apenas resumidos em médias, tabelas em PDF ou fontes sem
licença clara.
```

## Prompt 1 — regressão linear simples

```text
Pesquise dados reais, públicos e baixáveis para uma atividade de regressão
linear simples em pesca, aquicultura ou biologia aquática.

Preciso de duas variáveis numéricas medidas na mesma unidade observacional, com
no mínimo 30 observações, arquivo CSV ou Excel e licença explícita, de
preferência CC0 ou CC BY. Priorize relações como idade e comprimento, dose e
crescimento, temperatura e resposta fisiológica, ou esforço e captura.

Mostre apenas três candidatos. Para cada um, informe: organismo e contexto,
variável explicativa, resposta, unidade observacional, número de registros,
página original, link de download, DOI e licença. Escreva “não confirmado” em
vez de adivinhar. Avise se a relação exigir transformação, como peso e
comprimento em escala logarítmica.
```

## Prompt 2 — confirmar antes do download

```text
Confira este candidato diretamente na página original:

[COLE O LINK]

Responda em uma tabela curta: arquivo baixável? licença explícita? DOI? unidade
observacional? variáveis úteis? número de réplicas ou observações? A estrutura
é adequada para [ANOVA de um fator / regressão linear simples]?

Não suponha informações ausentes. Termine com: APROVAR, PENDENTE ou DESCARTAR,
e explique a razão em duas frases.
```

## Depois do download

O original fica intacto. A revisão humana define quais colunas e linhas entram
na atividade, qual preparo o aluno deverá fazer e se haverá uma cópia técnica no
EAPADados. A versão final em Excel só nasce após essa decisão.

## Prompt 3 — organizar o candidato escolhido

Use este prompt somente depois de escolher um candidato e conferir a página
original. Ele pede à IA uma pasta reconhecível e os três materiais que aceleram
a revisão. Se ela não conseguir criar o Excel, deve fornecer a estrutura exata
para criá-lo depois — nunca inventar observações.

```text
Organize este conjunto de dados externo já escolhido para uma futura atividade
EAPA de [ANOVA de um fator / regressão linear simples].

Página original: [COLE O LINK]
Arquivo que vou baixar: [NOME ORIGINAL, SE HOUVER]

Crie ou disponibilize estes três itens, em português:
1. `origem.md`, com título da fonte, página, DOI, licença, data de acesso,
   organismo, delineamento e unidade observacional. Marque como “não
   confirmado” tudo que não puder comprovar na fonte.
2. `curadoria.md`, com dicionário das colunas, número de linhas, variável
   resposta, variável explicativa ou fator, possíveis problemas, preparo que
   faria sentido para o aluno e limites científicos.
3. `<id>_revisao.xlsx`, somente se puder obtê-lo diretamente do arquivo original,
   com uma aba `dados`, cabeçalho na primeira linha e sem cálculos ou resumos.

Sugira o identificador da pasta no formato
`anova_<contexto>` ou `regressao_<contexto>`, por exemplo
`anova_tilapia_anestesia` ou `regressao_peixe_comprimento`.

Não altere nem substitua o arquivo original. Não crie valores, não transforme
médias em réplicas e não esconda limitações do delineamento. Se não puder gerar
um arquivo, entregue o conteúdo pronto para eu salvar com esse nome.
```

Depois, crie a pasta `ATIVIDADES/provisorios/<id>/`, coloque nela o original
baixado com o nome de origem e os três materiais produzidos pela IA. A revisão
confere tudo antes de disponibilizar `ATIVIDADES/dados/<id>.xlsx` ao aluno.
