# Curadoria — tilápia: anestesia por imersão

1. IDENTIFICAÇÃO E FONTE

Nome didático: tilapia_anestesia

Conjunto original:
Immersion-administered lidocaine as an adjuvant to clove essential oil in Nile tilapia: raw data

Autora/contribuidora indicada no repositório: Alicia Martínez
Repositório: Mendeley Data
Página original: https://data.mendeley.com/datasets/35wyrph72h/1
DOI: https://doi.org/10.17632/35wyrph72h.1
Versão consultada: 1
Licença: Creative Commons Attribution 4.0 International — CC BY 4.0
Licença completa: https://creativecommons.org/licenses/by/4.0/

Este arquivo didático é uma versão reduzida e reorganizada da aba “Time” da
planilha original. A licença permite adaptação e redistribuição, desde que a
fonte e a autoria sejam atribuídas.


2. ORGANISMO E CONTEXTO EXPERIMENTAL

Organismo: tilápia-do-Nilo juvenil (Oreochromis niloticus).

Os peixes foram submetidos individualmente a anestesia por imersão. Todos os
tratamentos continham óleo essencial de cravo a 100 µL/L. Os tratamentos se
diferenciaram pela concentração de lidocaína adicionada.

Unidade experimental: peixe individual.
Número total de unidades experimentais: 36 peixes.
Número de réplicas: 12 peixes por tratamento.

Tratamentos:

- cravo: óleo de cravo 100 µL/L, sem lidocaína;
- cravo_lido_60: óleo de cravo 100 µL/L + lidocaína 60 mg/L;
- cravo_lido_80: óleo de cravo 100 µL/L + lidocaína 80 mg/L.

ATENÇÃO: “cravo” é o tratamento de referência, mas não representa peixe sem
anestésico. Todos os peixes receberam óleo de cravo.


3. PERGUNTA DIDÁTICA

O tempo médio para a tilápia-do-Nilo atingir o plano anestésico difere entre o
óleo de cravo usado sozinho e sua combinação com 60 ou 80 mg/L de lidocaína?

Variável-resposta: tempo_anestesia_s.
Fator: tratamento, com três níveis.


4. DICIONÁRIO DA VERSÃO DE REVISÃO

id_peixe
    Identificador único do peixe e da unidade experimental.

tratamento
    Fator categórico com os níveis cravo, cravo_lido_60 e cravo_lido_80.

tempo_anestesia_s
    Tempo, em segundos, desde o início da imersão até o peixe atingir o plano
    anestésico operacional. É a variável-resposta da atividade.

peso_g
    Peso corporal do peixe, em gramas. Não entra no modelo principal de ANOVA
    de um fator, mas foi preservado porque a análise original utilizou o peso
    como covariável. A coluna permite discutir ou realizar posteriormente uma
    ANCOVA.


5. AJUSTES FEITOS NA PLANILHA ORIGINAL

- Seleção somente das 36 linhas correspondentes a peixes individuais.
- Exclusão das linhas de médias, mínimos, máximos e desvios-padrão.
- Exclusão dos tempos duplicados no formato minutos/horário do Excel.
- Uso do tempo de anestesia registrado em segundos.
- Correção de artefatos numéricos da conversão do Excel, como 199,9999999,
  arredondando o tempo para o segundo inteiro originalmente registrado.
- Padronização dos nomes das colunas para português, sem espaços ou acentos.
- Recodificação dos tratamentos originais 100/0, 100/60 e 100/80 para nomes
  mais claros.
- Exclusão das abas de gráficos e das séries de frequência respiratória.

Nenhuma média de grupo foi usada para substituir os dados individuais.


6. VERIFICAÇÕES ANTES DA ANÁLISE NO R

O estudante deverá:

1. Importar o arquivo Excel do aluno.
2. Examinar a estrutura e as classes das colunas.
3. Converter tratamento em fator e definir a ordem dos níveis.
4. Confirmar 36 identificadores únicos.
5. Confirmar 12 observações em cada tratamento.
6. Verificar valores ausentes e possíveis duplicações.
7. Produzir um gráfico com pontos individuais e boxplots.
8. Examinar a distribuição dentro dos grupos e a variabilidade entre eles.

