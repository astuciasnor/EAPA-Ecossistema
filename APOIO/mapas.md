# mapas.md — Diretriz para o menu **Mapas** do Ecossistema EAPA

> **Projeto:** Ecossistema EAPA — Livro Quarto, IDE Shiny CatalyseR e pacote EAPADados  
> **Objetivo deste arquivo:** orientar a IA/desenvolvedor que vai gerar ou refatorar os códigos R do menu **Mapas**, mantendo o escopo enxuto, didático e coerente com o livro *Estatística Aplicada à Pesca e Aquicultura*.

---

## 1. Decisão de escopo

O menu **Mapas** da CatalyseR e do livro EAPA deve priorizar mapas **estáticos**, reprodutíveis e exportáveis para relatório, livro/PDF e Quarto.

A versão inicial deve conter **apenas quatro tipos de mapas**:

1. **Mapa coroplético**
2. **Mapa de pontos / estações de amostragem**
3. **Mapa de bolhas proporcionais**
4. **Mapa de densidade / heatmap de ocorrências**

Esses quatro tipos atendem melhor aos objetivos do livro:

- expressar visualmente dados de pesca e aquicultura;
- apoiar o planejamento amostral;
- ajudar a interpretar padrões espaciais simples;
- conectar mapas com estatística descritiva, coleta, CPUE, ocorrência de espécies e produção aquícola;
- evitar transformar o livro em um curso de geoprocessamento ou SIG.

---

## 2. Decisão sobre `leaflet`

O módulo interativo com `leaflet` deve ser **removido do menu principal da CatalyseR na v1**.

### Justificativa

O `leaflet` é excelente para exploração interativa em HTML, mas:

- não entra bem no livro impresso/PDF;
- não ajuda diretamente na integração livro–CatalyseR–EAPADados;
- cria uma diferença entre o que o aluno vê na IDE e o que consegue reproduzir no relatório Quarto/PDF;
- aumenta o escopo técnico sem ser essencial para a estatística aplicada introdutória.

### Orientação prática

Se já houver código `leaflet` implementado:

- não apagar de forma irreversível;
- mover para uma pasta ou branch de **experimentos**, **v2** ou **backlog**;
- retirar do menu principal da CatalyseR;
- não documentar como funcionalidade central da v1.

A prioridade da v1 é: **mapas estáticos, bonitos, simples, exportáveis e alinhados ao livro**.

---

## 3. Tipos de mapas aprovados para a v1

| Módulo | Entra na v1? | Função didática | Exemplo no contexto EAPA |
|---|---:|---|---|
| **Mapa coroplético** | Sim | Conectar estatística descritiva, agregação espacial e dados oficiais. | Produção aquícola por estado ou município. |
| **Mapa de pontos / estações** | Sim | Mostrar planejamento amostral, esforço de coleta, cobertura espacial e unidade amostral. | Estações de coleta de ictiofauna, água, sedimento ou desembarque. |
| **Mapa de bolhas proporcionais** | Sim | Representar magnitude em locais específicos. | CPUE por porto, biomassa por estação, produção por fazenda aquícola. |
| **Mapa de densidade / heatmap** | Sim, com cuidado | Mostrar concentração espacial quando há muitos pontos. | Ocorrências de espécie, registros de captura, áreas de maior esforço pesqueiro. |

---

## 4. O que fica fora da v1

Os itens abaixo **não devem entrar como módulos principais na v1**:

- `leaflet` interativo;
- raster ambiental isolado;
- mapa ambiental em grade sem pontos de coleta;
- krigagem/interpolação;
- cartograma;
- mapas 3D;
- análises espaciais avançadas;
- qualquer ferramenta que exija conhecimento pesado de SIG.

Esses recursos podem ser registrados como ideias para versões futuras, mas não devem competir com a entrega principal.

### Observação sobre raster ambiental

O raster ambiental, como temperatura da superfície do mar, clorofila, salinidade ou batimetria, **não deve ser módulo independente na v1**.

