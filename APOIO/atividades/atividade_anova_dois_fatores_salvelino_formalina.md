# Atividade autônoma — ANOVA a dois fatores

## Formalina e remoção semanal: o que favorece a eclosão do salvelino?

**Dataset:** `salvelino_formalina_remocao.csv`; cada linha representa um
compartimento experimental com ovos de *Salvelinus alpinus*.
**Fonte / licença:** Olk, T. R.; Lydersen, E.; Wollebæk, J. (2023),
[DataverseNO, DOI 10.23642/USN.7334573](https://doi.org/10.23642/USN.7334573),
CC BY 4.0.
**Onde estão os dados:** `dados/salvelino_formalina_remocao.csv` (banco externo
da disciplina; o mesmo arquivo é documentado no pacote `EAPADados`).
**Habilidades avaliadas:** importação, identificação da unidade experimental,
preparo compartilhado, ANOVA fatorial, interação, pressupostos, tamanho de
efeito e comunicação reprodutível.
**Nível / tempo estimado:** intermediário · 3–4 h.

---

### Contexto

Em um incubatório de salvelino-do-Ártico, ovos podem ser expostos a fungos. O
experimento comparou a aplicação de formalina antes da fase de olhos e a
remoção manual semanal de ovos mortos durante essa fase. Os fatores foram
aplicados em combinações, e cada compartimento é uma unidade experimental.

### Problema de pesquisa

Investigue: **a formalina, a remoção semanal ou a combinação das duas está
associada à sobrevivência até a eclosão?**

Hipóteses para a resposta `sobrevivencia_eclosao_pct`:

- **H₀:** os efeitos de formalina, remoção semanal e interação são nulos;
- **H₁:** pelo menos um efeito principal ou a interação altera a sobrevivência.

> Não trate os ovos individuais como linhas independentes: a unidade do
> experimento é o compartimento. As células são desequilibradas; registre os
> tamanhos por combinação antes de ajustar o modelo.

### Etapas

1. **Importe** o CSV e documente os tipos das sete colunas. Confirme que
   `ovos_eclodidos + mortalidade_total = ovos_iniciais` em todas as linhas.
2. **Prepare a base compartilhada:** preserve as contagens, converta
   `formalin` e `remocao_semanal` em fatores e crie, se necessário, a
   proporção `sobrevivencia_eclosao_pct / 100`. Registre cada decisão na trilha
   de preparo.
3. **Derive a base da análise:** escolha a resposta percentual e documente a
   transformação arco-seno da raiz quadrada usada no artigo (`asin(sqrt(p))`).
   Não substitua nem apague a resposta original.
4. **Analise:** ajuste `resposta_transformada ~ formalin * remocao_semanal`.
   Apresente a tabela ANOVA, efeitos principais, interação, médias por célula e
   um gráfico de interação. Verifique normalidade dos resíduos e homogeneidade
   de variâncias, sem transformar esses diagnósticos em uma decisão mecânica.
5. **Contraste metodológico:** discuta em um parágrafo a alternativa de um
   modelo binomial usando `cbind(ovos_eclodidos, mortalidade_total)`. Não é
   necessário implementá-la se o escopo da turma for a ANOVA, mas explique por
   que os denominadores diferentes importam.
6. **Feche o ciclo:** exporte o relatório e o Projeto R pela CatalyseR. O
   relatório deve separar preparo (Seção 0), análise e interpretação biológica.

### Produto esperado (relatório)

1. pergunta, hipóteses e unidade experimental;
2. tabela de contagens e tamanhos por célula;
3. trilha de preparo e justificativa da transformação;
4. tabela ANOVA com efeitos principais e interação;
5. médias por célula, gráfico de interação e diagnósticos;
6. tamanho de efeito ou estimativa de diferença acompanhada de incerteza;
7. interpretação aplicada, alternativa binomial e limitações do delineamento.

### Questões para discussão

- A diferença entre os tamanhos das células muda a leitura dos efeitos?
- Uma interação não significativa autoriza ignorar o contexto biológico dos dois
  tratamentos?
- O que se perde ao analisar somente porcentagens, sem os denominadores?
- O resultado permite afirmar causalidade além das unidades e condições do
  incubatório?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Preparação dos dados** | Não identifica a unidade ou altera contagens sem justificativa. | Preparo parcial. | Tipos, consistências e células documentados. | Trilha reprodutível, contagens preservadas e decisões justificadas. |
| **Escolha e execução** | Modelo inadequado ou sem interação. | ANOVA correta, com falhas de execução. | Modelo, tabela e gráfico corretos. | Pressupostos, efeito e alternativa binomial discutidos com critério. |
| **Interpretação** | Confunde p-valor com efeito ou causalidade. | Relata apenas significância. | Interpreta no contexto do incubatório. | Integra efeito, interação, denominadores e limitações. |
| **Comunicação / relatório** | Não apresenta itens pedidos. | Cobre parte dos itens. | Relatório completo e claro. | Seção 0, narrativa, tabelas e Projeto R plenamente reproduzíveis. |
| **Pensamento crítico** | Não discute desequilíbrio ou unidade. | Limitações genéricas. | Discute desequilíbrio e pseudorrepetição. | Compara ANOVA transformada e modelo binomial sem p-hacking. |

**Nota = soma dos critérios (0–15).**

### Observações ao professor (não distribuir)

Os quatro tamanhos de célula são 12 (com formalina, com remoção), 8 (com
formalina, sem remoção), 3 (sem formalina, com remoção) e 7 (sem formalina,
sem remoção). A base não contém valores ausentes e as contagens fecham em todas
as linhas. O conjunto é real e aberto; não gerar linhas adicionais para
"balancear" o experimento. Se a turma calcular um modelo binomial, tratar a
unidade experimental como agrupamento e discutir sobredispersão.
