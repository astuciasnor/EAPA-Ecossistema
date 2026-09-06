# =============================================================================
# limpar-ambiente-r.ps1
# -----------------------------------------------------------------------------
# Remove R, RStudio, Rtools, Quarto, bibliotecas de pacotes, configuracoes e
# entradas de PATH, para simular um computador que nunca teve o ambiente R.
#
# SEGURO POR PADRAO: sem -Confirmar, ele apenas MOSTRA o que faria.
#
#   .\APOIO\scripts\limpar-ambiente-r.ps1                 # simulacao (nao apaga nada)
#   .\APOIO\scripts\limpar-ambiente-r.ps1 -Confirmar      # executa de verdade
#
# Rode como Administrador se quiser limpar tambem o PATH do sistema e as
# instalacoes feitas para todos os usuarios.
#
# ANTES DE APAGAR, ele grava um inventario em -Backup: lista de pacotes
# instalados, PATH atual e variaveis de ambiente. Guarde essa pasta.
#
# ATENCAO: este script apaga a sua biblioteca de pacotes R. Reinstalar leva
# tempo. Se o objetivo e apenas testar uma instalacao limpa, prefira o Windows
# Sandbox ou um snapshot de VM.
# =============================================================================

[CmdletBinding()]
param(
    [switch]$Confirmar,
    [string]$Backup = "$PSScriptRoot\backup-ambiente-r",
    [switch]$IncluirRegistro
)

