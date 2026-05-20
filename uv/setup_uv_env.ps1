$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PythonVersion = "3.11"

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
  $env:PATH = "$(Join-Path $env:USERPROFILE '.local\bin');$env:PATH"
}

Set-Location $ScriptDir

if (-not (Test-Path "pyproject.toml")) {
  uv init --bare --no-readme --python $PythonVersion
}

$PyProjectPath = Join-Path $ScriptDir "pyproject.toml"
$PyProjectContents = Get-Content -Raw $PyProjectPath
if ($PyProjectContents -match 'requires-python\s*=') {
  $PyProjectContents = $PyProjectContents -replace 'requires-python\s*=\s*"[^"]+"', 'requires-python = ">=3.11,<3.12"'
  Set-Content -Path $PyProjectPath -Value $PyProjectContents -NoNewline
}

uv add --python $PythonVersion montreal-forced-aligner new-fave pgvector pynini
uv run --python $PythonVersion python toy_import_check.py
