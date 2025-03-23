$location = Get-Location
$sourcePath = "${location}\Microsoft"
$destinationPath = "C:\Users\$env:USERNAME\documents\Microsoft"

xcopy "${sourcePath}\module-1\" "${destinationPath}\module-1" /S /H /I
xcopy "${sourcePath}\module-2\" "${destinationPath}\module-2" /S /H /I

Move-Item "${destinationPath}\module-2\module-2-START-AUTO.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
Move-Item "${destinationPath}\module-2\clear.bat" "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" -Force
