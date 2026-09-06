# Rotina EAPADados — dados reais para AAS e amostragem estratificada

## Ordem de uso

1. Abra o arquivo `dados_reais_amostragem_EAPADados_links.md`.
2. Baixe os CSVs oficiais pelo Dados.gov.
3. Coloque os CSVs na pasta `dados_brutos/`.
4. Rode:

```r
source("01_ler_padronizar_mpa.R")
source("02_amostragem_mpa.R")
source("03_preparar_para_pacote_EAPADados.R")
```

## Pastas geradas

- `dados_brutos/`: coloque aqui os CSVs baixados.
- `dados_processados/`: saem os arquivos `.rds` limpos e as amostras.
- `dados_pacote/`: saem os arquivos `.rda` prontos para o pacote.
- `metadados/`: links e metadados auxiliares.

## Observação

O ambiente da conversa nem sempre consegue acessar diretamente os arquivos brutos do Dados.gov. Por isso, o fluxo mais estável é: baixar manualmente o CSV pelo botão oficial e deixar o R fazer a limpeza, a junção e as amostragens.
