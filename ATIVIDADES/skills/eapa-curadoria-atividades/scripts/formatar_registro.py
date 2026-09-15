"""Monta e formata o REGISTRO_FONTES_DADOS_EAPA.xlsx na identidade Ocean Gradient.

Rodar da raiz de ATIVIDADES/ (o script R chama este por ultimo):

    python skills/eapa-curadoria-atividades/scripts/formatar_registro.py

Divisao de trabalho:
  o R grava a aba `fontes` (os dados, que vem do proprio arquivo);
  este script estiliza `fontes` e **constroi** a aba `resumo`, porque resumo e
  apresentacao: precisa de titulo de bloco, cores por situacao e larguras — e o
  writexl nao faz nada disso (ele ainda deixava uma linha vazia no topo).

Colunas do resumo, na ordem:
  1. Análise no menu da CatalyseR  — o item como o aluno o encontra na IDE;
  2. Teste estatístico             — a coluna principal e destacada, porque foi
                                     o teste que orientou a escolha do conjunto;
  3. Conjunto canônico no EAPADados
  4. Arquivo externo (em ATIVIDADES/dados)
  5. Atividade (número no índice do pilar)
  6. Situação
  7. Externo no disco (conferido no disco a cada geração)

Nenhum valor de `fontes` e alterado.
"""

import os

from openpyxl import load_workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter

CAMINHO = "dados/REGISTRO_FONTES_DADOS_EAPA.xlsx"
PASTA_DADOS = "dados"
N_COL = 7

# paleta Ocean Gradient
NAVY, TEAL, SEAFOAM = "FF0F3B5F", "FF2E7D8F", "FF62B6B7"
AMBER, CORAL = "FFE89B3C", "FFE76F51"
VERDE_TXT, CORAL_TXT, AMBAR_TXT = "FF1E6B45", "FFB33A22", "FF8A5A12"
SAGE, ZEBRA, CINZA, CINZA_T = "FFE7EFEA", "FFF4F8FA", "FFEFEFEF", "FF6B7A85"
AMBER_T, CORAL_T, SEAFOAM_T = "FFFDF2E0", "FFFBE3DE", "FFDCF0F1"

fino = Side(style="thin", color="FFD6E2E8")
borda = Border(bottom=fino, left=fino, right=fino)
central = Alignment(horizontal="center", vertical="center", wrap_text=True)
esquerda = Alignment(horizontal="left", vertical="top", wrap_text=True)
meio = Alignment(horizontal="left", vertical="center")
meio_topo = Alignment(horizontal="left", vertical="center", wrap_text=True)


def pintar(celula, fundo=None, cor=None, negrito=False, tam=10, alinhamento=None):
    if fundo:
        celula.fill = PatternFill("solid", fgColor=fundo)
    celula.font = Font(name="Calibri", size=tam, bold=negrito,
                       color=cor or "FF1F2A33")
    if alinhamento is not None:
        celula.alignment = alinhamento
    celula.border = borda


