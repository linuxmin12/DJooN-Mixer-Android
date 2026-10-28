$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'Node.js LTS belum terpasang. Instal dari https://nodejs.org/ lalu jalankan ulang.' }
if (-not (Test-Path (Join-Path $root 'node_modules'))) {
    Write-Host 'Memasang dependency npm. Koneksi internet diperlukan pada build pertama...' -ForegroundColor Cyan
    & npm.cmd install
    if ($LASTEXITCODE -ne 0) { throw 'npm install gagal.' }
}
& npm.cmd run dist:win
if ($LASTEXITCODE -ne 0) { throw 'Build EXE gagal. Periksa log npm di atas.' }
Write-Host 'Build selesai. Periksa folder dist.' -ForegroundColor Green
