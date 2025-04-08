@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
type ".\100.ps1" | powershell -
exit 0
