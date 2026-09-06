# Dados reais para AAS e amostragem estratificada proporcional — EAPADados

Este material organiza **fontes reais e abertas** para construir conjuntos didáticos no pacote `EAPADados`, com foco em:

- Amostragem Aleatória Simples (AAS);
- Amostragem Estratificada Proporcional;
- Estratos por UF, município, porto, petrecho, frota, tipo de embarcação, comprimento, AB, sistema de cultivo e espécie.

> Observação importante: este material evita dados simulados. A ideia é baixar bases oficiais, limpar, padronizar e depois gerar objetos `.rda` pequenos para o pacote.

---

## 1. Fontes principais recomendadas

### 1.1. Ministério da Pesca e Aquicultura — MPA

Página geral:

```text
https://www.gov.br/mpa/pt-br/acesso-a-informacao/dados-abertos-2
```

Notícia de abertura das primeiras bases, com descrição das variáveis:

```text
https://www.gov.br/mpa/pt-br/assuntos/noticias/mpa-abre-base-de-dados-sobre-o-setor-da-pesca-e-aquicultura
```

Notícia sobre atualização de bases de pesca e aquicultura:

```text
https://www.gov.br/mpa/pt-br/assuntos/noticias/mpa-atualiza-bases-de-dados-abertos-da-pesca-e-aquicultura
```

Notícia sobre Mapas de Bordo e sardinha-verdadeira:

```text
https://www.gov.br/mpa/pt-br/assuntos/noticias/mpa-divulga-dados-abertos-sobre-mapas-de-bordo-e-comercializacao-de-sardinha-veradeira
```

---

## 2. Links prováveis no Dados.gov

Os links abaixo levam às páginas dos conjuntos de dados. Dentro de cada página, use o botão **Acessar recurso** ou **Download** para obter o CSV.

### 2.1. Embarcações autorizadas

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-das-autorizacoes-das-embarcacoes-de-pesca
```

Uso didático principal:

- AAS com embarcações;
- Estratificada proporcional por UF;
- Estratificada por petrecho;
- Estratificada por frota;
- Estratificada por classe de comprimento;
- Estratificada por classe de AB;
- Estratificada por tipo de propulsão.

Variáveis esperadas ou equivalentes:

```text
id_embarcacao
nome_embarcacao
nr_rgp
inscricao_marinha
ab
comprimento
propulsao
hp
capacidade_porao
volume_tanque
tripulacao
numero_covos
uf
numero_frota
codigo_in
petrecho
```

Estratos especialmente bons:

```text
uf
petrecho
numero_frota
codigo_in
propulsao
classe_comprimento
classe_ab
```

---

### 2.2. Mapas de Bordo

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-mapas-de-bordo
```

Uso didático principal:

- AAS com viagens/cruzeiros de pesca;
- Estratificada por porto de saída;
- Estratificada por porto de chegada;
- Estratificada por UF;
- Estratificada por tipo de embarcação;
- Estratificada por classe de comprimento;
- Cruzamento com embarcações por `id_embarcacao`, quando disponível.

Variáveis esperadas ou equivalentes:

```text
id_mapa_bordo
porto_saida
porto_chegada
data_saida
data_chegada
nome_embarcacao
nr_rgp
codigo_ini
uf
comprimento
tipo_embarcacao
```

Estratos especialmente bons:

```text
uf
porto_saida
porto_chegada
tipo_embarcacao
classe_comprimento
```

---

### 2.3. Captura de pargo

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-captura-da-especie-pargo
```

Uso didático principal:

- AAS com registros de captura;
- Estratificada por embarcação;
- Estratificada por ano;
- Estratificada por código IN;
- Estratificada por espécie;
- Junção com embarcações autorizadas por `id_embarcacao`, quando disponível.

Variáveis esperadas ou equivalentes:

```text
id_mapa_bordo
id_embarcacao
nome_embarcacao
data_saida
data_chegada
ano
codigo_in
especie
producao_t
```

Estratos especialmente bons:

```text
ano
codigo_in
especie
classe_producao
```

---

### 2.4. Captura de tainha

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-captura-da-especie-tainha
```

Uso didático principal:

- AAS com registros de captura ou comercialização;
- Estratificada por tipo de produtor;
- Estratificada por ano/safra;
- Estratificada por embarcação;
- Estratificada por classes de captura.

Variáveis esperadas ou equivalentes:

```text
nome_embarcacao
data_saida
data_chegada
captura_total_tainha_kg
data_recebimento
peso_tainha_recebido_kg
tipo_produtor
```

Estratos especialmente bons:

```text
tipo_produtor
ano
classe_captura
```

---

