---
name: eapa-projetos-analise
description: Criar, adaptar ou revisar projetos R didáticos do EAPACadernos e orientar a estrutura dos Projetos R exportados pela CatalyseR. Usar a regressão linear simples do barbo como referência de clareza, com analise.R como fonte dos cálculos e dois QMDs para HTML e Word. Aplicar quando a tarefa pedir um projeto de análise, sua adaptação a outro método ou a revisão de sua organização e didática; não acionar apenas para responder uma dúvida estatística isolada.
---

# Projetos de análise EAPA: um roteiro que convida a programar

Você orienta um aluno que começa a usar R e um professor que precisa explicar
o percurso. Entregue um projeto que rode e que possa ser compreendido: o aluno
deve localizar os dados, acompanhar as decisões, examinar objetos e reconhecer
como os resultados chegam ao texto. Trabalhe como tutor, tornando visíveis as
operações que ensinam R e estatística.

Esta skill registra a organização amadurecida em 18–19/09/2026. O autor aprovou
a clareza do projeto de regressão para sua própria leitura e para explicação
por um professor com conhecimentos intermediários de R. Isso não equivale a
uma avaliação com alunos nem comprova a migração do exportador da CatalyseR.

## 1. Comece pelo contrato, não pela cópia de arquivos

1. Identifique o pedido: criar, adaptar, revisar ou apenas discutir. Execute
   alterações somente quando fizerem parte do pedido. Ler esta skill não
   autoriza migrar outros projetos nem implementar análises adicionais.
2. Localize a raiz do ecossistema. A partir desta pasta de skill, ela está dois
   níveis acima. Não grave caminhos absolutos da máquina no projeto entregue.
3. Leia o projeto de referência, nesta ordem: README, `R/analise.R`,
   `R/funcoes.R`, `_quarto.yml` e os dois arquivos de `relatorios/`.
   Referência: [linear-morfometria-barbo](../../EAPACadernos/linear-morfometria-barbo/README.md).
   Se os arquivos não estiverem disponíveis, use as regras abaixo, mas declare
   que não conferiu o exemplo executável. Não afirme ter reproduzido sua saída.
4. Para criar ou adaptar, leia [arquitetura e exemplos](references/arquitetura-e-exemplos.md)
   e o trecho aplicável de [adaptação estatística](references/adaptacao-estatistica.md).
   Para revisão, use esses textos conforme o objeto da revisão.
5. Antes de declarar a entrega concluída, aplique a
   [revisão e validação](references/revisao-e-entrega.md).

**Explique o projeto em um minuto:** a planilha fica em `dados/brutos/`; o
`analise.R` lê, prepara, analisa e cria os resultados; o `funcoes.R` define
pequenas funções de apresentação; os dois QMDs executam a mesma análise e
comunicam seus objetos; as cópias dos resultados ficam em `saida/`.

## 2. Preserve estes papéis

| Componente | Responsabilidade |
|---|---|
| `dados/brutos/` | Entrada preservada, com fonte e unidade de observação documentadas. |
| `R/analise.R` | Fonte única dos cálculos do projeto: preparo, exploração, análise, diagnósticos pertinentes, tabelas, gráficos, síntese estatística e gravações. |
| `R/funcoes.R` | Define funções pequenas e transparentes de formatação e estilo; não executa o estudo nem esconde a análise numa função genérica. |
| `relatorios/relatorio_completo.qmd` | Caderno HTML que explica o percurso, apresenta exploração e diagnósticos e orienta a escrita. |
| `relatorios/relatorio_artigo.qmd` | Texto científico em Word, com resultados essenciais e limitações que afetam sua interpretação. |
| `dados/processados/` e `saida/` | Produtos regeneráveis; não são o caminho de entrada dos dois QMDs. |

Cada QMD executa `source(here::here("R", "analise.R"), encoding = "UTF-8")`
em seu primeiro chunk, oculto com `include: false`. Os demais chunks exibem
objetos em memória. Cada Render refaz a análise; os documentos não compartilham
uma sessão nem dependem do Environment que ficou aberto no RStudio.

As análises canônicas do ecossistema vêm da CatalyseR. Dentro de cada projeto
autônomo, a implementação executável fica em `analise.R`. Ao transpor uma
análise existente, confira a base efetiva e as escolhas do módulo canônico;
diferenças precisam ser explicadas, não eliminadas à custa de correção.
O projeto do aluno funciona com a cópia local dos dados e pacotes do CRAN.

### Decisão explícita sobre programação e Quarto

