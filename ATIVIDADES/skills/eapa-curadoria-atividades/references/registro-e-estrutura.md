# Registro e estrutura da curadoria EAPA

## Pastas

Use um identificador curto, em minúsculas e com `_`, para cada candidato.

```text
ATIVIDADES/
├── provisorios/
│   └── <id>/
│       ├── <arquivo-original>
│       ├── origem.md
│       └── <arquivos de trabalho e validação>
├── dados/                         # .xlsx do aluno + REGISTRO_FONTES_DADOS_EAPA.xlsx
└── atividade_<tema>_<analise>.md  # enunciado aprovado
```

Não é preciso reorganizar um candidato já existente apenas para cumprir esse
desenho. O ponto essencial é preservar o original e separar claramente o que
foi baixado do que foi preparado.

## Nomes

O identificador começa pela análise e depois descreve o contexto científico:
use `anova_tilapia_anestesia` ou `regressao_tilapia_crescimento`. O arquivo
bruto mantém o nome recebido do repositório. Os demais nomes seguem este padrão:

```text
origem.md
curadoria.md
<id>_revisao.xlsx
ATIVIDADES/dados/<id>.xlsx
ATIVIDADES/atividade_<analise>_<id>.md
```

`origem.md` é a fonte única dos metadados e da licença. `curadoria.md` explica
as decisões técnicas; não use um arquivo genérico de “instruções” como único
registro dessas informações.

## `origem.md`

Crie ou complete este registro para cada candidato:

```markdown
# <nome do conjunto>

- Fonte: <página do repositório ou artigo>
- DOI ou identificador estável: <...>
- Link direto do arquivo: <...>
- Licença: <...>
- Data de acesso: <AAAA-MM-DD>
- Organismo e contexto: <...>
- Unidade observacional: <o que cada linha representa>
- Estrutura analítica pretendida: <ANOVA, regressão etc.>
- Situação: <pendente | aprovado com ajustes | aprovado | descartado>
- Observações: <limitações, decisões e pendências>
```

## Critérios de passagem

Um candidato só passa de `provisorios/` para `dados/` quando tem fonte e licença
confirmadas, unidade observacional compreendida, pergunta didática coerente,
arquivo importável e limitações registradas. A versão externa para o aluno pode
ser diferente da versão analítica curada, mas a diferença deve ser documentada.

Registre fontes aprovadas no `ATIVIDADES/dados/REGISTRO_FONTES_DADOS_EAPA.xlsx`.
A aba `fontes` é o registro em si (um conjunto de dados por linha) e é a **fonte
editável**: acrescente ou corrija linhas nela, no Excel. A aba `resumo` é
**derivada** e tem sete colunas, nesta ordem: **análise no menu da CatalyseR** (a
porta de entrada do aluno), **teste estatístico** (a coluna principal e destacada,
porque foi o teste que orientou a escolha de cada conjunto — itens do menu que não
são teste aparecem como "(sem teste)"), conjunto canônico no EAPADados, arquivo
externo, atividade, situação e "Externo no disco" (conferido nos arquivos reais a
cada geração). Abaixo da tabela vêm as contagens do registro e uma legenda das
cores. Rode, da raiz de `ATIVIDADES/`:

```bash
Rscript skills/eapa-curadoria-atividades/scripts/gerar_registro.R
```

O script R lê a aba `fontes`, conserta caminhos que envelheceram e regrava os
valores; em seguida chama `scripts/formatar_registro.py`, que aplica a identidade
visual (cabeçalhos em NAVY/TEAL, larguras, painel congelado, cores por situação) e
**constrói** a aba `resumo` — o catálogo das análises fica declarado nesse arquivo
Python, então uma análise nova no menu da CatalyseR entra lá. Requer **Python com
`openpyxl`** no PATH. Use o molde de atividade em
[`_MOLDE_atividade.md`](../../../_MOLDE_atividade.md) e mantenha a matriz
[`matriz-analise-pacote-arquivo.md`](matriz-analise-pacote-arquivo.md)
atualizada.