### 2.5. Sardinha-verdadeira

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-da-especie-sardinha-verdadeira
```

Uso didático principal:

- AAS com relatórios de comercialização;
- Estratificada por ano;
- Estratificada por espécie;
- Estratificada por classes de quantidade capturada;
- Estratificada por classes de valor por kg.

Variáveis esperadas ou equivalentes:

```text
codigo
data_relatorio
especie
quantidade_capturada_kg
valor_pago_kg
```

Estratos especialmente bons:

```text
ano
especie
classe_quantidade
classe_valor_kg
```

---

### 2.6. Registros de aquicultores

```text
https://dados.gov.br/dados/conjuntos-dados/base-de-dados-de-registros-de-aquicultores
```

Uso didático principal:

- AAS com aquicultores;
- Estratificada por UF;
- Estratificada por município;
- Estratificada por sistema de cultivo;
- Estratificada por tipo de atividade;
- Estratificada por tipo de registro.

Variáveis esperadas ou equivalentes:

```text
nome_razao_social
nr_rgp
sistema_cultivo
tipo_atividade
cidade_uf
uf
tipo_registro
genero
```

Estratos especialmente bons:

```text
uf
municipio
sistema_cultivo
tipo_atividade
tipo_registro
```

---

## 3. Estrutura sugerida no EAPADados

Depois de baixar e limpar os dados, os objetos podem ficar assim:

```r
data("mpa_embarcacoes")
data("mpa_mapas_bordo")
data("mpa_pargo")
data("mpa_tainha")
data("mpa_sardinha")
data("mpa_aquicultores")
data("mpa_embarcacoes_pargo")
```

---

## 4. Fórmula para alocação proporcional

```r
n_h <- n * N_h / N
```

Em que:

- `N_h` = tamanho do estrato;
- `N` = tamanho total da população;
- `n` = tamanho total da amostra;
- `n_h` = tamanho da amostra no estrato.

---

## 5. Código simples para plano amostral proporcional

```r
library(dplyr)

n_total <- 80

plano <- mpa_embarcacoes |>
  count(uf, name = "N_h") |>
  mutate(
    N = sum(N_h),
    prop = N_h / N,
    n_h = round(n_total * prop)
  )

plano
```

---

## 6. Código para AAS

```r
set.seed(123)

amostra_aas <- mpa_embarcacoes |>
  slice_sample(n = 80)
```

---

## 7. Código para amostragem estratificada proporcional

```r
amostrar_estratificada_prop <- function(dados, estrato, n_total, seed = 123) {
  set.seed(seed)

  estrato <- rlang::ensym(estrato)

  plano <- dados |>
    dplyr::count(!!estrato, name = "N_h") |>
    dplyr::mutate(
      N = sum(N_h),
      prop = N_h / N,
      n_h = round(n_total * prop)
    )

  amostra <- dados |>
    dplyr::inner_join(plano |> dplyr::select(!!estrato, n_h), by = rlang::as_string(estrato)) |>
    dplyr::group_by(!!estrato) |>
    dplyr::group_modify(~ dplyr::slice_sample(.x, n = min(unique(.x$n_h), nrow(.x)))) |>
    dplyr::ungroup() |>
    dplyr::select(-n_h)

  list(plano = plano, amostra = amostra)
}

res <- amostrar_estratificada_prop(mpa_embarcacoes, uf, n_total = 80)

res$plano
res$amostra
```

---

## 8. Exemplos de estratos por base

| Base | Unidade amostral | Estratos recomendados |
|---|---|---|
| `mpa_embarcacoes` | Embarcação | UF, petrecho, frota, código IN, propulsão, classe de comprimento, classe de AB |
| `mpa_mapas_bordo` | Viagem/cruzeiro/mapa | UF, porto de saída, porto de chegada, tipo de embarcação, classe de comprimento |
| `mpa_pargo` | Registro de captura | Ano, código IN, espécie, classe de produção |
| `mpa_tainha` | Registro de captura/comercialização | Tipo de produtor, ano, classe de captura |
| `mpa_sardinha` | Relatório/comercialização | Ano, espécie, classe de quantidade, classe de valor |
| `mpa_aquicultores` | Aquicultor | UF, município, sistema de cultivo, tipo de atividade, tipo de registro |

---

## 9. Procedimento recomendado

1. Abrir os links oficiais.
2. Baixar os CSVs pelo botão **Acessar recurso**.
3. Colocar os arquivos na pasta `dados_brutos/`.
4. Rodar `01_ler_padronizar_mpa.R`.
5. Rodar `02_amostragem_mpa.R`.
6. Conferir os arquivos `.rds` em `dados_processados/`.
7. Escolher quais bases entram no pacote `EAPADados`.

---

## 10. Observação sobre privacidade

Bases com nomes de pessoas físicas ou dados identificáveis devem ser tratadas com cuidado. Para o pacote didático, recomenda-se:

- remover CPF, mesmo que tarjado;
- remover nome pessoal quando não for necessário;
- manter apenas variáveis analíticas e estratos;
- preferir bases de embarcações, mapas, capturas e produção para objetos públicos do pacote.
