@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
cd C:\Users\%USERNAME%\Documents\Microsoft\module-2\
start /MIN "" ".\mouse.bat"
start /MIN "" ".\100.bat"
start /MIN "" ".\video.bat"
start /MIN "" ".\file-L.bat"
exit 0
