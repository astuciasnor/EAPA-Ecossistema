# Skill — Curadoria, tradução e organização de conjuntos de dados para o Ecossistema EAPA

## 1. Propósito

Esta skill orienta a busca, seleção, extração, tradução, limpeza, documentação e organização de conjuntos de dados para o **Ecossistema EAPA**, especialmente para:

- **EAPADados**: pacote de dados didáticos em português, documentado e reutilizável;
- **CatalyseR**: IDE/aplicativo para análises estatísticas aplicadas;
- **Livro EAPA em Quarto**: exemplos, exercícios e estudos de caso em Engenharia de Pesca, aquicultura, recursos pesqueiros, qualidade de água, tecnologia do pescado e áreas afins.

O objetivo é montar um banco de dados didático, realista e bem documentado, priorizando dados reais, públicos ou autorizados, organizados em planilhas Excel e em formato **tidy**.

---

## 2. Princípios gerais

### 2.1 Priorizar dados reais e aplicados

Dar preferência a conjuntos de dados provenientes de:

- artigos científicos;
- livros didáticos ou técnicos, desde que haja autorização de uso;
- bases públicas oficiais;
- repositórios institucionais;
- pacotes R com dados documentados;
- relatórios técnicos com tabelas claras;
- bancos internacionais de pesca, aquicultura, limnologia, alimento, biodiversidade e meio ambiente.

Dados simulados só devem ser usados quando:

- não houver base real adequada;
- o objetivo pedagógico exigir controle total do exemplo;
- a simulação for explicitamente identificada como tal.

### 2.2 Priorizar valor didático

Um conjunto de dados é bom para o EAPA quando permite ensinar claramente:

- uma pergunta de pesquisa;
- uma estrutura de dados;
- uma técnica estatística;
- uma interpretação biológica, ambiental, produtiva ou tecnológica;
- uma decisão prática em Engenharia de Pesca.

Nem todo dado completo é bom para aula. Pode ser necessário **enxugar** a base, mantendo apenas variáveis úteis e compreensíveis para o objetivo didático.

### 2.3 Respeitar licenças, autoria e autorização

Cada conjunto de dados deve ter status jurídico claro:

- `publico_aberto` — dados públicos com licença compatível;
- `artigo_aberto` — dados publicados em artigo/repositório aberto;
- `livro_com_autorizacao_pendente` — dados extraídos de livro, aguardando autorização;
- `livro_autorizado` — dados de livro com autorização formal;
- `uso_interno_aula` — permitido apenas para uso em aula ou estudo interno;
- `simulado` — dados gerados didaticamente;
- `restrito_nao_incluir` — não incluir no pacote ou livro.

Para dados de livros comerciais, editoras ou artigos sem licença aberta, manter registro de:

- fonte completa;
- páginas/tabelas;
- autor responsável;
- editora/periódico;
- e-mail de autorização enviado;
- resposta do autor/editora;
- escopo autorizado: aula, livro, pacote R, planilha, tradução, adaptação.

### 2.4 Traduzir para português, preservando o sentido técnico

Traduzir nomes de variáveis, descrições e categorias para português sempre que isso melhorar o uso didático.

Manter termos originais quando:

- a tradução gerar ambiguidade;
- o termo for consagrado em inglês;
- a variável for uma sigla técnica amplamente usada, como `SGR`, `FCR`, `DO`, `pH`, `ANCOVA`, `MANOVA`, `PCA`.

Quando necessário, usar duas colunas:

- `variavel` — nome curto em português ou sigla;
- `variavel_original` — nome conforme a fonte.

---

## 3. Estrutura padrão de cada arquivo Excel

Cada conjunto ou grupo de conjuntos deve ser salvo em um arquivo `.xlsx` com múltiplas abas.

### 3.1 Aba `README`

Deve conter informações gerais do arquivo:

| Campo | Conteúdo esperado |
|---|---|
| projeto | EAPADados / EAPA / CatalyseR |
| titulo_arquivo | nome geral do arquivo |
| descricao | descrição geral dos dados |
| fonte_principal | referência completa |
| status_licenca | público, autorizado, pendente etc. |
| uso_recomendado | aula, livro, pacote, teste interno |
| responsavel_curadoria | pessoa ou IA responsável pela organização |
| data_curadoria | data da versão |
| observacoes | limitações e cuidados |

### 3.2 Aba `Dicionario`

