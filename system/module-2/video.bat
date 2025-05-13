:: Play video.mkv
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit 0 >nul 2>&1
start /MIN "" .\ffplay.exe -vn -nodisp ".\video.mkv"
.\ffplay.exe -x 1600 -y 900 -an ".\video.mkv"
exit 0
