# Prompts para buscar/gerar conjuntos de dados — Ecossistema EAPA

Coleção de prompts prontos para pedir a um assistente (ChatGPT, Gemini, Claude) que
**(a)** aponte **fontes de dados reais** e **(b)**, se não houver, **gere dados
sintéticos realistas** já no formato *tidy* do EAPADados — cada um com a **estrutura
estatística** que a análise-alvo exige.

## Como usar

1. Copie o prompt da análise desejada e cole no assistente.
2. Ajuste espécie/região/faixas ao seu caso (o padrão é pesca/aquicultura da costa
   norte / Bragança-PA).
3. Peça a saída como **CSV** (ou tabela colável). Salve em
   `EAPADados/data-raw/<nome>.csv`.
4. Escreva o `data-raw/<nome>.R` (lê o CSV, tipa, `usethis::use_data`) e o
   `R/data_<nome>.R` (doc roxygen) — como no `exportacao_pargo` / `treino_desembarque`.

## Convenções (todo prompt já pede isto)

- **Tidy:** cada linha uma observação, cada coluna uma variável, um valor por célula.
- **Contexto amazônico**, nomes de colunas em `snake_case` sem acento/espaço, unidades
  no nome quando útil (`comprimento_cm`, `peso_g`).
- **Realismo:** faixas plausíveis, ruído natural, alguns `NA` ocasionais (opcional).
- **Reprodutível:** se sintético, fixar semente e dizer qual.
- Devolver também um **dicionário de variáveis** (nome, tipo, unidade, descrição).

---

## Template reutilizável (preencha os [colchetes])

```
Você é um especialista em estatística pesqueira e aquícola e em dados abertos.
Preciso de um conjunto de dados para a análise "[ANÁLISE]" no contexto da pesca/
aquicultura da [REGIÃO: costa norte do Brasil / estuário do Caeté, Bragança-PA].

Faça duas coisas:

1) FONTES REAIS: liste 3–5 fontes onde eu possa obter dados reais adequados a essa
   análise (repositórios como OBIS, GBIF, SpeciesLink, Comex Stat, ANA/HidroWeb,
   Copernicus Marine, INMET; artigos, dissertações do IECOS/UFPA; bancos gov). Diga
   o que baixar e como recortar.

2) DADOS SINTÉTICOS (caso eu não ache real agora): gere uma tabela tidy realista com:
   - [N] linhas;
   - colunas: [LISTA de colunas com tipo, unidade e faixa plausível];
   - a ESTRUTURA ESTATÍSTICA exigida pela análise: [ESTRUTURA];
   - semente fixa (informe qual) e ruído natural;
   Devolva como CSV pronto para salvar, mais um dicionário de variáveis (nome, tipo,
   unidade, descrição). Nomes de coluna em snake_case sem acento.
```

---

## 1. Análise de Agrupamento (HCA / k-means)

```
Você é especialista em morfometria de peixes e estatística multivariada. Preciso de
um conjunto de dados para ANÁLISE DE AGRUPAMENTO (clusters) no contexto da pesca da
costa norte do Brasil (Bragança-PA).

1) FONTES REAIS: liste fontes de dados morfométricos/merísticos de peixes de
   desembarque (FishBase, SpeciesLink, GBIF, dissertações do IECOS/UFPA, artigos de
   morfometria de Lutjanidae/Sciaenidae) e como extrair uma matriz de medidas.

2) DADOS SINTÉTICOS (fallback): gere uma tabela tidy com ~60 indivíduos e as colunas:
   - id (inteiro), especie (fator, use 3 espécies plausíveis do estuário),
   - comprimento_total_cm, altura_corpo_cm, largura_cabeca_cm, peso_g,
     comprimento_cabeca_cm (numéricos, com faixas plausíveis por espécie).
   ESTRUTURA: as espécies devem formar 3 GRUPOS LATENTES razoavelmente separáveis no
   espaço multivariado (médias e proporções corporais diferentes entre espécies), mas
   com sobreposição realista — para que a HCA recupere os grupos, não trivialmente.
   Padronização será aplicada depois. Semente fixa. Devolva CSV + dicionário.
   Nome sugerido: morfometria_peixes.
```

Alternativa (qualidade de água por estação): mesmas instruções, colunas `estacao`,
`od_mg_l`, `ph`, `temperatura_c`, `turbidez_ntu`, `clorofila_ug_l`, `salinidade`, com
3 grupos de estações (ex.: fluvial, mixohalina, marinha).

## 2. Mann-Whitney (duas amostras independentes)

```
Você é especialista em CPUE e amostragem pesqueira. Preciso de dados para o teste de
MANN-WHITNEY (duas amostras independentes) no contexto da pesca artesanal do Caeté
(Bragança-PA).

1) FONTES REAIS: onde obter CPUE/rendimento por petrecho ou por porto (boletins de
   desembarque, projetos do IECOS/UFPA, artigos).

2) DADOS SINTÉTICOS (fallback): tabela tidy com ~50 lances/observações e as colunas:
   - id (inteiro), petrecho (fator com EXATAMENTE 2 níveis, ex.: "gozeira" e
     "curral"), cpue_kg_lance (numérico, > 0).
   ESTRUTURA: distribuição ASSIMÉTRICA (não-normal) da resposta (ex.: log-normal),
   com um dos grupos tendendo a valores maiores, mas com sobreposição — apropriado
   para teste não-paramétrico de duas amostras. Semente fixa. CSV + dicionário.
   Nome sugerido: cpue_dois_petrechos.
```

