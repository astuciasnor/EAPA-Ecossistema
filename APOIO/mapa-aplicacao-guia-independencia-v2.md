# Mapa de aplicação do guia de independência e replicação

Data: 04/10/2026. Documento de avaliação, sem alteração do código da CatalyseR.

Fonte principal: `Curadoria_Literatura_R/Planejamento_05_LONGITUDINAL/Guia_Independencia_Replicacao_TanquesRede_v2.pdf`, especialmente as seções indicadas nas tabelas. Comparação com as curadorias de planejamento 01 a 05, `Mapa_Menus/Pendencias_CatalyseR.md` e os módulos atuais da aplicação. As recomendações da seção 14 do guia foram tratadas como propostas.

## 1. Síntese

O guia rende mais no Longitudinal comparativo, principalmente em Definições, Ficha do delineamento → Orientações e Modelo e cuidados: ajuda a distinguir a comparação de ambientes específicos da comparação de categorias ambientais, acrescenta o local de cultivo como possível nível de agrupamento e esclarece a diferença entre perda da unidade e mortalidade como resposta. No Transversal comparativo e no Estudo de gradiente, contribui com a definição da unidade de inferência e com a distinção entre resumo de medidas e mistura física. Nos Estudos de impacto (BA, CI, BACI), reforça cuidados já registrados sobre locais, sincronia e alcance da conclusão. No Monitoramento, cabe apenas uma orientação breve sobre dependência, esforço e registros ausentes. Recomendo preservar todas as abas, sub-abas, desenhos e exportações atuais, acrescentar poucos textos nos lugares existentes e reservar para PENDENCIA-V2 os campos hierárquicos, a seleção automática de modelos e a agregação de dados individuais.

### Como ler o mapa

- **v1**: texto curto ou esclarecimento que cabe na estrutura atual. É uma recomendação de aplicação futura, não uma mudança já realizada.
- **PENDENCIA-V2**: exige representar novos níveis, tratar dados ou validar análises. O marcador está neste mapa; não foi acrescentado ao código nem ao cadastro central de pendências.
- **já coberto**: manter o que existe. A coluna de texto registra a ideia, sem pedir uma segunda inserção.
- **complementa o que já existe**: indica qual campo ou conteúdo receberia o complemento.

O mapa distingue a cobertura das curadorias da implementação. Uma proposta presente em uma curadoria não foi considerada automaticamente implementada. As tabelas específicas abaixo acrescentam detalhes ao bloco comum, sem recomendar que o mesmo aviso seja repetido em todas as abas.

## 2. Bloco comum aos módulos observacionais

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Transversal comparativo; Longitudinal comparativo; Estudo de gradiente; Estudos de impacto (BA, CI, BACI) | Definições, junto à pergunta; no Estudo de gradiente, contexto em Organizar e avaliar | 2.1, 11.1 | texto de ajuda ("saiba mais") | complementa o que já existe: apresentação da natureza observacional | “Organizar a coleta ou instalar unidades padronizadas não torna experimental o fator ambiental. Pergunte se o fator de interesse foi atribuído pelo pesquisador ou já existia.” | v1 |
| Monitoramento | Modelo e cuidados | 2.1, 11.1 | conteúdo de Modelo e cuidados | complementa o que já existe: Quando usar | “Acompanhar uma série descreve mudanças. A organização do acompanhamento, por si só, não identifica suas causas.” | v1 |
| Transversal comparativo; Longitudinal comparativo; Estudo de gradiente; Estudos de impacto (BA, CI, BACI), quando houver organismos instalados | Definições, nos procedimentos; no Estudo de gradiente, Organizar e avaliar → Procedimento e distribuição das subamostras | 2.2, 9, 10 | texto de ajuda ("saiba mais") | complementa o que já existe: protocolo e seleção | “As unidades já estavam no ambiente ou foram instaladas? Nas instaladas, descreva origem, tamanho inicial, densidade, estrutura e manejo. O confinamento também pode influenciar a resposta.” | v1 |
| Os mesmos quatro módulos, quando aplicável | Definições | 2.2, 14 | campo ou opção | novo: seleção formal de unidades naturais ou instaladas | “Unidades naturais / Unidades padronizadas instaladas pelo pesquisador.” Não criar agora um seletor que ainda não altere coerentemente ficha e metodologia. | PENDENCIA-V2 |
| Transversal comparativo; Longitudinal comparativo | Definições, junto à pergunta e aos grupos | 3, 4, 5 | pergunta ao usuário | complementa o que já existe: pergunta do estudo; como ajuda, sem resposta obrigatória nova | “Você quer comparar estes ambientes específicos ou categorias de ambientes? Para categorias, a replicação precisa incluir ambientes distintos em cada categoria.” | v1 |
| Estudo de gradiente | Organizar e avaliar → Ambiente e Fonte ou origem do gradiente | 3, 4, 12.4 | texto de ajuda ("saiba mais") | complementa o que já existe: descrição do sistema | “Seu gradiente está dentro de um sistema ou compara ambientes distintos? Vários pontos de um reservatório não equivalem a vários reservatórios.” | v1 |
| Transversal comparativo; Longitudinal comparativo; Estudo de gradiente; Estudos de impacto (BA, CI, BACI) | Modelo e cuidados | 4, 5, 11.3 | aviso ou alerta | complementa o que já existe: pseudorreplicação e limites do modelo | “O modelo respeita a estrutura informada, mas não cria ambientes que não foram amostrados. Mais animais, unidades de cultivo ou visitas não substituem ambientes replicados.” | v1 |
| Transversal comparativo; Longitudinal comparativo; Estudo de gradiente; Estudos de impacto (BA, CI, BACI) | Metodologia para artigo | 4, 10, 11 | frase da Metodologia para artigo | complementa o que já existe: limites da comparação; só inserir limites apoiados pelo formulário | “A comparação será interpretada considerando os locais selecionados, o período e os critérios de seleção. Diferenças observadas não identificam, sozinhas, uma causa ambiental específica.” | v1 |
| Longitudinal comparativo | Ficha do delineamento → Orientações; Modelo e cuidados | 8.4, 8.5 | coluna ou texto da Ficha | já coberto: subamostras, n_medidas, código permanente e UA × momento | “Medidas dentro da UA descrevem aquela unidade; visitas acompanham sua trajetória. Nenhuma dessas contagens aumenta o número de UAs.” Manter, sem novo aviso equivalente. | v1 |
| Transversal comparativo; Estudo de gradiente; Estudos de impacto (BA, CI, BACI); Monitoramento | Ficha do delineamento e Modelo e cuidados | 8.4, 8.5 | texto de ajuda ("saiba mais") | complementa o que já existe: composição ou esforço, conforme o módulo | “Resumo de medidas e mistura física são procedimentos diferentes. Defina primeiro a UA e depois como as medidas feitas dentro dela serão registradas.” No Monitoramento, priorizar esforço e tipo de resposta. | v1 |
| Todos, conforme a pergunta | Resumo | 3, 4, 12.7 | item do Resumo | novo: contagem por nível explicitamente informado | “Ambientes: [n]; locais: [n]; unidades acompanhadas: [n]; registros: [n].” Exige cadastro dos níveis; nunca deduzir o nível pelo nome do grupo. | PENDENCIA-V2 |

