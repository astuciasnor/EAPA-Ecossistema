# Renderiza com o R e o Quarto locais, ajustando apenas o ambiente deste comando.
# No desktop, PROCESSOR_ARCHITECTURE pode vir ausente. O cli 3.6.6 consulta essa
# variável ao encerrar e pode provocar uma falha nativa se ela não existir.
[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Arquivo,
    [ValidateSet('all', 'html', 'docx')]
    [string]$Formato = 'all'
)

$ErrorActionPreference = 'Stop'
$relatorioLocal = (Resolve-Path -LiteralPath $Arquivo).Path
if ([IO.Path]::GetExtension($relatorioLocal) -ne '.qmd') {
    throw 'Informe o arquivo .qmd que deve ser renderizado.'
}
$quartoLocal = (Get-Command quarto.exe -ErrorAction Stop).Source
$rscriptLocal = (Get-Command Rscript.exe -ErrorAction Stop).Source
$ambienteAnterior = @{}
foreach ($nome in @('PROCESSOR_ARCHITECTURE', 'LC_ALL', 'QUARTO_R')) {
    $ambienteAnterior[$nome] = [Environment]::GetEnvironmentVariable($nome, 'Process')
}

Push-Location -LiteralPath (Split-Path -Parent $relatorioLocal)
try {
    if (-not $env:PROCESSOR_ARCHITECTURE) {
        $env:PROCESSOR_ARCHITECTURE = switch (
            [Runtime.InteropServices.RuntimeInformation]::ProcessArchitecture.ToString()) {
            'X64' { 'AMD64' }
            'Arm64' { 'ARM64' }
            'X86' { 'x86' }
            default { throw 'Arquitetura do processo não reconhecida.' }
        }
    }
    # C.UTF-8, herdado do desktop, não é um locale válido no R para Windows.
    $env:LC_ALL = 'Portuguese_Brazil.utf8'
    if (-not $env:QUARTO_R) { $env:QUARTO_R = Split-Path -Parent $rscriptLocal }
    & $quartoLocal render $relatorioLocal --to $Formato
    if ($LASTEXITCODE -ne 0) { throw "A renderização falhou (código $LASTEXITCODE)." }
}
finally {
    Pop-Location
    foreach ($nome in $ambienteAnterior.Keys) {
        [Environment]::SetEnvironmentVariable($nome, $ambienteAnterior[$nome], 'Process')
    }
}
