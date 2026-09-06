# Skill — Extração e Simulação de Dados para Teste t Pareado

## 1. Finalidade

Esta skill orienta uma IA a processar artigos científicos em PDF relacionados à pesca, aquicultura, recursos pesqueiros, tecnologia do pescado, ecologia aquática ou bioecologia, com o objetivo de construir conjuntos de dados didáticos para aplicação do **teste t pareado** no pacote **EAPDados**.

Para cada artigo, a IA deve:

1. identificar se o estudo usa ou permite o uso de teste t pareado;
2. extrair dados reais quando disponíveis;
3. reconstruir dados a partir de tabelas ou gráficos quando possível;
4. simular dados pareados quando os dados brutos não estiverem disponíveis;
5. documentar claramente a origem dos dados;
6. gerar um arquivo Excel com os dados e a documentação.

---

## 2. Entrada esperada

A IA receberá uma pasta contendo artigos em PDF, por exemplo:

```text
Artigos_Obter_Dados/
└── teste-t-pareado/
    ├── artigo_01.pdf
    ├── artigo_02.pdf
    ├── artigo_03.pdf
    └── skill_t_pareado.md
```

A IA deve processar todos os PDFs presentes nessa pasta.

---

## 3. Saída esperada

Gerar um arquivo Excel leve, por exemplo:

```text
dados_t_pareado.xlsx
```

O arquivo deve conter:

| Aba | Conteúdo |
|---|---|
| `README` | Explicação geral do arquivo |
| `indice_artigos` | Lista de todos os artigos processados |
| `dados_01` | Dados pareados do artigo 1 |
| `dict_01` | Dicionário e documentação do artigo 1 |
| `dados_02` | Dados pareados do artigo 2 |
| `dict_02` | Dicionário e documentação do artigo 2 |

Cada artigo deve gerar, preferencialmente, duas abas: uma de dados e outra de documentação.

---

## 4. Critério para reconhecer teste t pareado

A IA deve procurar no artigo termos como:

```text
paired t-test
paired samples t-test
paired-sample t test
dependent t-test
teste t pareado
teste t para amostras pareadas
```

Também deve reconhecer situações de pareamento mesmo que o termo estatístico não apareça explicitamente.

Exemplos de pareamento:

| Situação | Unidade pareada |
|---|---|
| Antes × depois | mesmo peixe, produtor, viveiro, área ou indivíduo |
| Tratamento A × tratamento B | mesma unidade medida em duas condições |
| Margem × centro | mesmo viveiro, lago, rio ou estação |
| Esquerdo × direito | mesmo peixe ou organismo |
| Represado × livre | trechos pareados de riacho |
| Hipóxico × normóxico | mesma área, estação ou sistema em duas condições |

---

## 5. Informações que devem ser extraídas do artigo

Para cada PDF, identificar:

- título do artigo;
- autores;
- ano;
- periódico;
- DOI;
- link, quando disponível;
- área temática;
- objetivo do estudo;
- local do estudo;
- espécie ou sistema estudado;
- delineamento amostral ou experimental;
- unidade observacional pareada;
- variáveis analisadas por teste t pareado;
- unidade de medida das variáveis;
- condições comparadas;
- tamanho amostral;
- média, desvio-padrão, erro-padrão, intervalo de confiança, t, graus de liberdade e p-valor, quando disponíveis;
- se há dados brutos, tabela, gráfico, apêndice ou material suplementar.

---

## 6. Classificação da origem dos dados

Todo conjunto de dados deve receber uma classificação explícita.

Usar uma das categorias abaixo:

```text
extraido_do_artigo
reconstruido_de_tabela
reconstruido_de_grafico
simulado_com_base_no_artigo
nao_disponivel
```

Nunca apresentar dados simulados como dados reais.

---

## 7. Estrutura da aba de dados

Cada aba `dados_XX` deve conter, sempre que possível, as seguintes colunas:

| Coluna | Descrição |
|---|---|
| `id_par` | Identificador do par |
| `artigo_id` | Código curto do artigo |
| `unidade_observacional` | Unidade pareada: peixe, produtor, viveiro, trecho etc. |
| `grupo` | Grupo, local, tratamento ou categoria, quando houver |
| `condicao_1` | Nome da primeira condição |
| `valor_1` | Valor observado na primeira condição |
| `condicao_2` | Nome da segunda condição |
| `valor_2` | Valor observado na segunda condição |
| `diferenca` | `valor_2 - valor_1`, salvo se o artigo usar outra direção |
| `variavel` | Nome da variável resposta |
| `unidade` | Unidade de medida |
| `origem_dados` | Origem dos dados |
| `observacao` | Comentário adicional, se necessário |