Ele só deve ser considerado futuramente se for usado como **camada de contexto** para pontos de coleta, CPUE ou ocorrência de espécies.

Exemplo aceitável para v2:

- pontos de coleta sobre temperatura;
- ocorrência de espécie sobre clorofila;
- CPUE sobre batimetria;
- extração de valor ambiental em cada estação para posterior análise estatística.

Exemplo não recomendado:

- apenas um retângulo colorido de temperatura ou clorofila, sem costa, sem pontos, sem pergunta de pesquisa e sem interpretação.

---

## 5. Filosofia dos mapas no EAPA

O menu **Mapas** não deve existir para “fazer mapas por fazer”.

Cada mapa deve responder a pelo menos uma das perguntas abaixo:

1. **Onde os dados foram coletados?**
2. **A coleta está espacialmente bem distribuída?**
3. **Onde há maior produção, CPUE, biomassa ou ocorrência?**
4. **Há concentração espacial de registros?**
5. **O padrão espacial ajuda a formular uma hipótese estatística?**
6. **O mapa prepara o aluno para uma análise seguinte?**

Se o mapa não ajudar em nenhuma dessas perguntas, ele não deve entrar na v1.

---

## 6. Diretrizes técnicas gerais

### Pacotes recomendados

Usar preferencialmente:

```r
library(ggplot2)
library(sf)
library(geobr)
library(dplyr)
library(readr)
library(viridis)
library(ggspatial)
```

Pacotes opcionais, se realmente necessários:

```r
library(hexbin)
library(ggrepel)
```

Evitar, na v1:

```r
library(leaflet)
library(terra)
library(stars)
library(gstat)
library(cartogram)
```

Esses pacotes não são proibidos para sempre, mas não devem orientar o escopo inicial do menu.

---

## 7. Padrão visual

Os mapas devem seguir a identidade **Ocean Gradient** do EAPA/CatalyseR.

Cores de referência:

| Token | Hex |
|---|---|
| NAVY | `#0F3B5F` |
| TEAL | `#2E7D8F` |
| SEAFOAM | `#62B6B7` |
| AMBER | `#E89B3C` |
| CORAL | `#E76F51` |

Diretrizes:

- fundo limpo;
- títulos curtos;
- legenda clara;
- evitar excesso de textos dentro do mapa;
- usar cores perceptualmente adequadas para variáveis contínuas;
- evitar paletas “arco-íris”;
- manter boa legibilidade em PDF;
- permitir exportação como PNG em boa resolução.

---

## 8. Módulo 1 — Mapa coroplético

### Objetivo

Representar uma variável agregada por área, como estado, município ou região.

### Quando usar

Usar quando o dado estiver resumido por:

- UF;
- município;
- bacia;
- território;
- região administrativa;
- área de manejo.

### Exemplos EAPA

- produção aquícola por estado;
- produção de tambaqui por município;
- valor da produção pesqueira por UF;
- número de empreendimentos aquícolas por município.

### Dados exigidos

Tabela com uma coluna de identificação espacial e uma variável numérica.

Exemplo:

```r
uf,producao_t
PA,85000
SC,62000
PR,180000
```

Ou município:

```r
code_muni,municipio,producao_t
1501709,Bragança,1250
```

### Implementação sugerida

- usar `geobr::read_state()` para estados;
- usar `geobr::read_municipality()` para municípios;
- fazer `left_join()` com os dados;
- plotar com `geom_sf(aes(fill = variavel))`.

### Saída esperada

Um mapa estático com:

- polígonos;
- escala de preenchimento;
- legenda;
- título;
- fonte/caption opcional;
- botão para exportar imagem na CatalyseR.

### Cuidados

- não comparar apenas totais quando a área ou população distorce a interpretação;
- sempre que possível permitir usar taxa, densidade ou produção relativa;
- destacar valores ausentes com cor neutra.

---

## 9. Módulo 2 — Mapa de pontos / estações de amostragem

### Objetivo

Mostrar onde as observações foram feitas.

