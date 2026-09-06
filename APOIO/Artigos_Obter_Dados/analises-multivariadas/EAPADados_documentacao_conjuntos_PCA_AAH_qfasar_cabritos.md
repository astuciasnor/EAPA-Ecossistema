# EAPADados — documentação de conjuntos para PCA e AAH/HCA

**Tema geral:** dados multivariados limpos para ensino de análise exploratória, PCA, agrupamento hierárquico e interpretação contextual em Engenharia de Pesca, Aquicultura, Química Analítica, Ciência Animal e Geociências Aplicadas.  
**Uso previsto:** livro EAPA, pacote `EAPADados` e IDE **CatalyseR**.  
**Versão deste documento:** 2026-06-13.  
**Métodos didáticos principais:** PCA, AAH/HCA, padronização/autoscaling, análise de variáveis, interpretação de grupos e biplots.

---

## Visão geral dos conjuntos recomendados

| Código sugerido no EAPADados | Nome curto | Área | Linhas x variáveis principais | Grupo conhecido | Melhor uso didático |
|---|---|---:|---:|---|---|
| `cabritos_fa_coltro` | Ácidos graxos em carne de cabritos | Ciência Animal / Quimiometria | 32 x 7 | 4 tratamentos dietéticos | PCA + HCA com interpretação biológica clara |
| `qfasar_assinaturas` | Assinaturas de ácidos graxos em predador-presa | Recursos pesqueiros / Ecologia trófica | variável, via pacote `qfasar` | tipos de presas/predadores | PCA/AAH em dados de composição lipídica; ponte para QFASA |
| `brine_carbonatos` | Sais dissolvidos em salmouras de unidades carbonáticas | Geoquímica / Hidroquímica | 19 x 6 | 3 unidades geológicas | PCA/AAH clássico, pequeno e limpo |
| `aquaponia_iot` | Qualidade da água em aquaponia com sensores IoT | Aquicultura / Monitoramento ambiental | 118286 x 5 no repositório original | tempo/condição de água | PCA/AAH após amostragem/filtragem; séries temporais e qualidade de água |

---

# 1. `cabritos_fa_coltro` — Ácidos graxos em carne de cabritos submetidos a dietas com diferentes níveis de energia

## Referência principal

Coltro, W. K. T.; Ferreira, M. M. C.; Macedo, F. A. F.; Oliveira, C. C.; Visentainer, J. V.; Souza, N. E.; Matsushita, M. (2005). **Correlation of animal diet and fatty acid content in young goat meat by gas chromatography and chemometrics**. *Meat Science*, 71(2), 358–363. DOI: `10.1016/j.meatsci.2005.04.016`.

## Contexto do estudo

O estudo avaliou a relação entre a dieta de cabritos jovens e o perfil de ácidos graxos da carne, usando cromatografia gasosa e métodos quimiométricos. Foram utilizados 32 caprinos jovens da raça Saanen, 16 machos e 16 fêmeas, desmamados aos 60 dias, com 75 dias de idade e peso vivo inicial médio de 15,3 kg. Os animais foram divididos em quatro grupos, cada um submetido a uma dieta com nível energético diferente.

As amostras de carne foram retiradas do músculo **Longissimus dorsi** na altura da 11ª costela. Os lipídios foram extraídos pelo método de Folch, Lees e Stanley, convertidos em ésteres metílicos de ácidos graxos e analisados por cromatografia gasosa com detector de ionização em chama. Os dados foram tratados por **análise de agrupamento hierárquico (HCA/AAH)** e **análise de componentes principais (PCA)**.

## Problema científico

A pergunta central era verificar se alterações nos níveis energéticos das dietas, mantendo dietas isoproteicas, modificariam o perfil de ácidos graxos da carne de cabritos. O estudo também avaliou se PCA e HCA seriam capazes de discriminar os quatro tratamentos dietéticos com base na composição lipídica da carne.

## Objetivo do estudo

Estudar a relação entre o conteúdo de ácidos graxos da carne caprina e quatro tratamentos dietéticos, usando cromatografia gasosa, PCA e HCA, para identificar qual dieta produziria carne com perfil lipídico mais favorável.