# ---------------------------------------------------------------- catalogo
# menu da CatalyseR | teste estatistico | canonico no EAPADados | arquivo
# externo | atividade | situacao
CATALOGO = [
    ("Preparando Dados", "(sem teste)", "treino_coletas; treino_desembarque",
     "preparar_dados_treino.xlsx", "",
     "Parcial: arquivo externo didático e temporário, sem atividade"),
    ("Estatística descritiva · Histograma · Boxplot", "(sem teste)",
     "biometria_caranguejos", "A criar", "", "Falta arquivo externo e atividade"),
    ("Tabela de frequência · Pizza · Barras", "(sem teste)", "captura_petrechos",
     "A criar", "", "Falta arquivo externo e atividade"),
    ("Dispersão · Linear simples", "Regressão linear simples", "camarao_vannamei_biometria",
     "regressao_otolito_comprimento.xlsx; regressao_otolito_comprimento_reduzido.xlsx", "#9",
     "Completo"),
    ("Linhas", "(sem teste)", "captura_pescada_amarela", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Não linear (crescimento)", "Regressão não linear",
     "cangulo_crescimento; tilapia_crescimento", "A criar", "",
     "Falta definir canônico e arquivo externo"),
    ("Logística", "Regressão logística", "A definir", "A criar", "",
     "Falta canônico e arquivo externo"),
    ("Linear múltipla (em dev.)", "Regressão linear múltipla",
     "truta_riacho_crescimento; tilapia_microalgas (a atividade usa conjunto distinto)",
     "mercurio_lago_escravo.xlsx", "#10", "Completo"),
    ("Teste t", "Teste t", "artemia", "A criar", "",
     "Falta arquivo externo (canônico a confirmar)"),
    ("ANOVA de um fator", "ANOVA de um fator", "isoproteica_bagre",
     "anova_tilapia_anestesia.xlsx", "#8", "Completo"),
    ("ANOVA de dois fatores", "ANOVA de dois fatores (interação)",
     "salvelino_formalina_remocao", "salvelino_formalina_remocao.xlsx", "#6", "Completo"),
    ("Atividade de leitura (sem menu próprio)", "(sem teste)",
     "gammarus_dieta_temperatura_resumo", "gammarus_dieta_temperatura_resumo.xlsx", "#7",
     "Completo"),
    ("ANCOVA", "ANCOVA", "bagley_lwr_central_america", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Qui-quadrado", "Qui-quadrado de independência", "lagostas_kelp_sexo",
     "Banco externo (não incorporado)", "#1",
     "Falta o arquivo externo local (a atividade #1 usa banco externo)"),
    ("Mann–Whitney", "Mann–Whitney", "darter_ontario", "darter_ontario.xlsx", "#2",
     "Completo"),
    ("Mann–Whitney (2º contexto)", "Mann–Whitney", "darter_ontario",
     "truta_touro_manejo.xlsx", "#3", "Completo"),
    ("Wilcoxon", "Wilcoxon pareado", "idades_savel_repetibilidade",
     "otolitos_salmonete.xlsx", "#4", "Completo"),
    ("Kruskal–Wallis", "Kruskal–Wallis (+ Holm)", "cpue_tubarao", "esturjao_palido.xlsx",
     "#5", "Completo"),
    ("PCA", "PCA (multivariada)",
     "peixes_nutricao_portugal; peixes_morfometria_multivariada", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Agrupamentos (HCA)", "HCA (agrupamentos)", "morfometria_barbo; brine_carbonatos",
     "A criar", "", "Falta arquivo externo e atividade"),
    ("Heatmap", "(sem teste)", "recifes_ostras_heatmap", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Coroplético", "(sem teste)", "aquicultura_br", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Pontos/estações · Bolhas", "(sem teste)", "estacoes_ictiofauna", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Séries temporais", "Séries temporais", "captura_pescada_amarela", "A criar", "",
     "Falta arquivo externo e atividade"),
    ("Normal · Binomial", "(sem teste)", "Não se aplica", "Não se aplica", "",
     "Não se aplica (visualizadores conceituais)"),
]

SEM_ARQUIVO = {"A criar", "Não se aplica", "Banco externo (não incorporado)"}


def no_disco(texto):
    """Confere no disco os arquivos externos nomeados (nao confia no texto)."""
    if texto in SEM_ARQUIVO or texto.startswith("CATALYSER/"):
        return "-"
    arquivos = [a.strip() for a in texto.split(";") if a.strip().endswith(".xlsx")]
    if not arquivos:
        return "-"
    return "SIM" if all(os.path.exists(os.path.join(PASTA_DADOS, a)) for a in arquivos) else "NÃO"


wb = load_workbook(CAMINHO)

# --------------------------------------------------------------------- fontes
ws = wb["fontes"]
larguras = {
    "id_fonte": 34, "origem": 52, "tipo_fonte": 16, "data_acesso": 12,
    "licenca": 15, "status_licenca": 19, "area": 26, "tema": 32,
    "unidade_observacional": 28, "estrutura_estatistica": 34,
    "destino_pretendido": 26, "decisao": 20, "arquivo_local": 46,
    "observacoes": 58,
}
colunas = {c.value: c.column for c in ws[1]}
for nome, largura in larguras.items():
    if nome in colunas:
        ws.column_dimensions[get_column_letter(colunas[nome])].width = largura

for celula in ws[1]:
    pintar(celula, fundo=NAVY, cor="FFFFFFFF", negrito=True, alinhamento=central)
ws.row_dimensions[1].height = 32

fill_decisao = {"aceitar": SAGE, "aceitar_com_restricoes": AMBER_T,
                "pedir_autorizacao": CORAL_T}
fill_status = {"publico_aberto": SAGE, "livro_com_autorizacao_pendente": AMBER_T}

