$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..")

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
  $env:PATH = "$(Join-Path $env:USERPROFILE '.local\bin');$env:PATH"
}

Set-Location $ProjectRoot

if (-not (Test-Path "pyproject.toml")) {
  uv init --no-readme
}

uv add montreal-forced-aligner new-fave pgvector
uv run python scripts/toy_import_check.py
