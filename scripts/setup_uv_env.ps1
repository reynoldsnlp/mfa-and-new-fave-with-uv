$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Resolve-Path (Join-Path $ScriptDir "..")
$VenvDir = Join-Path $ProjectRoot ".venv"
$PythonPath = Join-Path $VenvDir "Scripts/python.exe"

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
  if (Get-Command py -ErrorAction SilentlyContinue) {
    py -m pip install --user uv
  } else {
    python -m pip install --user uv
  }
  $env:PATH = "$(Join-Path $env:USERPROFILE '.local\bin');$env:PATH"
}

uv venv "$VenvDir"
uv pip install --python "$PythonPath" montreal-forced-aligner new-fave pgvector
& "$PythonPath" (Join-Path $ProjectRoot "scripts/toy_import_check.py")