A primeira aba analítica deve resumir todos os conjuntos incluídos no arquivo.

Colunas recomendadas:

| Coluna | Descrição |
|---|---|
| id_dataset | identificador curto e estável |
| nome_dataset | nome didático em português |
| nome_original | nome/tabela original, se houver |
| area | aquicultura, pesca, qualidade de água, tecnologia do pescado etc. |
| tema | crescimento, sobrevivência, alimentação, reprodução etc. |
| fonte | referência curta |
| pagina_tabela | página, tabela, figura ou repositório |
| unidade_observacional | peixe, tanque, viveiro, hapa, amostra, lote, fazenda etc. |
| delineamento | DIC, DBC, fatorial, survey, longitudinal etc. |
| variavel_resposta_principal | variável de maior interesse |
| fatores_principais | tratamentos, grupos ou fatores explicativos |
| analises_sugeridas | técnicas estatísticas possíveis |
| nivel_didatico | introdutório, intermediário, avançado |
| status_revisao | bruto, transcrito, revisado, validado |
| status_licenca | aberto, pendente, autorizado, restrito |
| observacoes | cuidados, limitações, decisões de curadoria |

### 3.3 Aba `Variaveis`

Deve funcionar como dicionário de variáveis para todas as abas de dados.

Colunas recomendadas:

| Coluna | Descrição |
|---|---|
| id_dataset | conjunto ao qual a variável pertence |
| variavel | nome padronizado usado na planilha |
| variavel_original | nome na fonte original |
| descricao | significado da variável |
| tipo | numérica, categórica, ordinal, data, texto, lógica |
| unidade | g, kg, %, mg/L, ind/m² etc. |
| papel | resposta, fator, bloco, covariável, identificador, metadado |
| valores_permitidos | níveis ou categorias possíveis |
| transformacao_sugerida | log, sqrt, arcsen, padronização etc. |
| observacoes | notas adicionais |

### 3.4 Abas de dados

Cada conjunto de dados deve ocupar uma aba própria, com nome curto e sem espaços excessivos.

Exemplos:

- `crescimento_tilapia`
- `mortalidade_vitamina`
- `fatorial_proteina_vitc`
- `ancova_ovos_tilapia`
- `pca_lipidios`

Regras:

- uma linha = uma observação;
- uma coluna = uma variável;
- uma célula = um valor;
- não usar células mescladas;
- não usar títulos soltos dentro da tabela;
- não usar notas no meio da base;
- não usar cores como informação essencial;
- nomes de colunas em `snake_case`, sem acento;
- categorias podem estar em português, mas devem ser consistentes;
- valores ausentes devem ser `NA`, vazio controlado ou outro padrão documentado.

---

## 4. Filosofia tidy aplicada ao EAPA

### 4.1 Unidade observacional clara

Antes de arrumar a base, definir qual é a unidade de cada linha:

- peixe individual;
- tanque;
- viveiro;
- hapa;
- amostra de água;
- amostra de músculo;
- semana de avaliação;
- produtor/fazenda;
- tratamento × repetição;
- painelista × amostra, em análise sensorial.

A base só está pronta quando a unidade observacional está explícita.

### 4.2 Evitar pseudorrepetição

Em dados de aquicultura, distinguir:

- peixes individuais como subamostras;
- tanques/viveiros/hapas como unidades experimentais;
- repetições reais;
- blocos espaciais ou temporais.

Quando peixes individuais estiverem dentro de tanques, incluir identificadores como:

- `id_tanque`;
- `id_peixe`;
- `tratamento`;
- `repeticao`.

E documentar se a análise correta deve usar o tanque como unidade experimental.

### 4.3 Dados largos versus tidy

Converter tabelas largas para formato tidy quando houver:

- colunas separadas por tratamento;
- colunas separadas por repetição;
- semanas em colunas;
- variáveis ambientais em blocos separados;
- grupos embutidos no cabeçalho.

Exemplo ruim:

| Rep1_controle | Rep2_controle | Rep1_tratado | Rep2_tratado |
|---|---|---|---|
| 10 | 12 | 15 | 16 |

Exemplo tidy:

| tratamento | repeticao | valor |
|---|---:|---:|
| controle | 1 | 10 |
| controle | 2 | 12 |
| tratado | 1 | 15 |
| tratado | 2 | 16 |

---

## 5. Fluxo de trabalho para busca e curadoria

### Etapa 1 — Definir a necessidade didática

