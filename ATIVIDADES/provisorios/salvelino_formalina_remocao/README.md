# Salvelino — formalina e remoção semanal

Conjunto enxuto no nível da unidade experimental para a ANOVA de dois fatores.
Cada linha é um compartimento com ovos de *Salvelinus alpinus*; as contagens
`ovos_eclodidos` + `mortalidade_total` reproduzem `ovos_iniciais` e a porcentagem
é mantida como publicada/calculada a partir dessas contagens.

- Fonte: Olk, Lydersen & Wollebæk (2023), DataverseNO, DOI
  [10.23642/USN.7334573](https://doi.org/10.23642/USN.7334573).
- Licença: CC BY 4.0.
- Uso: EAPADados, atividade de ANOVA fatorial 2 × 2, CatalyseR e livro.
- Delineamento: 30 unidades, fatores `formalin` e `remocao_semanal`, células
  desequilibradas (12, 8, 3 e 7).
- Nota analítica: os autores usaram transformação arco-seno da raiz quadrada;
  os denominadores variam, portanto as contagens também devem ser discutidas
  como alternativa binomial.

O CSV é uma versão didática rastreável do registro final de cada unidade do
arquivo original. A redução e as advertências estão descritas em
`../anova_dois_fatores_conjuntos_enxutos.md`.
