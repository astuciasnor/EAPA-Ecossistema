# Preparar Dados — arquivo único de treino (temporário)

- Arquivo entregue: `ATIVIDADES/dados/preparar_dados_treino.xlsx`
- Origem: duas planilhas de treino da IDE CatalyseR, no repositório do projeto:
  - `CATALYSER/inst/app/dados/Treino-Transformacoes.xlsx` — abas `biometria`,
    `desembarques_largo`, `guia`;
  - `CATALYSER/inst/app/dados/Treino-Arrumacao.xlsx` — abas `Treino-Largo`,
    `Treino-Separar` (há uma cópia de `Treino-Arrumacao.xlsx` também em
    `APOIO/materiais/`).
- Fonte externa: **nenhuma**
- Licença: **não se aplica** — material interno da disciplina
- Data de acesso: 2026-09-15
- Natureza dos dados: **sintéticos, de propósito** — cada imperfeição foi plantada
  para exercitar um tratamento do menu; não são observações de campo
- Unidade observacional: peixe individual (`biometria`, `coletas_composta`);
  porto × ano (`desembarques_largo`, `receitas_largo`)
- Estrutura pretendida: **preparo de dados** — Trilha de Preparo,
  Calcular/Reescalar, Arrumar e Contingência
- Situação: **aceitar com restrições** (uso temporário)

## Por que existe

O menu **Preparar Dados** era o único bloco de features da IDE sem arquivo externo no
pilar: as planilhas de treino viviam apenas em `CATALYSER/inst/app/dados/`. Elas foram
reunidas num arquivo único para o aluno percorrer o menu inteiro sem depender da IDE.

## O que foi preservado de propósito

| Imperfeição | Onde |
|---|---|
| Caixa e espaços inconsistentes | `biometria`: `local` com 12 variantes para 4 locais (`Ajuruteua`, ` Ajuruteua `, `AJURUTEUA`…); `sexo` com 6 para 2 (`M`, `m`, `Macho`, `F`, `f`, `Femea`); `especie` com variações de caixa |
| Valores ausentes | `biometria`: 5 em `comprimento_cm`, 6 em `peso_g` |
| Linhas duplicadas | `biometria`: 3 linhas idênticas |
| Formato largo | `desembarques_largo` (um ano por coluna) e `receitas_largo` (ano × medida) |
| Coluna composta | `coletas_composta`: `estacao_periodo` (`E01_Seca`) e `codigo_coleta` (`SERRA-2023-AUG`) |

Nada foi limpo, corrigido ou reordenado: os valores são cópia literal, conferida célula a
célula contra os arquivos de origem pelo script `artifact/gerar_arquivo_aluno.py`.

## Abas do arquivo entregue

| Aba | Linhas | Serve para |
|---|---|---|
| `biometria` | 71 | Trilha de Preparo (NA, duplicatas, texto, dicotomizar, padronizar, classes), Calcular e Contingência |
| `desembarques_largo` | 4 | Arrumar > empilhar (formato largo simples) |
| `receitas_largo` | 12 | Arrumar > empilhar (largo com duas medidas por ano) |
| `coletas_composta` | 15 | Arrumar > separar (duas colunas compostas) |
| `origem` | 9 campos | Procedência, natureza dos dados e o que está plantado |

## O mapa do preparo não vai no arquivo do aluno

O arquivo original da IDE tem uma aba `guia` que diz, para cada feature do menu, em qual
coluna está o problema. Ela **não é copiada**: seria gabarito. O mapa está em
[`README.md`](README.md), nesta mesma pasta, para o professor — o aluno recebe só os
dados e precisa reconhecer sozinho o que tratar em cada aba.

## Por que sintético (decisão, não defeito)

Dado real tem problemas, mas não concentrados assim: raramente um mesmo conjunto traz
todas as imperfeições ao mesmo tempo e de forma reconhecível. Aqui **cada imperfeição foi
plantada** para exercitar um tratamento específico do menu — é o que permite ao aluno
treinar o preparo inteiro com um único arquivo, encontrando cada caso de propósito.

Isso não substitui dado real onde ele importa: as atividades **avaliadas** do pilar usam
dado real e distinto, conforme o princípio do pilar. Este arquivo é o **aquecimento do
menu**, e está em `ATIVIDADES/dados/` **temporariamente**. Não entra no EAPADados — não
tem fonte externa nem licença.