Antes de buscar dados, registrar:

- técnica estatística desejada;
- tema aplicado;
- nível da aula;
- número ideal de variáveis;
- número ideal de observações;
- se precisa ter resposta contínua, categórica, proporção, contagem ou série temporal.

Exemplos de busca por técnica:

| Técnica | Tipo de dado ideal |
|---|---|
| teste t | dois grupos, resposta contínua |
| teste pareado | antes/depois ou pares naturais |
| ANOVA | 3 ou mais tratamentos |
| DBC | tratamentos repetidos em blocos |
| fatorial | dois ou mais fatores cruzados |
| regressão simples | uma resposta contínua e um preditor numérico |
| regressão múltipla | uma resposta e vários preditores |
| ANCOVA | fator + covariável contínua |
| PCA/ACP | várias variáveis quantitativas correlacionadas |
| cluster/AAH | matriz multivariada ou distância entre unidades |
| não paramétricos | dados ordinais, assimétricos ou com n pequeno |
| modelos curvos | crescimento, dose-resposta, maturidade, potência, alometria |

### Etapa 2 — Buscar fontes

Priorizar buscas com termos em português e inglês.

Exemplos de termos:

- `aquaculture growth trial dataset csv`
- `tilapia feeding rate dataset`
- `fish growth regression data`
- `aquaculture ANOVA table raw data`
- `fish water quality PCA dataset`
- `fisheries survey data csv`
- `fish maturity length logistic regression data`
- `fish weight length dataset`
- `seafood quality sensory data`
- `aquaculture feed trial supplementary data`

### Etapa 3 — Avaliar se a fonte serve

Critérios mínimos:

- há dados numéricos suficientes;
- há contexto experimental ou amostral;
- há variáveis interpretáveis;
- a análise estatística é didaticamente clara;
- o arquivo é acessível ou a tabela pode ser transcrita com segurança;
- a licença permite uso ou a autorização é possível.

Critérios de rejeição:

- tabela apenas com médias sem repetições;
- ausência de descrição dos tratamentos;
- variáveis mal definidas;
- dados sem unidade;
- licença incompatível;
- extração muito incerta;
- base grande demais sem ganho didático claro.

### Etapa 4 — Extrair dados

Fontes possíveis:

- CSV, XLSX, TXT, TSV, ZIP;
- material suplementar;
- tabelas de PDF;
- tabelas de livros, com autorização;
- datasets de pacotes R;
- repositórios GitHub/Zenodo/Figshare/Dataverse.

Para PDF ou livro:

1. identificar página e tabela;
2. extrair a imagem ou texto;
3. transcrever em formato tabular;
4. conferir contra a página original;
5. registrar incertezas;
6. marcar como `transcrito_nao_validado` até revisão manual.

### Etapa 5 — Enxugar dados, quando necessário

Enxugar não significa descaracterizar. Significa remover o que atrapalha a aula.

Pode remover:

- variáveis redundantes;
- colunas técnicas sem uso didático;
- metadados excessivos;
- observações com erro evidente, desde que documentado;
- níveis raros que inviabilizam análise introdutória.

Não remover sem justificativa:

- tratamentos;
- repetições;
- blocos;
- covariáveis importantes;
- valores extremos biologicamente plausíveis;
- dados ausentes relevantes para ensino de limpeza.

### Etapa 6 — Traduzir e padronizar

Padronizar nomes de variáveis em português técnico.

Exemplos:

| Original | Padronizado |
|---|---|
| treatment | tratamento |
| replicate | repeticao |
| stocking weight | peso_inicial_lote_g |
| final weight | peso_final_lote_g |
| survival | sobrevivencia_pct |
| mortality | mortalidade_pct |
| feeding rate | taxa_alimentacao_pct |
| dissolved oxygen | oxigenio_dissolvido_mg_l |
| temperature | temperatura_c |
| crude protein | proteina_bruta_pct |
| vitamin C | vitamina_c_mg_kg |
| egg production | producao_ovos |
| female weight | peso_femea_g |
| specific growth rate | sgr_pct_dia |
| feed conversion ratio | fcr |

### Etapa 7 — Criar variáveis derivadas

Criar variáveis derivadas quando elas forem úteis didaticamente.

Exemplos:

