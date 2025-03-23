@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
start /MIN "" ".\microsoft\module-3\screencapture.bat"
