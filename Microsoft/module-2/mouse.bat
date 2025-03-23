set "current_path=%cd%"
cd C:\windows\system32\
type %current_path%\mouse.ps1 | powershell - 
exit 0