## Delineamento e grupos

| Tratamento | Amostras | n | Energia metabolizável (MJ/kg) | Característica geral da dieta |
|---|---:|---:|---:|---|
| T1 | 1–8 | 8 | 9,60 | maior proporção de feno de aveia; menor energia |
| T2 | 9–16 | 8 | 10,40 | energia intermediária baixa |
| T3 | 17–24 | 8 | 11,60 | energia intermediária alta |
| T4 | 25–32 | 8 | 12,40 | maior proporção de milho moído; maior energia |

## Unidade experimental

Cada linha representa uma amostra de carne de um animal. No artigo, cada entrada da matriz corresponde à média de três repetições analíticas.

## Dicionário de variáveis

| Variável original | Nome sugerido no EAPADados | Descrição | Unidade/escala | Tipo |
|---|---|---|---|---|
| `sample` | `amostra` | Identificador da amostra, de 1 a 32 | código | categórica/ID |
| `treatment` | `tratamento` | Grupo dietético: T1, T2, T3 ou T4 | fator | categórica |
| `energy_mj_kg` | `energia_mj_kg` | Energia metabolizável da dieta | MJ/kg | numérica |
| `n_3` | `n3` | Ácidos graxos ômega-3 totais | % dos ácidos graxos totais | numérica |
| `n_6` | `n6` | Ácidos graxos ômega-6 totais | % dos ácidos graxos totais | numérica |
| `n_6_n_3` | `n6_n3` | Razão entre ômega-6 e ômega-3 | razão | numérica |
| `SFA` | `sfa` | Ácidos graxos saturados | % dos ácidos graxos totais | numérica |
| `MUFA` | `mufa` | Ácidos graxos monoinsaturados | % dos ácidos graxos totais | numérica |
| `PUFA` | `pufa` | Ácidos graxos poli-insaturados | % dos ácidos graxos totais | numérica |
| `PUFA_SFA` | `pufa_sfa` | Razão entre PUFA e SFA | razão | numérica |

## Observações importantes para documentação

- O conjunto é excelente para ensino porque é pequeno, limpo, balanceado e já foi usado no próprio artigo para PCA e HCA.
- As variáveis são composicionais ou razões derivadas de composição de ácidos graxos. Para uso introdutório, a padronização por z-score/autoscaling é suficiente; para discussões avançadas, pode-se introduzir a natureza composicional dos dados.
- O estudo mostrou separação clara dos tratamentos por HCA e PCA.
- O artigo relata que PC1 explicou 72,15% da variância e PC2 explicou 23,78%, totalizando aproximadamente 95,92% nas duas primeiras componentes.
- A interpretação principal foi que o tratamento 4 apresentou maior MUFA e n-3, menor razão n-6:n-3 e menor SFA, sendo considerado o perfil mais interessante do ponto de vista nutricional.

## Dados originais — versão organizada para EAPADados

