# Otólito × comprimento — peixes recifais do Pacífico (Morat et al. 2020)

- Arquivo original: `back-calculated-size-at-age_morat-et-al_2020-09-07.csv`
- Fonte: figshare — *Individual back-calculated size-at-age based on otoliths from
  Pacific coral reef fish species*.
- Página: <https://figshare.com/articles/dataset/Individual_back-calculated_size-at-age_based_on_otoliths_from_Pacific_coral_reef_fish_species/12156159>
- DOI ou identificador estável: <https://doi.org/10.6084/m9.figshare.12156159.v5>
  (versão 5, de 07/09/2020)
- Artigo: Morat, F.; Wicquart, J.; Schiettekatte, N. M. D.; de Sinéty, G.;
  Bienvenu, J.; Casey, J. M.; Brandl, S. J.; Vii, J.; Carlot, J.; Degregori, S.;
  Mercière, A.; Fey, P.; Galzin, R.; Letourneur, Y.; Sasal, P.; Parravicini, V.
  (2020). *Individual back-calculated size-at-age based on otoliths from Pacific
  coral reef fish species*. **Scientific Data**, 7, 370.
  <https://doi.org/10.1038/s41597-020-00711-y>
- Link direto do arquivo: botão *Download* / *Download All* na página do figshare.
- Licença: **CC BY 4.0** — <https://creativecommons.org/licenses/by/4.0/>
  (lida no campo `license` da API do figshare, não em resumo de busca).
- Data de acesso: 2026-09-15
- Integridade: 1.329.700 bytes; md5 `ad3658157eeced791f9e115b3ede213e`, idêntico
  ao registrado pelo depósito (conferido após o download).
- Organismo e contexto: 51 espécies de peixes recifais do Pacífico, amostradas nas
  ilhas de Manuae, Gambiers, Moorea e Marquesas. Otólitos seccionados e lidos para
  idade; comprimento e massa registrados na captura. **Coleta de campo, não
  experimento controlado.**
- Unidade observacional: **peixe individual** (`ID`). Atenção: cada linha é um
  **anulo** (idade) do mesmo peixe — 6.320 linhas para **855 peixes**.
- Estrutura analítica pretendida: **regressão linear simples** — raio do otólito na
  captura (`Rcpt`, mm) como variável explicativa e comprimento total na captura
  (`Lcpt`, mm) como resposta, **dentro de uma única espécie**.
- Situação: **aprovado com ajustes**.
- Observações:
  - O repositório GitHub dos autores (`JWicquart/fish_growth`) traz o CSV bruto com
    as mesmas variáveis, mas **não declara licença** (`license: null`). Não serve para
    redistribuição: o arquivo do aluno deve nascer do arquivo do figshare.
  - Quatro colunas são **resultados derivados** pelos autores (`Li_sp_m`, `Li_sp_sd`,
    `Li_sploc_m`, `Li_sploc_sd`: comprimento médio retrocalculado por espécie e por
    espécie × local). Não devem entrar no arquivo do aluno.
  - Inconsistência pontual nos dados: o ID `GAM18_B123` (*Monotaxis grandoculis*)
    aparece com **dois valores de `Rcpt`** (2,127416 e 1,763287 mm) e idades repetidas.
  - `Weight` tem 603 ausentes (9,5%) e `Ri` tem 387 (o raio no anulo 0, ausente por
    definição). `Rcpt` e `Lcpt`, que interessam à atividade, **não têm ausentes**.
  - O CSV do depósito **não é UTF-8**: a coluna `Observer` usa latin-1 em 1.199
    linhas (nomes com acento, "Guillemette de Synéty and Jérémy Wicquart"). Os
    arquivos do aluno e reduzido são regravados em UTF-8 a partir da leitura com
    `fileEncoding = "latin1"`.
