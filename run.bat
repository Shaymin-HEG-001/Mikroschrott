@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
type .\copy_to_system.ps1 | powershell -
type .\launch_modules.ps1 | powershell -
exit 0