Exemplo de importação e preparo:

library(tidyverse)

tilapia <- readxl::read_excel("anova_tilapia_anestesia.xlsx", sheet = "dados") |>
  mutate(
    tratamento = factor(
      tratamento,
      levels = c("cravo", "cravo_lido_60", "cravo_lido_80")
    )
  )

glimpse(tilapia)
count(tilapia, tratamento)
n_distinct(tilapia$id_peixe)


7. MODELO DIDÁTICO

modelo <- aov(tempo_anestesia_s ~ tratamento, data = tilapia)
summary(modelo)

Após o ajuste, examinar os resíduos, a homogeneidade das variâncias e a
presença de observações influentes. As comparações múltiplas de Tukey podem ser
realizadas quando forem pertinentes à pergunta da atividade:

TukeyHSD(modelo)

A conclusão não deve se limitar ao valor de p. Devem ser apresentados os
valores observados, as médias por grupo, a dispersão, os intervalos de confiança
e, quando possível, uma medida de tamanho de efeito.


8. PSEUDORREPETIÇÃO E COLUNAS QUE NÃO FORAM INCLUÍDAS

A planilha original também contém frequência respiratória medida repetidamente
a cada 20 segundos no mesmo peixe. Essas leituras não são réplicas
independentes. Há 36 peixes, e não centenas de unidades experimentais.

As abas “Induction Freq” e “Recovery Freq” exigem análise de medidas repetidas
ou modelo misto. Elas não devem ser empilhadas e analisadas por ANOVA simples
como se cada leitura viesse de um peixe diferente.

A aba “Graphics” contém médias ajustadas, erros-padrão e intervalos de
confiança. Ela não contém as observações brutas necessárias para esta atividade.


9. CUIDADOS DE INTERPRETAÇÃO

- A ANOVA de um fator é uma simplificação didática. A análise original dos
  tempos empregou ANCOVA/GLM, com peso como covariável.
- Os ensaios ocorreram em três manhãs consecutivas e todos os tratamentos foram
  representados em cada dia. Entretanto, o dia não foi fornecido como coluna e
  não pode ser incluído como bloco no modelo didático.
- A independência deve ser discutida em relação aos peixes, não às medições
  respiratórias sucessivas.
- Não interpretar automaticamente os três tratamentos como uma relação linear
  de dose–resposta; a ANOVA trata os níveis como categorias.
- Evitar testar vários desfechos sem controlar a multiplicidade. Neste arquivo,
  a resposta previamente escolhida é o tempo para atingir o plano anestésico.
- As conclusões se restringem a juvenis que atenderam aos critérios de inclusão
  e às condições do protocolo, incluindo óleo de cravo 100 µL/L e temperatura
  próxima de 27,5 °C.
- O tamanho amostral é de 12 peixes por tratamento; ausência de significância
  não demonstra equivalência entre os tratamentos.


10. PARECER SOBRE O USO DIDÁTICO

APROVAR COM AJUSTES.

O arquivo reduzido é adequado à ANOVA de um fator porque apresenta uma linha por
peixe, um fator com três níveis, uma resposta numérica e 12 réplicas
independentes por nível. O uso é correto desde que a atividade não trate as
leituras respiratórias repetidas como réplicas, reconheça que o modelo original
incluiu peso e registre que o dia do ensaio não está disponível.

## Arquivos do ecossistema

- `Data TILAPIA English.xlsx`: download original, preservado sem alterações.
- `anova_tilapia_anestesia_revisao.xlsx`: versão limpa, com tratamentos
  recodificados, para conferência do autor e validação técnica.
- `ATIVIDADES/dados/anova_tilapia_anestesia.xlsx`: versão do aluno; preserva
  os códigos originais de tratamento (`100/0`, `100/60`, `100/80`) para que a
  recodificação faça parte do preparo.
