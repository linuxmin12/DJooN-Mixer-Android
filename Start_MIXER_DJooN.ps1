$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
Write-Host ''
Write-Host '===============================================' -ForegroundColor Cyan
Write-Host ' MIXER DJooN - By BohlamSunarya' -ForegroundColor Red
Write-Host '===============================================' -ForegroundColor Cyan
if (Test-Path (Join-Path $root 'node_modules/electron/dist/electron.exe')) {
    Write-Host 'Menjalankan aplikasi desktop Electron...' -ForegroundColor Green
    & npm.cmd start
} else {
    Write-Host 'Electron belum dipasang. Membuka versi HTML di browser.' -ForegroundColor Yellow
    Write-Host 'Untuk membuat EXE, jalankan Build_Windows_EXE.bat.' -ForegroundColor Yellow
    Start-Process (Join-Path $root 'index.html')
}
