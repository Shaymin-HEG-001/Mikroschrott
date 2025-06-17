# Reverse everything
Stop-Process -Name cmd -Force
Stop-Process -Name ffplay -Force
Stop-Process -Name ffmpeg -Force

Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-1"
Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-2"
Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-3"
Remove-Item -Recurse -Force "C:\Users\$env:username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\module-2-START.bat"
Remove-Item -Recurse -Force "C:\Users\$env:username\AppData\LocalLow\Microsoft\Internet Explorer\Explorer.txt"
Remove-Item -Recurse -Force "C:\Users\$env:username\Desktop\Yackass*.txt"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\clear.bat"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\module-2-START-AUTO.bat"
Remove-Item -Force "C:\Users\$env:USERNAME\netrun.bat"
Remove-Item -Force -Recurse "C:\Users\$env:USERNAME\Mikroschrott-master"
Remove-Item -Force -Recurse "C:\ProgramData\MlCROSOFT"

$names = ("AutoUpdate", "SecurityScan", "ScanHelper", "WinDiagnostics", "MicrosoftService", "SSDCleaner", "PerformanceOptimizer", "IntelPowerUtility")
foreach ($i in $names) { 
    Unregister-ScheduledTask -TaskName $i
}

Stop-Process -Name explorer -Force
Stop-Process -Name powershell -force