O convite à programação se concentra no script comentado. O Quarto faz a
ligação entre seus resultados e a argumentação científica. Não transfira o
preparo ou o ajuste para os QMDs para aumentar a quantidade de código visível.

Na regressão, a consulta `summary(modelo_lm)` no caderno HTML é a alteração
aprovada: mostra como obter o resumo de um modelo já ajustado. Não refaz a
regressão. `resumo_console` pode continuar no script, onde tem outros usos.
Não generalize essa chamada a objetos de qualquer classe: um teste `htest`,
por exemplo, pode ser apresentado pela impressão do próprio objeto.

Não acrescente automaticamente `head()`, `formula()` ou consultas extras só
para preencher chunks. Foram discutidas como possibilidades, não adotadas
como requisitos. Use uma consulta adicional apenas se resolver uma necessidade
do pedido sem duplicar uma decisão analítica.

## 3. Faça o código ensinar sem virar uma infraestrutura

- Abra o script com a pergunta, a orientação para abrir o `.Rproj`, um mapa
  breve das etapas e os principais objetos que os relatórios consomem.
- Use seções numeradas reconhecíveis no RStudio. A ordem acompanha dados →
  análise → comunicação. A regressão possui onze seções; isso não é uma meta
  de extensão. A descritiva usa cinco e continua reconhecível.
- Guarde passos relevantes em objetos com nomes claros: `dados_brutos`,
  `base_<analise>`, `modelo_*` ou `teste_*`, `tabela_*`, `grafico_*`, `texto_*`.
  Evite encadear toda a análise numa única expressão.
- Comente em português as escolhas e as operações menos familiares. Explique
  o papel de `[[nome]]`, `complete.cases()`, `reformulate()`, laços ou
  interpolação quando aparecerem; não transforme cada comentário numa aula
  longa. Conecte a explicação ao dado ou objeto que o aluno tem diante de si.
- Prefira base R e tidyverse leve, pipe `|>` e dois espaços. Não reescreva
  código legível só para torná-lo mais curto ou tecnicamente sofisticado.
- Faça os cálculos do método à vista, usando funções estatísticas estabelecidas.
  Legibilidade não exige reimplementar mínimos quadrados ou um teste do zero.
- Use laços simples para repetição real, como salvar várias figuras. Não crie
  uma fábrica de projetos, classes próprias ou funções que recebam uma lista
  de opções e executem a análise inteira.
- Nos gráficos, distribua mapeamentos complexos e chamadas a `geom_ribbon()`,
  `geom_smooth()` e `geom_text()` em linhas legíveis. Mantenha compactas as
  chamadas simples a `labs()`, `geom_point()`, `geom_line()` e linhas de referência.
- Preserve valores numéricos nos objetos analíticos. Arredonde com `fmt()` e
  `formatar_p()` somente na apresentação. Diferencie, quando preciso,
  `tabela_resultados` de `tabela_resultados_exibir`.
- Nos roteiros que precisam de frases compostas, reúna-as depois das tabelas
  e gráficos e use `print(texto_*)` para conferência no script. Uma descritiva
  curta pode usar diretamente os escalares calculados no texto inline do QMD.

Um iniciante deve conseguir seguir o roteiro com algum esforço e apoio.
Não se promete que um iniciante dominará todos os diagnósticos de regressão
na primeira leitura. A progressão pode começar com uma análise curta.

## 4. Defina o estudo antes de escolher as saídas

Antes de escrever o método, registre no raciocínio de trabalho e depois nos
locais pertinentes do script, README e relatórios:

- pergunta, população de interesse e alcance possível da conclusão;
- fonte, licença, natureza real ou sintética dos dados e unidades de medida;
- significado de uma linha, unidade experimental/observacional, identificadores,
  pareamento, agrupamentos e medidas repetidas, se existirem;
- resposta, preditores ou grupos, tipos de variável e faltantes relevantes;
- método e variante, parâmetro de interesse, nível de confiança e comparações;
- diagnósticos aplicáveis e resultados necessários ao artigo.

Não crie um novo arquivo de especificação no projeto do aluno para isso.
Não escolha o teste apenas pela forma da planilha ou pelo resultado de Shapiro.
Dados e delineamento precisam sustentar o método. Se a informação decisiva
estiver ausente, explicite o que falta e peça essa informação; não invente.

Conserve identificadores junto dos valores. Retire faltantes considerando as
variáveis daquela análise e documente quantas unidades foram utilizadas.
Pareamentos dependem de identidade, não da ordem circunstancial das linhas.
Subamostras de uma mesma unidade não se tornam réplicas independentes.
Um número usado como rótulo de tratamento não vira dose contínua sem justificativa.

## 5. Comunique a estatística e seus limites

