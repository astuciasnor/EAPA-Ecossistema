# Preparar Dados — arquivo único de treino

Mapa do que exercitar no menu **Preparar Dados** da CatalyseR usando
[`ATIVIDADES/dados/preparar_dados_treino.xlsx`](../../dados/preparar_dados_treino.xlsx).

Este mapa fica **aqui, e não no arquivo do aluno**, de propósito: ele funciona como
gabarito do preparo. O aluno deve reconhecer sozinho o que precisa ser tratado em cada
aba — o arquivo que ele recebe tem só os dados, sem dizer onde está o problema.

> Procedência, natureza dos dados (sintéticos, de propósito) e o que está plantado em cada
> aba estão em [`origem.md`](origem.md).

## Mapa: o que exercitar e onde

| O que exercitar no menu | Aba e coluna sugeridas |
|---|---|
| Trilha > Dados faltantes (NA) | `biometria`: `comprimento_cm` e `peso_g` têm NA |
| Trilha > Remover duplicatas | `biometria`: a linha inteira (há 3 duplicatas) |
| Trilha > Padronizar texto (caixa/espaços) | `biometria`: `especie`, `local`, `sexo` |
| Trilha > Dicotomizar (numérica) | `biometria`: `comprimento_cm >= 25` (maturo) |
| Trilha > Dicotomizar (categórica) | `biometria`: `sexo` em {F}; ou `especie` |
| Trilha > Padronizar (z-score / normalizar) | `biometria`: `comprimento_cm`, `peso_g`, `cpue` |
| Trilha > Classes de tamanho (binning) | `biometria`: `comprimento_cm` |
| Calcular > variável calculada | `biometria`: `100*peso_g/comprimento_cm^3` (fator de condição) |
| Calcular > reescalar (prefixo SI) | `biometria`: `peso_g` (g → kg) |
| Arrumar > Separar coluna | `coletas_composta`: `estacao_periodo` → `estacao`, `periodo` (separador `_`) |
| Arrumar > Separar coluna (2) | `coletas_composta`: `codigo_coleta` → `especie`, `ano`, `mes` (separador `-`) |
| Arrumar > Empilhar (formato longo) | `desembarques_largo`: colunas `2022/2023/2024 - Captura (t)` |
| Arrumar > Empilhar (formato longo, 2 medidas) | `receitas_largo`: `Captura_t` e `Receita_mil` por ano |
| Contingência / Qui-quadrado | `biometria`: `especie` × `local`; ou `sexo` × `local` |

## As abas do arquivo

| Aba | Linhas | Serve para |
|---|---|---|
| `biometria` | 71 | Trilha de Preparo (NA, duplicatas, texto, dicotomizar, padronizar, classes), Calcular e Contingência |
| `desembarques_largo` | 4 | Arrumar > empilhar (formato largo simples) |
| `receitas_largo` | 12 | Arrumar > empilhar (largo com duas medidas por ano) |
| `coletas_composta` | 15 | Arrumar > separar (duas colunas compostas) |
| `origem` | 9 campos | Procedência, natureza dos dados e o que está plantado |

Dados sintéticos, preservados com todas as imperfeições — nada foi limpo, corrigido ou
reordenado. Refazer o arquivo:

```bash
python provisorios/preparar_dados_treino/artifact/gerar_arquivo_aluno.py
```