```csv
amostra,tratamento,energia_mj_kg,n3,n6,n6_n3,sfa,mufa,pufa,pufa_sfa
1,T1,9.60,0.2641,3.7498,14.1964,50.8125,41.5846,7.6029,0.1496
2,T1,9.60,0.2686,3.7584,13.9931,50.9835,41.5317,7.4848,0.1468
3,T1,9.60,0.2534,3.7288,14.7119,51.2187,41.1364,7.6448,0.1493
4,T1,9.60,0.2646,3.8066,14.3885,50.1781,41.9751,7.8568,0.1538
5,T1,9.60,0.2674,3.7707,14.1003,51.4442,41.1296,7.4348,0.1445
6,T1,9.60,0.2647,3.7492,14.1617,51.7418,40.8164,7.4419,0.1439
7,T1,9.60,0.2615,3.7110,14.1934,49.6910,42.6104,7.6985,0.1549
8,T1,9.60,0.2574,3.7667,14.4064,50.8604,41.5824,7.5574,0.1486
9,T2,10.40,0.3082,3.6688,11.9032,50.1596,44.7324,5.1079,0.1018
10,T2,10.40,0.3028,3.6869,12.1748,51.0211,43.7937,5.1851,0.1016
11,T2,10.40,0.2986,3.6462,12.2127,50.1743,44.7181,5.1076,0.1018
12,T2,10.40,0.3088,3.6534,11.8326,50.3315,44.5703,5.0982,0.1013
13,T2,10.40,0.3152,3.6755,11.6604,48.7372,46.3307,4.9321,0.1012
14,T2,10.40,0.2974,3.6462,12.2594,49.1212,45.6885,5.1902,0.1057
15,T2,10.40,0.3036,3.6621,12.0602,50.3380,45.4279,4.2341,0.1040
16,T2,10.40,0.2935,3.6486,12.4330,49.8098,44.9126,5.2776,0.1060
17,T3,11.60,0.3265,3.5218,10.4667,53.7498,41.1561,5.0964,0.0948
18,T3,11.60,0.3381,3.4948,10.3354,53.3053,41.5914,5.1033,0.0957
19,T3,11.60,0.3414,3.5198,10.3096,53.5173,41.4064,5.0761,0.0948
20,T3,11.60,0.3352,3.5109,10.4754,52.8601,41.9989,5.1410,0.0973
21,T3,11.60,0.3368,3.5314,10.4853,52.3581,42.5652,5.0767,0.0970
22,T3,11.60,0.3367,3.5224,10.4602,53.2827,41.6098,5.1076,0.0959
23,T3,11.60,0.3361,3.4972,10.4059,53.7520,41.1832,5.0647,0.0942
24,T3,11.60,0.3414,3.5098,10.2802,53.5173,41.4064,5.0761,0.0949
25,T4,12.40,0.3506,3.1983,9.1235,42.7332,52.4618,4.8050,0.1124
26,T4,12.40,0.3525,3.2163,9.1247,42.8315,52.3111,4.8574,0.1134
27,T4,12.40,0.3496,3.2131,9.1909,42.4186,52.7001,4.8813,0.1151
28,T4,12.40,0.3468,3.2200,9.2858,42.3136,53.1051,4.5812,0.1083
29,T4,12.40,0.3527,3.2172,9.1216,43.1662,51.8315,5.0023,0.1159
30,T4,12.40,0.3475,3.2290,9.2916,42.8412,52.1960,4.9628,0.1158
31,T4,12.40,0.3517,3.1981,9.0936,42.0623,53.1285,4.8092,0.1143
32,T4,12.40,0.3536,3.2090,9.0741,42.4960,52.6710,4.8329,0.1137
```

## Sugestões de exercícios para alunos

1. Padronizar as sete variáveis químicas e realizar PCA.
2. Reproduzir a interpretação geral do artigo: verificar se PC1 separa T1 e T4.
3. Gerar biplot e identificar quais variáveis explicam a posição de T1 e T4.
4. Fazer HCA com distância euclidiana e método de Ward.
5. Comparar agrupamentos obtidos com os quatro tratamentos conhecidos.
6. Discutir por que dados de composição lipídica são bons exemplos para análise multivariada.
7. Comparar os resultados com recomendações nutricionais: menor SFA, menor n-6:n-3 e maior n-3.

## Texto curto para o livro EAPA

Este conjunto mostra como a análise multivariada pode transformar uma tabela de composição química em uma interpretação biológica. Cada amostra representa a carne de um cabrito submetido a um dos quatro tratamentos dietéticos. As variáveis resumem grandes classes de ácidos graxos e razões nutricionalmente relevantes. A PCA permite visualizar a separação entre tratamentos e associar essa separação às variáveis que mais contribuem para o padrão observado. A AAH/HCA complementa a PCA ao mostrar se as amostras se agrupam naturalmente de acordo com as dietas. Assim, o conjunto é ideal para introduzir a integração entre cromatografia, química de alimentos, ciência animal e quimiometria.

---

# 2. `qfasar_assinaturas` — Assinaturas de ácidos graxos para inferência de dieta de predadores

## Referência principal

