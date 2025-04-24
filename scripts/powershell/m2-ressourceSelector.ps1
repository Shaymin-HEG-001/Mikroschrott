# Copy Video for Module 2
if ($video -eq -1) { $video = Get-Random -Minimum 0 -Maximum 5 }
if ($image -eq -1) { $image = Get-Random -Minimum 0 -Maximum 6 }

copy-item "${location}\extra\vid\vid${video}.mkv" "${_destinationPath}\module-2\video.mkv" -Force
copy-item "${location}\extra\img\img${image}.bmp" "${_destinationPath}\module-2\image.bmp" -Force