## 3. Wilcoxon dos postos sinalizados (pareado)

```
Você é especialista em aquicultura (larvicultura). Preciso de dados PAREADOS para o
teste de WILCOXON dos postos sinalizados no contexto de um tratamento em pós-larvas.

1) FONTES REAIS: onde achar medições antes/depois no mesmo indivíduo/viveiro
   (experimentos de larvicultura, artigos de desempenho zootécnico).

2) DADOS SINTÉTICOS (fallback): tabela tidy com ~30 unidades e as colunas:
   - id (inteiro, o MESMO indivíduo/viveiro medido duas vezes),
   - antes (numérico), depois (numérico) — ex.: escore de vigor (0–10) ou
     comprimento_mm antes e depois do tratamento.
   ESTRUTURA: medições PAREADAS e CORRELACIONADAS (mesma unidade), com um efeito
   moderado e consistente do "depois" sobre o "antes", distribuição não-normal das
   diferenças. Alguns pares sem mudança (empates) são bem-vindos. Semente fixa.
   CSV + dicionário. Nome sugerido: tratamento_pareado_poslarvas.
```

## 4. ANOVA de dois fatores (fatorial)

```
Você é especialista em experimentação em aquicultura. Preciso de dados para uma
ANOVA DE DOIS FATORES (fatorial com interação) num ensaio de crescimento.

1) FONTES REAIS: onde achar ensaios fatoriais de dieta × densidade (ou temperatura ×
   salinidade) em cultivo (artigos zootécnicos, dissertações).

2) DADOS SINTÉTICOS (fallback): tabela tidy BALANCEADA com as colunas:
   - id (inteiro),
   - dieta (fator, 3 níveis: "ração_A", "ração_B", "ração_C"),
   - densidade (fator, 2 níveis: "baixa", "alta"),
   - ganho_peso_g (numérico).
   ESTRUTURA: desenho fatorial completo (3 × 2), ~8 repetições por célula (~48 linhas),
   com EFEITO PRINCIPAL de dieta, efeito de densidade e uma INTERAÇÃO detectável
   (ex.: a melhor ração muda conforme a densidade). Resíduos aproximadamente normais e
   variâncias parecidas. Semente fixa. CSV + dicionário. Nome sugerido: crescimento_fatorial.
```

## 5. Regressão linear múltipla

```
Você é especialista em ecologia pesqueira. Preciso de dados para REGRESSÃO LINEAR
MÚLTIPLA (uma resposta, vários preditores numéricos).

1) FONTES REAIS: onde achar variáveis ambientais + resposta biológica no mesmo ponto
   (monitoramentos limnológicos/estuarinos, ANA/HidroWeb, Copernicus, artigos).

2) DADOS SINTÉTICOS (fallback): tabela tidy com ~80 observações e as colunas:
   - id (inteiro),
   - resposta: producao_kg (ou abundancia) — numérico;
   - preditores: temperatura_c, od_mg_l, ph, salinidade, clorofila_ug_l (numéricos,
     faixas plausíveis).
   ESTRUTURA: a resposta depende LINEARMENTE de 2–3 preditores (coeficientes
   informados), com os demais fracos/nulos; incluir correlação MODERADA entre dois
   preditores (para ilustrar multicolinearidade/VIF), ruído gaussiano. Semente fixa.
   CSV + dicionário. Nome sugerido: ambiente_producao.
```

## 6. ANCOVA (fator + covariável contínua)

```
Você é especialista em biometria pesqueira. Preciso de dados para uma ANCOVA:
comparar uma resposta entre grupos AJUSTANDO por uma covariável contínua.

1) FONTES REAIS: onde achar peso × comprimento por sexo (ou por espécie) — FishBase,
   dados de biometria de desembarque, dissertações.

2) DADOS SINTÉTICOS (fallback): tabela tidy com ~90 indivíduos e as colunas:
   - id (inteiro), sexo (fator, 2 níveis: "macho", "femea"),
   - comprimento_cm (covariável contínua), peso_g (resposta numérica).
   ESTRUTURA: peso cresce com o comprimento (relação linear forte = a covariável), e há
   uma DIFERENÇA de intercepto entre sexos após ajustar pelo comprimento (ex.: fêmeas
   mais pesadas para o mesmo comprimento). IMPORTANTE: as retas peso×comprimento dos
   dois sexos devem ser aproximadamente PARALELAS (mesma inclinação) — para satisfazer
   o pressuposto de homogeneidade de inclinações da ANCOVA. Gere também, como variante
   comentada, uma versão com inclinações DIFERENTES (para ilustrar violação). Semente
   fixa. CSV + dicionário. Nome sugerido: peso_comprimento_sexo.
```

---

## Depois de obter os dados

Para cada dataset novo, seguir o padrão do EAPADados (ver `exportacao_pargo`):
`data-raw/<nome>.R` (lê o CSV, tipa colunas, `usethis::use_data(<nome>, overwrite=TRUE)`)
+ `R/data_<nome>.R` (roxygen com `@format`, `@source`, exemplo da análise-alvo) +
`devtools::document()`. Registrar no README/inventário e bumpar a versão.
