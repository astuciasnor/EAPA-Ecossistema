# Contêineres originais de dados

Esta pasta centraliza os arquivos-fonte históricos usados na curadoria do EAPADados. Eles não são conjuntos prontos para distribuição: contêm múltiplas abas, versões anteriores e material de trabalho.

- `brutos.xlsx`: contêiner histórico inicial.
- `aulas_bioestatistica_ORIGINAL.xlsx`: planilha original de aulas, preservada sem alterações.
- `dados_brutos_eapadados.xlsx`: fonte consolidada ainda lida pelos scripts em `data-raw/`.

Os scripts que usam a fonte consolidada devem referenciá-la a partir da raiz do pacote como `CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx`.
