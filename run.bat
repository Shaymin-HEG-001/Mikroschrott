:: Run the Program
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min %1 & exit 0 >nul 2>&1
cd /d %~dp0
:: Change execution policy
powershell -Command "Set-ExecutionPolicy bypass -scope currentuser -force"
for /f "tokens=*" %%i in ('powershell -Command "Get-ExecutionPolicy"') do set policy=%%i

if "%policy%"=="Bypass" ( powershell .\run.ps1 %2
) else ( type .\run.ps1 | powershell - )
exit 0