Bromaghin, J. F. (2016). **qfasar: Quantitative Fatty Acid Signature Analysis in R**. U.S. Geological Survey data release. DOI: `10.5066/F71G0JC9`.

Referência metodológica associada:  
Bromaghin, J. F. (2017). **QFASAR: Quantitative fatty acid signature analysis with R**. *Methods in Ecology and Evolution*.

Referência clássica de QFASA:  
Iverson, S. J.; Field, C.; Bowen, W. D.; Blanchard, W. (2004). **Quantitative fatty acid signature analysis: A new method of estimating predator diets**. *Ecological Monographs*, 74, 211–235.

## Contexto do estudo/pacote

O QFASA é uma abordagem usada para estimar a composição da dieta de predadores a partir de assinaturas de ácidos graxos. A assinatura de ácidos graxos é um vetor de proporções que descreve a composição de ácidos graxos em lipídios de tecidos. Para estimar a dieta, são necessárias assinaturas de um ou mais predadores, assinaturas de presas potenciais e coeficientes de calibração que ajustam diferenças metabólicas entre presa e predador.

## Por que é importante para Engenharia de Pesca

Este conjunto é especialmente adequado para o livro EAPA e para o EAPADados porque conecta análise multivariada com temas centrais de recursos pesqueiros: dieta, relações predador-presa, ecologia trófica, biomarcadores lipídicos, composição de tecidos e inferência ecológica. É um exemplo mais alinhado à área de Pesca do que o conjunto geológico, mantendo a mesma estrutura didática: amostras nas linhas, variáveis químicas nas colunas e grupos biológicos como fator.

## Possibilidade de incorporação ao EAPADados

O pacote `qfasar` é distribuído como software/dados do USGS e a documentação do CRAN informa licença **Unlimited**. Assim, é tecnicamente viável incorporar exemplos derivados ou subconjuntos didáticos no EAPADados, desde que sejam mantidos os créditos ao autor, ao USGS e às referências metodológicas.

A forma mais segura de incorporação é:

1. manter uma função no EAPADados que importe os dados a partir do pacote `qfasar`, quando instalado;
2. ou incluir um subconjunto processado, com metadados completos e citação explícita;
3. registrar no `DESCRIPTION` do EAPADados que o conjunto foi derivado/adaptado de `qfasar`, com DOI do USGS.

## Estrutura esperada dos dados

| Campo | Descrição |
|---|---|
| `type` | tipo biológico: espécie de presa ou classe de predador |
| `id` | identificador da amostra/assinatura |
| colunas de ácidos graxos | proporções ou percentuais de ácidos graxos |
| metadados opcionais | tecido, local, espécie, sexo, idade, ano, grupo ecológico |

## Uso didático recomendado

Para PCA/AAH, o ideal é trabalhar inicialmente com um subconjunto de assinaturas de presas, em que cada linha representa uma amostra e as colunas representam ácidos graxos. A PCA pode mostrar se espécies de presas apresentam assinaturas lipídicas distintas. A AAH pode mostrar agrupamentos de presas com composição semelhante. Em uma etapa mais avançada, pode-se apresentar a lógica QFASA, em que a assinatura do predador é modelada como mistura das assinaturas de presas.

## Código-base para integração no EAPADados

```r
# Exemplo conceitual para futura função do EAPADados
# install.packages("qfasar") # ou instalar do CRAN Archive, se necessário
library(qfasar)

data(package = "qfasar")

# Após verificar os nomes exatos dos objetos de dados disponíveis:
# eapadados_qfasar <- algum_objeto_do_qfasar
# eapadados_qfasar <- tibble::as_tibble(eapadados_qfasar)
```

## Sugestões de exercícios

1. Selecionar apenas amostras de presas e aplicar PCA sobre as proporções de ácidos graxos.
2. Verificar se espécies/tipos de presas se agrupam por composição lipídica.
3. Comparar PCA com AAH usando distância euclidiana sobre dados padronizados.
4. Discutir a diferença entre usar dados em porcentagem e dados transformados para análise composicional.
5. Introduzir o conceito de assinatura de ácidos graxos como biomarcador ecológico.
6. Apresentar o QFASA como extensão: estimar dieta de predadores por mistura de assinaturas.

