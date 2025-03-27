@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
c:
cd C:\users\%USERNAME%\documents\Microsoft\module-1\
start /MIN "" ".\launch.bat"
