# Proposta de reorganização do índice — Livro EAPA (v1)

Princípios: (1) espelhar os menus da CatalyseR; (2) agrupar capítulos em **unidades** (o tema orange-book tem `part`); (3) eliminar redundância; (4) a Unidade de **planejamento** vem **antes** dos testes, porque é ela que decide qual teste usar.

> Observação prática: não é preciso renomear as pastas `capituloNN/`. Reordenamos e renumeramos só no `_quarto.yml`, e ajustamos os títulos no YAML de cada `.qmd`. Mais seguro e reversível.

---

## Estrutura proposta (v1)

**Frontmatter** — Prefácio

### Unidade I · Do mouse ao código (preparar o terreno)
- **1. O ecossistema EAPA** — *(atual `capitulo01/intro.qmd`)* · manter
- **2. O ambiente computacional e a IDE** — *(atual `capitulo02`)* · manter
- **3. O projeto de análise: organização, importação e dados *tidy*** — *(atual `capitulo03`)* · manter e **absorver** o "tratamento básico" que hoje está no cap. 4

### Unidade II · Conhecer os dados  *(espelha o menu "Descrevendo Dados")*
- **4. Análise exploratória e estatística descritiva** — **fusão** dos atuais `capitulo04` (visualização inicial) + `capitulo05` · renomear
  - conteúdo: descritiva, tabela de frequência, histograma, boxplot, gráfico de médias e erro
  - *a decidir:* incluir aqui **criar/ler tabela de contingência** (descrição de categóricas), deixando o **teste** qui-quadrado para a inferência

### Unidade III · Planejar a coleta — o que decide o teste  *(antes dos testes)*
- **5. Planejamento amostral** — **desmembrado** do atual `capitulo06` · amostragem (AAS, sistemática, estratificada/proporcional — espelha o menu 1 da IDE)
- **6. Planejamento experimental** — **desmembrado** do atual `capitulo06` · delineamentos (DIC e além)

### Unidade IV · Comparar grupos — inferência
- **7. Uma e duas amostras: testes paramétricos (teste *t*)** — *(atual `capitulo07`)* · manter
- **8. Uma e duas amostras: testes não-paramétricos** — *(atual `capitulo08`)* · manter
- **9. ANOVA: comparando três ou mais grupos** — **mover** o atual `capitulo11` para cá (junto das comparações de médias)
  - *a decidir:* qui-quadrado / associação de categóricas aqui ou na Unidade V

### Unidade V · Relações entre variáveis
- **10. Correlação e associação** — *(atual `capitulo10`)* · manter
- **11. Regressão linear simples e múltipla** — *(atual `capitulo09`)* · manter
- **12. Regressão não linear** — *(atual `capitulo13`)* · manter
- **13. Análise multivariada (PCA e HCA)** — *(atual `capitulo17`)* · manter

### Unidade VI · Visualização avançada e comunicação
- **14. Criação de mapas em R** — *(atual `capitulo18`)* · manter
- **15. Relatórios e comunicação com Quarto** — *(atual `capitulo21`)* · manter

---

## Resumo das mudanças

| Ação | Capítulo(s) | Vira |
|:---|:---|:---|
| Absorver | "tratamento básico" do cap. 4 | dentro do cap. 3 (preparação) |
| Fundir + renomear | cap. 4 (viz inicial) + cap. 5 | cap. 4 "Análise exploratória e descritiva" |
| Desmembrar | cap. 6 (planejamento) | cap. 5 (amostral) + cap. 6 (experimental) |
| Mover para cima | cap. 11 (ANOVA) | cap. 9, na unidade de inferência |
| Reposicionar | regressão/correlação | Unidade V (relações) |
| Agrupar | tudo | em 6 unidades (`part`) |

---

## Decisões ainda em aberto (para você apontar)

1. **Tabela de contingência:** criar/descrever na Unidade II e testar (qui-quadrado) na inferência? Ou tudo junto num capítulo só?
2. **ANOVA:** concorda em movê-la para perto do teste *t* (comparação de médias), separando-a da regressão?
3. **Nomes espelhando a IDE:** quer que o cap. 4 se chame literalmente "Descrevendo os dados" (igual ao menu), ou o título mais descritivo proposto?
4. **Multivariada e mapas:** mantê-los na v1 como propus (Unidades V e VI), ou enxugar ainda mais?

---

## Fora da v1 (backlog — próximas edições)

- ANCOVA *(atual `capitulo12`)*
- Análise de séries temporais *(atual `capitulo14`)*
- Metodologia de superfície de respostas *(atual `capitulo19`)*

*(Capítulos 15, 16 e 20 já saíram do índice em etapa anterior.)*