- `ganho_peso_g = peso_final_g - peso_inicial_g`
- `ganho_relativo_pct = 100 * ganho_peso_g / peso_inicial_g`
- `sgr_pct_dia = 100 * (ln(peso_final_g) - ln(peso_inicial_g)) / dias`
- `sobrevivencia_pct = 100 * n_final / n_inicial`
- `produtividade_kg_m3 = biomassa_final_kg / volume_m3`
- `fcr = racao_consumida_g / ganho_biomassa_g`

Sempre documentar se a variável foi:

- extraída da fonte;
- calculada durante a curadoria;
- estimada;
- adaptada.

### Etapa 8 — Validar qualidade

Verificar:

- número de linhas esperado;
- número de tratamentos;
- número de repetições;
- unidades;
- valores impossíveis;
- duplicatas;
- dados ausentes;
- coerência de fatores;
- médias publicadas versus médias recalculadas;
- gráficos exploratórios simples.

Registrar em uma aba ou arquivo de log:

- erros encontrados;
- decisões tomadas;
- valores corrigidos;
- valores mantidos como extremos plausíveis;
- diferenças em relação à fonte.

---

## 6. Padrão de nomes

### 6.1 Arquivos

Formato recomendado:

```text
area_tema_fonte_ano_v01.xlsx
```

Exemplos:

```text
aquicultura_crescimento_tilapia_bhujel_2008_v01.xlsx
qualidade_agua_pca_viveiros_publico_v01.xlsx
tecnologia_pescado_sensorial_filetes_v01.xlsx
pesca_artesanal_survey_produtores_v01.xlsx
```

### 6.2 Abas

Usar nomes curtos, sem acentos, preferencialmente até 31 caracteres, por limitação do Excel.

Exemplos:

```text
README
Dicionario
Variaveis
crescimento_tilapia
mortalidade_vitamina
fatorial_proteina_vitc
ancova_ovos
pca_lipidios
```

### 6.3 Variáveis

Usar `snake_case`, sem acentos e com unidade quando útil.

Exemplos:

```text
id_dataset
tratamento
repeticao
bloco
semana
peso_inicial_g
peso_final_g
comprimento_cm
sobrevivencia_pct
oxigenio_dissolvido_mg_l
temperatura_c
proteina_bruta_pct
vitamina_c_mg_kg
```

---

## 7. Tipos de conjuntos prioritários para o EAPADados

### 7.1 Estatística introdutória

- peso de peixes individuais;
- sobrevivência por tanque;
- mortalidade de larvas;
- tamanho de propriedades aquícolas;
- produção por fazenda;
- parâmetros de água por viveiro.

Análises:

- média, mediana, moda;
- variância, DP, EP, CV;
- boxplot;
- histograma;
- detecção de outliers;
- transformação de dados.

### 7.2 Testes de hipótese

- dois tratamentos de ração;
- antes/depois de manejo;
- selvagem versus cultivado;
- macho versus fêmea;
- dois locais de pesca.

Análises:

- teste t independente;
- teste t pareado;
- Mann–Whitney;
- Wilcoxon;
- qui-quadrado;
- teste de proporções.

### 7.3 ANOVA e delineamentos

- DIC com diferentes rações;
- DBC com viveiros como blocos;
- fatorial proteína × vitamina;
- densidade × alimentação;
- espécie × sistema de cultivo.

Análises:

- ANOVA de um fator;
- ANOVA em blocos;
- ANOVA fatorial;
- interação;
- Tukey;
- gráficos de interação.

### 7.4 Regressão e modelos curvos

- peso × comprimento;
- idade/tempo × peso;
- dose de fertilizante × produtividade;
- densidade × crescimento;
- comprimento × maturidade;
- salinidade × sobrevivência.

Análises:

- regressão linear;
- regressão múltipla;
- regressão polinomial;
- modelo potência/alométrico;
- modelos de crescimento;
- dose-resposta;
- regressão logística para maturidade.

### 7.5 Multivariada

- qualidade de água em viveiros;
- composição centesimal do pescado;
- perfil de ácidos graxos;
- características morfométricas;
- indicadores produtivos de fazendas;
- dados socioeconômicos de pescadores.

Análises:

- PCA/ACP;
- cluster/AAH;
- heatmap;
- MANOVA;
- correlação múltipla;
- matriz de distância.

### 7.6 ANCOVA e modelos com covariáveis

- produção de ovos ajustada pelo peso da fêmea;
- crescimento ajustado pelo peso inicial;
- sobrevivência ajustada por qualidade de água;
- produtividade ajustada por densidade inicial.

