# Material de apoio do ecossistema

Organização feita em 6 de setembro de 2026. As pastas foram movidas da raiz
para este diretório, preservando os conteúdos e os nomes originais.

| Pasta | Conteúdo |
|---|---|
| `documentacao/` | Planejamento, decisões e guias |
| `CURADORIA_DADOS/` | Curadoria de dados |
| `Artigos_Obter_Dados/` | Artigos e fontes para obtenção de dados |
| `materiais/` | Materiais de apoio |
| `explicacoes_visuais/` | Explicações e recursos visuais |
| `scripts/` | Utilitários do ecossistema |
| `redacao-eapa/` | Orientações de redação |
| `transferencia-vm/` | Artefatos de entrada do Sandbox; somente locais |
| `saida-sandbox/` | Resultados de homologação; somente locais |
| `_legado/` | Histórico preservado; somente local |
| `temp/` | Produtos transitórios de desenvolvimento e testes; somente local |
| `tmp/` | Temporários preservados; somente locais |

`mapas.md` contém a especificação de mapas. O lançador `sandbox-catalyser.wsb`
aponta para as pastas de transferência e saída deste diretório.
`Rplots.pdf` foi preservado aqui e permanece fora do Git.

Os quatro projetos e `ATIVIDADES/` ficam um nível acima. Ao usar um caminho relativo em um
arquivo movido, considere a nova localização. Os arquivos históricos e os
pacotes de transferência preservam os caminhos registrados na época.

Padrão aprovado: [Transparência estatística e beleza dos dados](documentacao/TRANSPARENCIA_E_BELEZA_DOS_DADOS.md), com a representação de médias, observações, DP e IC adotada na CatalyseR.

Entrega atual: [CatalyseR 0.1.14 — versão unificada](documentacao/ENTREGA_CATALYSER_0.1.14.md). Para abrir a principal após reiniciar o R: `source("D:/Claude/EAPA-Ecossistema/APOIO/scripts/abrir_catalyser_principal.R")`.
