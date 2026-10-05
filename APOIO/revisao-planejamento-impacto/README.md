# Revisão do painel Estudos de impacto

Atualização de 4 de outubro de 2026, seguindo a organização dos painéis transversal, longitudinal e gradiente da CatalyseR.

O exemplo de conferência usa quatro sítios de impacto, quatro de referência, seis campanhas antes, seis depois e três subamostras por visita: 288 linhas. Não se declara que os oito sítios sejam ambientes independentes. A seleção e a hierarquia devem ser justificadas pelo pesquisador.

- `esquema_impacto_baci.png`: desenho do plano, sem respostas simuladas.
- `coleta_impacto_baci.xlsx`: coleta, sítios, campanhas e orientações.
- `metodologia_impacto_baci.docx`: minuta no futuro, com desenho incorporado e cuidados.

A verificação `APOIO/verificar_impacto.R` exercita downloads reais do servidor Shiny, contagens, identificadores, BA, CI, BACI, quantidades desiguais de sítios, datas inválidas e respostas com nomes reservados. Excel foi reaberto e Word foi inspecionado quanto ao texto e à imagem incorporada. A renderização visual das páginas do Word foi tentada, mas o renderer depende de LibreOffice, indisponível neste ambiente; a paginação ainda exige conferência no Word.

A revisão conceitual está em `Curadoria_Literatura_R/Planejamento_01_IMPACTO/Revisao_2026-10-04.md`. O PDF e o roteiro originais foram preservados. As ressalvas registradas ali prevalecem sobre as regras absolutas de setembro.
