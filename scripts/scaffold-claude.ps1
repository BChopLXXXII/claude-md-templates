param(
  [string]$Template,
  [string]$Output = "CLAUDE.md",
  [switch]$List,
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoRoot = Resolve-Path (Join-Path $ScriptDir "..")
$TemplatesDir = Join-Path $RepoRoot "templates"

function Show-Usage {
  @"
Usage:
  ./scripts/scaffold-claude.ps1 -List
  ./scripts/scaffold-claude.ps1 -Template react-vite
  ./scripts/scaffold-claude.ps1 -Template minimal -Output .\CLAUDE.md -Force
"@
}

function Get-Templates {
  Get-ChildItem -Path $TemplatesDir -Filter "*.md" -File |
    Select-Object -ExpandProperty BaseName |
    Sort-Object
}

if ($List) {
  Get-Templates
  exit 0
}

if (-not $Template) {
  Write-Error "-Template is required."
  Show-Usage
  exit 1
}

$Source = Join-Path $TemplatesDir "$Template.md"
if (-not (Test-Path $Source)) {
  Write-Host "Template '$Template' not found. Available templates:" -ForegroundColor Red
  Get-Templates
  exit 1
}

if ((Test-Path $Output) -and -not $Force) {
  Write-Error "'$Output' already exists. Use -Force to overwrite."
  exit 1
}

$OutDir = Split-Path -Parent $Output
if ($OutDir -and -not (Test-Path $OutDir)) {
  New-Item -ItemType Directory -Path $OutDir | Out-Null
}

Copy-Item -Path $Source -Destination $Output -Force
Write-Host "Created $Output from template '$Template'" -ForegroundColor Green
