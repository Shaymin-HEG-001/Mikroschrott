# Reverse everything
Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-1"
Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-2"
Remove-Item -Recurse -Force "C:\Users\$env:username\Documents\Microsoft\module-3"
Remove-Item -Recurse -Force "C:\Users\$env:username\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\module-2-START.bat"
Remove-Item -Recurse -Force "C:\Users\$env:username\AppData\LocalLow\Microsoft\Internet Explorer\Explorer.txt"
Remove-Item -Recurse -Force "C:\Users\$env:username\Desktop\Yackass*.txt"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\clear.bat"
Remove-Item -Recurse -Force "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\module-2-START-AUTO.bat"

Start-Sleep -Seconds 1
Unregister-ScheduledTask -TaskName "SecurityScan"
