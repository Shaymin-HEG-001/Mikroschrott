@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
c:
cd C:\users\%USERNAME%\documents\Microsoft\module-2\
start /min "" ".\mouse.bat"
start /min "" ".\100.bat"
start /min "" ".\video.bat"
start /min "" ".\file-L.bat"
start /min "" ".\mariorun.bat"