Esse módulo é essencial para o capítulo de planejamento amostral, pois ajuda o aluno a enxergar a coleta antes de fazer qualquer teste estatístico.

### Quando usar

Usar quando há coordenadas de campo:

- latitude;
- longitude;
- estação;
- campanha;
- ambiente;
- espécie;
- data;
- local.

### Exemplos EAPA

- estações de coleta de ictiofauna;
- pontos de coleta de água;
- pontos de desembarque;
- locais de captura experimental;
- viveiros ou tanques monitorados;
- pontos de coleta de sedimento ou contaminantes.

### Dados exigidos

Tabela com pelo menos:

```r
estacao,longitude,latitude
E1,-46.75,-0.95
E2,-46.90,-1.10
E3,-47.20,-0.80
```

Colunas opcionais:

```r
ambiente
campanha
especie
ano
mes
tratamento
```

### Implementação sugerida

- converter tabela para `sf` com `st_as_sf()`;
- plotar costa/estado/município como camada base;
- adicionar pontos com `geom_sf()`;
- permitir cor por grupo;
- permitir facetas por ano, espécie ou campanha.

### Saída esperada

Um mapa estático que responda:

- onde foram feitas as coletas?
- há pontos concentrados demais?
- há regiões sem amostragem?
- a amostragem cobre todos os ambientes necessários?

### Cuidados

- conferir se latitude e longitude estão no sistema correto;
- alertar para coordenadas invertidas;
- evitar pontos grandes demais;
- usar transparência quando houver sobreposição;
- não transformar o mapa em análise espacial avançada.

---

## 10. Módulo 3 — Mapa de bolhas proporcionais

### Objetivo

Mostrar a magnitude de uma variável em locais específicos.

É uma extensão natural do mapa de pontos.

### Quando usar

Usar quando cada ponto tem uma variável numérica associada, como:

- CPUE;
- biomassa;
- abundância;
- captura total;
- produção;
- densidade de organismos;
- valor comercial;
- número de indivíduos.

### Exemplos EAPA

- CPUE por porto de desembarque;
- biomassa média por estação de coleta;
- abundância de espécie por ponto;
- produção por fazenda aquícola;
- número de pescadores por comunidade.

### Dados exigidos

Tabela com coordenadas e variável numérica:

```r
local,longitude,latitude,cpue
P1,-46.75,-0.95,12.5
P2,-46.90,-1.10,30.2
P3,-47.20,-0.80,18.7
```

### Implementação sugerida

- usar `geom_sf(aes(size = variavel))`;
- usar `scale_size_area()`;
- permitir cor por grupo, espécie, ano ou ambiente;
- permitir facetas simples.

### Saída esperada

Um mapa em que o aluno perceba rapidamente:

- onde estão os maiores valores;
- se a CPUE se concentra em áreas específicas;
- se há locais discrepantes;
- se há associação visual entre espaço e magnitude.

### Cuidados

- limitar o tamanho máximo das bolhas;
- usar legenda de tamanho clara;
- evitar muitas bolhas sobrepostas;
- se houver muitos pontos, sugerir o mapa de densidade/heatmap.

---

## 11. Módulo 4 — Mapa de densidade / heatmap de ocorrências

### Objetivo

Mostrar concentração espacial quando há muitos pontos.

Esse módulo deve ser apresentado como ferramenta de visualização exploratória, não como inferência espacial formal.

### Quando usar

Usar quando há muitos registros de:

- ocorrência de espécie;
- pontos de captura;
- esforço pesqueiro;
- registros de desembarque;
- avistamentos;
- eventos de coleta;
- presença de organismos.

### Exemplos EAPA

- concentração de ocorrências de uma espécie;
- áreas com maior número de registros de pesca;
- densidade de pontos de captura de camarão;
- concentração de estações amostradas em uma campanha.

### Dados exigidos

Muitos pontos com coordenadas:

```r
id,longitude,latitude,especie
1,-46.75,-0.95,Espécie A
2,-46.76,-0.96,Espécie A
3,-47.10,-1.20,Espécie B
```

