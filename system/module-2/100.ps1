# Enable Sound
$obj = New-Object -ComObject WScript.Shell
1..50 | ForEach-Object {$obj.SendKeys([char] 175)}
1..300 | ForEach-Object {$obj.SendKeys([char] 175);Start-Sleep -Milliseconds 100}