**Aplicabilidade:** a distinção entre ambientes específicos e categorias não é obrigatória em toda pesquisa observacional. Não deve virar pergunta obrigatória para quem compara espécies, descreve uma série ou estuda um gradiente em um único sistema. Os nomes “experimento mensurativo”, “transplante ativo” e “bioensaio in situ” cabem, quando pertinentes, em ajuda secundária. Não recomendo colocá-los nos títulos das abas.

## 3. Aplicação específica por módulo

### Transversal comparativo

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Transversal comparativo | Definições, junto a pool; Ficha do delineamento, planilha coleta | 8.4, 8.5 | texto de ajuda ("saiba mais") | complementa o que já existe: pool da curadoria 03 | “Use pool para a amostra composta por mistura física. Se cada animal foi medido separadamente, o resumo dessas medidas não é um pool.” Preservar o exemplo de tecidos e a UA composta. | v1 |
| Transversal comparativo | Desenho | 3, 8.4 | elemento do Desenho (infográfico) | já coberto: grupos, UAs e componentes na coleta única | Manter o desenho. Uma legenda breve pode esclarecer os componentes, sem trocar o esquema por tanques-rede. | v1 |
| Transversal comparativo | Definições, junto à opção de segundo fator | 4, 5 | aviso ou alerta | complementa o que já existe: segundo fator | “Um segundo fator não cria replicação. Se cada categoria ocorre em um único ambiente, categoria e ambiente ficam confundidos.” | v1 |
| Transversal comparativo | Modelo e cuidados | 4.1, 5.3, 12.1 a 12.3 | conteúdo de Modelo e cuidados | novo: alcance da comparação ambiental | “Com um ponto por ambiente, o resultado descreve os pontos escolhidos. Para comparar categorias ambientais, inclua ambientes distintos em cada categoria.” | v1 |
| Transversal comparativo | Metodologia para artigo | 4, 9, 10 | frase da Metodologia para artigo | complementa o que já existe: critérios e padronização | “Serão descritos os critérios de seleção e os procedimentos comuns aos grupos.” Usar o conteúdo já informado, sem presumir mesma ração, lote ou densidade para qualquer estudo. | v1 |
| Transversal comparativo | Ficha do delineamento, planilha coleta; Resumo | 3, 8.5, 14 | coluna ou texto da Ficha | novo: identificadores para dados individuais e contagens efetivas | Manter agora uma linha por UA. Planilha individual ligada à UA e agregação dependem de especificação própria, sem novas sub-abas nesta etapa. | PENDENCIA-V2 |

**Não se aplica:** calendário de revisitas, sincronia entre campanhas, perdas de acompanhamento, interação grupo × tempo e modelo de medidas repetidas, quando há um único recorte temporal. O guia não substitui as decisões da curadoria 03 sobre massa igual no pool, quantidade de tecido e repetições de bancada.

