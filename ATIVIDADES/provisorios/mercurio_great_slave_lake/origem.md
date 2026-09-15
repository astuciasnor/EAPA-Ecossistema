# Mercúrio em peixes do Great Slave Lake — candidato para a atividade de regressão múltipla

- Arquivo: **a receber** — baixar de <https://datadryad.org/dataset/doi:10.5061/dryad.59zw3r23g>
  (*Download all*) e guardar nesta pasta com o nome original.
- Fonte: Chételat, J.; Rohonczy, J.; Cott, P. A.; Benwell, A.; Forbes, M. R.;
  Robinson, S. A.; Rosabal, M.; Amyot, M. (2020). *Trophic structure and mercury
  transfer in the subarctic fish community of Great Slave Lake, Northwest
  Territories, Canada* [Dataset]. Dryad.
- DOI: <https://doi.org/10.5061/dryad.59zw3r23g> (versão 5, 67.593 bytes)
- Artigo: *Journal of Great Lakes Research* **46**(2), 402–413,
  <https://doi.org/10.1016/j.jglr.2019.12.009>
- Licença: **CC0 1.0 Universal** (domínio público) — confirmada no `rightsList` do
  DataCite (`rightsIdentifier: cc0-1.0`), não em resumo de busca.
- Data de acesso: 2026-09-15
- Contexto: lago subártico do Canadá com pesca recreativa, de subsistência e
  comercial. O mercúrio nos peixes do lago aumentou nas últimas décadas. O estudo
  caracterizou uso de habitat, posição trófica e concentrações de mercúrio em cinco
  espécies: lúcio (*Esox lucius*), corégono-branco (*Coregonus clupeaformis*), cisco
  (*Coregonus artedi*), sucker (*Catostomus catostomus*) e burbot (*Lota lota*).
- Uso pretendido: **regressão linear múltipla** — mercúrio no músculo em função de
  **idade, tamanho e posição trófica**.
- Situação: **pendente** — falta o arquivo.

## Por que este conjunto

O próprio artigo faz a análise da atividade: *"Age, size, and trophic position were
significant explanatory variables for muscle total mercury concentrations within
populations of fish species"* e, entre espécies, *"size and trophic position
explained 80% of the variation"*.

E ele resolve a objeção levantada à truta-de-riacho: pela regra do pilar, a atividade
avaliada usa dado **distinto** do exemplo do pacote e do livro — e
`truta_riacho_crescimento` é justamente o conjunto canônico do EAPADados. Aqui o dado é
de outro repositório, outro estudo, e não existe no pacote.

Bônus didático: **idade e tamanho são colineares por construção** (peixe mais velho é
maior), o que transforma "quais preditores entram no modelo" numa decisão real, com
consequência visível no VIF — o mesmo tipo de armadilha que o `conv_eff` dava na truta,
mas agora vindo do dado, não de uma variável de tanque.

## Arquivos do depósito (2)

| Arquivo | Tamanho | sha-256 (para conferir depois do download) |
|---|---|---|
| `Rohonczy_et_al_2019_Journal_of_Great_Lakes_Research_mercury_Great_Slave_Lake_food_web_Nov_2019.xlsx` | 49.839 bytes | `ef94712241f765978e6789db88ce1b9fa881aeab0dc13d9a63bfac6545749a8a` |
| `Usage_Notes.docx` | 17.754 bytes | `f85c5dfa45a3fc1c9355e0797ba893d642e37df85581c91271385de19f4eaa69` |

O `Usage_Notes.docx` é o dicionário de dados dos autores — vale ler antes de curar.

## Verificações a fazer quando o arquivo chegar (checklist da curadoria)

1. Unidade observacional: cada linha é um **peixe individual**? Há mais de uma linha por
   peixe (medidas repetidas, tecido, réplica analítica)?
2. Quantos peixes por espécie e quantos com todas as variáveis completas.
3. Variáveis disponíveis: idade, comprimento/massa, posição trófica (δ15N?), Hg,
   local, data, sexo.
4. Formato: CSV ou Excel? Uma aba de dados ou várias (inclusive abas derivadas, que
   **não** entram no arquivo do aluno)?
5. Ausentes por coluna e o que significam.
6. Se idade e tamanho são realmente colineares no subconjunto escolhido, e qual espécie
   tem n suficiente para a análise.

## Estado da atividade

A atividade **#10** estava montada com a truta-de-riacho; por decisão de set/2026 ela é
**substituída** por este conjunto. O enunciado e a rubrica se aproveitam inteiros —
mudam o contexto, as variáveis e o gabarito. O arquivo da truta sai de
`ATIVIDADES/dados/` (o conjunto continua no EAPADados, como exemplo canônico).
