# Revisão, validação e entrega

Use antes de entregar um projeto novo ou uma alteração substancial. Em uma
correção pequena, limite a verificação à parte afetada e suas dependências.
Este checklist é para a IA; não copie uma suíte de testes para o aluno.

## 1. Coerência do estudo

- A pergunta combina com o dado, o delineamento e a variante do método?
- Unidade observacional, unidade experimental, pares e agrupamentos estão claros?
- Fonte/licença e natureza real ou sintética foram conferidas? As unidades
  declaradas correspondem à planilha e à documentação?
- N recebido, faltantes, n analisado e graus de liberdade são compatíveis?
- As tabelas, figuras e frases derivam dos mesmos objetos e da mesma base?
- Os diagnósticos têm relação com o método? Problemas reais aparecem na discussão?
- Estimativas, incerteza e magnitude recebem atenção além do p-valor?
- Nenhuma exclusão, transformação ou troca de teste foi usada para procurar
  significância sem justificativa científica?

Confira resultados centrais com a função estatística pertinente e, quando
disponível, com a CatalyseR sob as mesmas escolhas. Um valor esperado no livro
ou numa documentação não substitui executar o dado atual. Investigue diferenças
de filtros, pareamento, confiança, hipóteses e variantes antes de mudar código.

## 2. Clareza para quem aprende R

- Ao abrir o script, o aluno encontra pergunta, ordem e objetos principais?
- Um professor consegue explicar onde cada objeto nasceu e para que serve?
- Operações novas têm comentários curtos em português, junto da primeira ocorrência?
- As seções acompanham a análise real, sem imitar a extensão da regressão?
- Os cálculos relevantes estão visíveis no script, com funções estatísticas
  reconhecíveis, sem uma função própria que esconda o estudo inteiro?
- `funcoes.R` mantém apresentação reutilizável, sem carregar dados ou ajustar modelos?
- O QMD exibe os resultados da execução atual e explica seu significado?
- Os exercícios, se pedidos, mandam alterar o lugar correto e observar o efeito,
  sem criar uma segunda análise dentro do QMD?

## 3. Execução reprodutível

Para projeto novo ou modificação dos cálculos, execute cada relatório a partir
de uma sessão limpa, com as dependências já instaladas. A validação de referência
do autor é abrir o `.Rproj`, reiniciar o R no RStudio e clicar em Render.
Uma renderização pela linha de comando é evidência útil, mas não afirme ter
feito a verificação manual no RStudio se ela não ocorreu.

Confira que:

1. O `.Rproj` não restaura nem salva automaticamente `.RData`.
2. Caminhos são relativos à raiz identificada por `here`, inclusive com o projeto
   dentro de outra pasta que também contém `.Rproj`.
3. Cada QMD executa o script e funciona sem renderizar o outro primeiro.
4. Ausência de saídas anteriores não impede a geração: o script cria diretórios
   necessários e não lê seus próprios CSVs/PNGs como entrada do relatório.
5. O registro de ambiente identifica versões, sem ser descrito como mecanismo
   que reinstala o ambiente.

Se for necessário testar ausência de saídas, prefira uma cópia temporária do
projeto fora da entrega. Não apague resultados ou dados do usuário para provar
que o código os recria. Execute apenas verificações úteis ao risco da mudança.

### Confirme o arquivo final, não apenas o processamento dos chunks

Verifique conclusão do processo, mensagens finais do Quarto, existência do
HTML/Word no destino esperado, data de atualização e conteúdo da execução.
Se o arquivo já existia, confira que foi realmente substituído. Um log que
termina em `output file: ...knit.md` comprova somente uma etapa intermediária.
Um objeto procurado num HTML antigo não confirma o sucesso do Render atual.

Nesta máquina existe [renderizar-quarto-desktop.ps1](../../../APOIO/scripts/renderizar-quarto-desktop.ps1),
com documentação em [APOIO/scripts/README.md](../../../APOIO/scripts/README.md).
Se houver falha de ambiente semelhante à já documentada, leia-os antes de usar
o ajuste temporário. Esse recurso é apoio local da IA, não dependência ou
script a acrescentar a todos os projetos dos alunos. Não instale outra versão
de R apenas com base numa mensagem genérica do Quarto.

Se não houver R, Quarto ou pacote necessário, informe a limitação. Uma revisão
estática não equivale a Render validado. Não esconda avisos estatísticos para
produzir um log aparentemente limpo.

## 4. Conferência dos documentos

Inspecione o HTML renderizado e o Word final, usando os recursos disponíveis
para visualização/conversão. Verifique títulos, legenda e referência cruzada,
bibliografia, largura das tabelas, cortes de gráficos e legibilidade.
No Word, procure tabelas que ultrapassam as margens, dicas de redação que
escaparam dos comentários e números que divergem das tabelas. No HTML,
confira o texto explicativo e a consulta bruta prevista para a análise.

Se só conseguir verificar a estrutura ou extrair texto, registre exatamente
isso. Não declare inspeção visual que não foi realizada. Abra os artefatos
finais para o autor quando isso ajudar sua revisão.

## 5. Casos para conferir se a skill está sendo seguida

Estes são cenários de revisão, não resultados de testes já executados:

| Pedido | Comportamento esperado |
|---|---|
| Criar uma descritiva de uma medida | Mesmo arranjo de arquivos, resumo e figura simples; sem modelo, diagnóstico de resíduos ou teste inventado. |
| Adaptar para ANOVA de rações por gaiola | Confirmar unidade e replicação, fator e perdas; saídas e comparações próprias de ANOVA; nenhum resultado copiado do barbo. |
| Criar teste t pareado com duas planilhas | Conferir IDs, correspondência, ausências por par e sentido da diferença antes de testar; não alinhar por posição. |
| Melhorar a exibição no HTML | Consultar/exibir objetos existentes quando pedido; manter preparo e ajuste no script e a análise comum aos dois QMDs. |
| Há apenas uma planilha sem informação da coleta | Identificar o que a planilha mostra e perguntar pela informação decisiva; não inventar delineamento ou inferência. |
| Render termina após gerar Markdown intermediário | Verificar o processo e o artefato final antes de declarar sucesso. |

## 6. Entrega ao autor

Relate de forma breve o que foi construído, os arquivos de entrada e saída,
a verificação realmente realizada e as limitações pendentes. Mostre o link
do script e peça a revisão didática quando houver roteiro novo ou modificado
substancialmente. Não peça outra autorização para concluir o trabalho que já
foi solicitado.

Distinga três situações: funcionamento verificado, revisão didática do autor
e avaliação com alunos. A aprovação de uma não comprova as demais. A revisão
de um projeto também não comprova que o exportador da CatalyseR já o produz.
