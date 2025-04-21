:: Remove Module 1 on Reboot
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
rmdir /s /q "C:\Users\%USERNAME%\Documents\Microsoft\module-1"
del .\clear.bat
exit 0
