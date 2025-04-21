:: Launcher for register-task.ps1
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
type .\register-task.ps1 | powershell -