### Longitudinal comparativo

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Longitudinal comparativo | Definições, pergunta e grupos | 4, 12.7 | texto de ajuda ("saiba mais") | complementa o que já existe: aviso de replicação ambiental | “Comparar Caeté, Emboraí Velho e Quatipuru é comparar ambientes específicos. Comparar categorias, como rios e estuários, exige vários ambientes de cada categoria.” Os locais são exemplos do plano, não dados de um estudo realizado. | v1 |
| Longitudinal comparativo | Ficha do delineamento → Unidades e características de partida | 3, 5.3, 6 | coluna ou texto da Ficha | complementa o que já existe: agrupamento de origem e características de partida | “Registre o local de cultivo compartilhado pelas unidades. Unidades do mesmo local podem compartilhar fluxo, manejo e eventos.” Aproveitar a coluna opcional existente, sem adicionar uma segunda coluna equivalente. | v1 |
| Longitudinal comparativo | Definições; Ficha do delineamento → Unidades e características de partida | 3, 4, 11.4 | campo ou opção | novo: cadastro completo de categoria, ambiente, local e tanque | “Qual nível é a réplica da sua pergunta?” Adiar o cadastro hierárquico completo; o atual campo de origem não representa sozinho todos os níveis. | PENDENCIA-V2 |
| Longitudinal comparativo | Desenho | 6, 8.4, 8.5 | elemento do Desenho (infográfico) | já coberto: mesmas UAs, subamostras, visitas e registros | Preservar os símbolos genéricos e a sequência UA → medidas → registro. Manter a nota de que a distância gráfica não é distância de campo. | v1 |
| Longitudinal comparativo | Ficha do delineamento → Calendário previsto; Metodologia para artigo | 6, 8.2 | coluna ou texto da Ficha | já coberto: janela curta, ordem sorteada, data prevista e real, relógio comum ou individual | Manter. Não acrescentar um segundo calendário ou repetir o aviso de sincronia em novos cartões. | v1 |
| Longitudinal comparativo | Ficha do delineamento → Orientações; Modelo e cuidados | 8.1, 8.3 | conteúdo de Modelo e cuidados | complementa o que já existe: status_ua, motivo_ausencia e perda informativa | “Mortalidade total observada é uma resposta: registre sobrevivência zero. Use resposta vazia quando a medida não pôde ser obtida, com o motivo anotado. Preserve o código da UA.” | v1 |
| Longitudinal comparativo | Ficha do delineamento → Orientações | 8.1, 9 | coluna ou texto da Ficha | complementa o que já existe: interpretação de sobrevivência | “Registre a população inicial e as retiradas ou reposições. A sobrevivência depende de um denominador definido, não do número de animais pesados na biometria.” Não gerar automaticamente uma fórmula única de sobrevivência. | v1 |
| Longitudinal comparativo | Modelo e cuidados | 11.4, 13 | conteúdo de Modelo e cuidados | complementa o que já existe: fórmula do modelo misto e explicação dos parâmetros | “O exemplo atende à comparação dos grupos informados com repetição da UA. Para categorias ambientais, é necessário representar também os ambientes replicados. Um efeito aleatório de UA não resolve sozinho essa hierarquia.” | v1 |
| Longitudinal comparativo | Modelo e cuidados | 4, 11.4, 13 | regra automática | novo: fórmula conforme objetivo A ou B e níveis presentes | A fórmula deve refletir a pergunta e a hierarquia. Adiar a troca automática até haver identificadores, replicação e análise validada. Não alternar só pelo nome “rio”, “estuário” ou “reservatório”. | PENDENCIA-V2 |
| Longitudinal comparativo | Definições, procedimentos; Modelo e cuidados | 8.1, 9, 10 | texto de ajuda ("saiba mais") | complementa o que já existe: protocolo e características iniciais | “Em unidades instaladas, padronize e registre origem, tamanho, densidade e manejo. Crescimento e sobrevivência integram várias condições; não identificam sozinhos qual variável ambiental atuou.” | v1 |
| Longitudinal comparativo | Ficha do delineamento → Coleta e Orientações; Modelo e cuidados | 8.5, 14 | regra automática | novo: resumo automático de uma base individual | “As medidas individuais serão resumidas por UA e visita, com método e contagem apresentados.” Proposta para o preparo da análise; a ficha atual é vazia e já espera o resumo por UA × momento. | PENDENCIA-V2 |
| Longitudinal comparativo | Resumo | 8.3, 12.7 | item do Resumo | já coberto: UAs, momentos e linhas | Manter as contagens atuais, identificadas como unidades acompanhadas e registros. Não apresentá-las como número de ambientes independentes. | v1 |

**A fórmula deve mudar entre A e B?** Sim, conceitualmente, mas não recomendo uma troca automática agora. No objetivo A, ambiente específico pode entrar como fator fixo; a repetição temporal é da UA, e locais compartilhados podem exigir outro agrupamento. No objetivo B, categoria é o fator de interesse e ambientes distintos dentro de categoria fornecem sua replicação; locais e tanques são níveis internos, conforme o desenho. O atual exemplo de `nlme::lme` com intercepto aleatório da UA é um ponto de partida, não um modelo universal para os dois objetivos. Preservar a explicação curta dos parâmetros e acrescentar o limite de aplicação é suficiente para a v1. A escolha entre tempo numérico, momentos como categorias e correlação temporal também depende da pergunta, não apenas de A ou B.

