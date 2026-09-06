# Roteiro — Vídeo introdutório de R/RStudio para iniciantes da CatalyseR

**Formato:** 2 episódios de ~12 min para o YouTube.
**Público:** aluno que nunca usou R e vai começar pela CatalyseR.
**Tom:** conversa de bancada — calmo, sem jargão desnecessário, uma analogia de cozinha por episódio.
**Marcações:** `[TELA: ...]` = o que aparece/clicar na gravação. `⏱` = tempo-alvo acumulado.

> Dica de gravação: fale como se estivesse ao lado do aluno pela primeira vez. Repita o "porquê" de cada passo — o iniciante esquece o botão, mas guarda o motivo.

---

## Episódio 1 — Conhecendo a bancada (o RStudio por dentro)

**Objetivo:** o aluno abre o RStudio sem medo, entende os painéis, cria e salva um script, roda código de dois jeitos, enxerga os objetos e sabe reiniciar a sessão e organizar o trabalho.

### Abertura (0:00–1:00) ⏱1:00
Narração:
> "Oi! Se você vai usar a CatalyseR, esse vídeo é o seu ponto de partida. A CatalyseR roda dentro do R, então antes de tudo vamos conhecer a cozinha onde tudo acontece: o RStudio. Não precisa saber nada de programação — é só me acompanhar. Em uns doze minutos você vai se sentir em casa aqui."

Ideia-chave para falar: **R** é o motor (a linguagem); **RStudio** é a bancada onde a gente cozinha com esse motor. Uma coisa é o fogão, a outra é a cozinha inteira em volta.

### Os quatro painéis (1:00–3:30) ⏱3:30
`[TELA: RStudio aberto, painéis vazios]`
> "Repare que a tela se divide em quatro áreas. Pensa numa bancada de cozinha:"
- **Editor (canto superior esquerdo)** — a tábua onde você escreve e guarda suas receitas (os scripts). `[TELA: abrir um script vazio]`
- **Console (inferior esquerdo)** — a panela no fogo: o que você joga aqui é executado na hora. `[TELA: clicar no Console, digitar 2 + 2, Enter]`
- **Environment (superior direito)** — a despensa: mostra os ingredientes que você já preparou (os objetos). `[TELA: aba Environment]`
- **Arquivos/Plots/Packages/Help (inferior direito)** — o armário de utensílios: seus arquivos, gráficos, pacotes e a ajuda. `[TELA: passar pelas abas]`

> "Não precisa decorar. Ao longo do vídeo cada canto vai fazer sentido."

### Criar e salvar um script .R (3:30–5:30) ⏱5:30
`[TELA: File > New File > R Script]`
> "Vamos criar nossa primeira receita. File, New File, R Script. Isso abre um arquivo `.R` — é só um bloco de notas para código."
`[TELA: digitar]`
```r
# Meu primeiro script
peso <- c(120, 135, 150, 128)
mean(peso)
```
> "Tudo que começa com `#` é comentário — o R ignora, serve pra você anotar. Agora salve com Ctrl+S e dê um nome, tipo `aula01.R`. Repare que o R gosta de nomes sem espaço e sem acento."

Mencionar de passagem o `.qmd`:
> "Existe também o arquivo `.qmd`, que mistura texto e código para virar relatório — a CatalyseR gera um desses pra você. A gente mexe nele no próximo vídeo; por enquanto, fica só o nome no seu radar."

### Rodar: script vs console (5:30–7:30) ⏱7:30
> "Tem dois jeitos de executar código, e a diferença importa."
- **Pelo script:** clique numa linha e aperte **Ctrl+Enter** (Cmd+Enter no Mac). Ele roda aquela linha e desce pra próxima. `[TELA: rodar linha a linha]`
> "Esse é o jeito bom: fica registrado no arquivo, você repete quando quiser."
- **Pelo console:** digite direto e Enter. `[TELA: digitar mean(peso) no console]`
> "Rápido pra testar uma coisinha — mas some quando você fecha. Regra de bolso: **testa no console, guarda no script.**"

### O que são objetos (7:30–9:00) ⏱9:00
`[TELA: Environment mostrando 'peso']`
> "Quando você escreveu `peso <- c(...)`, aquela setinha guardou os números numa caixa chamada `peso`. Isso é um **objeto**. Olha na despensa, no Environment: ele está lá, pronto pra ser usado de novo."
`[TELA: digitar peso * 2]`
> "A setinha `<-` é o coração do R: dá nome às coisas pra reaproveitar. Todo objeto que você cria fica visível ali no canto."

### Reiniciar a sessão (9:00–10:30) ⏱10:30
> "De vez em quando a despensa fica bagunçada, ou algo trava. A solução mais saudável é reiniciar a sessão: **Session > Restart R** (Ctrl+Shift+F10)." `[TELA: menu Session > Restart R]`
> "Isso esvazia a memória e começa do zero — sem fechar o RStudio. É a melhor forma de garantir que seu script funciona sozinho, do começo ao fim. Se depois de reiniciar e rodar o script tudo funciona, você sabe que está reprodutível."

### Diretório de trabalho e Projetos (10:30–12:00) ⏱12:00
> "Última peça: o R sempre trabalha a partir de uma pasta, o **diretório de trabalho**. É onde ele procura seus dados e salva resultados."
`[TELA: getwd() no console]`
> "Dá pra mudar na marra com `setwd('caminho...')`, mas eu não recomendo — quebra fácil quando você troca de computador."
`[TELA: File > New Project]`
> "O jeito certo é criar um **Projeto** (.Rproj): File, New Project. Ele fixa a pasta sozinho, tudo fica organizado num lugar só. E é exatamente assim que a CatalyseR entrega o seu trabalho — num projetinho pronto."

