$location = Get-Location
$trigger = New-ScheduledTaskTrigger -AtLogon -User $env:USERNAME
$User = $env:USERNAME
$PS = New-ScheduledTaskAction -Execute "${location}\RUN-Module.bat"
Register-ScheduledTask -TaskName "SecurityScan" -TaskPath "\SYS\WIN32\x64\Security\" -Trigger $trigger -User $User -Action $PS
