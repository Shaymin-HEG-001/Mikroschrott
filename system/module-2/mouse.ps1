# Lock Mouse top left
Clear-Host; $r = 0; $m = 10000; while ($r -lt $m){Add-Type -AssemblyName System.Windows.Forms; $screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $screen.Width = 0; $screen.Height = 0; [Windows.Forms.Cursor]::Position = "$($screen.Width),$($screen.Height)"; $r++; start-sleep -Milliseconds(5); Write-Output "Get Rekt"}