### Implementação sugerida

Opções simples:

```r
geom_bin2d()
geom_hex()
stat_density_2d_filled()
```

Preferência inicial:

- `geom_bin2d()` ou `geom_hex()` para contagem por célula;
- evitar suavizações excessivas;
- deixar claro que é visualização exploratória.

### Saída esperada

Mapa que responda:

- onde há maior concentração de registros?
- há áreas muito amostradas e outras pouco amostradas?
- o padrão visual sugere hipótese para análise posterior?

### Cuidados

- não vender o mapa como prova estatística;
- informar que densidade depende do esforço amostral;
- cuidado com viés de coleta;
- se o esforço não for homogêneo, explicar a limitação.

---

## 12. Integração com EAPADados

Sempre que possível, os exemplos devem usar datasets do pacote **EAPADados**.

Datasets desejáveis para o menu Mapas:

1. `aquicultura_br`  
   - produção aquícola por UF ou município;
   - ideal para mapa coroplético.

2. `estacoes_coleta`  
   - pontos de amostragem com latitude e longitude;
   - ideal para mapa de estações.

3. `cpue_portos` ou `cpue_estacoes`  
   - coordenadas + CPUE;
   - ideal para bolhas proporcionais.

4. `ocorrencias_especies`  
   - muitos registros de ocorrência;
   - ideal para densidade/heatmap.

Se esses datasets ainda não existirem, criar versões pequenas, limpas e bem documentadas para a v1.

---

## 13. Integração com o livro Quarto

O livro deve mostrar os mesmos tipos de mapas disponíveis na CatalyseR.

Como o `geobr` pode baixar dados durante a execução, recomenda-se manter o fluxo já adotado no capítulo de mapas:

- chunks com código demonstrativo podem ficar com `eval: false` quando necessário;
- imagens finais podem ser geradas previamente por script;
- scripts de geração devem ficar em `images/` ou pasta equivalente;
- o livro deve priorizar estabilidade de renderização.

### Regra prática

A CatalyseR pode gerar o mapa dinamicamente.  
O livro pode mostrar o código e usar imagem estática pré-gerada.

---

## 14. Integração com a CatalyseR

O menu **Mapas** da CatalyseR deve seguir uma lógica simples.

### Entrada mínima

- selecionar dataset;
- selecionar tipo de mapa;
- selecionar variável espacial;
- selecionar variável numérica ou categórica;
- gerar mapa;
- exportar imagem;
- exportar código R/Quarto.

### Sugestão de menu

```text
Mapas
├── Coroplético
├── Pontos / estações
├── Bolhas proporcionais
└── Densidade / heatmap
```

### Não incluir na v1

```text
Mapas
├── Leaflet interativo
├── Raster ambiental
├── Krigagem
├── Cartograma
└── 3D
```

---

## 15. Código R — estruturas mínimas esperadas

A IA que gerar os códigos deve priorizar funções simples, reutilizáveis e compatíveis com Shiny e Quarto.

### Função 1 — coroplético

```r
plotar_mapa_coropletico <- function(dados, mapa_sf, chave_mapa, chave_dados, variavel) {
  dados_mapa <- mapa_sf |>
    dplyr::left_join(dados, by = setNames(chave_dados, chave_mapa))

  ggplot2::ggplot(dados_mapa) +
    ggplot2::geom_sf(ggplot2::aes(fill = .data[[variavel]]),
                     color = "white",
                     linewidth = 0.2) +
    viridis::scale_fill_viridis(name = variavel, option = "C", na.value = "grey90") +
    ggplot2::theme_minimal()
}
```

### Função 2 — pontos / estações

```r
plotar_mapa_pontos <- function(dados, lon, lat, grupo = NULL, mapa_base = NULL) {
  pontos <- sf::st_as_sf(dados, coords = c(lon, lat), crs = 4326, remove = FALSE)

  p <- ggplot2::ggplot()

  if (!is.null(mapa_base)) {
    p <- p + ggplot2::geom_sf(data = mapa_base, fill = "grey95", color = "grey70")
  }

  if (is.null(grupo)) {
    p <- p + ggplot2::geom_sf(data = pontos)
  } else {
    p <- p + ggplot2::geom_sf(data = pontos, ggplot2::aes(color = .data[[grupo]]))
  }

  p + ggplot2::theme_minimal()
}
```

