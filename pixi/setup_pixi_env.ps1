$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PixiExe = $null

if (Get-Command pixi -ErrorAction SilentlyContinue) {
  $PixiExe = "pixi"
} else {
  (Invoke-WebRequest -Uri https://pixi.sh/install.ps1 -UseBasicParsing).Content | Invoke-Expression
  $Candidate = Join-Path $env:USERPROFILE ".pixi\bin\pixi.exe"
  if (Test-Path $Candidate) {
    $PixiExe = $Candidate
  } else {
    $env:PATH = "$(Join-Path $env:USERPROFILE '.pixi\bin');$env:PATH"
    if (Get-Command pixi -ErrorAction SilentlyContinue) {
      $PixiExe = "pixi"
    } else {
      throw "pixi was installed but could not be resolved in this shell session."
    }
  }
}

Set-Location $ScriptDir
& $PixiExe run python toy_import_check.py
