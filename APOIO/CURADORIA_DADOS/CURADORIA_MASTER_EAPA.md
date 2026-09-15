# Curadoria master dos dados EAPA

Data de abertura: 2026-07-08

Este arquivo e o painel de controle da curadoria de dados do ecossistema EAPA. Use-o para registrar fontes, decidir o uso didatico, controlar licencas/autorizacoes, acompanhar validacao e preparar os dados para:

- pacote R `EAPADados`;
- livro EAPA em Quarto;
- exemplos e exercicios da CatalyseR;
- planilhas de avaliacao com dados reais.

## Regra central

Todo dataset entra na curadoria com quatro perguntas respondidas:

1. De onde veio o dado e qual e a licenca/autorizacao?
2. Qual e a unidade observacional de cada linha?
3. Que pergunta didatica ele ajuda o aluno a responder?
4. Qual e o destino permitido: aula interna, livro, pacote R, avaliacao ou restrito?

## Arquivos-base ja presentes

| arquivo | papel | status |
|---|---|---|
| `GUIA_IA_CURADORIA_DADOS_EAPA.md` | guia obrigatorio para datasets do pacote, planilha de avaliacao, documentacao e fontes | lido e adotado como regra |
| `SKILL_curadoria_dados_EAPA.md` | protocolo operacional de curadoria, traducao, licenca, tidy data e validacao | lido e adotado como regra |
| `provisorios/bhujel_statistics_aquaculture_dados_v02_traduzido.xlsx` | workbook com datasets extraidos/transcritos de Bhujel (2008) | inventariado; precisa revisao contra PDF e autorizacao |
| `provisorios/Statistics for Aquaculture - Ram Bhujel - 2008 - Wiley-Blackwell.pdf` | fonte primaria do workbook Bhujel | leitura feita por copia temporaria; 376 paginas; usar para conferencia de tabelas |

## Localizacao canonica dos arquivos de curadoria

Os arquivos brutos, provisórios, versões limpas intermediárias e artefatos de
validação ficam em `ATIVIDADES/provisorios/`, para que a curadoria e as
atividades permaneçam no mesmo pilar de trabalho. O workbook curado principal,
o registro de fontes e os containers originais permanecem na raiz desta pasta e
em `fontes_containers_originais/`.

`curadoria_arquivos/` foi a área legada de transição e foi descontinuada. Ela não
é fonte da verdade nem deve ser recriada; novos arquivos entram em
`ATIVIDADES/provisorios/` ou, quando aprovados, no pacote `EAPADados`.

Registros históricos que mencionam apenas `provisorios/` referem-se à pasta
`ATIVIDADES/provisorios/` a partir da raiz do ecossistema.

## Status juridico padrao

Use estes valores em planilhas, dicionarios e documentos:

| status | significado | uso permitido ate nova decisao |
|---|---|---|
| `publico_aberto` | fonte publica com licenca compativel | aula, livro, pacote, avaliacao |
| `artigo_aberto` | artigo/repositorio aberto com dados reutilizaveis | aula, livro, pacote, avaliacao, conforme licenca |
| `livro_com_autorizacao_pendente` | livro comercial ou material fechado ainda sem autorizacao formal | estudo interno e aula interna apenas |
| `livro_autorizado` | livro com autorizacao formal registrada | conforme escopo autorizado |
| `uso_interno_aula` | permitido para demonstracao interna, sem redistribuir | aula interna |
| `simulado` | gerado didaticamente e identificado como simulado | aula/livro/pacote, se rotulado |
| `restrito_nao_incluir` | licenca inadequada, fonte incerta ou autorizacao negada | nao incluir |

## Inventario inicial: Bhujel (2008)

Fonte: Bhujel, R. C. (2008). *Statistics for Aquaculture*. Wiley-Blackwell.

Status global recomendado: `livro_com_autorizacao_pendente`.

Motivo: os dados foram extraidos/transcritos de livro comercial. Antes de distribuir em pacote publico, livro aberto ou planilha compartilhada, solicitar autorizacao ao autor/editora. Enquanto isso, podem ser tratados como base de estudo interno e prototipo didatico.

