# Planejamento: Ciclo da ANOVA (Análise de Variância)

Este documento registra as diretrizes e metas para a próxima missão do **Ecossistema EAPA**, focada na consolidação do módulo de **ANOVA**.

---

## 🎯 As 3 Etapas da Missão

### 1. Pacote `EAPADados` (Dados de Contexto)
* **Objetivo:** Estruturar, documentar e expor o conjunto de dados de **bagres** como a base de referência canônica para a ANOVA.
* **Tarefas:**
  * Importar e preparar os dados de bagres.
  * Criar a documentação roxygen em `EAPADados/R/dados.R` explicando as variáveis, origem e contexto bioecológico.
  * Desenhar as funções canônicas de cálculo, formatação e narrativa em português (ex: `calcular_anova()`, `mostrar_anova()` com tabela `flextable` no estilo Ocean Gradient, e `relatar_anova()`).

### 2. IDE `catalyser` (Interface Interativa)
* **Objetivo:** Implementar o menu de ANOVA na interface e testar a geração do relatório em Quarto (`.qmd`).
* **Tarefas:**
  * Implementar o módulo da interface Shiny para ANOVA (caso ainda falte integrar o motor).
  * Validar a importação automática do dataset `bagres` no menu correspondente.
  * Testar e depurar a geração do arquivo `.zip` contendo o `.qmd` e o relatório final `.docx` (via `quarto render`), garantindo que o tema visual e as tabelas sigam o padrão.

### 3. Livro `eapa` (Material Didático)
* **Objetivo:** Escrever o capítulo de ANOVA do livro, servindo-se do conjunto de dados `bagres` como modelo de estudo.
* **Tarefas:**
  * Seguir o esqueleto padrão de 9 seções estabelecido no backlog.
  * Focar no planejamento experimental de onde vêm os dados de bagres.
  * Demonstrar a interpretação biológica e estatística dos resultados gerados pela IDE (p-valor, tamanho do efeito, comparações múltiplas).