**O que não acrescentar agora:** painel completo de hidrodinâmica, desenho com quatro níveis obrigatório, modelos binomiais automáticos, marcação individual de animais ou cálculo de poder para modelos hierárquicos. O desenho genérico atual continua útil para mesas, viveiros, tanques, árvores e outras UAs.

### Estudo de gradiente

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Estudo de gradiente | Organizar e avaliar → Ambiente; Fonte ou origem do gradiente | 6, 7, 12.4 | texto de ajuda ("saiba mais") | complementa o que já existe: contexto, fonte e conectividade da curadoria 04 | “Descreva o caminho da água e as conexões entre estações. A distância em linha reta pode não representar a conexão pelo fluxo.” | v1 |
| Estudo de gradiente | Organizar e avaliar → Procedimento e distribuição das subamostras | 7.1, 7.2 | texto de ajuda ("saiba mais") | complementa o que já existe: distribuição espacial | “Use o piloto para avaliar a extensão da pluma e a heterogeneidade entre locais. Não há distância universal que garanta independência.” Não converter distâncias ilustrativas em regra automática. | v1 |
| Estudo de gradiente | Organizar e avaliar → Referências e decisões ainda pendentes | 7.2 | texto de ajuda ("saiba mais") | complementa o que já existe: decisões de planejamento | “Registre o que o piloto sustentou sobre espaçamento, número de locais e viabilidade da coleta; anote o que ainda precisa ser verificado.” | v1 |
| Estudo de gradiente | Organizar e avaliar → Segundo gradiente e outros fatores a medir; Período, maré / hidrologia e ordem de visita | 6, 10 | texto de ajuda ("saiba mais") | já coberto: confundidores, condições de coleta e janela na curadoria 04 | Manter os campos. Variáveis ambientais que acompanham o gradiente não devem ser interpretadas automaticamente como mecanismo causal. | v1 |
| Estudo de gradiente | Organizar e avaliar → Registro dentro de cada estação; Modelo e cuidados | 8.4, 8.5 | conteúdo de Modelo e cuidados | complementa o que já existe: opção de resumo ou amostra composta; alguns textos antigos ainda dizem “somar no pool” | “Uma estação pode gerar um resumo de medidas ou uma amostra composta física. A escolha depende da resposta; média e pool não são equivalentes.” Alinhar os textos antigos à distinção já presente no formulário. | v1 |
| Estudo de gradiente | Organizar e avaliar → Ambiente; Modelo e cuidados | 4, 12.4 | conteúdo de Modelo e cuidados | novo: gradiente entre ambientes | “Se o preditor caracteriza reservatórios, os reservatórios são as unidades dessa comparação. Vários tanques no mesmo reservatório não acrescentam novos valores independentes do gradiente ambiental.” | v1 |
| Estudo de gradiente | Ficha do delineamento; Desenho | 3, 12.4, 13 | coluna ou texto da Ficha | novo: representação de ambientes com níveis internos | Cadastro e resumo por ambiente exigem evolução da ficha. Não reaproveitar silenciosamente “estação” para representar qualquer um dos níveis. | PENDENCIA-V2 |
| Estudo de gradiente | Organizar e avaliar → Campanhas previstas; Modelo e cuidados | 8.2 a 8.5 | aviso ou alerta | já coberto: revisitas não são novas estações; ficha atual de uma campanha | Manter o aviso. Uma análise com revisitas exige registro temporal próprio; não prometer que a ficha atual já representa essa estrutura. | v1 |

**Não se aplica automaticamente:** ração, densidade e confinamento em gradientes medidos diretamente na natureza. O exemplo de estado trófico entre reservatórios complementa o módulo, mas não deve substituir os exemplos atuais de praia, rio e fonte de poluição. Medidas repetidas só se aplicam quando há revisitas às mesmas UAs.

### Estudos de impacto (BA, CI, BACI)

