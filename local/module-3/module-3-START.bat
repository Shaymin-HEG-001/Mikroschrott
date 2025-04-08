@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
start /MIN "" ".\local\module-3\screencapture.bat"