registros = []
for linha in range(2, ws.max_row + 1):
    valores = {nome: ws.cell(row=linha, column=col).value for nome, col in colunas.items()}
    if not valores.get("id_fonte"):
        continue
    registros.append(valores)
    zebra = ZEBRA if linha % 2 == 0 else None
    for celula in ws[linha]:
        pintar(celula, fundo=zebra, alinhamento=esquerda)
    for nome in ("data_acesso", "tipo_fonte", "licenca"):
        pintar(ws.cell(row=linha, column=colunas[nome]), fundo=zebra, alinhamento=central)
    valor = valores.get("decisao")
    if valor in fill_decisao:
        pintar(ws.cell(row=linha, column=colunas["decisao"]), fundo=fill_decisao[valor],
               negrito=True, alinhamento=central)
    valor = valores.get("status_licenca")
    if valor in fill_status:
        pintar(ws.cell(row=linha, column=colunas["status_licenca"]), fundo=fill_status[valor],
               alinhamento=central)
    # `estrutura_estatistica` diz para que o conjunto foi escolhido: e o campo
    # que liga o dado ao teste, entao ganha o mesmo destaque do resumo
    pintar(ws.cell(row=linha, column=colunas["estrutura_estatistica"]), fundo=SEAFOAM_T,
           negrito=True, cor=NAVY, alinhamento=esquerda)

ws.freeze_panes = "B2"
ws.auto_filter.ref = f"A1:{get_column_letter(ws.max_column)}{ws.max_row}"
ws.sheet_properties.tabColor = NAVY

# --------------------------------------------------------------------- resumo
if "resumo" in wb.sheetnames:
    del wb["resumo"]
rs = wb.create_sheet("resumo")

for col, largura in {1: 30, 2: 30, 3: 34, 4: 42, 5: 11, 6: 44, 7: 16}.items():
    rs.column_dimensions[get_column_letter(col)].width = largura

linha = 1
rs.merge_cells(start_row=linha, start_column=1, end_row=linha, end_column=N_COL)
pintar(rs.cell(row=linha, column=1), fundo=NAVY, cor="FFFFFFFF", negrito=True, tam=11,
       alinhamento=meio)
rs.cell(row=linha, column=1).value = "MENU DA CATALYSER × TESTE ESTATÍSTICO × DADOS × ATIVIDADE"
rs.row_dimensions[linha].height = 22

linha += 1
cabecalho = ["Análise no menu da CatalyseR", "Teste estatístico",
             "Conjunto canônico no EAPADados", "Arquivo externo", "Atividade",
             "Situação", "Externo no disco"]
for col, texto in enumerate(cabecalho, start=1):
    # o cabecalho da coluna do teste e NAVY; o resto e TEAL, para ela dominar
    fundo = NAVY if col == 2 else TEAL
    pintar(rs.cell(row=linha, column=col, value=texto), fundo=fundo, cor="FFFFFFFF",
           negrito=True, alinhamento=central, tam=11 if col == 2 else 10)
rs.row_dimensions[linha].height = 30
primeira_analise = linha + 1

for i, (menu, teste, canonico, externo, atividade, situacao) in enumerate(CATALOGO):
    linha += 1
    zebra = ZEBRA if i % 2 else None
    for col, texto in enumerate([menu, teste, canonico, externo, atividade, situacao,
                                 no_disco(externo)], start=1):
        pintar(rs.cell(row=linha, column=col, value=texto), fundo=zebra, alinhamento=esquerda)
    # a coluna do teste e a ancora da tabela: fundo proprio e texto NAVY
    pintar(rs.cell(row=linha, column=2), fundo=SEAFOAM_T, cor=NAVY, negrito=True,
           alinhamento=meio_topo)
    # o item do menu é a porta de entrada: legível, sem competir com o teste
    pintar(rs.cell(row=linha, column=1), fundo=zebra, cor="FF3C4A55", alinhamento=meio_topo)
    pintar(rs.cell(row=linha, column=5), fundo=zebra, alinhamento=central, negrito=True,
           cor=TEAL)
    if situacao == "Completo":
        pintar(rs.cell(row=linha, column=6), fundo=SAGE, cor=VERDE_TXT, negrito=True,
               alinhamento=esquerda)
    elif situacao.startswith("Parcial"):
        pintar(rs.cell(row=linha, column=6), fundo=AMBER_T, cor=AMBAR_TXT, negrito=True,
               alinhamento=esquerda)
    elif situacao.startswith("Falta"):
        pintar(rs.cell(row=linha, column=6), fundo=CORAL_T, cor=CORAL_TXT,
               alinhamento=esquerda)
    elif situacao.startswith("Existe"):
        pintar(rs.cell(row=linha, column=6), fundo=AMBER_T, cor=AMBAR_TXT,
               alinhamento=esquerda)
    else:
        pintar(rs.cell(row=linha, column=6), fundo=CINZA, cor=CINZA_T, alinhamento=esquerda)
    disco = rs.cell(row=linha, column=7).value
    if disco == "SIM":
        pintar(rs.cell(row=linha, column=7), fundo=SAGE, cor=VERDE_TXT, negrito=True,
               alinhamento=central)
    elif disco == "NÃO":
        pintar(rs.cell(row=linha, column=7), fundo=CORAL_T, cor=CORAL_TXT, negrito=True,
               alinhamento=central)
    else:
        pintar(rs.cell(row=linha, column=7), fundo=CINZA, cor=CINZA_T, alinhamento=central)