CI, BA e BACI continuam sendo opções de Definições, sem novas sub-abas.

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Estudos de impacto (BA, CI, BACI), opção CI | Definições; Modelo e cuidados | 4, 5, 12.5 | conteúdo de Modelo e cuidados | complementa o que já existe: locais por condição, curadoria 01 | “CI compara controle e impacto no recorte observado. Sem informação anterior, a diferença também pode refletir diferenças que já existiam entre os locais.” | v1 |
| Estudos de impacto (BA, CI, BACI), opção BA | Definições; Modelo e cuidados | 6, 8.3, 12.5 | conteúdo de Modelo e cuidados | complementa o que já existe: antes e depois nas mesmas UAs | “BA acompanha a mudança nos locais estudados. Sem controle, mudanças gerais no tempo podem acompanhar a mudança atribuída ao impacto.” | v1 |
| Estudos de impacto (BA, CI, BACI), opção BACI | Definições; Modelo e cuidados | 6, 12.5 | conteúdo de Modelo e cuidados | já coberto: controle e impacto, antes e depois; replicação espacial e temporal na curadoria 01 | Manter a interação condição × período como contraste do desenho. Não acrescentar a promessa de que BACI, sozinho, comprova causalidade. | v1 |
| Estudos de impacto (BA, CI, BACI), opção BACI | Metodologia para artigo | 10, 12.5 | frase da Metodologia para artigo | complementa o que já existe: alcance da interpretação | “A mudança nos locais de impacto será comparada à mudança nos controles, considerando a comparabilidade dos locais e as condições das campanhas.” | v1 |
| Estudos de impacto (BA, CI, BACI), opções CI e BACI | Modelo e cuidados | 5, 6, 7 | texto de ajuda ("saiba mais") | complementa o que já existe: independência dos locais | “Avalie conexões pelo fluxo e eventos compartilhados entre locais. Estar fora da área visual do impacto ou a certa distância não garante independência.” | v1 |
| Estudos de impacto (BA, CI, BACI), opções BA e BACI | Ficha do delineamento; Metodologia para artigo | 6, 8.2 | coluna ou texto da Ficha | já coberto na curadoria 01: condições comparáveis e campanhas sincronizadas | Manter a identificação das UAs e condições de coleta. O guia não justifica refazer a ficha, o calendário ou as exportações. | v1 |
| Estudos de impacto (BA, CI, BACI), quando houver organismos instalados | Definições, procedimentos; Modelo e cuidados | 2.2, 9, 10, 12.5 | texto de ajuda ("saiba mais") | novo: aplicação condicional com sentinelas | “Se instalar organismos nos locais, registre origem e manejo comuns. A resposta também pode refletir transporte, confinamento e efeitos do cultivo.” Usar ajuda breve, não campos obrigatórios. | v1 |

**Não se aplica:** repetir a UA no tempo em CI de uma campanha; criar controle em BA sem mudar a modalidade escolhida; exigir tanques-rede em qualquer avaliação de impacto. O checklist amplo, a matriz de esforço e as campanhas adicionais da curadoria 01 já têm origem própria e não devem ser registrados como novidades deste guia.

### Monitoramento

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Monitoramento | Desenho; Ficha do delineamento | 6, 8.3 | elemento do Desenho (infográfico) | já coberto: locais fixos e datas, uma linha por data × local | Manter o desenho e a quadrícula de registros. Mais datas não significam mais locais independentes. | v1 |
| Monitoramento | Definições; Modelo e cuidados | 6, 8.2 | conteúdo de Modelo e cuidados | complementa o que já existe: horário, esforço e coleta | “Mantenha esforço e condições de coleta comparáveis. Anote mudanças de horário, método e operação que possam acompanhar a variação da série.” | v1 |
| Monitoramento | Modelo e cuidados | 6, 7 | texto de ajuda ("saiba mais") | novo: dependência espacial entre locais, se houver vários | “Locais conectados pela mesma água podem compartilhar eventos. A série de cada local não prova que os locais são independentes.” | v1 |
| Monitoramento | Ficha do delineamento, planilha dados; Modelo e cuidados | 8.1, 8.3 | coluna ou texto da Ficha | complementa o que já existe: registro da coleta e esforço | “Zero observado e coleta não realizada são situações diferentes. Registre o motivo quando faltar a coleta e preserve a sequência prevista.” Não alterar as fórmulas dos índices. | v1 |
| Monitoramento | Ficha do delineamento, planilhas dados e metadados | 8.5 | regra automática | novo: consolidação de registros detalhados | “O resumo depende da medida: captura e esforço não devem ser reduzidos automaticamente por média.” Adiar qualquer agregação e preservar a base dos índices. | PENDENCIA-V2 |

**Não recomendo incorporar:** objetivo A/B como seletor obrigatório, ração, lote, densidade, desenho hierárquico de tanques ou fórmula de modelo misto comparativo. O Monitoramento acompanha séries e tem seus próprios requisitos. Frequência, duração e esforço já são tratados na curadoria 02; não é necessário duplicar esse conteúdo.

## 4. Itens relacionados, fora dos cinco módulos

As localizações abaixo usam os painéis existentes dos itens relacionados. Não propõem novas abas. Esses painéis têm nomes próprios, diferentes das seis abas dos delineamentos observacionais.

