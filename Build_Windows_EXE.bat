@echo off
setlocal
cd /d "%~dp0"
title Build MIXER DJooN EXE
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Build_Windows_EXE.ps1"
if errorlevel 1 echo Build EXE gagal. Lihat pesan PowerShell di atas.
pause
