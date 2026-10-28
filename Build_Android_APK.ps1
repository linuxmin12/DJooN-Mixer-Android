$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw 'Node.js LTS belum terpasang.' }
if (-not (Test-Path (Join-Path $root 'node_modules'))) {
    Write-Host 'Memasang dependency npm...' -ForegroundColor Cyan
    & npm.cmd install
    if ($LASTEXITCODE -ne 0) { throw 'npm install gagal.' }
}
if (-not (Test-Path (Join-Path $root 'android/gradlew.bat'))) {
    Write-Host 'Membuat proyek native Android Capacitor...' -ForegroundColor Cyan
    & npm.cmd run android:init
    if ($LASTEXITCODE -ne 0) { throw 'Inisialisasi Android gagal.' }
}
& npm.cmd run apk:debug
if ($LASTEXITCODE -ne 0) { throw 'Build APK gagal. Pastikan Android Studio, Android SDK, dan JDK terpasang.' }
Write-Host 'Build selesai. APK ada di android/app/build/outputs/apk/debug/app-debug.apk' -ForegroundColor Green