Análises:

- ANCOVA;
- regressões por grupo;
- teste de homogeneidade de inclinações;
- GLM;
- interpretação de covariável.

---

## 8. Planilha mínima aceitável para entrar no banco

Um conjunto só deve entrar no banco principal quando tiver:

- dados em formato tidy;
- nomes de variáveis padronizados;
- dicionário de variáveis;
- fonte completa;
- status de licença/autorização;
- descrição da pergunta didática;
- unidade observacional definida;
- análise estatística sugerida;
- revisão mínima dos valores;
- observações sobre limitações.

---

## 8.1 Padrão atual da planilha-mãe EAPA

Quando o objetivo for acumular vários conjuntos em um único arquivo de curadoria para pacote, aulas e testes, usar o arquivo:

```text
dados_organizados_limpos_para_pacote_aulas.xlsx
```

Estrutura recomendada:

1. A primeira aba deve ser `info_conjuntos`, com uma linha por conjunto de dados.
2. As abas seguintes devem conter apenas dados limpos/adaptados, uma aba por conjunto.
3. Não incluir abas com dados brutos na planilha-mãe. Registrar em `info_conjuntos` a fonte, DOI, URL, licença e caminho do arquivo bruto local para recuperação futura.
4. Cada aba limpa deve ter somente colunas de dados necessárias para a análise didática. Evitar colunas administrativas como fonte, DOI, id interno ou observações longas dentro da aba de dados.
5. Os cabeçalhos das variáveis na aba limpa devem ter comentários clássicos do Excel, em português, explicando o significado da variável, unidade quando houver e papel na análise. Evitar threaded comments, pois versões antigas do Excel mostram aviso antes do comentário.
6. Se houver modelo sugerido, registrar duas colunas em `info_conjuntos`:
   - `modelo_sugerido`: versão com nomes curados da planilha, em português técnico;
   - `modelo_sugerido_r`: versão em sintaxe R usando nomes originais ou nomes esperados pelo artigo, quando fornecida.
7. Registrar explicitamente a unidade observacional e cuidados de pseudorrepetição, sobretudo em experimentos de aquicultura com peixes dentro de tanques.
8. Registrar o nome exato da aba limpa em `aba_limpa`.
9. Em conjuntos para ACP/AAH, preferir uma versão didática enxuta com variáveis brutas centrais. Evitar misturar na mesma aba de análise variáveis originais e índices derivados calculados a partir delas, para não "pesar duas vezes" a mesma informação.
10. Se o bruto trouxer cabeçalhos instáveis, duplicados ou errados, reconstruir os nomes a partir de uma aba de variáveis, legenda do artigo ou documentação oficial, e registrar isso em `tipo_adaptacao` e `observacoes`.
11. Evitar criar múltiplas abas limpas para o mesmo conjunto. Quando houver necessidade didática de subconjuntos ou dicionário, priorizar comentários nos cabeçalhos e registrar a estratégia em `info_conjuntos`, mantendo apenas uma aba de dados por dataset.
12. Quando a descricao do repositório prometer dimensões ou metadados que não aparecem no arquivo local baixado, documentar explicitamente a discrepância e curar o conjunto pelo conteúdo real disponível, não pela expectativa da página.

Colunas úteis em `info_conjuntos`:

```text
id_conjunto
nome_dataset_pacote
nome_curto
objetivo_didatico
area
tema
analise_principal
modelo_sugerido
modelo_sugerido_r
unidade_observacional
status_limpeza
tipo_adaptacao
aba_limpa
linhas_limpo
colunas_limpo
linhas_dados_originais
colunas_dados_originais
fonte
doi
url_documentacao
licenca
uso_recomendado
arquivo_bruto_local
observacoes
```

Esse padrão também deve servir como base para documentação futura no pacote `EAPADados`: `nome_curto` vira título, `objetivo_didatico` e `unidade_observacional` viram descrição, `fonte`/`doi`/`licenca` viram `@source`, e os comentários dos cabeçalhos viram o bloco `\describe{}`.

---

## 9. Checklist de revisão

Antes de considerar o conjunto pronto, responder:

1. O dado é real, público, autorizado ou claramente simulado?
2. A fonte está completa?
3. A licença permite o uso pretendido?
4. A unidade observacional está clara?
5. A planilha está em formato tidy?
6. Os nomes das variáveis estão em português técnico e sem acento?
7. As unidades estão documentadas?
8. Os fatores e tratamentos estão coerentes?
9. Há dados ausentes? Eles foram documentados?
10. Há outliers? Foram mantidos ou removidos com justificativa?
11. As médias ou resultados principais batem com a fonte?
12. A análise sugerida é adequada ao desenho dos dados?
13. O conjunto é didaticamente útil?
14. A base está enxuta o suficiente para aula?
15. O conjunto pode ser usado no livro, no pacote ou apenas internamente?

---

## 10. Fluxo sugerido para trabalhar com Codex e ChatGPT

### 10.1 Papel do ChatGPT

Usar o ChatGPT para:

- identificar fontes promissoras;
- avaliar valor didático;
- propor nomes de datasets;
- traduzir variáveis;
- escrever descrições em português;
- sugerir análises estatísticas;
- revisar coerência pedagógica;
- preparar e-mails de autorização;
- gerar documentação para livro e pacote.

### 10.2 Papel do Codex

Usar o Codex para:

- criar scripts de extração;
- limpar dados;
- converter para tidy;
- gerar planilhas Excel;
- validar formatos;
- criar arquivos `.R`, `.Rda`, `.csv` e documentação;
- automatizar checagens;
- gerar exemplos reprodutíveis em R.

### 10.3 Artefatos esperados por conjunto

Para cada dataset consolidado:

```text
/data-raw/nome_dataset/original/
/data-raw/nome_dataset/processar.R
/data-raw/nome_dataset/validar.R
/inst/extdata/nome_dataset.csv
/data/nome_dataset.rda
/man/nome_dataset.Rd
/docs/datasets/nome_dataset.md
/excel/nome_dataset_v01.xlsx
```

---

## 11. Modelo de descrição curta de dataset

```markdown
## nome_dataset

Conjunto de dados sobre [tema], obtido de [fonte]. A unidade observacional é [unidade]. O objetivo didático é permitir [análise principal], com discussão aplicada sobre [interpretação em Engenharia de Pesca].

### Pergunta didática
[Escrever pergunta clara.]

### Variável resposta principal
[Nome, unidade e significado.]

### Fatores/covariáveis
[Listar fatores, blocos e covariáveis.]

### Análises sugeridas
- [análise 1]
- [análise 2]
- [análise 3]

### Cuidados
[Licença, pseudorrepetição, dados ausentes, transformação, limitação etc.]
```

---

## 12. Modelo de e-mail para solicitar autorização

```text
Assunto: Solicitação de autorização para uso didático de dados em livro e pacote educacional

Prezado(a) Prof.(a) [Nome],

Meu nome é [Nome], sou professor da Universidade Federal do Pará, Faculdade de Engenharia de Pesca, Campus de Bragança, Brasil.

Estou desenvolvendo um projeto educacional chamado Ecossistema EAPA, composto por um livro em português sobre estatística aplicada à Engenharia de Pesca, uma IDE didática chamada CatalyseR e um pacote de dados chamado EAPADados.

Gostaria de solicitar sua autorização para adaptar e traduzir alguns conjuntos de dados apresentados em [obra/artigo], especialmente as tabelas [listar tabelas], para uso exclusivamente didático no livro e no pacote EAPADados.

A fonte original será devidamente citada, e os dados serão acompanhados de documentação em português, mantendo o crédito autoral. Quando necessário, os dados poderão ser reorganizados em formato tidy para facilitar o ensino de estatística aplicada.

A autorização solicitada inclui:

1. uso em aulas e materiais didáticos;
2. uso no livro em português do projeto EAPA;
3. inclusão no pacote EAPADados, com citação completa da fonte;
4. tradução dos nomes das variáveis e descrições para o português;
5. reorganização dos dados em formato tidy, sem alterar seu significado científico.

Caso haja alguma restrição ou condição específica, ficarei feliz em adequar o uso.

Atenciosamente,
[Nome]
[Instituição]
[Contato]
```

---

## 13. Critério final de qualidade

Um conjunto de dados está pronto para o EAPA quando permite ao aluno dizer:

> “Eu entendo de onde esses dados vieram, o que cada linha representa, o que cada variável significa, qual pergunta posso responder, qual análise estatística é adequada e como interpretar o resultado no contexto da Engenharia de Pesca.”

Esse é o padrão mínimo de curadoria para o banco de dados do Ecossistema EAPA.