| Módulo(s) | Aba / Sub-aba | Seção do guia | Tipo | Situação | Texto proposto | Prioridade |
|---|---|---|---|---|---|---|
| Conceitos antes da coleta | Cartão existente “Escolha o tipo de estudo” | 2.1, 2.2, 11.1 | texto de ajuda ("saiba mais") | complementa o que já existe: observar ou manipular | “Instalar peixes padronizados em ambientes não sorteados organiza a comparação. O fator ambiental continua observacional.” | v1 |
| Conceitos antes da coleta | Cartão existente “Identifique a unidade experimental ou amostral” | 3 a 5, 8.4 | texto de ajuda ("saiba mais") | complementa o que já existe: peixe, tanque e pool | “A UA depende da pergunta. Para comparar categorias de reservatórios, cada reservatório fornece uma réplica; os tanques descrevem sua variação interna.” | v1 |
| Conceitos antes da coleta | Cartão existente “Padronize antes de comparar” | 9, 10, 11 | texto de ajuda ("saiba mais") | complementa o que já existe: controlar diferenças de porte e procedimento | “Padronizar reduz explicações alternativas, mas não garante que toda diferença restante tenha uma única causa.” Substituir uma frase excessivamente causal, em vez de acrescentar outro cartão. | v1 |
| Quanto amostrar | Ajuda das calculadoras existentes, especialmente Comparação de médias | 4, 7.2, 11.3 | texto de ajuda ("saiba mais") | complementa o que já existe: n na unidade independente | “Antes de calcular n, defina a unidade da pergunta. Para categorias ambientais, conte ambientes distintos por categoria, não peixes, tanques ou visitas.” As calculadoras simples não dimensionam toda a hierarquia. | v1 |
| Quanto amostrar | Ajuda existente das calculadoras | 7.2 | regra automática | novo: ICC, efeito de delineamento e poder hierárquico | “Dados de piloto podem orientar o esforço entre ambientes, locais e unidades internas.” Adiar o cálculo automático; a aproximação de efeito de delineamento não é fórmula universal para quatro níveis e tempo. | PENDENCIA-V2 |
| Como amostrar | Ajuda existente sobre seleção e sorteio | 11.2, 15 | texto de ajuda ("saiba mais") | complementa o que já existe: lista elegível e amostragem | “Sortear ambientes de uma lista melhora a seleção da amostra. Isso não sorteia a condição ambiental nem elimina os fatores que a acompanham.” | v1 |
| Onde amostrar | Ajuda existente; Mapa | 6, 7 | texto de ajuda ("saiba mais") | complementa o que já existe: localização dos pontos | “O mapa mostra a distribuição. Avalie também fluxo, conexões e resultados do piloto; distância entre pontos não comprova independência.” | v1 |
| Onde amostrar | Mapa | 6, 7.2 | regra automática | novo: avaliar conectividade, pluma ou autocorrelação | Não prometer diagnóstico de independência pelo mapa. Avaliação quantitativa fica para PENDENCIA-V2, articulada às pendências já existentes de distribuição e dependência espacial. | PENDENCIA-V2 |
| ANOVA com subamostras | Leitura do delineamento; As duas análises; Código R | 8.4, 11.3 | texto de ajuda ("saiba mais") | já coberto: médias por UA, subamostras mantidas no modelo e comparação didática | Manter. O módulo já distingue médias por UA e modelo com agrupamento, com escopo de um fator fixo e um nível de agrupamento. | v1 |
| ANOVA com subamostras | Leitura do delineamento | 3, 4, 8.5 | aviso ou alerta | complementa o que já existe: limite de agrupamento | “Este módulo não representa sozinho visitas repetidas e vários níveis, como ambiente, local e tanque.” Não encaminhar automaticamente a estrutura completa para ele. | v1 |
| ANOVA de medidas repetidas | Configurar e executar, ajuda junto aos seletores | 8.4, 8.5, 11.4 | texto de ajuda ("saiba mais") | complementa o que já existe: uma linha por unidade e ocasião | “Se houver várias medidas dentro da UA na mesma visita, defina seu resumo antes da análise. Repetir a UA no tempo não é o mesmo que medir vários animais dentro dela.” | v1 |
| ANOVA de medidas repetidas | Configurar e executar | 11.4, 13 | aviso ou alerta | novo: diferença para o longitudinal comparativo | “O painel atual analisa a mudança entre ocasiões. Ele não recebe automaticamente grupo × tempo nem a hierarquia ambiental do longitudinal comparativo.” O formulário atual tem resposta, unidade e ocasião, sem seletor de grupo. | v1 |
| Parcelas Subdivididas (Split-Plot) | Descrição | 12.6 | texto de ajuda ("saiba mais") | novo: exemplo híbrido apenas como explicação | “Rações sorteadas entre tanques permitem avaliar o componente experimental da ração. Reservatórios preexistentes continuam sendo um componente observacional.” Não usar esse caso para substituir o sorteio do desenho clássico. | v1 |
| Parcelas Subdivididas (Split-Plot) | Ficha de campo; Descrição | 12.6 | regra automática | novo: geração e análise do desenho híbrido | O exemplo precisa de ficha e análise próprias para distinguir fatores sorteados e preexistentes, além da replicação em cada nível. Preservar o gerador clássico atual. | PENDENCIA-V2 |

**Nota sobre “n efetivo”:** para categorias, o número de ambientes é a contagem de réplicas ambientais. Isso não equivale automaticamente ao tamanho amostral efetivo calculado a partir de uma correlação. Na v1, prefiro “número de ambientes por categoria”. Usar a mesma expressão para contagem do delineamento e ajuste por ICC confundiria duas coisas diferentes.

## 5. Estrutura combinada: subamostras dentro de medidas repetidas

### O que cabe agora

O Longitudinal comparativo já apresenta essa organização: cada UA volta nas visitas; as medidas internas são resumidas; a coleta tem uma linha por UA × momento e uma coluna `n_medidas`. O aplicativo gera uma ficha vazia, portanto ainda não recebeu os dados individuais que precisaria agregar. Não é adequado anunciar “agregação automática realizada” nessa tela.