## Texto curto para o livro EAPA

As assinaturas de ácidos graxos representam uma aplicação elegante da química analítica em ecologia pesqueira. Como diferentes presas apresentam composições lipídicas distintas, a composição de ácidos graxos dos tecidos de um predador pode carregar informação sobre sua dieta. Antes de aplicar modelos específicos como QFASA, a PCA e a AAH permitem explorar a estrutura das assinaturas, identificar agrupamentos de presas e reconhecer quais ácidos graxos contribuem para a separação entre grupos. Este conjunto é especialmente útil para mostrar aos estudantes que análise multivariada não é apenas uma técnica estatística, mas uma forma de conectar composição química, ecologia trófica e manejo de recursos pesqueiros.

---

# 3. `brine_carbonatos` — Composição química de salmouras de unidades carbonáticas

## Referência principal

Davis, J. C. (2002). **Statistics and Data Analysis in Geology**. 3rd ed. Wiley.  
Dados de apoio: Kansas Geological Survey, arquivo `BRINE.TXT`.

## Contexto do estudo

O conjunto contém concentrações iônicas de salmouras/águas de formação associadas a três unidades carbonáticas dos Estados Unidos: Ellenburger Dolomite, Grayburg Dolomite e Viola Limestone. As amostras foram recuperadas em testes de poço. Embora não seja um conjunto diretamente de aquicultura ou pesca, ele é um excelente exemplo didático de hidroquímica e geoquímica multivariada.

## Problema científico

A composição química das águas de formação pode refletir processos como interação água-rocha, origem deposicional, mistura de águas e alterações diagenéticas. O problema estatístico é verificar se a composição iônica permite distinguir as unidades geológicas de origem.

## Unidade experimental

Cada linha representa uma amostra de salmoura/água de formação.

## Dicionário de variáveis

| Variável | Descrição | Unidade | Tipo |
|---|---|---|---|
| `amostra` | identificador da amostra | código | ID |
| `grupo` | unidade geológica | E, G ou V | fator |
| `HCO3` | bicarbonato | ppm | numérica |
| `SO4` | sulfato | ppm | numérica |
| `Cl` | cloreto | ppm | numérica |
| `Ca` | cálcio | ppm | numérica |
| `Mg` | magnésio | ppm | numérica |
| `Na` | sódio | ppm | numérica |

## Dados revisados

```csv
amostra,grupo,HCO3,SO4,Cl,Ca,Mg,Na
E01,Ellenburger_Dolomite,10.4,30.0,967.1,95.9,53.7,857.7
E02,Ellenburger_Dolomite,6.2,29.6,1174.9,111.7,43.9,1054.7
E03,Ellenburger_Dolomite,2.1,11.4,2387.1,348.3,119.3,1932.4
E04,Ellenburger_Dolomite,8.5,22.5,2186.1,339.6,73.6,1803.4
E05,Ellenburger_Dolomite,6.7,32.8,2015.5,287.6,75.1,1691.8
E06,Ellenburger_Dolomite,3.8,18.9,2175.8,340.4,63.8,1793.9
E07,Ellenburger_Dolomite,1.5,16.5,2367.0,412.0,95.8,1872.5
G08,Grayburg_Dolomite,25.6,0.0,134.7,12.7,7.1,134.7
G09,Grayburg_Dolomite,12.0,104.6,3163.8,95.6,90.1,3093.9
G10,Grayburg_Dolomite,9.0,104.0,1342.6,104.9,160.2,1190.1
G11,Grayburg_Dolomite,13.7,103.3,2151.6,103.7,70.0,2054.6
G12,Grayburg_Dolomite,16.6,92.3,905.1,91.5,50.9,871.4
G13,Grayburg_Dolomite,14.1,80.1,554.8,118.9,62.3,472.4
V14,Viola_Limestone,1.3,10.4,3399.5,532.3,235.6,2642.5
V15,Viola_Limestone,3.6,5.2,974.5,147.5,69.0,768.1
V16,Viola_Limestone,0.8,9.8,1430.2,295.7,118.4,1027.1
V17,Viola_Limestone,1.8,25.6,183.2,35.4,13.5,161.5
V18,Viola_Limestone,8.8,3.4,289.9,32.8,22.4,225.2
V19,Viola_Limestone,6.3,16.7,360.9,41.9,24.0,318.1
```