ultima_analise = linha

# --- contagens, calculadas a partir da aba fontes -------------------------
def contar(campo):
    total = {}
    for registro in registros:
        chave = (registro.get(campo) or "").strip()
        if chave:
            total[chave] = total.get(chave, 0) + 1
    return sorted(total.items(), key=lambda kv: (-kv[1], kv[0]))


com_arquivo = sum(1 for r in registros if "ATIVIDADES/dados" in (r.get("arquivo_local") or ""))
blocos = [
    ("", [("Fontes registradas", len(registros)),
          ("Com arquivo em ATIVIDADES/dados", com_arquivo)]),
    ("Por decisão", contar("decisao")),
    ("Por licença", contar("licenca")),
    ("Por status da licença", contar("status_licenca")),
    ("Por área", contar("area")),
]

linha += 1                                   # linha em branco
rs.merge_cells(start_row=linha, start_column=1, end_row=linha, end_column=N_COL)
pintar(rs.cell(row=linha, column=1), fundo=NAVY, cor="FFFFFFFF", negrito=True, tam=11,
       alinhamento=meio)
rs.cell(row=linha, column=1).value = "RESUMO DAS FONTES REGISTRADAS"
rs.row_dimensions[linha].height = 22

for titulo, itens in blocos:
    if titulo:
        linha += 1
        pintar(rs.cell(row=linha, column=1, value=titulo), fundo=SEAFOAM, negrito=True,
               alinhamento=meio)
        pintar(rs.cell(row=linha, column=2), fundo=SEAFOAM, alinhamento=central)
    for rotulo, valor in itens:
        linha += 1
        pintar(rs.cell(row=linha, column=1, value=rotulo), fundo=ZEBRA, alinhamento=meio)
        pintar(rs.cell(row=linha, column=2, value=str(valor)), fundo=ZEBRA,
               alinhamento=central, negrito=True, cor=TEAL)

# --- legenda ---------------------------------------------------------------
linha += 2
pintar(rs.cell(row=linha, column=1, value="LEGENDA"), fundo=SEAFOAM, negrito=True,
       alinhamento=meio)
rs.merge_cells(start_row=linha, start_column=2, end_row=linha, end_column=N_COL)
pintar(rs.cell(row=linha, column=2), fundo=SEAFOAM, alinhamento=meio)
legenda = [
    ("Teste estatístico", SEAFOAM_T, NAVY,
     "coluna principal: o teste para o qual o conjunto de dados foi escolhido"),
    ("Completo", SAGE, VERDE_TXT, "canônico no pacote + arquivo externo + atividade"),
    ("Parcial ...", AMBER_T, AMBAR_TXT,
     "tem arquivo externo, mas didático/temporário ou ainda sem atividade"),
    ("Falta ...", CORAL_T, CORAL_TXT, "pendência: falta arquivo externo, canônico ou atividade"),
    ("Existe no repositório da IDE", AMBER_T, AMBAR_TXT,
     "arquivos de teste moram no repositório da CatalyseR"),
    ("(sem teste)", CINZA, CINZA_T,
     "item do menu que não é teste: descrição, gráfico, mapa ou visualizador"),
    ("SIM / NÃO / -", CINZA, CINZA_T,
     "arquivo externo encontrado (ou não) em dados/ no momento da geração"),
]
for rotulo, fundo, cor, explicacao in legenda:
    linha += 1
    pintar(rs.cell(row=linha, column=1, value=rotulo), fundo=fundo, cor=cor, negrito=True,
           alinhamento=meio_topo)
    rs.merge_cells(start_row=linha, start_column=2, end_row=linha, end_column=N_COL)
    pintar(rs.cell(row=linha, column=2, value=explicacao), fundo=None, alinhamento=meio)

rs.freeze_panes = "C3"
rs.auto_filter.ref = f"A{primeira_analise - 1}:G{ultima_analise}"
rs.sheet_properties.tabColor = TEAL

wb.save(CAMINHO)
print(f"formatado: {CAMINHO}")
print(f"  fontes: {len(registros)} registros | resumo: {len(CATALOGO)} linhas de analise, "
      f"{linha} linhas")