Na v1, manter esse formato e explicar o procedimento em **Ficha do delineamento → Orientações**. Em **Modelo e cuidados**, basta a referência curta ao resumo por UA e visita, sem repetir o texto completo. Não há necessidade de uma quinta sub-aba nem de alterar o infográfico.

### Onde uma agregação futura se aplica

| Módulo | Aplicação | Local da mensagem no planejamento | Encaminhamento |
|---|---|---|---|
| Longitudinal comparativo | Sim, quando várias medidas resumíveis pertencem à mesma UA na mesma visita | Ficha do delineamento → Orientações; nota breve em Modelo e cuidados | PENDENCIA-V2 para preparo e passagem à análise |
| Transversal comparativo | Sim, para medidas internas de uma UA, em uma coleta única; sem etapa temporal | Ficha do delineamento; Modelo e cuidados | Não confundir com pool físico nem impor agregação à ANOVA com subamostras |
| Estudo de gradiente | Sim, para resumo por estação; revisitas exigem estrutura temporal adicional | Organizar e avaliar → Registro dentro de cada estação; Ficha do delineamento | A ficha atual representa uma campanha |
| Estudos de impacto (BA, CI, BACI) | CI: por local na campanha; BA e BACI: por UA e campanha, quando apropriado | Ficha do delineamento; Modelo e cuidados | Preservar modalidade, esforço e identidade dos locais |
| Monitoramento | Condicional; pode exigir somas, esforço e cálculo de índices, em vez de médias | Ficha do delineamento; Modelo e cuidados | Não adotar média automática geral |

### Proposta conservadora para PENDENCIA-V2

A agregação pode ser o caminho sugerido por padrão **depois** de o pesquisador informar a estrutura e o significado da resposta. Linhas repetidas não bastam para identificar subamostras: podem ser duplicatas, erros, espécies diferentes, tecidos diferentes ou medições técnicas. A rotina precisa reconhecer os identificadores declarados, verificar a chave UA × momento e mostrar como a base será resumida. Não deve substituir os dados brutos nem eliminar a alternativa de um modelo que mantenha as medidas internas.

O local de execução é o preparo dos dados ou a entrada da análise, não a geração da ficha vazia. Seu resultado deve integrar a trilha reprodutível já existente. Isso é uma evolução específica, sem novo menu e sem presumir que o longitudinal já dispõe de passagem validada para a análise completa.

Para cada resposta, registrar método de resumo, número de valores válidos e tratamento dos ausentes. Média pode ser apropriada para peso e comprimento; soma ou proporção pode ser apropriada para outra resposta. Sobrevivência exige numerador, denominador e regras para retiradas e reposições. Não se calcula sobrevivência a partir apenas da biometria dos animais encontrados vivos.

### Colunas e contagens

Na planilha **coleta** do Longitudinal comparativo, manter `n_medidas` como quantidade efetivamente medida, separada da previsão registrada em Orientações. Na futura rotina com várias respostas e ausências diferentes, cada resposta pode precisar de sua própria contagem de valores válidos. Um único `n_medidas` não deve afirmar que peso, comprimento e outra variável tiveram o mesmo número válido se isso não ocorreu.

Nos demais módulos, uma coluna de número de medidas só deve ser proposta quando houver medidas internas resumidas. Não substituir `pool` nem usá-lo como essa contagem. Identificadores de ambiente e local são necessários se esses níveis fizerem parte da pergunta, mas a inclusão automática dessas colunas fica para PENDENCIA-V2. A unidade não deve ser deduzida de um nome como “tanque” ou “árvore”.

### Mensagens em três variações

São textos para a situação **confirmada pelo pesquisador**, com quantidades e método preenchidos a partir dos dados. Na ficha de planejamento, usar o futuro; depois da execução, informar o que foi efetivamente feito.

**Peixes em tanque-rede, no planejamento:** “Os peixes medidos em cada tanque e visita serão resumidos pela média do peso, registrando a quantidade medida em n_medidas. As visitas acompanharão o mesmo tanque; peixes e visitas não serão contados como novos tanques.”

**Peixes em tanque-rede, depois da agregação:** “Resumimos o peso dos peixes pela média de cada tanque em cada visita, usando os valores válidos. A base ficou com [n] tanques e [r] registros tanque × visita. As [v] visitas são medidas repetidas dos tanques.”

**Folhas em árvore, no planejamento:** “Se as folhas forem subamostras da árvore, suas medidas serão resumidas por árvore e campanha, com a quantidade medida registrada. As campanhas acompanharão a mesma árvore; folhas e campanhas não acrescentarão árvores independentes.”

**Folhas em árvore, depois da agregação:** “Resumimos as medidas das folhas por árvore e campanha usando [método]. Foram mantidas [n] árvores e [r] registros árvore × campanha, com a contagem válida de cada resposta.”

**Amostras de água no mesmo local, no planejamento:** “Se as amostras forem subamostras do mesmo local na mesma visita, será produzido um resumo por local e visita, com a quantidade válida registrada. Uma mistura física será identificada como amostra composta.”

**Amostras de água no mesmo local, depois da agregação:** “Resumimos as medidas das amostras por local e visita usando [método]. A base ficou com [n] locais e [r] registros local × visita. Esse resumo de medidas não representa mistura física das amostras.”