## Notas de curadoria

- A versão revisada corrige dois valores em relação à tabela digitada inicialmente: `V18: Cl = 289.9` e `V19: Na = 318.1`.
- Por ser pequeno, o conjunto é ideal para demonstrar como a padronização muda a PCA quando as variáveis estão em escalas diferentes.
- Pode ser usado como exemplo paralelo em aulas de qualidade da água, salinidade, águas subterrâneas, hidroquímica ou poluição ambiental.

## Sugestões de exercícios

1. Aplicar PCA com e sem padronização e comparar os resultados.
2. Identificar quais íons mais contribuem para PC1 e PC2.
3. Fazer HCA e verificar se os grupos geológicos são recuperados.
4. Discutir por que Cl e Na podem dominar a análise se os dados não forem padronizados.
5. Comparar o conjunto com dados de qualidade da água em aquicultura.

---

# 4. `aquaponia_iot` — Qualidade da água em sistema de aquaponia com sensores IoT

## Referência principal

Siswanto, B. (2023). **A Simple Dataset of Aquaponic Fish Pond Water Quality Measurement using Internet of Things devices**. Mendeley Data, Version 2. DOI: `10.17632/yd36bx6f8f.2`.

## Contexto do estudo/dataset

O conjunto contém medições de pH, sólidos dissolvidos totais (TDS) e temperatura da água obtidas por sensores em um sistema de aquaponia. O sistema inclui viveiro de aquicultura e meio hidropônico com técnica de filme de nutrientes (NFT). As medições foram feitas ao longo de três meses, de janeiro a março de 2023, com dados coletados por dispositivos IoT.

## Importância para Aquicultura

A qualidade da água é um dos fatores centrais no manejo de sistemas aquícolas. Em aquaponia, o controle é ainda mais importante porque o sistema integra organismos aquáticos, plantas, microrganismos nitrificantes e recirculação de água. O dataset permite trabalhar monitoramento ambiental, filtragem de dados, séries temporais, classificação de condições adequadas e análise multivariada.

## Dicionário esperado de variáveis

| Variável | Descrição | Unidade/escala | Tipo |
|---|---|---|---|
| `datetime` | data/hora da medição | timestamp | temporal |
| `pH` | potencial hidrogeniônico da água | unidade de pH | numérica |
| `TDS` | sólidos dissolvidos totais | mg/L ou ppm | numérica |
| `temperature` | temperatura da água | °C | numérica |
| `status` ou equivalente | possível classe/filtro de condição | categoria | fator |

## Licença e incorporação

O repositório informa licença **CC BY 4.0**, o que permite reuso, adaptação e redistribuição, desde que haja atribuição adequada. Para o EAPADados, recomenda-se incluir uma versão reduzida e tratada, por exemplo:

- amostra sistemática de 300 a 1000 linhas;
- remoção de duplicatas;
- conversão de data/hora;
- padronização dos nomes de variáveis;
- criação de variáveis auxiliares: hora, dia, semana, turno, faixa de pH, faixa de temperatura.

## Uso didático recomendado

Este conjunto é melhor para uma aula posterior, porque exige decisões de curadoria. Ao contrário dos dados de cabritos e salmouras, que já são tabelas pequenas e prontas, o dataset de aquaponia é grande e temporal. Para PCA/AAH, recomenda-se gerar uma tabela agregada por hora ou por dia, usando médias, desvios-padrão, mínimos e máximos de pH, TDS e temperatura.

## Sugestões de exercícios

1. Importar o dataset e verificar dimensões, tipos de variáveis e valores ausentes.
2. Agregar por dia ou por hora.
3. Fazer PCA usando médias diárias de pH, TDS e temperatura.
4. Usar HCA para agrupar dias semelhantes de qualidade da água.
5. Comparar períodos com maior ou menor estabilidade ambiental.
6. Discutir limites ideais de qualidade da água para organismos cultivados.

