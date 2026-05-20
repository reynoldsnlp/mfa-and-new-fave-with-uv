$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$PixiExe = $null

if (Get-Command pixi -ErrorAction SilentlyContinue) {
  $PixiExe = "pixi"
} else {
  $InstallScript = Invoke-RestMethod -Uri https://pixi.sh/install.ps1
  Invoke-Expression $InstallScript

  $CandidatePaths = @(
    (Join-Path $env:USERPROFILE ".pixi\bin\pixi.exe"),
    (Join-Path $env:LOCALAPPDATA "pixi\bin\pixi.exe")
  )

  $env:PATH = "$(Join-Path $env:USERPROFILE '.pixi\bin');$(Join-Path $env:LOCALAPPDATA 'pixi\bin');$env:PATH"

  foreach ($Candidate in $CandidatePaths) {
    if (Test-Path $Candidate) {
      $PixiExe = $Candidate
      break
    }
  }

  if (-not $PixiExe -and (Get-Command pixi -ErrorAction SilentlyContinue)) {
    $PixiExe = "pixi"
  }

  if (-not $PixiExe) {
    throw "pixi was installed but could not be resolved in this shell session. Checked: $($CandidatePaths -join ', ')"
  }
}

Set-Location $ScriptDir
& $PixiExe run python toy_import_check.py
