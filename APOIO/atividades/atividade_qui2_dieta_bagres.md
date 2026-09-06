# Atividade autônoma — Qui-quadrado de independência

## A dieta dos grandes bagres amazônicos depende da espécie?

**Base de dados:** conteúdo estomacal de grandes bagres da bacia Mamoré–Madeira (2009–2011), oito espécies.
**Fonte:** estudo sobre sazonalidade alimentar e partilha de recursos entre grandes bagres do rio Madeira, licença CC BY 4.0 — [Mendeley Data](https://data.mendeley.com/datasets/b7kwsyzmyf/1).
**Onde estão os dados:** banco externo de dados da disciplina (arquivo Excel).
**Habilidades avaliadas:** importação; seleção/exclusão justificada de espécies; agrupamento de presas em categorias; construção da tabela de contingência (um peixe por linha); qui-quadrado e verificação de pressupostos; tamanho de efeito (V de Cramér); interpretação biológica; comunicação.
**Nível / tempo estimado:** introdutório–intermediário · 3–4 h.

---

### Contexto

Os grandes bagres estão entre os recursos pesqueiros mais importantes da Amazônia. Embora diferentes espécies possam ocorrer nas mesmas regiões, elas não necessariamente utilizam os recursos alimentares da mesma maneira. Diferenças na dieta podem reduzir a competição e favorecer a coexistência entre as espécies.

Nesta atividade, você trabalhará com dados reais provenientes da análise do conteúdo estomacal de grandes bagres capturados pela pesca comercial na bacia dos rios Mamoré–Madeira. As coletas foram realizadas entre 2009 e 2011, abrangendo períodos de águas altas e baixas. Cada linha da base representa um peixe cujo estômago foi examinado. Os itens alimentares encontrados foram identificados no nível taxonômico mais detalhado possível, e o volume relativo de cada item foi estimado em relação ao conteúdo total do estômago.

### Problema de pesquisa

Investigue a seguinte questão: **a categoria predominante de presa consumida é independente da espécie de bagre?**

Você deverá selecionar e preparar os dados, construir a tabela de contingência e realizar uma análise de qui-quadrado. A tabela necessária para o teste não está pronta na base original.

### Etapas da atividade

Inicialmente, examine a estrutura do conjunto de dados e identifique:

- a unidade de observação;
- as espécies de bagres disponíveis;
- o número de estômagos analisados por espécie;
- as variáveis que descrevem os itens alimentares;
- os registros sem conteúdo estomacal ou sem identificação suficiente das presas.

Selecione apenas as espécies que apresentem quantidade adequada de estômagos com alimento. A exclusão de espécies com amostragem insuficiente deverá ser informada e justificada no relatório.

Em seguida, reúna os itens alimentares em categorias biologicamente coerentes. Dependendo da composição da base, poderão ser utilizadas categorias como:

- Characiformes;
- Siluriformes;
- Perciformes ou Cichliformes;
- outros peixes;
- crustáceos;
- material não identificado;
- outros itens alimentares.

Evite manter categorias muito raras apenas porque elas aparecem com nomes diferentes na base. Entretanto, não reúna organismos ecologicamente distintos sem apresentar uma justificativa.

Para cada estômago, determine a categoria de presa predominante, considerando aquela que apresentar o maior volume relativo. **Cada peixe deverá contribuir apenas uma vez para a tabela de contingência.**

### Construção da tabela

Depois de classificar a presa predominante de cada estômago, construa uma tabela contendo:

- as espécies de bagres nas linhas;
- as categorias de presas nas colunas;
- o número de estômagos em cada combinação.

Essa será a tabela de frequências observadas utilizada na análise.

### Análise estatística

Aplique o teste do qui-quadrado de independência para avaliar as hipóteses:

- **H₀:** a categoria predominante de presa é independente da espécie de bagre;
- **H₁:** existe associação entre a espécie de bagre e a categoria predominante de presa.

Antes de interpretar o teste, examine as frequências esperadas. Se houver muitas células com valores esperados baixos, reavalie o agrupamento das presas ou a seleção das espécies. Qualquer alteração deverá ter justificativa biológica e ser descrita no relatório. **Não agrupe categorias apenas para obter um resultado significativo.**

### Apresentação dos resultados

O relatório deverá conter:

1. a pergunta de pesquisa e as hipóteses estatísticas;
2. os critérios utilizados para selecionar as espécies;
3. a forma de agrupamento dos itens alimentares;
4. o número de estômagos aproveitados e excluídos;
5. a tabela de contingência;
6. as frequências esperadas;
7. o resultado do teste do qui-quadrado;
8. uma medida da intensidade da associação, preferencialmente o V de Cramér;
9. um gráfico que represente a composição da dieta;
10. a interpretação biológica dos resultados.

Um gráfico de barras proporcionais pode ser utilizado para comparar a composição alimentar entre as espécies. Os resíduos padronizados da análise também podem ajudar a identificar quais combinações entre espécies e presas mais contribuíram para o resultado do teste.

### Questões para discussão

- Todas as espécies apresentaram composição alimentar semelhante?
- Quais espécies estiveram mais associadas a determinadas categorias de presas?
- O resultado estatístico indica apenas associação ou permite afirmar causalidade?
- O agrupamento das presas pode influenciar as conclusões?
- A pesca comercial e o período hidrológico podem ter afetado a composição da amostra?
- Quais limitações devem ser consideradas ao interpretar os resultados?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Preparação dos dados** | Não filtra estômagos vazios/inválidos; usa a base crua. | Seleciona espécies e agrupa presas parcialmente, com pouca justificativa. | Seleção e agrupamento corretos e justificados; um peixe por linha. | Idem, com critérios explícitos, reprodutíveis e biologicamente coerentes. |
| **Execução do qui-quadrado** | Teste ausente ou mal montado. | Tabela e teste corretos, sem checar pressupostos. | Correto e com frequências esperadas verificadas. | Idem, tratando esperadas baixas (reagrupar/Fisher/simular) com justificativa. |
| **Interpretação** | Ausente ou equivocada. | Só relata o p-valor. | Interpreta a associação no contexto ecológico. | Usa resíduos padronizados + V de Cramér e lê a partilha de recursos. |
| **Comunicação / relatório** | Desorganizado; faltam itens. | Cobre parte dos 10 itens. | Completo e claro, com gráfico adequado. | Completo, claro, com barras proporcionais e escrita cuidadosa. |
| **Pensamento crítico** | Não discute limitações. | Limitações genéricas. | Discute agrupamento, causalidade e amostra. | Discute agrupamento, causalidade, viés da pesca comercial e do período hidrológico. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

- **Unidade observacional:** o estômago (peixe individual). A base tem ~315 estômagos e 8 espécies (*Brachyplatystoma* spp., *Pseudoplatystoma* spp., *Pinirampus pirinampu*, *Zungaro zungaro*).
- **Seleção esperada:** excluir estômagos vazios/sem identificação suficiente das presas; manter espécies com número adequado de estômagos com alimento (ex.: n ≥ 10–20), justificando as exclusões.
- **Agrupamento esperado:** reunir os ~70 táxons dominantes em ~5–7 categorias ecológicas (Characiformes; Siluriformes; Perciformes/Cichliformes; outros peixes; crustáceos; não identificado; outros). A presa predominante de cada estômago é a de **maior volume relativo**; cada peixe entra uma vez.
- **Resultado provável:** dieta difere entre espécies (partilha de recursos) → associação significativa esperada; *Brachyplatystoma* tende a ser mais piscívoro. O V de Cramér resume a força.
- **Armadilhas comuns:** manter categorias raras; agrupar para "forçar" significância; contar itens em vez de estômagos; ignorar estômagos vazios; usar o item dominante bruto sem agrupar; muitas células com esperada < 5.
- **Viés a discutir:** a pesca comercial é seletiva (tamanho/espécie) e o período hidrológico (cheia × vazante/seca) afeta a composição da amostra.
