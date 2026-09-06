# =============================================================================
# verificar-sandbox.ps1
# -----------------------------------------------------------------------------
# Diz se esta maquina pode rodar o Windows Sandbox e, se puder, o que falta.
# Nao altera nada: so verifica.
#
#   .\APOIO\scripts\verificar-sandbox.ps1
#
# Para ATIVAR depois, e preciso um PowerShell como Administrador. O script
# imprime o comando no fim.
# =============================================================================

$ErrorActionPreference = "SilentlyContinue"

function Titulo($t) {
    Write-Host ""
    Write-Host ("=" * 66)
    Write-Host $t
    Write-Host ("=" * 66)
}

Titulo "WINDOWS SANDBOX - VERIFICACAO DE REQUISITOS"

$impedimentos = @()
$pendencias   = @()

# --- 1. Edicao do Windows ------------------------------------------------------
$os = Get-CimInstance Win32_OperatingSystem
$edicao = $os.Caption
Write-Host ""
Write-Host "[1] EDICAO DO WINDOWS"
Write-Host "    $edicao"
Write-Host "    Build: $($os.BuildNumber)"

if ($edicao -match "Home") {
    Write-Host "    ESTADO : NAO SUPORTADO OFICIALMENTE"
    Write-Host "             O Sandbox e recurso das edicoes Pro, Enterprise e"
    Write-Host "             Education. No Home ele nao aparece em Recursos do Windows."
    $impedimentos += "edicao Home"
} elseif ($edicao -match "Pro|Enterprise|Education") {
    Write-Host "    ESTADO : OK"
} else {
    Write-Host "    ESTADO : indeterminado - confira manualmente"
}

# --- 2. Virtualizacao ----------------------------------------------------------
$cs  = Get-CimInstance Win32_ComputerSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
Write-Host ""
Write-Host "[2] VIRTUALIZACAO"
Write-Host "    Hipervisor presente          : $($cs.HypervisorPresent)"
Write-Host "    Virtualizacao no firmware    : $($cpu.VirtualizationFirmwareEnabled)"

if (-not $cs.HypervisorPresent -and -not $cpu.VirtualizationFirmwareEnabled) {
    Write-Host "    ESTADO : DESLIGADA"
    Write-Host "             Ative a virtualizacao no BIOS/UEFI (procure por"
    Write-Host "             'Intel VT-x', 'AMD-V' ou 'SVM Mode')."
    $impedimentos += "virtualizacao desligada no BIOS"
} else {
    Write-Host "    ESTADO : OK"
    if ($cs.HypervisorPresent -and -not $cpu.VirtualizationFirmwareEnabled) {
        Write-Host "             (O campo do firmware aparece como False porque ja ha"
        Write-Host "              um hipervisor rodando - VBS/Integridade de Memoria ou"
        Write-Host "              WSL2. Isso e normal e nao e problema.)"
    }
}

# --- 3. Hardware ---------------------------------------------------------------
$ramGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 1)
$nucleos = $cpu.NumberOfCores
$disco = Get-PSDrive C
$livreGB = [math]::Round($disco.Free / 1GB, 1)

Write-Host ""
Write-Host "[3] HARDWARE"
Write-Host "    Memoria RAM      : $ramGB GB   (minimo 4, recomendado 8)"
Write-Host "    Nucleos de CPU   : $nucleos      (minimo 2, recomendado 4)"
Write-Host "    Livre em C:      : $livreGB GB  (minimo 1)"
Write-Host "    Arquitetura      : $($os.OSArchitecture)"

if ($ramGB -lt 4)    { $impedimentos += "RAM abaixo de 4 GB" }
if ($nucleos -lt 2)  { $impedimentos += "menos de 2 nucleos" }
if ($livreGB -lt 1)  { $impedimentos += "menos de 1 GB livre em C:" }
if ($ramGB -ge 4 -and $ramGB -lt 8) {
    Write-Host "    Nota: com $ramGB GB o Sandbox roda, mas aperta se voce"
    Write-Host "          mantiver muita coisa aberta no Windows principal."
}

# --- 4. Estado do recurso ------------------------------------------------------
Write-Host ""
Write-Host "[4] RECURSO 'Containers-DisposableClientVM'"
$feature = Get-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM"
if ($null -eq $feature) {
    Write-Host "    ESTADO : recurso nao existe nesta edicao do Windows"
    if ($impedimentos -notcontains "edicao Home") { $impedimentos += "recurso indisponivel" }
} else {
    Write-Host "    ESTADO : $($feature.State)"
    if ($feature.State -ne "Enabled") { $pendencias += "recurso desativado" }
}

# --- Veredito ------------------------------------------------------------------
Titulo "VEREDITO"

if ($impedimentos.Count -gt 0) {
    Write-Host "NAO DA PARA USAR O SANDBOX nesta maquina:"
    foreach ($i in $impedimentos) { Write-Host "  - $i" }
    Write-Host ""
    Write-Host "Alternativas, da melhor para a pior:"
    Write-Host ""
    Write-Host "  1. SNAPSHOT DA VM QUE VOCE JA USA  (recomendado)"
    Write-Host "     Tire a foto antes de instalar, teste, restaure depois."
    Write-Host "     E o mesmo Windows onde a CatalyseR sera homologada, entao o"
    Write-Host "     teste vale mais do que num Sandbox generico."
    Write-Host ""
    Write-Host "  2. VM NOVA no VirtualBox ou VMware Player (ambos gratuitos e"
    Write-Host "     funcionam no Windows Home; o Hyper-V Manager NAO existe no Home)."
    Write-Host ""
    Write-Host "  3. NOVO USUARIO DO WINDOWS  (limpeza parcial, sem instalar nada)"
    Write-Host "     Configuracoes > Contas > Outros usuarios > Adicionar conta."
    Write-Host "     O novo usuario nasce sem biblioteca de pacotes, sem .Rprofile"
    Write-Host "     e com PATH de usuario limpo. Nao remove o R instalado para"
    Write-Host "     toda a maquina, mas ja testa 'pacotes nao instalados'."
    Write-Host ""
    Write-Host "  4. LIMPAR A MAQUINA REAL com limpar-ambiente-r.ps1 (ultimo recurso)."
} elseif ($pendencias.Count -gt 0) {
    Write-Host "DA PARA USAR, mas o recurso esta desativado."
    Write-Host ""
    Write-Host "Para ativar, abra o PowerShell COMO ADMINISTRADOR e rode:"
    Write-Host ""
    Write-Host '  Enable-WindowsOptionalFeature -FeatureName "Containers-DisposableClientVM" -All -Online'
    Write-Host ""
    Write-Host "Ou: tecla Windows > 'Ativar ou desativar recursos do Windows' >"
    Write-Host "    marque 'Area Restrita do Windows'."
    Write-Host ""
    Write-Host "Em seguida REINICIE o computador."
} else {
    Write-Host "PRONTO: o Windows Sandbox esta disponivel e ativado."
    Write-Host ""
    Write-Host "Para abrir com a pasta do projeto ja mapeada, clique duas vezes em:"
    Write-Host "  sandbox-catalyser.wsb"
}
Write-Host ("=" * 66)
