@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
cd /d %~dp0
TIMEOUT /T 4
start /MIN "" ".\launch.bat"
