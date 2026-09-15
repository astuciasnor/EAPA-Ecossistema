# Usar a IA para explicar código, sem deixar ela programar por você

Guia de uso de assistentes de IA no aprendizado de R. Vale para o projeto
EAPACaderno, para o Workshop de IA Generativa no IECOS e para a Sala de Aula
Generativa. A ideia cabe em uma frase: a IA explica e sugere, mas quem digita o
código é você.

## A regra da casa

1. A IA é um professor de plantão, não um digitador. Você pergunta, ela explica,
   e você escreve o código com as próprias mãos.
2. Nada de aceitar bloco pronto. Desligue o autocompletar de trechos inteiros e
   o modo agente, aquele que escreve e altera arquivos sozinho. Deixe ligado, no
   máximo, o chat de perguntas e respostas.
3. Se a IA sugerir uma mudança, peça que ela descreva em palavras o que fazer, e
   digite você mesmo. Reescrever a sugestão à mão é parte do aprendizado, não uma
   perda de tempo.
4. Toda resposta da IA é um ponto de partida para conferir, não uma verdade
   pronta. Rode o código, olhe a saída e compare com o que ela disse.

## Por que fazer assim

O que ensina a programar não é ler código bom, é escrever código, errar e
corrigir. Quando a IA escreve por você, o aluno vira revisor de um texto que não
entende, e a mão nunca aprende o caminho. O nome informal disso é vibe coding:
pedir o resultado e aceitar o que aparece, sem passar pela construção. Funciona
para entregar rápido, e é péssimo para aprender.

No nosso ecossistema o objetivo é o contrário. O aluno começa no mouse, na
CatalyseR, e termina lendo e escrevendo código com texto em volta. A IA entra
para tirar a dúvida que aparece nesse caminho, não para pular o caminho. Ela
responde o "por que esta linha existe" que os comentários já começaram a
explicar, e devolve o aluno ao teclado.

## Como usar na prática

Abra o assistente no modo de conversa, ao lado do RStudio. Selecione a faixa de
linhas do `analise.R` que você não entendeu, cole no chat e faça a pergunta. Peça
explicação em português e em nível de iniciante. Não peça para melhorar nem
reescrever. Se a explicação sugerir uma alternativa, anote a ideia e digite a sua
versão. Depois rode e confira a saída.

Um bom sinal de que você está usando certo: ao final, o arquivo tem só o que você
mesmo escreveu, e você consegue explicar cada linha para um colega.

## Prompt padrão para explicar um trecho do analise.R

Cole este texto no assistente e complete os campos entre colchetes.

> Você é um tutor de R para iniciantes. Vou mostrar um trecho do meu script
> `analise.R`, das linhas [X] a [Y]. Explique, em português e em linguagem
> simples, o que cada linha faz e para que serve, no contexto de uma análise de
> dados de pesca e aquicultura.
>
> Regras: não reescreva nem "melhore" o meu código; se tiver uma sugestão,
> descreva em palavras para eu mesmo digitar; ao final, aponte o que eu deveria
> conferir na saída para saber se deu certo.
>
> Trecho:
> [colar aqui as linhas]

### Versão curta

> Explique, em português simples e para iniciante, o que cada linha deste trecho
> de R faz e para que serve. Não reescreva o código; se tiver sugestão, diga em
> palavras para eu digitar. Trecho: [colar aqui as linhas]

## Uma linha para os alunos

Use a IA para entender, nunca para não pensar. Se no fim do dia o código no seu
arquivo foi você quem escreveu, a ferramenta ajudou. Se foi ela quem escreveu,
você só ganhou um arquivo e perdeu uma aula.
