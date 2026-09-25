# F00 — Acompanhamento da evolução da CatalyseR

Esta nota guarda o combinado para as próximas sessões de melhoria da CatalyseR. Não é um cronograma rígido: serve para escolher uma pequena atividade por vez, preservar o estúdio integrado e impedir que defeitos pequenos se acumulem.

## Formato de cada agenda do dia

Quando o autor pedir uma agenda, ela deve propor:

1. uma melhoria principal, pequena e concreta, em um menu ou na passagem entre menus;
2. uma checagem de coesão com `planejar → preparar → explorar → visualizar → analisar → comunicar`;
3. uma entrada do Laboratório de Conceitos apenas quando a dúvida didática surgir naquele ponto;
4. uma refatoração preventiva leve, se couber na mesma área;
5. uma validação proporcional, normalmente por um percurso curto na tela afetada; e
6. a força de modelo e de raciocínio recomendada para a sessão, com uma frase de justificativa.

O objetivo é deixar uma parte mais clara e mais inteira. Não é fechar um menu nem transformar a sessão em mutirão.

## Maturidade do percurso

- **Disponível:** a tela funciona e produz resultado.
- **Registrável:** a execução pode entrar em **Inserir análise**.
- **Reprodutível:** parâmetros, código e saídas chegam à Comunicação e ao Projeto R.
- **Reservado:** tem propósito e lugar definidos, mas ainda não está construído.

O ciclo completo de referência é `tela → resultado → código → Inserir análise → Comunicação → Projeto R`.

## Refatoração preventiva

Uma refatoração pode acompanhar a melhoria quando for local, preservar o comportamento e tornar o código ou a interface mais legível. Exemplos: nome inconsistente, comentário desatualizado, repetição curta, texto que diverge do fluxo ou validação simples duplicada.

- Deve caber em 10 a 20 minutos.
- Deve receber uma conferência prática após a alteração.
- Não deve criar infraestrutura, dependência, abstração genérica ou reorganização ampla.
- Deve parar quando revelar uma decisão de arquitetura, migração ou família maior de problemas.

O que ultrapassar esses limites vira a semente de uma agenda futura. Não entra como “só mais uma limpeza”.

## Escolha consciente de força de LLM

| Tipo de tarefa | Modelo | Raciocínio | Exemplo |
|---|---|---|---|
| Auditoria curta, ajuste de texto, comentário ou consistência visual | rápido/econômico | mínimo ou baixo | tarefa local e conhecida |
| Pequena integração, correção em alguns arquivos ou refatoração local | equilibrado | médio | leitura de contexto e validação |
| Diagnóstico difícil, contrato entre menus, exportação ou planejamento | mais capaz | alto | risco de regressão ou decisão difícil de desfazer |
| Arquitetura transversal, migração do Projeto R ou falha resistente | mais capaz | muito alto | uso deliberado, curto e com objetivo explícito |

Começar econômico. Subir a força somente quando a tarefa exigir comparar contratos, seguir estado entre módulos, depurar uma falha difícil ou tomar uma decisão cara de reverter.

Exemplo para a agenda: **Custo recomendado: modelo equilibrado, raciocínio médio — a tarefa mexe em dois módulos e pede conferir o caminho até a Comunicação.**

Se houver seleção de modelos no ambiente, usar um modelo rápido para auditorias e ajustes locais; um equilibrado para mudanças integradas; e o mais capaz para arquitetura, planejamento e depuração difícil.

## Agenda-base

1. **Comunicação e reprodutibilidade:** definir e conferir o que significa uma análise chegar inteira ao Projeto R; comparar uma rota madura e uma legada.
2. **Preparação dos dados:** acompanhar uma base da importação à Base Compartilhada e a uma Base Derivada; conferir prévia, trilha, código e seletores.
3. **Planejamento:** manter uma matriz honesta entre delineamentos e análises; não prometer para DBC, quadrado latino ou parcelas subdivididas o que ainda não existe.
4. **Exploração e visualização:** revisar um retrato numérico, um categórico e uma relação; sugerir próximos passos sem decidir pelo pesquisador.
5. **Testes paramétricos:** usar teste *t* e ANOVA de um fator como percursos de referência para base, pressupostos, código, registro e exportação.
6. **Frequências e testes categóricos:** marcar a maturidade de proporções, aderência, McNemar e independência; amadurecer um degrau por vez.
7. **Testes não paramétricos:** mapear os pares com os testes paramétricos e escolher um primeiro piloto de integração, sem tratar “não paramétrico” como ausência de pressupostos.
8. **Regressão:** separar descoberta de modelo, linear, logística, contagem e não linear; manter a linear simples como percurso de referência.
9. **Séries, multivariada e mapas:** fazer uma cartografia leve, com um caso representativo de cada família e um único próximo passo para cada uma.

## Laboratório de Conceitos

O Laboratório é transversal e discreto. Entra no momento da dúvida: TLC e variação amostral na exploração; curvas *t*, *F*, qui-quadrado e *p*-valor nos testes; resíduos e inclinação na regressão; autocorrelação e padronização nas famílias que pedirem isso. Não precisa aparecer em toda tela nem ser exportado automaticamente para o relatório científico.

## O que preservar e o que vigiar

Preservar a continuidade entre pergunta, preparo, análise, código e comunicação. Base Compartilhada, Bases Derivadas, registro de execuções e Projeto R legível são a espinha do estúdio.

Vigiar a convivência de caminhos paralelos de integração: módulos novos no registro de execuções e módulos legados chegando à Comunicação por outra rota. Acompanhar essa diferença por etapas, sem tentar eliminá-la toda de uma vez.
