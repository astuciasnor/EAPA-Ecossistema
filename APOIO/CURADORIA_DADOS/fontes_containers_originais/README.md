# Contêineres originais de dados

Esta pasta centraliza os arquivos-fonte históricos usados na curadoria do EAPADados. Eles não são conjuntos prontos para distribuição: contêm múltiplas abas, versões anteriores e material de trabalho.

- `brutos.xlsx`: contêiner histórico inicial.
- `aulas_bioestatistica_ORIGINAL.xlsx`: planilha original de aulas, preservada sem alterações.
- `dados_brutos_eapadados.xlsx`: fonte consolidada ainda lida pelos scripts em `data-raw/`.

Esta pasta mora em `APOIO/`, fora do pacote. Os scripts de `data-raw/` rodam a partir da raiz do pacote EAPADados e referenciam a fonte consolidada como `../APOIO/CURADORIA_DADOS/fontes_containers_originais/dados_brutos_eapadados.xlsx` (o pacote e a pasta `APOIO/` são irmãos dentro de `EAPA-Ecossistema`).