## Texto curto para o livro EAPA

Dados de sensores em aquaponia aproximam a estatística multivariada do manejo real de sistemas aquícolas. Em vez de analisar apenas uma variável isolada, como pH ou temperatura, o estudante passa a observar o comportamento conjunto dos parâmetros de qualidade da água. A PCA ajuda a reconhecer padrões gerais de variação, enquanto a AAH permite agrupar períodos semelhantes de funcionamento do sistema. Esse tipo de dado também prepara o estudante para lidar com problemas atuais da aquicultura: monitoramento contínuo, automação, internet das coisas e tomada de decisão baseada em dados.

---

# Proposta de organização no pacote EAPADados

## Objetos de dados sugeridos

| Objeto | Formato | Origem | Status sugerido |
|---|---|---|---|
| `cabritos_fa_coltro` | `data.frame` | tabela do artigo Coltro et al. (2005) | incluir diretamente com citação completa |
| `brine_carbonatos` | `data.frame` | KGS/Davis | incluir diretamente com citação completa |
| `qfasar_assinaturas` | `data.frame` ou função importadora | USGS/qfasar | preferir função importadora ou subconjunto documentado |
| `aquaponia_iot_amostra` | `data.frame` | Mendeley Data | incluir amostra reduzida, citando CC BY 4.0 |

## Estrutura de documentação R sugerida

```r
#' Ácidos graxos em carne de cabritos submetidos a dietas com diferentes níveis de energia
#'
#' Dados de composição de ácidos graxos em 32 amostras de carne caprina,
#' organizadas em quatro tratamentos dietéticos. As variáveis incluem n3, n6,
#' razão n6/n3, SFA, MUFA, PUFA e razão PUFA/SFA. O conjunto foi usado no estudo
#' original para PCA e HCA.
#'
#' @format Um data frame com 32 linhas e 10 colunas.
#' @source Coltro et al. (2005), Meat Science, 71(2), 358–363.
"cabritos_fa_coltro"
```

## Integração com a IDE CatalyseR

Na CatalyseR, estes conjuntos podem aparecer em uma aba de “Dados de exemplo” com filtros por área:

- **Ciência Animal:** `cabritos_fa_coltro`
- **Pesca/Ecologia trófica:** `qfasar_assinaturas`
- **Aquicultura/qualidade da água:** `aquaponia_iot_amostra`
- **Geoquímica/Hidroquímica:** `brine_carbonatos`

Para cada conjunto, a IDE pode exibir:

1. descrição curta;
2. referência bibliográfica;
3. botão “ver dicionário de variáveis”;
4. botão “rodar PCA”;
5. botão “rodar AAH/HCA”;
6. botão “exportar gráfico para relatório”;
7. perguntas-guia para interpretação.

---

# Referências

Bromaghin, J. F. (2016). *qfasar: Quantitative Fatty Acid Signature Analysis in R*. U.S. Geological Survey data release. DOI: `10.5066/F71G0JC9`.

Coltro, W. K. T.; Ferreira, M. M. C.; Macedo, F. A. F.; Oliveira, C. C.; Visentainer, J. V.; Souza, N. E.; Matsushita, M. (2005). Correlation of animal diet and fatty acid content in young goat meat by gas chromatography and chemometrics. *Meat Science*, 71(2), 358–363. DOI: `10.1016/j.meatsci.2005.04.016`.

Davis, J. C. (2002). *Statistics and Data Analysis in Geology*. 3rd ed. Wiley. Dados de apoio: Kansas Geological Survey, `BRINE.TXT`.

Iverson, S. J.; Field, C.; Bowen, W. D.; Blanchard, W. (2004). Quantitative fatty acid signature analysis: A new method of estimating predator diets. *Ecological Monographs*, 74, 211–235.

Siswanto, B. (2023). *A Simple Dataset of Aquaponic Fish Pond Water Quality Measurement using Internet of Things devices*. Mendeley Data, Version 2. DOI: `10.17632/yd36bx6f8f.2`.