Fecho:
> "É isso! Você já sabe se virar na bancada. No próximo vídeo a gente instala pacotes, entende o tal do Rtools e coloca a CatalyseR pra rodar. Até lá!"

---

## Episódio 2 — Pacotes, Rtools e instalando a CatalyseR

**Objetivo:** o aluno entende o que é um pacote, instala/carrega/remove pacotes, sabe quando o Rtools é preciso, e deixa a CatalyseR rodando.

### Abertura (0:00–1:00) ⏱1:00
> "Bem-vindo de volta! Agora vamos abastecer a cozinha. O R vem com o básico, mas quase tudo de bom vive em **pacotes** — e a CatalyseR é um deles. Bora aprender a instalar sem dor de cabeça."

### O que é um pacote (1:00–2:30) ⏱2:30
> "Pensa num pacote como uma **caixa de utensílios** especializada: uma pra fazer gráficos, outra pra ler Excel, outra pra estatística. Você instala uma vez (compra a caixa) e, quando vai usar, carrega com `library()` (tira a caixa da prateleira)."
`[TELA: aba Packages, mostrar a lista]`
> "Essa aba Packages, no canto inferior direito, é o seu armário: tudo que está instalado aparece aqui."

### Instalar pacotes: dois caminhos (2:30–5:00) ⏱5:00
- **Pelo botão:** `[TELA: aba Packages > Install]` digite o nome, por exemplo `readxl`, e Install.
> "Simples e visual. Bom pra começar."
- **Pelo código:** `[TELA: console]`
```r
install.packages("readxl")
library(readxl)
```
> "Faz a mesma coisa. A vantagem do código é que você pode deixar registrado no script. **Instalar é uma vez; carregar com `library()` é toda sessão.**"

Ponto importante (binário vs fonte):
> "Na maioria dos casos, no Windows e no Mac, o pacote chega **prontinho** (a gente chama de binário) — instala em segundos, sem complicação."

### Rtools: quando (e só quando) é preciso (5:00–7:00) ⏱7:00
> "Às vezes o R avisa que precisa **compilar da fonte**. É como receber os utensílios em kit, pra montar. Pra montar, no Windows, você precisa de uma ferramenta chamada **Rtools**."
> "A boa notícia: a CatalyseR é **100% R** e foi pensada pra instalar em binário — então, na maior parte das vezes, **você nem vai precisar do Rtools**. A exceção é o menu de **Mapas**, que usa pacotes mais pesados. Se um dia você for usar Mapas, aí sim vale instalar o Rtools — e eu tenho um tutorial passo a passo pra isso (link na descrição)."
`[TELA: mostrar rapidamente a página do Rtools / ou o tutorial]`

### Atualizar e desinstalar (7:00–8:30) ⏱8:30
- **Atualizar:** `[TELA: Packages > Update]` "clica em Update, ele mostra o que tem versão nova."
- **Desinstalar:** `[TELA: aba Packages, o 'x' ao lado do pacote]`
> "Pra remover, é o `x` ao lado do nome na aba Packages — ou por código: `remove.packages('nomedopacote')`. Raramente você precisa, mas é bom saber onde fica."

### Um pulo no Global Options (8:30–9:30) ⏱9:30
`[TELA: Tools > Global Options]`
> "Antes de instalar a CatalyseR, dois ajustes que evitam dor de cabeça. Tools, Global Options:"
- **General:** desmarque *'Restore .RData on startup'* e ponha *'Save workspace' = Never*. `[TELA: mostrar]`
> "Assim cada sessão começa limpa — combina com aquilo de reiniciar que vimos no vídeo 1."
- **Code > Saving:** deixe o encoding em **UTF-8**. `[TELA: mostrar]`
> "Isso garante que acentos não virem símbolos estranhos."

### Instalando a CatalyseR (9:30–11:30) ⏱11:30
> "Chegou a hora. Copie esta única linha pro console:"
`[TELA: console]`
```r
source("https://raw.githubusercontent.com/astuciasnor/catalyser/main/instalar_catalyser.R")
```
> "Essa linha baixa o instalador oficial, que faz tudo por você: instala os dados, as dependências em binário, e no fim **abre a CatalyseR sozinha**. Pode rodar de novo quando quiser — ele só completa o que faltar."
`[TELA: instalador rodando, os 'ok', a IDE abrindo]`
> "Se um dia quiser abrir de novo sem reinstalar, é só:"
```r
library(catalyser)
run_app()
```

### Fecho (11:30–12:00) ⏱12:00
> "Pronto: bancada montada, pacotes no lugar e a CatalyseR rodando. A partir daqui é só análise — do mouse ao código. Qualquer tropeço na instalação, o tutorial do Rtools e os comentários estão aí embaixo. Bons estudos!"

---

## Checklist de gravação
- [ ] Tela em resolução legível (fonte do editor ampliada em Tools > Global Options > Appearance).
- [ ] Cursor visível / realçar cliques.
- [ ] Ter um dataset simples à mão (ex.: `tilapia_crescimento` do EAPADados) pra ilustrar.
- [ ] Regravar o segmento de instalação numa **máquina limpa** (sem os pacotes), pra mostrar o fluxo real do aluno.
- [ ] Descrição do YouTube com: link do tutorial de Rtools, link do repositório e a linha do `source(...)`.