O HTML acompanha a aprendizagem; o Word segue Introdução, Material e métodos,
Resultados, Discussão, Conclusão e Referências, com extensão proporcional ao
estudo. No artigo, sugestões de redação ficam em comentários que não aparecem
na saída. No caderno, orientações breves podem ficar visíveis.

Para cada diagnóstico pertinente, explique antes da figura o que procurar e
qual padrão merece investigação. Inclua no artigo uma síntese dos problemas
que afetam a inferência, mesmo quando as figuras detalhadas ficam só no HTML.
Um p-valor acima de alfa não comprova pressupostos; a independência depende
do delineamento. Valores influentes são sinalizados para revisão, não removidos
automaticamente.

Apresente a saída bruta pertinente ao menos uma vez na introdução didática da
análise. As tabelas numeradas usam `flextable_ocean()`, `tbl-cap` e referência
no texto; as figuras usam objetos gráficos, `fig-cap` e referência no texto.
O estilo do livro para saídas sem legenda não é uma exigência adicional deste
projeto. Use os recursos já existentes sem instalar o EAPADados como dependência.

Números no texto vêm dos objetos do script. A síntese estatística pode ser
montada automaticamente, mas a interpretação biológica, a discussão e a
conclusão científica precisam de argumentação e revisão do pesquisador.
Não fabrique causa, local de coleta, unidade de medida, referência ou resultado.

## 6. Reproduza sem acrescentar complexidade ao aluno

Use `here::i_am()` e `here::here()`; preserve a planilha local e documente os
pacotes no README. Não use `setwd()` com caminho da máquina, `.RData` como
entrada, instalação automática no Render ou downloads necessários a cada execução.
Se houver aleatoriedade, documente a finalidade e a semente.

Os dois relatórios devem funcionar ao reiniciar o R e clicar em Render no
RStudio. Configure o projeto para trabalhar a partir de sua raiz e refazer os
cálculos. Registre R, pacotes e Quarto; esse registro descreve o ambiente,
mas não o congela nem o reinstala.

Mantenha fora do projeto do aluno: `renv`, `targets`, CI, suíte de testes,
scripts de orquestração e arquivos de instrução de agentes. A IA pode realizar
verificações temporárias fora dele. Não deixe ferramentas de validação dentro
da entrega para o estudante manter.

## 7. Entregue evidências e solicite a leitura didática

Conclua a implementação autorizada e a validação possível antes de solicitar
a revisão do autor. Informe o caminho do `.Rproj` e do script, quais saídas
foram geradas e verificadas e qualquer limitação real de execução. Não chame
um Render de concluído apenas porque os chunks terminaram: confira também
o HTML/Word final, como especificado no checklist.

Ao concluir um novo roteiro ou uma revisão pedagógica substancial, apresente
`R/analise.R` ao autor: **um iniciante consegue acompanhá-lo com algum esforço?
Um professor consegue explicá-lo com facilidade?** Registre a resposta como
avaliação do autor, sem atribuir aprovação antecipada aos próximos projetos.

## 8. O que a evolução resolveu — e não deve ser reintroduzido

- O projeto antigo tinha um QMD com a análise e mecanismos de sincronização
  com o script. O modelo atual tem um script e dois QMDs que o executam.
  Não recrie `atualizar_codigo()`, `conferir_codigo()`, `# fonte:` ou cópias
  sincronizadas para este modelo.
- Separar identificação e medidas em arquivos distintos ligava os dados pela
  posição da linha. Agora a base processada preserva a identidade junto das medidas.
- Ler RDS, CSV ou PNG de saída no QMD criaria outra dependência a administrar.
  Agora o QMD usa os objetos da execução atual; as cópias servem para compartilhar.
- O roteiro da regressão ficou mais legível com etapas, objetos e comentários;
  a seção de textos passou a retomar resultados depois dos gráficos.
- O projeto descritivo mostrou que a mesma organização comporta poucas operações.
  Sua revisão didática pelo autor estava pendente ao registrar esta skill.
- Em 19/09, o autor confirmou que o Quarto conserva sua função de comunicação.
  A única mudança adotada nessa discussão foi exibir `summary(modelo_lm)` no HTML.

Se encontrar documentação histórica com um só QMD, ABNT como padrão obrigatório,
ausência de `saida/` ou sincronização de chunks, reconheça a fase anterior.
Use a decisão atual para os novos projetos desta família, respeitando qualquer
instrução posterior do autor. A pasta `anova-bagres` ainda aguarda adaptação;
sua existência não autoriza migrá-la e sua estrutura antiga não redefine este padrão.
