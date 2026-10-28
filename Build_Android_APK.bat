@echo off
setlocal
cd /d "%~dp0"
title Build MIXER DJooN APK
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build_Android_APK.ps1"
if errorlevel 1 echo Build APK gagal. Pastikan Android Studio, Android SDK, dan JDK terpasang.
pause
