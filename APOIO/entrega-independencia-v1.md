# Implementação dos ajustes de independência e replicação

04/10/2026. Ajustes pontuais da v1, conforme o texto fornecido pelo autor. As abas, sub-abas, desenhos, fórmulas e contagens da coleta foram preservados.

## O que mudou na prática

- **Tipo de unidade**, opcional, em Definições do Transversal comparativo, Longitudinal comparativo e Estudos de impacto. O padrão é “Não informado”. Escolher unidades instaladas disponibiliza uma ajuda recolhida sobre padronização e indicadores.
- **Comparação ambiental**, opcional, no Transversal e Longitudinal. O padrão “Não se aplica” preserva o comportamento dos estudos que não comparam ambientes. As alternativas mudam o alcance do texto metodológico; categorias também exibem o aviso de replicação ambiental em Modelo e cuidados. Nenhuma fórmula é trocada.
- **Conferir locais das UAs**, botão no campo de origem do Longitudinal, abre Ficha do delineamento → Unidades e características de partida. O pesquisador preenche os locais na planilha exportada, como antes; o botão não edita os dados.
- **Alinhamento**, com medidas previstas e perda esperada lado a lado no Longitudinal. Valores e identificadores dos campos foram mantidos.
- **Ajuda compacta**, com “Saiba mais sobre padronização e indicadores”, “Limite deste exemplo”, orientação sobre n em Quanto amostrar e exemplo híbrido em Parcelas Subdivididas recolhidos por padrão.
- **Textos alinhados**, distinguindo zero observado de medida ausente, pool físico de resumo de medidas, réplicas ambientais de unidades internas e organização do estudo de causalidade.
- **Exportações**, com as novas orientações no Excel longitudinal e transversal, distinção de zero nos metadados do Monitoramento e alcance da conclusão no texto que alimenta o Word dos delineamentos que já o exportam.

## Arquivos de aplicação e documentação alterados

| Arquivo | Mudança desta entrega |
|---|---|
| `CATALYSER/inst/app/modules/mod_planejamento_observacional.R` | Seletores opcionais, ajuda condicional, botão de navegação, alinhamento dos campos, alcance metodológico, cuidados e textos compartilhados com as exportações. |
| `CATALYSER/inst/app/modules/mod_monitoramento.R` | Esforço comparável, conectividade, zero versus ausência, alcance da série e orientação nos metadados do Excel. |
| `CATALYSER/inst/app/modules/mod_conceitos_coleta.R` | Cartão de padronização com limites de interpretação e organismos instalados. |
| `CATALYSER/inst/app/modules/mod_n_poder.R` | Ajuda recolhida nas três comparações existentes do grupo Para comparar, distinguindo réplicas ambientais de unidades internas. |
| `CATALYSER/inst/app/modules/mod_mapa_pontos.R` | Ajuda de Onde amostrar sobre fluxo, conectividade, piloto e limites da distância. |
| `CATALYSER/inst/app/modules/mod_experimental_design.R` | Exemplo híbrido recolhido em Descrição, somente em Parcelas Subdivididas; sem alteração do gerador do croqui. |
| `Curadoria_Literatura_R/Mapa_Menus/Pendencias_CatalyseR.md` | Cinco itens PENDENCIA-V2, com origem “Guia de independência e replicação, out/2026”. |

Os dois primeiros módulos já tinham alterações de etapas anteriores. A lista descreve somente o acréscimo desta entrega. Foram preservadas as terminações existentes: CRLF nos módulos observacional, monitoramento, mapas e experimental; LF em conceitos e tamanho amostral.

Instrumentos de conferência criados em `APOIO/`: `validar_independencia_v1.R`, `verificar_testes_legados_independencia.R` e `resultado_independencia_v1.txt`. São conferências desta entrega, não uma nova estrutura da aplicação.

## Validação

