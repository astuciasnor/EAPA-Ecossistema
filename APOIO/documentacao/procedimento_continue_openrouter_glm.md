Claro. Abaixo está o conteúdo pronto de um arquivo em Markdown.

Salve com este nome:

`procedimento_continue_openrouter_glm.md`

```markdown
# Como conectar o GLM no VS Code usando OpenRouter e Continue

Este guia mostra o jeito mais fácil de conectar um modelo GLM no VS Code usando a extensão Continue e o OpenRouter, sem editar manualmente o arquivo `config.yaml`.

---

## Requisitos

Antes de começar, você precisa ter:

- VS Code instalado.
- Extensão Continue instalada no VS Code.
- Conta no OpenRouter.
- Créditos/saldo disponível no OpenRouter.
- Uma API key do OpenRouter.

A chave normalmente começa com algo parecido com:

```text
sk-or-v1-...
```

Você pode criar ou copiar sua chave aqui:

```text
https://openrouter.ai/keys
```

---

## Passo a passo pelo mouse

### 1. Abrir o Continue

1. Abra o VS Code.
2. Clique no ícone da extensão Continue na barra lateral esquerda.

---

### 2. Abrir o seletor de modelos

1. Na parte de baixo do painel do Continue, clique no nome do modelo atual.
2. Clique em:

```text
+ Add Chat model
```

---

### 3. Escolher o provedor

Na janela `Add Chat model`, em `Provider`, selecione:

```text
OpenRouter
```

---

### 4. Escolher o modelo GLM

No campo `Model`, escolha o modelo GLM desejado.

Exemplo:

```text
Z.ai: GLM 5.2
```

Também podem aparecer outros modelos GLM, dependendo da disponibilidade no OpenRouter.

---

### 5. Colar a API key

No campo `API key`, cole sua chave do OpenRouter.

Exemplo de formato:

```text
sk-or-v1-xxxxxxxxxxxxxxxxxxxxxxxx
```

Atenção:

- Cole a chave inteira.
- Não deixe espaço antes ou depois.
- Use uma chave válida do OpenRouter.

---

### 6. Conectar

Depois de colar a API key, clique em:

```text
Connect
```

O Continue vai configurar tudo automaticamente e atualizar o arquivo `config.yaml`.

Você não precisa editar o `config.yaml` manualmente.

---

### 7. Selecionar o modelo

Depois de conectar:

1. Clique novamente no seletor de modelos do Continue.
2. Escolha:

```text
Z.ai: GLM 5.2
```

ou o modelo GLM que você adicionou.

---

### 8. Testar

No chat do Continue, envie uma mensagem como:

```text
Olá, você está funcionando via OpenRouter?
```

Se estiver tudo certo, o modelo responderá usando sua conta do OpenRouter.

---

## Se o botão Connect ficar desativado

Verifique:

- Se o Provider está como `OpenRouter`.
- Se o modelo foi selecionado.
- Se a API key foi colada corretamente.
- Se a chave começa com `sk-or-v1-`.
- Se não há espaços antes ou depois da chave.

---

## Se conectar, mas der erro ao responder

Confira estes pontos:

### Créditos no OpenRouter

Verifique seu saldo em:

```text
https://openrouter.ai/credits
```

### Modelo indisponível

Às vezes um modelo pode estar temporariamente indisponível.

Tente selecionar outro modelo GLM ou outro modelo disponível no OpenRouter.

### Recarregar o VS Code

No VS Code:

1. Pressione `Ctrl + Shift + P`.
2. Procure por:

```text
Developer: Reload Window
```

3. Clique nessa opção.

---

## Resumo rápido

1. Instale a extensão Continue.
2. Abra o painel do Continue.
3. Clique no modelo atual.
4. Clique em `+ Add Chat model`.
5. Em Provider, escolha `OpenRouter`.
6. Em Model, escolha `Z.ai: GLM 5.2` ou outro GLM.
7. Cole sua API key do OpenRouter.
8. Clique em `Connect`.
9. Selecione o modelo e use no chat.

---

## Observação

Este é o método mais fácil porque não exige editar manualmente o arquivo `config.yaml`.
```

Se quiser, também posso fazer uma versão mais curta em `.txt` para você salvar como `passo_a_passo_glm_openrouter.txt`.