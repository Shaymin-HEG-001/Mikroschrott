$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"

Start-Process ".\microsoft\module-3\module-3-START.bat"
Start-Process "C:\users\$env:username\documents\microsoft\module-2\module-2-START.bat"
Start-Sleep 7
Start-Process "${destinationPath}\module-1\module-1-START.bat"
