# Documentação do ecossistema

Documentos de planejamento, decisões, inventários e roteiros que orientam os
quatro subprojetos (`catalyser/`, `eapa/`, `EAPADados/` e `EAPACaderno/`).

- [Código que Fala](codigo-que-fala-guia-estilo.md) — guia de legibilidade do R
  fornecido pelo autor em 14/09/2026, após concluir a ANOVA; referência para
  as próximas análises, começando pela regressão linear;
- `uso-ia-explicar-codigo-R.md` — orientação para usar IA como apoio ao estudo
  de código R, sem substituir o trabalho de análise;
- `historico/2026-09-relatorio/instrucoes_relatorio_R_01.docx` — registro das
  decisões iniciais que orientaram a saída humanizada do relatório;
- `PORQUE_EAPACADERNO.md` — por que o EAPACaderno existe e o que ele especifica
  (texto de apresentação, para quem chega sem contexto);
- `BACKLOG.md` — ideias e decisões adiadas;
- `PACOTES.md` — inventário de dependências R;
- `PLAN_ANOVA.md` — plano de consolidação da ANOVA;
- `PROMPT_DADOS_EAPA.md` — prompts para buscar ou gerar dados;
- `proposta-indice-unidades.md` — proposta de organização do livro;
- `ROTEIRO_video_intro_rstudio.md` — roteiro de introdução ao RStudio;
- `procedimento_continue_openrouter_glm.md` — guia externo de integração com Continue/OpenRouter.

O guia canônico do menu Mapas está em `APOIO/mapas.md` (ou `../mapas.md` a partir desta pasta), citado
diretamente pela CatalyseR e pelas instruções do workspace.

## Aplicação do guia Código que Fala

O arquivo foi preservado como recebido. Suas orientações complementam as
convenções do ecossistema: comentários explicam intenções, decisões usam
valores brutos, resultados recebem nomes claros e mensagens ajudam a corrigir
o preparo. Não é uma solicitação para reescrever análises já aprovadas.

`case_when()` organiza listas de condições; `if` continua apropriado para
validar a entrada ou escolher objetos de tipos diferentes. Constantes como
o nível de significância devem ter nome, sem confundi-lo com o nível de
confiança nem alterar automaticamente o critério estatístico existente.

Autossuficiência se aplica ao projeto e ao seu script principal. Os trechos
da análise compartilham objetos e `R/funcoes.R` apenas define funções, conforme
o par script–relatório já adotado. As famílias existentes `arrumar_*`,
`exibir_*`, `mostrar_*` e `relatar_*` mantêm seus contratos; os exemplos do
guia não implicam renomear funções. As sugestões visuais complementam a
identidade Ocean, sem substituir os padrões aprovados de cada saída.