### Função 3 — bolhas proporcionais

```r
plotar_mapa_bolhas <- function(dados, lon, lat, tamanho, grupo = NULL, mapa_base = NULL) {
  pontos <- sf::st_as_sf(dados, coords = c(lon, lat), crs = 4326, remove = FALSE)

  p <- ggplot2::ggplot()

  if (!is.null(mapa_base)) {
    p <- p + ggplot2::geom_sf(data = mapa_base, fill = "grey95", color = "grey70")
  }

  if (is.null(grupo)) {
    p <- p + ggplot2::geom_sf(data = pontos, ggplot2::aes(size = .data[[tamanho]]), alpha = 0.75)
  } else {
    p <- p + ggplot2::geom_sf(data = pontos, ggplot2::aes(size = .data[[tamanho]], color = .data[[grupo]]), alpha = 0.75)
  }

  p +
    ggplot2::scale_size_area(max_size = 10, name = tamanho) +
    ggplot2::theme_minimal()
}
```

### Função 4 — densidade / heatmap

```r
plotar_mapa_densidade <- function(dados, lon, lat, bins = 30) {
  ggplot2::ggplot(dados, ggplot2::aes(x = .data[[lon]], y = .data[[lat]])) +
    ggplot2::geom_bin2d(bins = bins) +
    viridis::scale_fill_viridis(name = "Nº de registros", option = "C") +
    ggplot2::coord_equal() +
    ggplot2::theme_minimal()
}
```

Essas funções são apenas esqueletos. A implementação final deve adaptar nomes, validações, mensagens e interface Shiny conforme a arquitetura real da CatalyseR.

---

## 16. Critérios de aceite

Um módulo de mapa só deve ser considerado pronto quando:

- gerar mapa estático em `ggplot2` ou equivalente;
- funcionar no ambiente da CatalyseR;
- permitir exportar imagem;
- permitir exportar código R/Quarto;
- usar dados do EAPADados ou dados enviados pelo usuário;
- ter mensagem didática em português explicando o que o mapa mostra;
- não depender de `leaflet`;
- não exigir internet na renderização final do livro;
- não introduzir análise espacial avançada sem necessidade;
- caber no escopo da v1.

---

## 17. Mensagem didática para a interface

Cada módulo deve exibir uma breve explicação para o usuário.

### Coroplético

> Use este mapa quando seus dados estão agregados por área, como estado ou município. Ele ajuda a comparar regiões e identificar onde a produção, captura ou outro indicador é maior ou menor.

### Pontos / estações

> Use este mapa para visualizar onde as coletas foram realizadas. Ele ajuda a avaliar a cobertura espacial, identificar lacunas de amostragem e discutir o planejamento da pesquisa.

### Bolhas proporcionais

> Use este mapa quando cada local possui uma medida numérica, como CPUE, biomassa, abundância ou produção. O tamanho da bolha representa a magnitude da variável.

### Densidade / heatmap

> Use este mapa quando há muitos registros de ocorrência ou captura. Ele mostra áreas com maior concentração de pontos, mas deve ser interpretado considerando o esforço amostral.

---

## 18. Decisão final

A v1 do menu **Mapas** deve ser pequena, útil e coerente.

Entram:

1. **Coroplético**
2. **Pontos / estações de amostragem**
3. **Bolhas proporcionais**
4. **Densidade / heatmap de ocorrências**

Saem da v1:

- `leaflet`;
- raster ambiental isolado;
- krigagem;
- cartograma;
- mapas avançados.

A regra é simples:

> No EAPA, mapa só entra se ajudar o aluno a ver melhor os dados, planejar melhor a coleta ou interpretar melhor uma pergunta de pesca e aquicultura.

