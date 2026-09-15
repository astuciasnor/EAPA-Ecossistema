# Atividade autônoma — ANOVA de um fator

## Cravo sozinho ou com lidocaína: muda o tempo de anestesia da tilápia?

**Dataset:** `anova_tilapia_anestesia.xlsx`, aba `dados`; cada linha representa um
peixe (36 peixes, 12 por tratamento). A aba `origem` traz fonte, DOI, licença e
unidade observacional.
**Fonte / licença:** Martínez, A., *Immersion-administered lidocaine as an adjuvant
to clove essential oil in Nile tilapia: raw data*,
[Mendeley Data, DOI 10.17632/35wyrph72h.1](https://doi.org/10.17632/35wyrph72h.1),
CC BY 4.0.
**Onde estão os dados:** `dados/anova_tilapia_anestesia.xlsx` (banco externo da
disciplina).
**Habilidades avaliadas:** importação, tipagem e ordenação do fator, descrição por
grupo, ANOVA de um fator, verificação de pressupostos, comparações múltiplas,
tamanho de efeito e comunicação reprodutível.
**Nível / tempo estimado:** introdutório–intermediário · 3–4 h.

---

### Contexto

A anestesia por imersão é rotina no manejo de peixes: reduz o estresse e o risco de
lesão durante biometria, transporte e procedimentos. O óleo essencial de cravo é um
dos anestésicos mais usados na aquicultura, e a busca por adjuvantes que encurtem a
indução — ou reduzam a dose necessária — é um tema ativo.

Neste experimento, juvenis de tilápia-do-Nilo foram anestesiados individualmente por
imersão. **Todos os tratamentos continham óleo de cravo a 100 µL/L**; o que varia
entre eles é a concentração de **lidocaína** adicionada ao banho. Os códigos que
chegaram na planilha significam, portanto:

| Código na planilha | Óleo de cravo | Lidocaína |
|---|---|---|
| `100/0` | 100 µL/L | 0 mg/L (cravo sozinho — tratamento de referência) |
| `100/60` | 100 µL/L | 60 mg/L |
| `100/80` | 100 µL/L | 80 mg/L |

**Atenção:** `100/0` **não** é um controle sem anestésico. Não existe, neste
experimento, um grupo de peixes sem anestesia.

A resposta medida é o **tempo, em segundos, até o peixe atingir o plano
anestésico**. O peso corporal também foi registrado.

### Problema de pesquisa

Investigue: **o tempo médio para atingir o plano anestésico difere entre o óleo de
cravo usado sozinho e suas combinações com 60 ou 80 mg/L de lidocaína?**

Hipóteses para a resposta `tempo_anestesia_s`:

- **H₀:** as três médias são iguais (µ cravo = µ +60 = µ +80);
- **H₁:** pelo menos uma das médias difere das demais.

> A unidade de observação é o **peixe individual**. Cada peixe contribui uma única
> vez; não empilhe medições sucessivas do mesmo animal como se fossem réplicas.

### Etapas

1. **Importe** a aba `dados` e confira a estrutura: 36 linhas, quatro colunas,
   nenhum valor faltante, nenhum `id_peixe` repetido e 12 peixes por tratamento.
   Leia também a aba `origem` e registre fonte e licença no relatório.
2. **Prepare a base** (e registre cada decisão na trilha de preparo): converta
   `tratamento` em fator e **recodifique os códigos** para nomes que digam o que o
   tratamento é (por exemplo `cravo`, `cravo_lido_60`, `cravo_lido_80`), definindo a
   ordem dos níveis. Comente, no código, o que compõe cada código original. Não
   altere `tempo_anestesia_s` e não descarte `peso_g`.
3. **Descreva:** n, média, desvio-padrão, mediana e amplitude por tratamento, e um
   gráfico com os pontos individuais sobre o boxplot. Antes de testar, olhe a
   **dispersão dentro de cada grupo** — ela decide parte do que vem adiante.
4. **Analise:** ajuste `aov(tempo_anestesia_s ~ tratamento)`. Apresente a tabela
   ANOVA (graus de liberdade, soma de quadrados, F e p) e, se H₀ for rejeitada,
   as comparações múltiplas de Tukey.
5. **Verifique os pressupostos:** normalidade dos resíduos (QQ-plot e Shapiro-Wilk)
   e homogeneidade das variâncias (resíduos versus ajustados e Levene ou Bartlett).
   **Se as variâncias não forem homogêneas, refaça com `oneway.test()` (Welch)** e
   compare as duas leituras. Dizer qual delas você adota e por quê faz parte do
   relatório — assim como não é aceitável escolher o teste depois de ver o p-valor.
6. **Quantifique:** η² (ou ω²) e os intervalos de confiança das médias. Lembre que
   **ausência de significância não demonstra equivalência**: discuta o poder do
   teste com 12 peixes por grupo.
7. **Feche o ciclo:** produza o relatório (preparo → análise → interpretação) e o
   Projeto R, com os gráficos e a tabela de ANOVA reproduzíveis.

### Produto esperado (relatório)

1. pergunta, hipóteses e unidade observacional;
2. o significado de cada código de tratamento e a recodificação adotada;
3. tabela descritiva por tratamento e gráfico de pontos + boxplot;
4. verificação de normalidade e de homogeneidade, com os gráficos;
5. tabela ANOVA e, quando pertinente, Tukey;
6. tamanho de efeito e incerteza das médias (intervalos de confiança);
7. interpretação aplicada, comparação com a análise de variâncias desiguais e
   limitações do delineamento.

### Questões para discussão

- A dispersão dos grupos com lidocaína é semelhante à do grupo só com cravo? O que
  isso implica para o teste escolhido?
- Trocar a ANOVA clássica por um teste que não assume variâncias iguais muda a
  conclusão? Qual leitura é defensável — e como decidir isso **sem** escolher o
  teste pelo p-valor?
- Um p-valor acima de 0,05 autoriza afirmar que a lidocaína não tem efeito?
- A ANOVA trata os três tratamentos como categorias. Por que não se pode falar em
  relação dose–resposta apenas com este resultado?
- O estudo original usou o peso do peixe como covariável (ANCOVA). O que muda ao
  ignorá-lo? `peso_g` foi preservada para essa discussão.
- O resultado permite generalizar para outras temperaturas, outros tamanhos de peixe
  ou outras espécies?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Preparação dos dados** | Não confere a estrutura; usa o fator como texto sem sentido. | Importa e converte o fator, com recodificação parcial. | Estrutura conferida, fator ordenado e códigos recodificados. | Idem, com a trilha de preparo registrada e o significado de cada código documentado. |
| **Escolha e execução da análise** | Modelo inadequado ou tabela ANOVA ausente. | ANOVA correta, execução com falhas. | ANOVA correta, com descritiva e gráfico adequados. | ANOVA com pressupostos verificados e comparação explícita com a solução de Welch. |
| **Interpretação** | Confunde p-valor com efeito ou afirma equivalência. | Relata apenas a significância. | Interpreta no contexto do manejo aquícola. | Integra efeito, incerteza, dispersão e poder, sem transformar ausência de significância em prova de igualdade. |
| **Comunicação / relatório** | Desorganizado; faltam itens pedidos. | Cobre parte dos itens. | Relatório completo e claro. | Completo, com preparo, tabelas e Projeto R plenamente reproduzíveis. |
| **Pensamento crítico** | Não discute limitações. | Limitações genéricas. | Discute n, dispersão e o peso não controlado. | Discute dispersão, escolha prévia do teste, dose–resposta e limites de generalização. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

**Estrutura do arquivo.** A aba `dados` tem 36 linhas (uma por peixe), quatro
colunas (`id_peixe`, `tratamento`, `tempo_anestesia_s`, `peso_g`), sem valores
faltantes e com 12 peixes por tratamento. Os **códigos originais de tratamento
(`100/0`, `100/60`, `100/80`) foram preservados de propósito**: recodificá-los faz
parte do preparo. A aba `origem` repete fonte, DOI, licença e unidade observacional.

**Valores observados** (conferidos no arquivo do aluno):

| Tratamento | n | Média (s) | DP (s) | IC 95% da média |
|---|---|---|---|---|
| `100/0` (cravo) | 12 | 120,8 | 20,8 | 107,5 – 134,0 |
| `100/60` | 12 | 154,0 | 49,4 | 122,6 – 185,4 |
| `100/80` | 12 | 152,1 | 50,5 | 120,0 – 184,1 |

- **ANOVA clássica:** F(2, 33) = 2,31; **p ≈ 0,115** → não significativa. Tukey:
  nenhum par difere (p ≥ 0,15); as diferenças pontuais são +33,3 s (+60 vs cravo) e
  +31,3 s (+80 vs cravo).
- **Normalidade dos resíduos:** Shapiro-Wilk p ≈ 0,76 (sem problema).
- **Homogeneidade:** Levene p ≈ 0,096 e Bartlett na mesma ordem — **limítrofe**. O
  desvio-padrão do grupo de referência é menos da metade dos demais, o que é
  biologicamente esperado (a resposta é mais variável quando se adiciona lidocaína).
- **Welch (`oneway.test`):** F(2; 18,5) = 3,60; **p ≈ 0,048**. **Kruskal–Wallis:**
  p ≈ 0,043. η² ≈ 0,12.

**O ponto central da atividade é essa fragilidade.** A conclusão depende da
hipótese de variâncias iguais, e o resultado está na fronteira: o correto não é
"achar o teste que dá significativo", e sim **decidir antes** qual modelo é
defensável (aqui, Welch, dado o desenho e a dispersão), reportar os dois e ler a
estimativa com sua incerteza. Um bom relatório diz que **não há evidência
suficiente de diferença** entre os tratamentos, que as estimativas pontuais sugerem
tempos **maiores** (e não menores) com lidocaína, e que com 12 peixes por grupo o
poder é baixo.

**Armadilhas comuns**

- Tratar `100/0` como controle sem anestésico (todos os grupos receberam cravo).
- Ler "não significativo" como "não há efeito" (equivalência não demonstrada).
- Trocar para Welch ou Kruskal–Wallis apenas porque o p cruzou 0,05, sem critério
  declarado previamente.
- Falar em dose–resposta: o fator é categórico e 60 e 80 mg/L deram praticamente o
  mesmo tempo médio.
- Contar as leituras de frequência respiratória do estudo original (a cada 20 s no
  mesmo peixe, nas abas `Induction Freq`/`Recovery Freq`, excluídas do arquivo do
  aluno) como réplicas independentes — é pseudorrepetição.

**Extensões.** (1) `peso_g` permite discutir ANCOVA, que foi o modelo do artigo
original; (2) a atividade serve de contraste com a ANOVA a dois fatores (#6) e com
o teste de homogeneidade de variâncias; (3) um bom fecho é comparar, no relatório,
o IC da diferença com a diferença mínima de interesse prático.