| Conferência | Resultado |
|---|---|
| Sintaxe dos seis arquivos R alterados | Conferida por parse. |
| Novos seletores no Longitudinal e Transversal | Verificações concluídas: alteram textos e orientações, mantendo tabela de coleta e fórmula. |
| Downloads reais de Excel e Word dos dois módulos | Verificados no servidor Shiny: orientações de zero, terminologia e organismos instalados no Excel; alcance da comparação no Word. As quatro planilhas longitudinais foram mantidas. |
| Construção da interface dos quatro delineamentos do módulo compartilhado | Verificada; Tipo de unidade não aparece no Gradiente. |
| Exemplo de Parcelas Subdivididas | Verificado: aparece no Split-Plot e não aparece no DIC. |
| Navegação no navegador | O botão abriu a ficha e selecionou Unidades e características de partida. Escolher categorias mostrou o aviso em Modelo e cuidados. |
| `test_observacional_impacto.R` | Asserções concluídas, mensagem OK. |
| `test_monitoramento.R` | Asserções concluídas, mensagem OK. |
| `test_transversal_saidas.R` | Verificações de Excel, Word e figura concluídas. |
| `test_observacional_longitudinal.R`, original | Falha na expectativa de 24 linhas: não informa perda zero, enquanto a configuração atual inclui previsão de perdas. |
| `test_observacional_gradiente.R`, original | Falha na expectativa de pool 3: informa o antigo pool único, enquanto a interface atual usa pool por estação. |
| Cenários dos dois testes legados, com entradas atuais em memória | Asserções concluídas: perda zero explícita, UAs e pools por grupo/estação, e redação vigente da metodologia. Os arquivos originais ficaram intactos. |

**Limitação da execução:** o ambiente R apresentou avisos de locale na inicialização e de acesso ao cache Sass na prévia. Algumas execuções retornaram código 1 no encerramento mesmo depois da mensagem de conclusão das asserções. Portanto, o resultado acima distingue verificações concluídas de um encerramento integralmente limpo; não apresenta toda a suíte original como aprovada. O arquivo de resultados mantém as duas falhas originais visíveis. Não houve alteração de cálculos para satisfazer expectativas antigas.

## Adaptações dos textos sugeridos

**Contagem de ambientes por categoria.** A frase não preenche “[n] ambientes”, porque esse número não existe no cadastro atual. A redação informa que a associação depende de ambientes distintos e que número e seleção devem ser descritos no projeto. Contar tanques como ambientes seria incorreto.

**Tipo de unidade não informado.** Foi incluído um estado inicial neutro, além das duas escolhas substantivas, para que o formulário não classifique silenciosamente os estudos existentes como naturais ou instalados.

**Comparação ambiental quando pertinente.** O campo tem “Não se aplica” como padrão. O pesquisador declara sua pertinência; o aplicativo não tenta reconhecer ambientes a partir do nome do fator ou da pergunta.

**Réplica e medidas internas.** O texto diz que medidas internas não aumentam o número de UAs e que a unidade da comparação depende da pergunta. Evita afirmar que o tanque será sempre a réplica quando a pergunta é sobre categorias ambientais.

**Sobrevivência.** Zero observado é explicitamente válido. Também se distingue sua contagem e denominador do número de animais medidos na biometria. Resposta ausente continua vazia, com motivo anotado.

**Nome da coluna de observações.** No Monitoramento, a coluna real é `observacao`, no singular. Nos módulos que usam `observacoes`, foi mantido o plural. No Longitudinal, o texto também aproveita `motivo_ausencia`.

**Quanto amostrar.** O aviso usa “categorias ambientais”, evitando dizer que qualquer comparação de ambientes específicos exige contar somente ambientes. O nível de inferência depende da pergunta. A ajuda informa que as calculadoras simples não dimensionam toda a hierarquia.

**Pool e n_medidas.** O Longitudinal mantém `n_medidas`. Transversal e Gradiente não receberam uma coluna nova: seus textos orientam guardar a contagem de medidas internas nos registros ou protocolo existentes. Pool continua representando mistura física.

**Modelo misto e exemplo híbrido.** O limite do modelo foi colocado numa explicação recolhida abaixo da função. O híbrido foi apresentado como exemplo didático, deixando claro que o croqui clássico atual não o gera. A redação distingue o componente experimental da ração do ambiental preexistente.

## O que não foi implementado como automação

Não foram acrescentados agregação de dados, cadastro hierárquico completo, alteração automática de fórmula, ICC/poder hierárquico ou análise do híbrido. Esses cinco itens foram registrados para a v2, conforme solicitado.

Não foi criada contagem de ambientes por categoria nem coluna n_medidas nos módulos que não a possuem. Isso exigiria novos campos ou alteração da estrutura da ficha, contrariando o limite desta etapa. O Monitoramento manteve a exportação somente em Excel; não ganhou um download Word novo.

Nenhum menu, módulo, aba ou sub-aba foi criado.