$ErrorActionPreference = "Continue"
$modo = if ($Confirmar) { "EXECUCAO REAL" } else { "SIMULACAO (nada sera apagado)" }
$admin = ([Security.Principal.WindowsPrincipal] `
          [Security.Principal.WindowsIdentity]::GetCurrent()
         ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

function Titulo($texto) {
    Write-Host ""
    Write-Host ("=" * 70)
    Write-Host $texto
    Write-Host ("=" * 70)
}

function Acao($texto) {
    if ($Confirmar) { Write-Host "  [APAGANDO] $texto" }
    else            { Write-Host "  [simular ] $texto" }
}

Titulo "LIMPEZA DO AMBIENTE R"
Write-Host "Modo          : $modo"
Write-Host "Administrador : $(if ($admin) { 'sim' } else { 'nao (PATH do sistema nao sera tocado)' })"
Write-Host "Backup        : $Backup"

# -----------------------------------------------------------------------------
# 1. INVENTARIO (sempre roda, mesmo em simulacao)
# -----------------------------------------------------------------------------
Titulo "1. INVENTARIO - o que existe hoje"

if (-not (Test-Path $Backup)) { New-Item -ItemType Directory -Path $Backup -Force | Out-Null }

# PATH atual, para poder voltar atras
[Environment]::GetEnvironmentVariable("PATH", "User") |
    Out-File "$Backup\path-user-antes.txt" -Encoding utf8
if ($admin) {
    [Environment]::GetEnvironmentVariable("PATH", "Machine") |
        Out-File "$Backup\path-machine-antes.txt" -Encoding utf8
}
Write-Host "  PATH salvo em $Backup"

# Lista de pacotes instalados, para saber o que reinstalar depois
$rscript = Get-Command Rscript.exe -ErrorAction SilentlyContinue
if (-not $rscript -and (Test-Path "C:\R")) {
    $rscript = Get-ChildItem "C:\R" -Recurse -Filter "Rscript.exe" -ErrorAction SilentlyContinue |
               Select-Object -First 1
}
if ($rscript) {
    $destino = "$Backup\pacotes-instalados.csv"
    $codigo = "write.csv(installed.packages()[, c('Package','Version','LibPath')], '" +
              ($destino -replace '\\','/') + "', row.names = FALSE)"
    & $rscript.Source -e $codigo 2>$null
    if (Test-Path $destino) {
        $n = (Import-Csv $destino | Measure-Object).Count
        Write-Host "  $n pacotes catalogados em $destino"
    }
} else {
    Write-Host "  Rscript nao encontrado: sem catalogo de pacotes."
}

# -----------------------------------------------------------------------------
# 2. PROGRAMAS INSTALADOS
# -----------------------------------------------------------------------------
Titulo "2. PROGRAMAS - desinstalar pelo mecanismo oficial"

$chaves = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"
)
$alvos = Get-ItemProperty $chaves -ErrorAction SilentlyContinue |
         Where-Object { $_.DisplayName -match '^(R for Windows|R \d|RStudio|Rtools|Quarto)' } |
         Select-Object DisplayName, DisplayVersion, UninstallString

if ($alvos) {
    foreach ($a in $alvos) {
        Write-Host "  - $($a.DisplayName) $($a.DisplayVersion)"
    }
    Write-Host ""
    Write-Host "  Desinstale pelo Windows: Configuracoes > Aplicativos > Aplicativos instalados."
    Write-Host "  Ou, se usa winget:"
    Write-Host "    winget uninstall --id RProject.R"
    Write-Host "    winget uninstall --id Posit.RStudio"
    Write-Host "    winget uninstall --id RProject.Rtools"
    Write-Host "    winget uninstall --id Posit.Quarto"
    Write-Host ""
    Write-Host "  Este script NAO desinstala programas: desinstalador quebrado pela"
    Write-Host "  metade e pior que programa instalado. Faca isso primeiro e depois"
    Write-Host "  rode o script de novo para limpar as sobras."
} else {
    Write-Host "  Nenhum programa R/RStudio/Rtools/Quarto registrado. Seguindo para as sobras."
}

# -----------------------------------------------------------------------------
# 3. PASTAS QUE SOBRAM
# -----------------------------------------------------------------------------
Titulo "3. PASTAS - o que o desinstalador deixa para tras"

$usuario = $env:USERNAME
$candidatos = @(
    # Instalacoes
    "C:\R",
    "$env:ProgramFiles\R",
    "${env:ProgramFiles(x86)}\R",
    "$env:ProgramFiles\RStudio",
    "$env:LOCALAPPDATA\Programs\RStudio",
    "$env:LOCALAPPDATA\Programs\Quarto",
    "$env:ProgramFiles\Quarto",
    "C:\rtools40", "C:\rtools42", "C:\rtools43", "C:\rtools44",
    "C:\rtools45", "C:\rtools46", "C:\Rtools",
    # Bibliotecas de pacotes e cache
    "$env:LOCALAPPDATA\R",
    "$env:APPDATA\R",
    "$HOME\Documents\R",
    # Configuracoes do RStudio
    "$env:LOCALAPPDATA\RStudio",
    "$env:LOCALAPPDATA\RStudio-Desktop",
    "$env:LOCALAPPDATA\rstudio",
    "$env:APPDATA\RStudio",
    # Quarto
    "$env:LOCALAPPDATA\quarto",
    "$env:APPDATA\quarto"
)

$existentes = $candidatos | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique
if ($existentes) {
    foreach ($p in $existentes) {
        $tam = try {
            "{0:N0} MB" -f ((Get-ChildItem $p -Recurse -Force -ErrorAction SilentlyContinue |
                             Measure-Object Length -Sum).Sum / 1MB)
        } catch { "tamanho nao medido" }
        Acao "$p  ($tam)"
        if ($Confirmar) { Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue }
    }
} else {
    Write-Host "  Nenhuma pasta conhecida encontrada."
}

# Arquivos de configuracao soltos
$arquivos = @(
    "$HOME\.Rprofile", "$HOME\.Renviron", "$HOME\.Rhistory",
    "$HOME\Documents\.Rprofile", "$HOME\Documents\.Renviron"
)
foreach ($f in ($arquivos | Where-Object { Test-Path $_ })) {
    Acao $f
    if ($Confirmar) { Remove-Item $f -Force -ErrorAction SilentlyContinue }
}

# Temporarios de sessao
$temps = Get-ChildItem $env:TEMP -Directory -Filter "Rtmp*" -ErrorAction SilentlyContinue
if ($temps) {
    Acao "$($temps.Count) pasta(s) Rtmp* em $env:TEMP"
    if ($Confirmar) { $temps | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue }
}

# -----------------------------------------------------------------------------
# 4. PATH
# -----------------------------------------------------------------------------
Titulo "4. PATH - remover as entradas do ambiente R"

$padrao = '\\R\\R-|\\R\\|rtools|RStudio|Quarto|\\R-\d'

function LimparPath($escopo) {
    $atual = [Environment]::GetEnvironmentVariable("PATH", $escopo)
    if (-not $atual) { return }
    $partes = $atual -split ';' | Where-Object { $_ -ne '' }
    $remover = $partes | Where-Object { $_ -match $padrao }
    if (-not $remover) {
        Write-Host "  ${escopo}: nada a remover."
        return
    }
    foreach ($r in $remover) { Acao "PATH ${escopo}: $r" }
    if ($Confirmar) {
        $novo = ($partes | Where-Object { $_ -notmatch $padrao }) -join ';'
        [Environment]::SetEnvironmentVariable("PATH", $novo, $escopo)
    }
}

LimparPath "User"
if ($admin) { LimparPath "Machine" }
else { Write-Host "  Machine: pulado (rode como Administrador para limpar o PATH do sistema)." }

# -----------------------------------------------------------------------------
# 5. VARIAVEIS DE AMBIENTE
# -----------------------------------------------------------------------------
Titulo "5. VARIAVEIS DE AMBIENTE"

$variaveis = @("R_HOME", "R_LIBS", "R_LIBS_USER", "R_USER", "QUARTO_PATH",
               "RTOOLS40_HOME", "RTOOLS42_HOME", "RTOOLS43_HOME",
               "RTOOLS44_HOME", "RTOOLS45_HOME", "RSTUDIO_WHICH_R")
foreach ($v in $variaveis) {
    foreach ($escopo in @("User", "Machine")) {
        if ($escopo -eq "Machine" -and -not $admin) { continue }
        $valor = [Environment]::GetEnvironmentVariable($v, $escopo)
        if ($valor) {
            Acao "variavel $escopo\$v = $valor"
            if ($Confirmar) { [Environment]::SetEnvironmentVariable($v, $null, $escopo) }
        }
    }
}

# -----------------------------------------------------------------------------
# 6. REGISTRO (opcional, so com -IncluirRegistro)
# -----------------------------------------------------------------------------
Titulo "6. REGISTRO"

if ($IncluirRegistro) {
    $regs = @("HKCU:\Software\R-core", "HKLM:\SOFTWARE\R-core",
              "HKLM:\SOFTWARE\WOW6432Node\R-core")
    foreach ($r in ($regs | Where-Object { Test-Path $_ })) {
        if ($r -like "HKLM*" -and -not $admin) {
            Write-Host "  $r : precisa de Administrador."
            continue
        }
        Acao "chave $r"
        if ($Confirmar) { Remove-Item $r -Recurse -Force -ErrorAction SilentlyContinue }
    }
} else {
    Write-Host "  Pulado. O registro so e tocado com -IncluirRegistro."
    Write-Host "  Na pratica, chaves orfas em R-core nao impedem uma instalacao nova."
}

# -----------------------------------------------------------------------------
# 7. VERIFICACAO
# -----------------------------------------------------------------------------
Titulo "7. VERIFICACAO"

if (-not $Confirmar) {
    Write-Host "  Simulacao: nada foi alterado."
    Write-Host "  Para executar de verdade:  .\APOIO\scripts\limpar-ambiente-r.ps1 -Confirmar"
} else {
    Write-Host "  FECHE e reabra o terminal antes de conferir (o PATH desta sessao"
    Write-Host "  ainda e o antigo). Depois, em um terminal NOVO:"
    Write-Host ""
    Write-Host "    where.exe R"
    Write-Host "    where.exe Rscript"
    Write-Host "    where.exe quarto"
    Write-Host ""
    Write-Host "  Os tres devem responder que nao encontraram nada."
    Write-Host ""
    Write-Host "  Inventario preservado em: $Backup"
    Write-Host "  Para reinstalar depois, veja catalyser\docs\INSTALACAO_AMBIENTE.md"
}
Write-Host ("=" * 70)