| dataset_id | sheet | tema didatico | fonte no livro | analises sugeridas | status atual |
|---|---|---|---|---|---|
| `batch_weights_fish` | `batch_weights_fish` | peso em lote de 15 peixes: normal vs stunted sob taxas de alimentacao | Table 1.2 / Table 3.1; p. 31/70 | derivadas de crescimento, ANOVA fatorial 2x3, regressao por taxa, barras de erro | revisar contra PDF |
| `family_size_fish_farmers` | `family_size` | tamanho de familias de piscicultores | Table 4.6 + texto; p. 89-90 | frequencia, acumulada, porcentagem, moda, mediana, barras | revisar contra PDF |
| `tilapia_recruits` | `tilapia_recruits` | recrutas de tilapia por viveiro | secao 4.7.2; p. 90 | EDA, histograma, classes, log/sqrt, outliers, assimetria | revisar contra PDF |
| `farm_size_fish_farmers` | `farm_size` | area de fazendas de piscicultores | secao 4.7.2; p. 91 | histograma, classes, media/mediana, quartis, boxplot, normalidade | revisar contra PDF |
| `survival_transformation` | `survival_transform` | sobrevivencia percentual para transformacao | Tables 4.8-4.10; p. 97-99 | transformacao percentual, variancias, normalidade, t/ANOVA | revisar contra PDF |
| `fish_fry_mortality_vitamin` | `mortality_vitamin` | mortalidade de alevinos com mistura vitaminica | Table 4.11; p. 103 | EDA, skewness, kurtosis, transformacao, teste t, Mann-Whitney | revisar contra PDF |
| `prawn_harvest_dirty` | `prawn_dirty` | peso individual de camarao de agua doce no harvest | Table 4.12; p. 105 | limpeza, outliers, histograma, teste t/ANOVA, pseudorrepeticao | transcricao preliminar; revisar contra PDF |
| `fish_farm_salaries` | `salaries` | salarios em fazenda de peixes | Table 5.2; p. 112-113 | media, mediana, DP, CV, quartis, boxplot, outliers | revisar contra PDF |
| `hapa_sex_counts` | `hapa_counts` | contagem de machos e femeas em hapas | Table 5.9; p. 133 | ausentes, sobrevivencia por sexo, pareado, qui-quadrado | revisar contra PDF |
| `fish_size_distribution` | `size_distribution` | distribuicao de tamanho de peixes | Table 6.3; p. 146-147 | aderencia, qui-quadrado, K-S, observado vs esperado | revisar contra PDF |
| `sex_ratio_fish` | `sex_ratio` | razao sexual de peixes | Table 6.4; p. 148 | qui-quadrado de aderencia, proporcoes, binomial | revisar contra PDF |
| `formalin_fry_survival` | `formalin_survival` | sobrevivencia de fry com formalina | Table 6.5; p. 150 | qui-quadrado de independencia, risco relativo, odds ratio | revisar contra PDF |
| `tilapia_length_weight` | `length_weight` | comprimento e peso de tilapias machos | Table 8.11; p. 273 | correlacao, regressao peso-comprimento, alometria | revisar contra PDF |
| `chicken_manure_productivity` | `cm_productivity` | esterco de galinha e produtividade de tilapia | Table 8.17; p. 284 | regressao linear/quadratica/cubica, dose-resposta | revisar contra PDF |
| `vitaminC_protein_factorial` | `vitC_protein` | vitamina C x proteina no peso final | Table 7.32; p. 227 | ANOVA fatorial, interacao, RCBD, pos-teste, tendencias | revisar contra PDF |
| `market_prices_thailand` | `market_prices` | preco de mercado de especies na Tailandia | Table 9.1; p. 286 | cluster univariado, matriz de distancia, dendrograma | revisar contra PDF |
| `tilapia_egg_output_ancova` | `ancova_egg` | producao de ovos ajustada pelo peso da femea | Table 9.7; p. 295 | ANCOVA, t antes/depois, regressao por grupo | revisar contra PDF |
| `carp_growth_feeding` | `carp_growth` | crescimento de carpas sob taxas de alimentacao | Table 9.16; p. 313 | curvas de crescimento, modelos lineares/nao lineares, fatorial, ANCOVA | revisar contra PDF |
| `lipid_water_quality` | `lipids_water` | composicao lipidica e qualidade da agua | Table 9.17; p. 314 | PCA, MANOVA, ANCOVA, cluster, heatmap, correlacao | revisar contra PDF |

## Checagem rapida do Excel Bhujel

Resultado da verificacao em 2026-07-08:

- 19 abas de dados + abas de metadados.
- Todas as abas de dados usam nomes de colunas em formato compativel com `snake_case` ASCII.
- Nao foram encontradas linhas duplicadas completas.
- Pendencias de valores ausentes:
  - `prawn_dirty`: 5 celulas ausentes.
  - `hapa_counts`: 1 celula ausente.
  - `size_distribution`: 8 celulas ausentes, possivelmente esperadas por frequencias observadas/esperadas.
  - `Dicionario_variaveis`: 63 ausencias, principalmente campos opcionais como unidade.
- A aba `README` tem cabecalho descritivo nao padronizado; aceitavel como metadado, mas para arquivo final EAPA e melhor usar colunas `campo` e `valor`.

## Prioridade de curadoria dos conjuntos Bhujel

Alta prioridade didatica, mas nao distribuir sem autorizacao:

- `length_weight`: regressao peso-comprimento e alometria.
- `vitC_protein`: ANOVA fatorial e interacao.
- `ancova_egg`: ANCOVA clara e aplicada.
- `carp_growth`: crescimento ao longo do tempo e comparacao entre especies/taxas.
- `lipids_water`: PCA/ACP e multivariada.
- `mortality_vitamin`: transformacoes, comparacao de grupos e assimetria.

Boa prioridade para aula introdutoria:

- `family_size`
- `tilapia_recruits`
- `farm_size`
- `salaries`
- `sex_ratio`
- `formalin_survival`

Usar como treino de arrumacao/validacao:

- `prawn_dirty`
- `hapa_counts`
- `size_distribution`

## Dados reais para ANOVA de dois fatores (agosto de 2026)

Dois conjuntos enxutos foram incorporados a partir de fontes abertas. Eles têm
papéis complementares e não devem ser confundidos:

### Salvelino: formalina × remoção semanal

