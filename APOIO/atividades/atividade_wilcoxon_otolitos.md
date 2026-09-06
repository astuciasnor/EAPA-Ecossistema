# Atividade autônoma — Teste de Wilcoxon pareado

## Dois métodos de leitura de otólito dão a mesma idade?

**Dataset:** `otolitos_salmonete.xlsx` — 51 salmonetes-do-Mar-Negro (*Mullus barbatus ponticus*); cada linha é um peixe avaliado por **dois métodos** de leitura de otólito.
**Fonte / licença:** dados da Fig. 3 de Polat, Bostanci & Yilmaz (2005), Turkish J. Vet. Anim. Sci. 29:429–433; pacote `FSAdata` (`MulletBS`, GPL ≥ 2).
**Onde estão os dados:** banco externo da disciplina — `dados/otolitos_salmonete.xlsx` (aba **Dados**; a aba **Contexto_Dicionario** traz o dicionário). Importe e confira.
**Habilidades avaliadas:** import; identificação do pareamento; criação de variável (diferença); descritivas de diferenças; Wilcoxon pareado com empates; interpretação de viés/precisão; comunicação.
**Nível / tempo estimado:** introdutório–intermediário · 2–3 h.

---

### Contexto

A idade de peixes costuma ser lida em otólitos, e há mais de uma técnica de preparo. Neste estudo, o mesmo otólito de cada salmonete foi lido de duas formas: **inteiro** (`whole_otolith_age`) e **quebrado-e-queimado** (`broken_burnt_age`). Saber se os métodos concordam é essencial: idades enviesadas distorcem estimativas de crescimento, mortalidade e avaliação de estoques.

### Questão central

A idade estimada pelo otólito **inteiro** difere sistematicamente daquela estimada pelo método **quebrado-e-queimado**?

Variável de interesse: `diferenca = broken_burnt_age - whole_otolith_age`.

Hipóteses:

- **H₀:** a distribuição das diferenças está centrada em zero (sem diferença sistemática entre os métodos);
- **H₁:** a distribuição das diferenças não está centrada em zero.

### Orientações

> **Passo 0 — importe e confira.** Importe `otolitos_salmonete.xlsx` (aba **Dados**), confira os tipos e o **pareamento**: as duas idades pertencem ao **mesmo peixe** (linha/`fish_id`), não é só ter o mesmo número de observações.

1. Identifique a unidade amostral, as variáveis numéricas e o fator de pareamento.
2. Verifique o número de pares completos (aqui não há ausências: 51 pares).
3. Crie a variável `diferenca = broken_burnt_age - whole_otolith_age`.
4. Descreva as diferenças: mediana, IQR, número de diferenças positivas/negativas/nulas e a **% de concordância exata**.
5. Construa um gráfico que **preserve os pares** (ex.: pontos ligados por peixe) ou o gráfico das diferenças.
6. Avalie a simetria aproximada das diferenças não nulas.
7. Formule as hipóteses e aplique o **Wilcoxon pareado** com α = 0,05, usando `exact = FALSE` (idade discreta → muitos empates e zeros).
8. Interprete o resultado em termos de **viés sistemático** entre os métodos.

### Produto esperado

Síntese com: contextualização; pergunta de pesquisa; justificativa do pareamento; tratamento/descrição das diferenças; estatísticas descritivas; gráfico; hipóteses; resultado do teste; conclusão técnica; e uma limitação da análise.

### Questões para discussão

- Qual método produziu as maiores idades?
- Quantos peixes receberam exatamente a mesma idade nos dois métodos?
- O sentido das diferenças foi consistente?
- A diferença estatística seria biologicamente relevante?
- Ausência de significância indicaria concordância perfeita?
- Qual a consequência de subestimar a idade dos peixes mais velhos numa avaliação de estoque?

---

## Rubrica de avaliação

| Critério | Insuficiente (0) | Suficiente (1) | Bom (2) | Excelente (3) |
|----------|------------------|----------------|---------|----------------|
| **Import e pareamento** | Não importa/entende o pareamento. | Importa, mas não explica o pareamento. | Importa e justifica o pareamento (mesmo peixe). | Idem, conferindo tipos e pares completos. |
| **Variável e descritivas** | Não cria a diferença. | Cria a diferença, sem descrever. | Diferença + mediana/IQR/sinais. | Idem, com % de concordância exata e gráfico que preserva pares. |
| **Execução do teste** | Teste inadequado. | Wilcoxon sem `exact=FALSE`/α. | Wilcoxon pareado correto (empates tratados). | Correto, avaliando a simetria das diferenças. |
| **Interpretação** | Ausente ou como "média". | Só o p-valor. | Interpreta como viés sistemático entre métodos. | Idem, distinguindo viés de concordância e relevância biológica. |
| **Pensamento crítico** | Não discute consequências. | Menção genérica. | Discute impacto em avaliação de estoque. | Idem, com precisão × acurácia e limitações. |

**Nota = soma dos critérios (0–15).**

---

### Observações ao professor (não distribuir)

- **Unidade observacional:** peixe individual (51 pares completos, sem ausências). `fish_id` é sequencial criado na curadoria (não é identificador original do estudo).
- **Resultado esperado:** o método **quebrado-e-queimado tende a dar idades maiores** — mediana 3 (inteiro) × 4 (quebrado-queimado); diferença mediana 1; **36 diferenças positivas, 0 negativas, 15 zeros**. Viés sistemático claro → resultado significativo esperado.
- **Teste:** `wilcox.test(broken_burnt_age, whole_otolith_age, paired = TRUE, exact = FALSE)`.
- **Ponto central:** ausência de significância **não** demonstraria concordância perfeita; e aqui o viés é direcional (subestimar idade de peixes velhos infla estimativas de mortalidade/produção — relevante para manejo).
- **Armadilhas comuns:** usar teste t; ignorar o pareamento; não tratar empates/zeros; confundir "sem viés" com "concordância exata".
- **Nota de escopo:** conjunto usado **só como atividade** (Excel externo) — não entra no pacote, para não duplicar o exemplo de Wilcoxon do pacote (`idades_savel_repetibilidade` / ShadCR).
