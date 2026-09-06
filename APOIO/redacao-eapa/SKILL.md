---
name: redacao-eapa
description: >
  Use ao escrever ou revisar qualquer texto do livro "Estatística Aplicada à
  Pesca e Aquicultura com R" (EAPA) — capítulos, prefácio, introdução — ou
  qualquer prosa técnica em PT-BR que precise soar natural, envolvente e
  conversacional. Codifica a voz do livro, a estrutura padrão de capítulo, o
  entrosamento com a IDE CatalyseR e o pacote EAPADados, a identidade visual
  Ocean Gradient e um checklist de revisão. Gatilhos: livro EAPA, capítulo,
  prefácio, introdução, redação técnica, "do mouse ao código", CatalyseR.
---

# Redação EAPA — escrever técnico com voz humana

Guia para redigir o livro **Estatística Aplicada à Pesca e Aquicultura com R**.
Objetivo: rigor técnico com linguagem **natural, envolvente e conversacional**
em PT-BR. Capítulo-modelo de referência:
`capitulos/capitulo11/anova_estudos_observacionais_experimentais.qmd`.

## Quando usar
Sempre que escrever ou revisar capítulo, prefácio ou introdução do livro EAPA —
ou qualquer prosa técnica que deva soar humana, não de manual.

## A voz (o mais importante)
- **Converse com uma pessoa.** Trate o leitor por "você". Tom caloroso, sem
  solenidade acadêmica.
- **Frases curtas e ritmo variado.** Leia em voz alta; se travar, reescreva.
- **Mostre, não decrete.** Em vez de "é importante notar que...", conte a cena.
- **Jargão só com tradução** na primeira aparição.
- **Analogias do cotidiano** (cozinha, restaurante, feira, pesca) para criar
  intuição antes da fórmula.
- Curiosidade e humor leve são bem-vindos; condescendência, nunca.

## Os quatro pilares (da CatalyseR)
1. **Do mouse ao código** — conduza o leitor da análise visual até o R, sem susto.
2. **Contexto amazônico** — exemplos reais da pesca e aquicultura regional.
3. **Reprodutível** — código executável, caminhos relativos, do dado ao relatório.
4. **Aberto** — recursos pensados para compartilhar e contribuir.

## Entrosamento (a regra de ouro)
- A análise "verdade" vive na **CatalyseR**; o **livro espelha** a IDE.
- Dados **sempre** do `EAPADados`: `data(nome)` ou `EAPADados::nome`. Nada de
  `iris`/`mtcars`.
- Use as **funções canônicas**: `calcular_*()`, `mostrar_*()`, `relatar_*()`;
  tabelas com `flextable_ocean()`; relato automático com `relatar_*()`.
- Sempre que couber, faça a ponte: "a mesma função que a IDE CatalyseR usa para
  gerar o relatório `.docx`".

## Estrutura padrão de um capítulo
1. **Gancho** — `::: {.callout-note .destaque icon=false}` com `## <pergunta>`
   e uma cena real ("Já passou por isso?").
2. **Contexto + dados** — o problema e o dataset do EAPADados.
3. **Por dentro da conta** — intuição/teoria com analogia, antes do "botão".
4. **No R e na CatalyseR** — função base e a canônica; tabela Ocean; gráfico.
5. **Pressupostos / diagnósticos** (quando aplicável).
6. **Relato automático** — `> ` + `` `r relatar_*(...)` ``.
7. **Da significância à decisão** — o que fazer na prática (custo, manejo).
8. **Fechamento** — callout "Resumo do capítulo" + "Para praticar" (2–3 itens).

## Forma (Quarto/Markdown)
- **Prosa em parágrafos.** Nada de listas onde cabe uma frase; headers com
  parcimônia; negrito só para termos-chave; itálico para *t*, *p* e nomes
  científicos.
- **Tabelas de resultado:** `flextable_ocean()`. Tabelas-resumo em markdown com
  `tbl-colwidths` e alinhamento à esquerda (`:---`).
- **Figuras:** figura de abertura tipo infográfico no tema Ocean (template de
  prompt em `capitulos/capitulo11/prompt_imagem_experimento.md`); legenda
  citando a fonte; rótulo `{#fig-...}` e referência com `@fig-...`.
- **Equações:** `$...$` inline e `$$...$$` em display; rótulos em português;
  no texto corrido, decimais com vírgula.
- **Acentuação PT correta**, sempre.

## Identidade visual Ocean Gradient
Paleta: NAVY `#0F3B5F`, TEAL `#2E7D8F`, SEAFOAM `#62B6B7`, AMBER `#E89B3C`,
CORAL `#E76F51`. Cabeçalho navy nas tabelas; capa e figuras coerentes.

## Anti-padrões (cara de IA — evitar)
- "Em suma", "vale ressaltar", "é importante notar", "no mundo de hoje".
- Bullet em tudo; um header por parágrafo; negrito demais.
- Parágrafos-bloco gigantes; tom de manual seco.
- Exemplos genéricos (iris, mtcars); use pesca/aquicultura via EAPADados.
- Conclusão que só repete o que já foi dito.

## Checklist antes de fechar
- [ ] Abre com gancho real e específico (não genérico)?
- [ ] Usa dados do EAPADados e funções canônicas?
- [ ] Faz a ponte "do mouse ao código" com a CatalyseR?
- [ ] Explica a intuição/analogia antes do código?
- [ ] Tom conversacional, frases variadas, sem cara de IA?
- [ ] Tabelas/figuras no padrão Ocean, com legenda e fonte?
- [ ] Fecha com resumo + "Para praticar"?
- [ ] Acentuação e itálicos (*t*, *p*, espécies) corretos?