- Arquivo de curadoria: `provisorios/salvelino_formalina_remocao/salvelino_formalina_remocao.csv`.
- Fonte: Olk, Lydersen & Wollebæk (2023), [DataverseNO, DOI 10.23642/USN.7334573](https://doi.org/10.23642/USN.7334573).
- Licença: **CC BY 4.0**; uso público permitido com atribuição.
- Unidade: compartimento experimental; 30 linhas, uma por unidade.
- Delineamento: fatorial 2 × 2, com `formalin` e `remocao_semanal`; células
  desequilibradas (12, 8, 3 e 7).
- Respostas: contagens (`ovos_iniciais`, `ovos_eclodidos`, `mortalidade_total`)
  e `sobrevivencia_eclosao_pct`.
- Destino: **EAPADados**, atividade autônoma de ANOVA a dois fatores, capítulo
  do livro e módulo CatalyseR.
- Decisão: **aceitar**. As contagens foram preservadas para discutir a
  alternativa binomial; para reproduzir a análise publicada, documentar a
  transformação arco-seno da raiz quadrada da proporção.

### Gammarus: dieta × temperatura (resumo publicado)

- Arquivo de curadoria: `provisorios/gammarus_dieta_temperatura_resumo/gammarus_dieta_temperatura_resumo.csv`.
- Fonte: Ribes-Navarro et al. (2022), [Frontiers in Marine Science, DOI 10.3389/fmars.2022.931991](https://doi.org/10.3389/fmars.2022.931991).
- Licença: **CC BY**; o artigo é open access.
- Unidade: combinação de tratamento; 12 linhas (3 dietas × 4 temperaturas),
  com média, desvio-padrão e `n = 4` por célula.
- Destino: **EAPADados**, gráficos, discussão do delineamento e interpretação
  do resultado publicado.
- Decisão: **aceitar com restrições**. O arquivo não contém as 48 observações
  dos recipientes: não usar para recalcular ANOVA, pressupostos ou pós-testes.
  A atividade deve pedir leitura de médias/DP, barras de erro e comparação com
  a ANOVA reportada pelos autores.

Os dois CSV também estão em `ATIVIDADES/dados/`, acompanhados dos handouts das
atividades. A cópia em `EAPADados/data-raw/curados/` é a entrada de construção
dos objetos `.rda`; os arquivos não são gerados sinteticamente.

## Protocolo para novos arquivos e links

Quando chegar um novo arquivo/link, registrar primeiro:

| campo | preencher |
|---|---|
| `id_fonte` | identificador curto, ex.: `obis_pargo_2026` |
| `origem` | URL, artigo, livro, instituicao ou arquivo local |
| `data_acesso` | data em que a fonte foi baixada/acessada |
| `licenca` | licenca declarada ou situacao de autorizacao |
| `area` | pesca, aquicultura, bioecologia, qualidade de agua, tecnologia do pescado |
| `tema` | crescimento, reproducao, desembarque, ocorrencia, qualidade, sensorial etc. |
| `unidade_observacional` | peixe, tanque, viveiro, amostra, lote, municipio, viagem etc. |
| `estrutura_estatistica` | descritiva, teste t, ANOVA, regressao, associacao, PCA etc. |
| `destino_pretendido` | aula, livro, pacote, avaliacao, estudo interno |
| `decisao` | aceitar, aceitar com restricoes, pedir autorizacao, rejeitar |

## Fontes publicas abertas curadas

### Rutledge et al. (2025) - Brook trout / truta de riacho

Fonte: Rutledge, E.; Nislow, K.; Fuller, M.; McCormick, S.; Chen, C.; Chadwick, J. G. (2025). *Interactive effects of temperature and food ration on growth and mercury concentration in eastern brook trout* [Dataset]. Dryad. DOI: 10.5061/dryad.v6wwpzh86.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / Dryad CC0.

Dataset principal: `truta_riacho_crescimento_rutledge_2025`, aba `truta_crescimento`.

Resumo de validacao:

- 89 peixes individuais.
- 19 variaveis curadas.
- 9 tanques.
- 20 ausencias em `eficiencia_conversao`, todas nas linhas de `racao_fator = "zero"`.
- 69 linhas completas para modelos que incluem `eficiencia_conversao`.
- Sem linhas duplicadas completas.
- A versao `v02` inclui a aba `truta_regressao`, uma adaptacao didatica com 69 linhas completas e 11 variaveis para uso direto em testes.
- Na planilha-mae atual, a aba `truta_regressao_limpo` guarda somente os dados limpos/adaptados. Os dados originais nao ficam como aba para evitar crescimento excessivo; a fonte, DOI e arquivo bruto local ficam registrados em `info_conjuntos`.

Objetivo didatico:

- Regressao linear multipla com `crescimento_especifico_pct_dia` como resposta.
- Modelo simples sugerido: `crescimento_especifico_pct_dia ~ temperatura_c + racao_g + massa_inicial_g + eficiencia_conversao`.
- Modelo mais cuidadoso sugerido: `crescimento_especifico_pct_dia ~ temperatura_c * racao_g + massa_inicial_g + tanque`.
- Para prova/teste, usar preferencialmente a aba `truta_regressao_limpo` e descrever como "adaptacao didatica dos dados originais de Rutledge et al. (2025)".
- Discutir que `tanque` e tratamentos compartilhados por grupos de peixes podem gerar dependencia/pseudorrepeticao.
- Extensao possivel: usar `mercurio_ng_g_peso_seco` como resposta para conectar crescimento e bioacumulacao.

### Amira et al. (2021) - Tilapia-do-Nilo alimentada com microalgas

Fonte: Amira, K. I.; Rahman, M. R.; Sikder, S.; Khatoon, H.; Afruj, J.; Haque, M. E.; Minhaz, T. M. (2021). *Data on Growth, Survivability, Water quality and Hemato-biochemical Indices of Nile Tilapia (Oreochromis niloticus) Fry Fed with Selected Marine Microalgae*. Data in Brief / Mendeley Data. Dataset DOI: 10.17632/hv5fg5r869.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / CC BY 4.0.

Dataset principal: `tilapia_microalgas`, aba `tilapia_microalgas1`.

Resumo de validacao:

- 15 linhas, cada uma representando um tanque/repeticao experimental.
- 32 variaveis limpas combinando crescimento, sobrevivencia, qualidade da agua, hematologia e bioquimica serica.
- Sem valores ausentes na aba limpa.
- As linhas de resumo da fonte (`Average`, `STDEV`, `SE`) foram removidas.
- As quatro tabelas originais foram combinadas por codigo de tratamento/repeticao (`N25R1`, `T50R3`, `CR1` etc.).

Objetivo didatico:

- Regressao multipla de `sgr_pct_dia` usando dieta/microalga e qualidade da agua.
- Modelo sugerido com nomes curados: `sgr_pct_dia ~ tipo_microalga + nivel_substituicao_pct + temperatura_c + oxigenio_dissolvido_mg_l + ph + tan_mg_l + no2_n_mg_l + srp_mg_l`.
- Modelo original sugerido em R: `SGR ~ tipo_microalga + nivel_substituicao + temperatura + DO + pH + TAN + NO2_N + SRP`.
- Tambem pode servir para PCA/ACP exploratoria com variaveis de qualidade da agua, hematologia e bioquimica.
- Cuidado central: a unidade experimental e o tanque, nao os 18 peixes individuais por tanque.

### Jorge et al. (2025) - Composicao nutricional de peixes comercializados em Portugal

Fonte: Jorge, A. O.; Oliveira, M. B. P. P.; Prieto, M. A. (2025). *Nutritional Composition and Derived Indices of Fish Species Sold in Portugal*. Mendeley Data. DOI: 10.17632/3wvbgtwkfz.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / CC BY 4.0.

Dataset principal: `peixes_nutricao_portugal`, aba `peixes_nutricao1`.

Resumo de validacao:

- Fonte local: `Nutritional Composition and Derived Indices of Fis.zip`.
- O arquivo `A2.xlsx` traz tres abas: `MASTER_SHEET`, `RAW_DATA` e `CLUSTER_SUMMARY`.
- A aba `RAW_DATA` possui 40 especies completas e 69 colunas sem valores ausentes.
- A adaptacao didatica gerou 40 linhas e 22 colunas, com nomes curados em `snake_case`.
- O cluster publicado pelos autores foi mantido apenas como rotulo auxiliar (`cluster_autores`, `perfil_nutricional_autores`).

Objetivo didatico:

- Usar uma base enxuta para ACP, AAH, k-means, heatmap e correlacao.
- Focar em proteina, lipideos, umidade, cinzas, classes de acidos graxos, EPA, DHA e minerais selecionados.
- Evitar misturar variaveis brutas com indices derivados na mesma ACP, porque isso duplica parte da informacao.
- Usar o cluster dos autores apenas para comparar os agrupamentos produzidos em aula.
- Interpretar perfis como peixes magros, gordos e atipicos a partir das cargas e agrupamentos.

### Bano e Takacs (2022) - Morfometria de tres especies de peixes de agua doce

Fonte: Bánó, K.; Takács, P. (2022). *Raw morphometric data of three freshwater fish species*. Mendeley Data / Hydrobiologia. DOI: 10.17632/c8856zg4hj.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / CC BY 4.0.

Dataset principal: `peixes_morfometria_multivariada`, aba `peixes_morfometria_completo1`.

Dataset didatico derivado para AAH: `morfometria_barbo`, aba `morfometria_barbo1`.

Resumo de validacao:

- Fonte local original: `Raw_morphometric_data.xlsx`.
- O bruto trazia duas abas: `variables` e `raw data`.
- A aba `raw data` possui 299 individuos, 3 especies, 15 populacoes e 35 medidas morfometricas, sem valores ausentes.
- O cabecalho bruto das medidas estava inconsistente, com repeticao de `Var07`; por isso os nomes foram reconstruidos usando a aba `variables`.
- A curadoria inicial manteve uma aba limpa completa, com comentarios em portugues nos cabecalhos para substituir a necessidade de abas auxiliares.
- Em 2026-07-09, foi adicionada uma versao didatica enxuta de `Barbus petenyi`, com 100 individuos, 5 populacoes balanceadas e 10 medidas morfometricas corrigidas alometricamente pelo comprimento padrao (SL), para uso direto em AAH.
- A planilha bruta local nao informa os nomes reais dos rios; por isso a coluna `rio` em `morfometria_barbo1` usa rotulos didaticos derivados da populacao (`rio_pop06` a `rio_pop10`), sem inventar toponimos.

Objetivo didatico:

- Trabalhar ACP das medidas morfometricas padronizadas, selecionando em aula o subconjunto desejado a partir da aba completa.
- Fazer AAH de individuos e discutir separacao entre especies e populacoes.
- Fazer AAH introdutoria com `morfometria_barbo1`, usando apenas as dez variaveis quantitativas corrigidas; `populacao` e `rio` entram somente como rotulos externos para interpretar os grupos.
- Fazer AAH das variaveis para discutir redundancia entre medidas corporais.
- Usar heatmap e matrizes de distancia.
- Discutir por que a selecao e o numero de variaveis alteram resultados de analises multivariadas.

### Bennett et al. (2025) - Recifes de ostras e assembleias de peixes

Fonte: Bennett et al. (2025). *Oyster reef structure and fish assemblages dataset*. Zenodo record 19993470.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `fonte_aberta_com_registro` / conferir licenca exata no Zenodo ao publicar.

Dataset principal: `recifes_ostras_heatmap`, aba `recifes_heatmap1`.

Resumo de validacao:

- Fonte local: `MeanCount.NO.hyperabundants.dat.csv`.
- O arquivo local possui 301 linhas e 27 colunas originais.
- A coluna tecnica `Unnamed: 0` foi removida.
- A aba limpa final ficou com 301 linhas e 26 colunas, sem valores ausentes.
- O conjunto combina fatores ecologicos (`sitio`, `zona_recife`, `estacao`, `ano`) com variaveis numericas de habitat e assembleia.

Objetivo didatico:

- Heatmap por `zona_recife`, `estacao` ou `sitio`.
- Correlacao entre estrutura do habitat e metricas da assembleia de peixes.
- ACP exploratoria com variaveis numericas selecionadas.
- Comparacao entre grupos ecologicos com interpretacao aplicada.
- Discussao metodologica sobre repeticao de metricas estruturais do mesmo recife em levantamentos distintos.

### Bagley et al. (2022) - Relacao comprimento-peso de peixes neotropicais

Fonte: Bagley, J. C., Breitman, M. F., & Johnson, J. B. (2022). *Length-weight relation for seven Neotropical freshwater fish species (Actinopterygii) endemic to Central America*. Acta Ichthyologica et Piscatoria 52(3): 183-187. https://doi.org/10.3897/aiep.52.86467. Dataset: Mendeley Data. DOI: 10.17632/kphrvvgwwz.1.

Arquivo curado preferido: `provisorios/bagley_2022_lwr_clean.xlsx` (versao limpa para ANCOVA).

Status: `publico_aberto` / CC BY 4.0 (revista Pensoft open access).

Dataset principal: `bagley_lwr_central_america`, aba `bagley_lwr_ancova`.

Resumo de validacao:

- Fonte local: `Bagley_et_al_2022_DataS1.xlsx` (arquivo bruto original; 308 linhas x 45 colunas, muitas vazias).
- O arquivo bruto tem cabecalho na primeira linha de dados; colunas posicionais (indices 0, 3, 4, 5, 6, 12, 13, 15, 16, 17, 18, 19).
- Valores problematicos tratados: peso com `D` (damaged/destruido) convertido para NA; `–` (dash) em SL, TL, sexo e nadadeiras convertidos para NA.
- Dataset limpo: 306 individuos com peso e comprimento padrao (SL) completos, 9 especies, 3 paises.
- Especies e tamanhos: Alfaro cultratus (n=101), Priapichthys annectens (n=69), Poecilia gillii (n=47), Phallichthys amates (n=44), Parachromis dovii (n=22), Atherinella hubbsi (n=13), Parachromis managuensis (n=7), Poecilia sp. (n=2), Atherinella sp. (n=1).
- Faixa de peso: 0.0182 a 23.691 g. Faixa de SL: 11.11 a 96.8 mm.
- Variaveis transformadas para ANCOVA: `log_peso_g` e `log_sl_mm` (logaritmo natural).
- Variaveis categóricas disponiveis: `especie`, `pais`, `localidade`, `sexo`, `nadadeira_dorsal`, `nadadeira_caudal`.
- Sexo determinado em apenas parte dos individuos (muitos NA); nadadeiras dorsal/caudal com anotacoes morfologicas esparsas.

Objetivo didatico:

- ANCOVA classica: `log(peso_g) ~ log(comprimento_padrao_mm) + especie + log(comprimento_padrao_mm):especie`.
- Testar homogeneidade de slopes (interacao) entre especies: o exponente b da relacao peso-comprimento difere?
- Se slopes homogeneos, comparar interceptos ajustados: qual especie tem maior `log(a)` para um mesmo comprimento?
- Teste de isometria (H0: b = 3) para cada especie, reproduzindo a analise do artigo original.
- Discussao de crescimento alometrico (b > 3, peixe mais alto que longo) vs isometrico (b = 3).
- Interpretacao em biologia pesqueira: LWR como ferramenta para estimativa de biomassa em campo.
- Extensao possivel: usar `pais` como fator adicional (ANOVA fatorial) ou como bloco, discutindo efeito de latitude/localidade.

Cuidados:

- Desequilibrio severo de tamanho entre especies (n varia de 1 a 101). Para aula introdutoria, recomenda-se filtrar especies com n >= 10 (7 especies, 301 individuos) ou ate n >= 20 (5 especies, 283 individuos).
- `Atherinella sp.` e `Poecilia sp.` sao identificacoes incertas; podem ser agrupadas ou removidas.
- A variavel `sexo` tem muitos valores ausentes; nao e confiavel para analise estratificada completa.
- O artigo original remove outliers antes da regressao; o dataset didatico pode incluir ou excluir outliers, com discussao sobre o criterio de Froese (2006).
- A transformacao log-linear e obrigatoria para ANCOVA; dados brutos (peso x comprimento) seguem relacao potencial, nao linear.

### Malyenge (2025) - Lagosta-vermelha da costa oeste em florestas de kelp na Namibia

Fonte: Malyenge, S. (2025). *Abundance, Size Structure, and Sex Ratio Variation of West Coast Rock Lobster (Jasus lalandii) in Cultivated and Natural Kelp Forests off Luderitz, Namibia*. Mendeley Data. DOI: 10.17632/y4vc857g9y.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / CC BY 4.0.

Dataset principal: `lagosta_namibia_malyenge_2025`, aba `lagosta_namibia1`.

Resumo de validacao:

- Fonte local original: `provisorios/malyenge_2025_lobster_mendeley/Lobster Log sheet.xlsx`.
- Foram usadas as abas mensais oficiais: setembro/2024, outubro/2024, dezembro/2024, janeiro/2025, marco/2025 e abril/2025.
- As abas de teste, normalidade, graficos, `MANUSCRIPT DATA`, `Combined` e os testes preliminares de junho/agosto nao foram usadas como dados analiticos principais.
- A aba limpa possui 1457 lagostas individuais e 18 variaveis.
- Unidade observacional: lagosta individual amostrada em armadilha.
- Totais por mes e sitio conferidos contra a aba `Combined`, todos batendo.
- Existe uma discrepancia interna na propria fonte em setembro/SWB: `Combined` informa total 167, mas seu resumo por sexo soma 166; a base individual contem 101 machos e 66 femeas. A curadoria preservou os dados individuais.
- Datas de dezembro foram corrigidas pelo contexto da aba mensal, pois algumas celulas foram interpretadas pelo Excel como 2024-06-12 quando o registro pretendido e 06/12/2024.
- Valores ausentes esperados: profundidade so aparece em dezembro; coordenadas e maturidade reprodutiva estao ausentes em parte das linhas.

Objetivo didatico:

- Comparar estrutura de tamanho de *Jasus lalandii* entre sitios, meses e sexos.
- Modelo sugerido: `comprimento_cefalotorax_mm ~ sitio * sexo + mes_nome`.
- Tabelas de contingencia e qui-quadrado para razao sexual por sitio/mes.
- Descritiva e visualizacao de distribuicao de comprimento por sitio e mes.
- Possivel extensao: regressao logistica de `sexo` ou classificacao de maturidade quando houver anotacao reprodutiva.

Cuidados:

- As covariaveis ambientais sao repetidas por evento de amostragem/sitio, nao por individuo independente.
- O efeito de armadilha pode gerar dependencia; para analise mais cuidadosa, considerar armadilha ou evento de coleta como agrupamento.
- `DIAZ` e `SWB` foram mantidos como codigos de sitio, sem inventar equivalencia entre sitio e tipo de floresta de kelp quando a planilha bruta nao declara explicitamente a correspondencia.

### Ropke et al. (2025) - Dieta de grandes bagres do rio Madeira

Fonte: Ropke, C.; Zuanon, J. A. S.; Fonseca, M.; Lima, M. A.; Sant'Anna, I.; Gunther, H.; Torrente-Vilara, G.; Doria, C. (2025). *Data for: Diet of large Catfishes from Madeira River*. Mendeley Data. DOI: 10.17632/b7kwsyzmyf.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / CC BY 4.0.

Dataset principal: `bagres_dieta_madeira_ropke_2025`, aba `bagres_dieta_madeira1`.

Resumo de validacao:

- Fonte local original: `provisorios/ropke_2025_bagres_madeira_mendeley/diet of large catfishes from Madeira River_mendeley data.csv`.
- A base bruta possui 315 estomagos de grandes bagres, 95 colunas e 85 colunas de itens alimentares.
- A leitura correta do CSV exige separador `;` e encoding `MacRoman`; em `cp1252` nomes como `Babao` aparecem corrompidos.
- A aba limpa possui 315 linhas e 25 variaveis.
- Unidade observacional: estomago de peixe predador com conteudo alimentar.
- Oito especies de grandes bagres foram preservadas: *Brachyplatystoma vaillantii*, *B. rousseauxii*, *B. filamentosum*, *B. platynemum*, *Pseudoplatystoma punctifer*, *P. tigrinum*, *Pinirampus pirinampu* e *Zungaro zungaro*.
- Os 85 itens alimentares originais foram agrupados em seis grupos troficos didaticos: peixe nao identificado, restos de peixe, ordens de peixes, familias/subfamilias de peixes, peixes identificados e invertebrados.
- Tres estomagos tinham soma original diferente de 100%: 99,99; 180; 478. Para manter uma matriz composicional usavel em aula, os volumes foram reescalonados proporcionalmente para soma 100%, mantendo `volume_total_original_pct` e `volume_reescalonado_100` na aba limpa.
- Ausencias relevantes: 58 em `comprimento_padrao_cm` e 50 em `peso_g`; as variaveis de dieta agrupada nao possuem ausencias.

Objetivo didatico:

- Servir como atividade de consolidacao com dados amazonicos reais.
- Comparar composicao da dieta entre especies de grandes bagres e entre periodos hidrologicos.
- Testar associacao entre especie, periodo hidrologico e item dominante.
- Explorar ACP/AAH com os seis grupos troficos, discutindo que dados composicionais exigem cuidado interpretativo.
- Modelo sugerido: `volume_peixes_identificados_pct ~ especie_predador + periodo_hidrologico`.

Cuidados:

- Os valores alimentares sao proporcoes/volumes relativos, portanto as colunas de dieta sao composicionais e somam 100%.
- O agrupamento taxonomico e uma adaptacao didatica; para reproducao fiel do artigo, usar o CSV bruto com os 85 itens originais.
- `volume_reescalonado_100` deve ser usado para discutir limpeza de dados e diferenca entre preservar o bruto e criar uma versao didatica analisavel.
- O conjunto e especialmente adequado para avaliacao/consolidacao porque tem contexto amazonico, multiplas especies, sazonalidade hidrologica e variaveis de dieta.

### Reid / FSAdata - Percina-do-canal em dois rios de Ontario

Fonte: `FSAdata::DarterOnt`, documentado em FishR/FSAdata. Dados reconstruidos a partir da Figura 2 de Reid (2004), artigo DOI: 10.1080/02705060.2004.9664917.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / pacote FSAdata GPL-2 ou GPL-3.

Dataset principal: `darter_ontario_fsa_reid_2004`, aba `darter_ontario1`.

Resumo de validacao:

- Fonte local original: `provisorios/fsa_darter_ontario/DarterOnt.csv`.
- O bruto possui 54 observacoes e tres variaveis originais: `age`, `tl` e `river`.
- A aba limpa possui 54 peixes individuais e quatro variaveis: `id_peixe`, `idade_anos`, `comprimento_total_mm` e `rio`.
- Rios: Salmon (n = 21) e Trent (n = 33).
- Idades: 1 ano (n = 2), 2 anos (n = 16), 3 anos (n = 24), 4 anos (n = 11), 5 anos (n = 1).
- Sem valores ausentes e sem duplicatas completas.
- Medianas de idade: Salmon = 2 anos; Trent = 3 anos.
- Validacao didatica do Mann-Whitney: U menor = 233; ha muitos empates nas idades, portanto usar aproximacao com `exact = FALSE` em R.

Objetivo didatico:

- Teste de Mann-Whitney para comparar a distribuicao das idades entre dois grupos independentes.
- Modelo/formula sugerida: `idade_anos ~ rio`.
- Em R: `wilcox.test(idade_anos ~ rio, data = darter_ontario, exact = FALSE)`.
- Discutir que Mann-Whitney trabalha com postos e nao deve ser apresentado simplesmente como teste de medias.

Cuidados:

- A idade e discreta e possui poucos valores possiveis, gerando empates nos postos.
- A interpretacao em termos de mediana so e segura se as distribuicoes tiverem formatos semelhantes.
- Comprimento e idade nao devem ser misturados em um unico teste simples; comparar comprimento entre rios pode ser confundido por composicao etaria.
- A pesca eletrica pode subamostrar individuos menores e mais jovens.

### Parker et al. / FSAdata - Trutas-touro antes e depois de restricoes de pesca

Fonte: `FSAdata::BullTroutRML1`, documentado em FishR/FSAdata. Dados de aproximadamente a Figura 2 de Parker, B. R.; Schindler, D. W.; Wilhelm, F. M.; Donald, D. B. (2007). *Bull trout population responses to reductions in angler effort and retention limits*. North American Journal of Fisheries Management, 27(3), 848-859. DOI: 10.1577/M06-051.1.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / pacote FSAdata GPL-2 ou GPL-3.

Dataset principal: `truta_touro_manejo`, aba `truta_touro_manejo`.

Resumo de validacao:

- Fonte local original: `provisorios/fsa_truta_touro_manejo/BullTroutRML1.csv`.
- O bruto possui 137 observacoes e tres variaveis originais: `fl`, `mass` e `era`.
- A aba limpa possui 137 trutas-touro individuais e quatro variaveis: `id_peixe`, `comprimento_furcal_mm`, `massa_umida_g` e `periodo_coleta`.
- Grupos independentes: 1977-79 (n = 27) e 2001 (n = 110).
- Sem valores ausentes, valores biologicamente impossiveis ou duplicatas completas.
- A atividade autonoma deve usar `comprimento_furcal_mm` como resposta e `periodo_coleta` como agrupamento.
- Validacao interna: mediana de 411 mm em 1977-79 e 313 mm em 2001; U menor = 756,5. Ha empates, portanto usar a aproximacao com `exact = FALSE`.

Objetivo didatico:

- Atividade autonoma de Mann-Whitney e estatistica descritiva aplicada a manejo pesqueiro.
- Formula sugerida: `comprimento_furcal_mm ~ periodo_coleta`.
- Em R: `wilcox.test(comprimento_furcal_mm ~ periodo_coleta, data = truta_touro_manejo, exact = FALSE)`.
- Trabalhar boxplot, histograma/densidade, IQR, valores extremos e diferenca entre significancia estatistica e interpretacao biologica.

Cuidados:

- Os dados sao de grupos independentes, nao de peixes acompanhados antes e depois.
- A base FSAdata foi reconstruida aproximadamente de uma figura e nao inclui identificador do lago; nao e possivel separar efeito de lago, de amostragem ou de outras mudancas temporais.
- Uma diferenca entre periodos e uma associacao temporal; por si so, nao demonstra que a regulamentacao causou a mudanca.
- Maior frequencia de peixes pequenos pode refletir recrutamento, estrutura etaria, seletividade de captura, ambiente, densidade ou outros processos; nao e um indicador automatico de pior condicao populacional.
- O enunciado completo da atividade esta em `provisorios/fsa_truta_touro_manejo/atividade_autonoma_truta_touro_manejo.md`.

### McBride, Hendricks e Olney / FSAdata - Repetibilidade da idade do savel-americano

Fonte: `FSAdata::ShadCR`, documentado em FishR/FSAdata. McBride, R. S.; Hendricks, M. L.; Olney, J. E. (2005). *Testing the validity of Cating's (1953) method for age determination of American Shad using scales*. Fisheries, 30(10), 10-18. DOI: 10.1577/1548-8446(2005)30[10:TTVOCM]2.0.CO;2.

Arquivo curado preferido: `dados_organizados_limpos_para_pacote_aulas.xlsx`

Status: `publico_aberto` / pacote FSAdata GPL-2 ou GPL-3.

Dataset principal: `idades_savel_repetibilidade`, aba `idades_savel_repetibilidade`.

Resumo de validacao:

- Fonte local original: `provisorios/fsa_idades_savel/ShadCR.csv`.
- O bruto possui 53 observacoes e oito variaveis: identificador, idade verdadeira e duas leituras para cada um dos leitores A, B e C.
- A aba limpa preserva as 53 linhas e oito variaveis, usando os nomes `fish_id`, `true_age`, `reader_a_1`, `reader_a_2`, `reader_b_1`, `reader_b_2`, `reader_c_1` e `reader_c_2`.
- Ausencias esperadas por leitor: A = 2 em cada leitura; B = 20 em cada leitura; C = 1 em cada leitura.
- Pares completos: leitor A = 51, B = 33 e C = 52. Nao ha identificadores duplicados nem idades negativas ou nao inteiras.
- Para o leitor A, ha 26 diferencas nulas em 51 pares completos; a concordancia exata e 51,0%. Empates e diferencas nulas exigem o uso de `exact = FALSE`.

Objetivo didatico:

- Teste de Wilcoxon pareado para avaliar se um leitor apresenta diferenca sistematica entre duas leituras das mesmas escamas.
- Comparacao inicial sugerida: `reader_a_2 - reader_a_1`.
- Em R: `wilcox.test(reader_a_2, reader_a_1, paired = TRUE, exact = FALSE)`.
- Estender para concordancia exata, distribuicao das diferencas, graficos de pares, tabela cruzada e comparacao com a idade verdadeira.

Cuidados:

- O pareamento decorre do `fish_id`: as duas leituras pertencem ao mesmo peixe e ao mesmo leitor. Nao basta que duas colunas tenham o mesmo numero de linhas.
- Cada comparacao deve excluir apenas os pares incompletos daquela combinacao; uma ausencia do leitor B nao exclui o peixe da analise do leitor A ou C.
- Uma diferenca nao significativa nao demonstra concordancia perfeita. Repetibilidade, vies e acuracia em relacao a `true_age` sao conceitos distintos.
- O pressuposto relevante do Wilcoxon pareado e a simetria aproximada das diferencas; se ele for muito inadequado, discutir o teste dos sinais como alternativa de menor poder.
- O enunciado da atividade esta em `provisorios/fsa_idades_savel/atividade_wilcoxon_pareado_idades_savel.md`.

### Polat, Bostanci e Yilmaz / FSAdata - Otolitos inteiros versus quebrados e queimados

Fonte: `FSAdata::MulletBS`. Polat, N.; Bostanci, D.; Yilmaz, S. (2005). *Differences between whole otolith and broken-burnt otolith ages of red mullet (Mullus barbatus ponticus Essipov, 1927) sampled from the Black Sea (Samsun, Turkey)*. Turkish Journal of Veterinary and Animal Science, 29, 429-433.

Destino: atividade autonoma em Excel, no arquivo `atividade_wilcoxon_otolitos.xlsx`. Este conjunto nao entra no EAPADados, pois o `ShadCR` ja oferece uma versao mais rica da mesma ideia didatica.

Resumo de validacao:

- O bruto possui 51 pares de idade: `whole` e `bb`.
- O Excel criado possui as abas `Dados` e `Contexto_Dicionario`.
- A aba `Dados` tem 51 peixes, sem ausencias, com `fish_id` sequencial criado apenas para visualizar o pareamento, `whole_otolith_age` e `broken_burnt_age`.
- A unidade amostral e o peixe individual; as idades sao dependentes porque os dois metodos foram aplicados ao mesmo peixe.
- A variavel `diferenca = broken_burnt_age - whole_otolith_age` deve ser criada pelo aluno como parte da atividade.

Objetivo didatico:

- Aplicar o Wilcoxon pareado para investigar diferenca sistematica entre dois metodos de preparacao/leitura de otolitos.
- Em R: `wilcox.test(broken_burnt_age, whole_otolith_age, paired = TRUE, exact = FALSE)`.
- Discutir concordancia exata, direcao das diferencas, relevancia biologica e consequencias de subestimar a idade de peixes mais velhos em avaliacao de estoque.

### Keenlyne e Maxwell / FSAdata - Tamanho de esturjoes-palidos em quatro regioes

Fonte: `FSAdata::Pallid`. Keenlyne, K. D.; Maxwell, S. J. (1993). *Length conversions and length-weight relations for pallid sturgeon*. North American Journal of Fisheries Management, 13, 395-397.

Destino: atividade autonoma em Excel, no arquivo `atividade_kruskal_esturjao_palido.xlsx`. Nao incluir na planilha-mae EAPADados.

Resumo de validacao:

- A fonte possui 30 peixes e sete variaveis: data, comprimentos padrao/furcal/total, massa, condicao e local.
- O Excel possui as abas `Dados` e `Contexto_Dicionario`, sem valores ausentes ou medidas invalidas.
- Grupos independentes: NB = 4, SD = 8, ND = 7 e MT = 11.
- A resposta principal e `total_length_mm`; `location` e a variavel de agrupamento.

Objetivo didatico:

- Aplicar Kruskal-Wallis para comparar a distribuicao do comprimento total em quatro locais de coleta.
- Em R: `kruskal.test(total_length_mm ~ location, data = dados)`.
- Se o teste global for significativo, realizar comparacoes pos-hoc pareadas com correcao de Holm e interpretar junto a medianas e graficos.

Cuidados:

- Kruskal-Wallis compara postos e nao identifica os locais diferentes sem pos-teste.
- Os grupos sao independentes, pequenos e desequilibrados; ausencia de significancia nao prova estruturas de tamanho identicas.
- Local e uma associacao observacional, pois data de coleta, idade, recrutamento, epoca do ano e ambiente podem diferir entre grupos.
- Comprimento e massa refletem em grande parte o porte do mesmo peixe e nao devem ser tratados como respostas independentes em uma unica analise simples.

## Fluxo de trabalho recomendado

1. Salvar o bruto sem alteracoes em uma pasta por fonte.
2. Criar uma versao curada tidy com nomes em `snake_case` ASCII.
3. Criar/atualizar `Dicionario`, `Variaveis` e, quando preciso, `Dicionario_valores`.
4. Registrar fonte, licenca, pagina/tabela/URL e decisao de uso.
5. Validar tipos, ausentes, duplicatas, unidades, fatores e valores impossiveis.
6. Decidir se o dataset e de analise ou de treino de arrumacao.
7. Para pacote R, gerar `data-raw/<nome>.R`, `data/<nome>.rda` e `R/data_<nome>.R`.
8. Para avaliacao, garantir que os dados sejam reais e diferentes dos exemplos do pacote/livro.

## Template de descricao curta

```markdown
## nome_dataset

Conjunto de dados sobre [tema], obtido de [fonte]. A unidade observacional e [unidade]. O objetivo didatico e permitir [analise principal], com discussao aplicada sobre [interpretacao em Engenharia de Pesca].

### Pergunta didatica
[Pergunta clara.]

### Variavel resposta principal
[Nome, unidade e significado.]

### Fatores/covariaveis
[Tratamentos, grupos, blocos, covariaveis.]

### Analises sugeridas
- [analise 1]
- [analise 2]
- [analise 3]

### Cuidados
[Licenca, pseudorrepeticao, ausentes, transformacao, limitacao.]
```

## Proximas acoes

- Validar as tabelas do Excel Bhujel contra as paginas do PDF.
- Preparar e-mail de autorizacao para Bhujel/Wiley antes de qualquer redistribuicao publica.
- Separar datasets Bhujel em: exemplos internos, candidatos ao livro, candidatos ao pacote apos autorizacao, treino de arrumacao.
- Criar inventario de fontes publicas abertas para substituir ou complementar Bhujel quando o destino for pacote publico.
- Quando novos links chegarem, iniciar pela triagem de licenca e valor didatico antes de limpar os dados.
- **Concluido:** Bagley et al. (2022) curado para ANCOVA; arquivo limpo em `provisorios/bagley_2022_lwr_clean.xlsx`. Proximo passo: integrar ao `dados_organizados_limpos_para_pacote_aulas.xlsx` ou gerar script `data-raw/` para o pacote R.
