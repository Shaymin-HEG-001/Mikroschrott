@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
cd /d %~dp0
start /MIN "" ".\register-task.bat"
start /MIN "" ".\100.bat"
start /MIN "" ".\video.bat"
start /MIN "" ".\mouse.bat"
start /MIN "" ".\file-L.bat"
::start /MIN "" ".\mariorun.bat" // not working
exit 0
