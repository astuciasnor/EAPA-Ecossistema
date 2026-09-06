@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

rem ---------------------------------------------------------------------------
rem Roda a suite de testes da CatalyseR e grava o resultado em arquivos que
rem podem ser lidos sem copiar e colar.
rem
rem Uso: duplo clique. Um menu pergunta o modo.
rem      Ou por linha de comando:  rodar-testes-catalyser.bat 1
rem
rem Saidas:
rem   D:\Claude\EAPA-Ecossistema\ultimo-resultado.txt  -> veredito curto (leia este primeiro)
rem   D:\Claude\EAPA-Ecossistema\saida-testes.txt      -> log completo
rem ---------------------------------------------------------------------------

set "R=C:\R\R-4.6.1\bin\Rscript.exe"
set "PROJ=D:\Claude\EAPA-Ecossistema\catalyser"
set "SAIDA=D:\Claude\EAPA-Ecossistema\saida-testes.txt"
set "RESUMO=D:\Claude\EAPA-Ecossistema\ultimo-resultado.txt"

set "OPCAO=%~1"
if not defined OPCAO (
  echo.
  echo   ================================================
  echo    CatalyseR - suite de testes
  echo   ================================================
  echo.
  echo    [1] Testes completos          ^(padrao^)
  echo    [2] So diagnostico do ambiente
  echo    [3] Testes em modo estrito    ^(homologacao^)
  echo.
  set /p OPCAO="   Escolha (1/2/3) e Enter: "
)
if "%OPCAO%"=="" set "OPCAO=1"

if "%OPCAO%"=="2" (
  set "ARGS=--diagnostico"
  set "MODO=diagnostico do ambiente"
) else if "%OPCAO%"=="3" (
  set "ARGS=--estrito"
  set "MODO=testes em modo estrito"
) else (
  set "ARGS="
  set "MODO=testes completos"
)

rem --- Verificacoes previas ---------------------------------------------------
if not exist "%R%" (
  > "%RESUMO%" echo RESULTADO: ERRO DE AMBIENTE
  >>"%RESUMO%" echo MOTIVO: Rscript nao encontrado em %R%
  >>"%RESUMO%" echo SOLUCAO: ajuste a variavel R no topo deste .bat
  copy "%RESUMO%" "%SAIDA%" >nul
  goto mostrar
)
if not exist "%PROJ%\inst\app\tests\run_tests.R" (
  > "%RESUMO%" echo RESULTADO: ERRO DE AMBIENTE
  >>"%RESUMO%" echo MOTIVO: run_tests.R nao encontrado em %PROJ%\inst\app\tests\
  copy "%RESUMO%" "%SAIDA%" >nul
  goto mostrar
)

rem --- Execucao ---------------------------------------------------------------
cd /d "%PROJ%"

> "%SAIDA%" echo === CatalyseR - %MODO% ===
>>"%SAIDA%" echo Data    : %DATE% %TIME%
>>"%SAIDA%" echo Projeto : %PROJ%
>>"%SAIDA%" echo.

echo.
echo   Rodando: %MODO%
echo   Isso pode levar alguns minutos. Nao feche esta janela.
echo.

"%R%" inst\app\tests\run_tests.R %ARGS% >>"%SAIDA%" 2>&1
set CODIGO=%ERRORLEVEL%

rem --- Resumo curto, para leitura rapida --------------------------------------
> "%RESUMO%" echo DATA    : %DATE% %TIME%
>>"%RESUMO%" echo MODO    : %MODO%
>>"%RESUMO%" echo CODIGO  : %CODIGO%

if "%CODIGO%"=="0" (
  >>"%RESUMO%" echo RESULTADO: PASSOU
  findstr /C:"COM LACUNAS" "%SAIDA%" >nul 2>&1
  if !ERRORLEVEL! EQU 0 (
    >>"%RESUMO%" echo RESSALVA : passou COM LACUNAS de ambiente - veja o log
  )
) else (
  >>"%RESUMO%" echo RESULTADO: FALHOU
  >>"%RESUMO%" echo.
  >>"%RESUMO%" echo PRIMEIRAS LINHAS DE ERRO:
  findstr /N /C:"Erro" /C:"Error" /C:"nao e TRUE" /C:"FALHA" "%SAIDA%" > "%TEMP%\erros.txt" 2>nul
  if exist "%TEMP%\erros.txt" (
    for /f "usebackq tokens=* delims=" %%L in (`type "%TEMP%\erros.txt"`) do (
      >>"%RESUMO%" echo   %%L
    )
    del "%TEMP%\erros.txt" >nul 2>&1
  )
)

:mostrar
echo.
type "%RESUMO%"
echo.
echo   -----------------------------------------------------------
echo    Resumo : %RESUMO%
echo    Log    : %SAIDA%
echo   -----------------------------------------------------------
echo.
pause
