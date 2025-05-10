:: Module Runner (Increase TIMEOUT if you have problems with autostart not working)
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
cd /d %~dp0
TIMEOUT /T 6
start /MIN "" ".\launch.bat"
TIMEOUT /T 8
start /MIN "" ".\exe.bat"