Essas mensagens não declaram que os tanques, árvores ou locais são independentes. A validade dessa suposição continua dependendo do desenho e das condições de campo.

## 6. Seções do guia sem destino claro ou que exigem outra etapa

- **2.1, contraexemplo dos carvalhos:** rende mais como exemplo didático no livro ou no material de apoio. Não acrescentar um caso longo de aves e carvalhos aos formulários de pesca e aquicultura. Excluir aves é manipular um fator; não presumir detalhes do sorteio sem consultar o estudo original.
- **7.1 e 7.2, protocolo completo do piloto:** pode ficar no guia vinculado à ajuda de Onde amostrar. Não cabe inteiro na interface; medição da pluma, perfis de água e componentes de variância exigem trabalho de campo e análise própria.
- **7.2, ICC, efeito de delineamento e poder:** destino conceitual em Quanto amostrar, mas sem implementação automática na v1. A expressão simplificada não dimensiona qualquer hierarquia espacial e temporal.
- **9, detalhes de alimentação, transporte e reposição:** úteis para o protocolo específico do projeto. Não devem virar campos obrigatórios para todos os estudos, especialmente árvores, água, pesca extrativa e unidades naturais.
- **10, diagramas causais e evidências complementares:** cabem na discussão metodológica do livro e do guia; não proponho um editor de diagramas no planejamento.
- **12.1 a 12.4 e 12.7, coleção completa de exemplos:** manter como apoio. O Longitudinal comparativo já tem um exemplo compreensível; não acrescentar um seletor A1/A2/B1/B2 aos formulários.
- **12.5, mesocosmos e experimentos de mecanismo:** ajudam a discutir estudos complementares. Não exigem novo módulo nem transformam automaticamente o estudo ambiental em DIC.
- **12.6, execução do híbrido:** há destino didático em Parcelas Subdivididas, mas a geração e análise desse caso precisam de especificação própria. O fator ambiental preexistente não deve receber o sorteio de uma parcela experimental clássica.
- **13, esboço completo em R:** material de estudo, não código pronto a copiar para os módulos. Exige conferir identificação, ausentes, ordenação temporal antes de first/last, pesos dos resumos e estrutura residual. O exemplo de sobrevivência acumulada em várias visitas também exige revisão da dependência entre contagens; não deve virar um GLMM automático apenas por transcrição.
- **14, novos seletores e automação:** foram distribuídos como propostas nas tabelas. Não são especificação aprovada.
- **15, checklist completo:** os itens relevantes cabem nos cuidados existentes; não recomendo uma nova aba de checklist. Um futuro checklist dinâmico exigiria saber quais itens realmente se aplicam ao plano.
- **16, referências:** permanecer no guia e no material de apoio. O próprio guia pede conferência antes da citação formal. Este mapa não verifica DOI, páginas ou todas as afirmações nas fontes originais.

### Ajustes de linguagem ao usar o guia

Algumas frases do guia funcionam como atalhos didáticos, mas não devem virar regras rígidas. Sorteio, distância, resíduos pouco correlacionados ou um modelo misto não certificam independência. “Posso embaralhar os rótulos?” ajuda a explicar subamostras, mas não basta para classificar qualquer estrutura. Graus de liberdade dependem do modelo e da estimação; o aplicativo não deve diagnosticar erro só por compará-los a uma conta ilustrativa. Os números de tanques, locais e ambientes apresentados nos desenhos são exemplos, não mínimos universais.

## 7. Escopo recomendado e decisões do autor

Para uma aplicação discreta, começaria por cinco ajustes: esclarecer ambientes específicos versus categorias na ajuda junto à pergunta; usar o campo de origem já existente para explicar local compartilhado; distinguir mortalidade observada de medida ausente; limitar explicitamente o alcance da fórmula atual; e alinhar os textos de pool no Estudo de gradiente à distinção já disponível no formulário. Fora dos módulos, o cartão de padronização pode receber uma frase menos causal. Os demais textos das tabelas são possibilidades localizadas, não um pacote para inserir inteiro.

Preservar os cinco módulos, as seis abas comuns, Organizar e avaliar no Estudo de gradiente e as quatro sub-abas da ficha longitudinal. Preservar também símbolos genéricos, esquema do infográfico, downloads e estrutura de cada Excel. Nenhuma nova aba ou sub-aba é indispensável para os esclarecimentos da v1.

Perguntas para uma próxima decisão, sem impedir este mapa:

1. A distinção entre ambientes específicos e categorias deve permanecer como ajuda junto à pergunta, como recomendo, ou evoluir depois para uma escolha formal que também altere a ficha?
2. Qual exemplo deve orientar uma futura estrutura hierárquica: comparação dos três estuários específicos ou categorias ambientais com vários ambientes por categoria?
3. A futura agregação deve começar apenas com peso e comprimento no Longitudinal comparativo, antes de incluir sobrevivência, captura e outras respostas?
4. Na v1, prefere disponibilizar o guia completo como apoio ou somente os poucos esclarecimentos prioritários indicados acima?

Não há alteração de código neste trabalho. O mapa oferece um conjunto pequeno para a v1 e separa as evoluções que poderiam tornar os módulos mais difíceis de entender.
