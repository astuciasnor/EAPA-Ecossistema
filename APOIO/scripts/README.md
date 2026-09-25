# Scripts de apoio

São utilitários do workspace, não código-fonte da CatalyseR:

- `gerar-projeto-exemplo.R` — gera o projeto-exemplo exportado;
- `renderizar-quarto-desktop.ps1` — renderiza um `.qmd` em Word e HTML com o R local, corrigindo a variável de arquitetura ausente em algumas sessões do desktop;
- `rodar-testes-catalyser.bat` — executa a suíte da CatalyseR;
- `verificar-sandbox.ps1` — verifica os requisitos do Windows Sandbox;
- `limpar-ambiente-r.ps1` — simula ou limpa um ambiente R (usar com cautela);
- `pca_ajudar_saida_publicacao.R` — experimento avulso para saída de PCA.

Os scripts que geram logs continuam gravando em `D:\Claude\EAPA-Ecossistema` para manter
compatibilidade com os procedimentos existentes.

## Renderizar pelo desktop

Na raiz do ecossistema:

```powershell
.\APOIO\scripts\renderizar-quarto-desktop.ps1 -Arquivo 'caminho\relatorios\relatorio.qmd'
```

O padrão é gerar os dois formatos; use `-Formato html` ou `-Formato docx` para
apenas um. Os arquivos saem na pasta do relatório. O script não instala pacotes
nem muda configurações permanentes do Windows ou do RStudio, e restaura as
variáveis do processo depois da execução.

Diagnóstico de 15/09/2026: nesta sessão, `PROCESSOR_ARCHITECTURE` estava ausente,
embora Windows e processo fossem x64. O `cli` 3.6.6 consulta essa variável com
`getenv` e passa o resultado a `strcmp` sem verificar se é nulo, durante o
encerramento. Carregar apenas `cli` reproduziu a falha `0xc0000005`; informar
`AMD64` eliminou a falha, com os mesmos R 4.6.1 e pacotes do RStudio.
[Código do pacote cli](https://github.com/r-lib/cli/blob/v3.6.6/src/thread.c).
O aviso do Quarto sobre Windows ARM era genérico e não descrevia este computador.

Para executar um script R em vez de renderizar, a mesma correção temporária se
aplica: definir a arquitetura real do processo antes de iniciar `Rscript`.