Exemplo:

| id_par | artigo_id | unidade_observacional | condicao_1 | valor_1 | condicao_2 | valor_2 | diferenca | variavel | unidade | origem_dados |
|---|---|---|---|---:|---|---:|---:|---|---|---|
| 1 | art_01 | piscicultor | antes | 72.1 | depois | 78.4 | 6.3 | atitude | escore | simulado_com_base_no_artigo |
| 2 | art_01 | piscicultor | antes | 68.5 | depois | 71.0 | 2.5 | atitude | escore | simulado_com_base_no_artigo |

---

## 8. Estrutura da aba de documentação

Cada aba `dict_XX` deve conter campos como:

| Campo | Conteúdo esperado |
|---|---|
| `artigo_id` | Código curto do artigo |
| `referencia_abnt` | Referência completa em formato ABNT ou próximo disso |
| `titulo` | Título do artigo |
| `autores` | Autores |
| `ano` | Ano |
| `periodico` | Nome do periódico |
| `doi` | DOI |
| `link` | Link do artigo ou PDF |
| `area` | Pesca, aquicultura, bioecologia etc. |
| `objetivo_estudo` | Objetivo resumido do estudo |
| `contexto` | Contexto biológico, ecológico, pesqueiro ou aquícola |
| `metodologia_coleta` | Como os dados foram coletados |
| `delineamento` | Tipo de pareamento |
| `unidade_pareada` | Unidade observacional do par |
| `variavel_resposta` | Variável analisada |
| `unidade_variavel` | Unidade da variável |
| `condicoes_comparadas` | Condição 1 × condição 2 |
| `estatisticas_reportadas` | n, média, DP, EP, t, gl, p etc. |
| `origem_dados` | Extraído, reconstruído ou simulado |
| `justificativa_simulacao` | Explicação quando os dados forem simulados |
| `uso_didatico` | Como usar no EAPDados ou no livro |
| `limitacoes` | Cuidados de interpretação |

---

## 9. Regras para extração dos dados

A IA deve seguir a seguinte ordem de prioridade:

1. procurar dados brutos no artigo;
2. procurar tabelas com valores individuais;
3. procurar material suplementar;
4. reconstruir dados a partir de tabelas resumidas, quando possível;
5. reconstruir dados a partir de gráficos, somente se os pontos estiverem suficientemente legíveis;
6. simular dados apenas quando os dados reais não estiverem disponíveis.

Quando usar dados reais, registrar:

```text
origem_dados = extraido_do_artigo
```

Quando reconstruir:

```text
origem_dados = reconstruido_de_tabela
```

ou

```text
origem_dados = reconstruido_de_grafico
```

Quando simular:

```text
origem_dados = simulado_com_base_no_artigo
```

---

## 10. Regras para simulação de dados pareados

A simulação deve tentar reproduzir as estatísticas reportadas pelo artigo.

### 10.1. Caso o artigo informe média da diferença, t e n

Usar a relação:

```text
t = media_diferenca / (sd_diferenca / sqrt(n))
```

Logo:

```text
sd_diferenca = abs(media_diferenca) * sqrt(n) / abs(t)
```

Simular diferenças com média próxima de `media_diferenca` e desvio-padrão próximo de `sd_diferenca`.

### 10.2. Caso o artigo informe média das duas condições e t

Calcular:

```text
media_diferenca = media_condicao_2 - media_condicao_1
```

Depois estimar `sd_diferenca` pela fórmula anterior.

### 10.3. Caso o artigo informe apenas médias, DP e p-valor

A IA deve simular dados de forma conservadora, tentando manter:

- direção do efeito;
- magnitude aproximada das médias;
- tamanho amostral;
- p-valor aproximado;
- interpretação final igual à do artigo.

### 10.4. Regras de segurança

A IA deve registrar que a base é simulada e não representa os dados originais do artigo.

Inserir no dicionário:

```text
Os dados desta aba foram simulados para fins didáticos, com base nas estatísticas resumidas reportadas no artigo. Eles não correspondem aos dados brutos originais dos autores.
```

---

## 11. Validação estatística da base simulada

Após criar os dados simulados, aplicar o teste t pareado e conferir se os resultados estão próximos dos reportados.

Registrar na documentação:

| Item | Descrição |
|---|---|
| `t_reportado` | Valor de t informado no artigo |
| `gl_reportado` | Graus de liberdade informado |
| `p_reportado` | p-valor informado |
| `t_simulado` | Valor obtido na base simulada |
| `gl_simulado` | Graus de liberdade da base simulada |
| `p_simulado` | p-valor da base simulada |
| `conclusao_compativel` | Sim ou não |

A conclusão da base simulada deve ser compatível com a do artigo.

---

## 12. Recomendações para nomes de abas

Usar nomes curtos, sem acentos e com até 31 caracteres, para evitar problemas no Excel.

Exemplos:

```text
dados_01_extensao
dict_01_extensao
dados_02_metano
dict_02_metano
dados_03_barragens
dict_03_barragens
```

---

## 13. Aba `indice_artigos`

Criar uma aba geral com:

| Coluna | Descrição |
|---|---|
| `artigo_id` | Código do artigo |
| `titulo_curto` | Título abreviado |
| `ano` | Ano |
| `area` | Área temática |
| `tipo_pareamento` | Antes/depois, centro/margem etc. |
| `variavel_principal` | Principal variável usada |
| `origem_dados` | Extraído, reconstruído ou simulado |
| `aba_dados` | Nome da aba de dados |
| `aba_dicionario` | Nome da aba de documentação |
| `status` | Processado, parcial ou não utilizável |
| `observacoes` | Comentários |

---

## 14. Aba `README`

A aba `README` deve explicar:

- finalidade do arquivo;
- que os dados são voltados ao ensino de estatística aplicada;
- que alguns dados podem ser simulados;
- que dados simulados não substituem os dados originais dos autores;
- que toda base possui documentação própria;
- que o arquivo pode ser usado para compor o pacote EAPDados.

Texto sugerido:

```text
Este arquivo reúne conjuntos de dados pareados extraídos, reconstruídos ou simulados a partir de artigos científicos relacionados à pesca, aquicultura, recursos pesqueiros, tecnologia do pescado, ecologia aquática ou bioecologia. O objetivo é apoiar atividades didáticas sobre teste t pareado no pacote EAPDados e em materiais de ensino. As bases classificadas como simuladas foram geradas para reproduzir aproximadamente as estatísticas reportadas nos artigos e não correspondem aos dados brutos originais dos autores.
```

---

## 15. Cuidados éticos e científicos

A IA deve:

- citar sempre o artigo original;
- diferenciar dados reais de simulados;
- não inventar informações bibliográficas;
- não afirmar que dados simulados são dados originais;
- manter a finalidade didática explícita;
- preservar a interpretação estatística do artigo;
- registrar limitações sempre que houver incerteza.

---

## 16. Fluxo resumido da skill

```text
Para cada PDF:
    1. Ler artigo.
    2. Identificar se há teste t pareado.
    3. Extrair referência e contexto.
    4. Identificar variáveis e condições comparadas.
    5. Procurar dados brutos.
    6. Se houver dados:
           montar aba de dados reais.
       Senão:
           simular dados compatíveis com as estatísticas reportadas.
    7. Validar teste t pareado na base criada.
    8. Criar aba de documentação.
    9. Atualizar indice_artigos.
Ao final:
    10. Criar README.
    11. Salvar dados_t_pareado.xlsx.
```

---

## 17. Estrutura mínima esperada para uso no R

Cada aba de dados deve permitir rodar, no mínimo:

```r
t.test(dados$valor_1, dados$valor_2, paired = TRUE)
```

Também deve permitir transformar para formato longo:

```r
dados_longos <- tidyr::pivot_longer(
  dados,
  cols = c(valor_1, valor_2),
  names_to = "condicao",
  values_to = "valor"
)
```

E gerar gráficos pareados:

```r
ggplot(dados_longos, aes(x = condicao, y = valor, group = id_par)) +
  geom_line(alpha = 0.4) +
  geom_point(size = 2) +
  theme_minimal()
```

---

## 18. Resultado final esperado

Ao final, o usuário deve ter um arquivo Excel organizado, leve e documentado, pronto para ser usado no pacote EAPDados, no aplicativo Shiny ou no livro didático.

O arquivo deve permitir responder:

- de onde vieram os dados;
- qual artigo originou o exemplo;
- quais variáveis foram medidas;
- qual foi o tipo de pareamento;
- se os dados são reais, reconstruídos ou simulados;
- quais estatísticas o artigo reportou;
- se a base reproduz a conclusão estatística do artigo.
