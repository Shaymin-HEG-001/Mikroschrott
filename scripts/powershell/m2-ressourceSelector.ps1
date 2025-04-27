# Copy Video for Module 2
if ($video -eq -1) { $video = Get-Random -Minimum 0 -Maximum 5 }
elseif ($video -is [array]) {
    $indexv = Get-Random -Minimum 0 -Maximum $video.Length
    $video = $video[$indexv]
}

if ($image -eq -1) { $image = Get-Random -Minimum 0 -Maximum 6 }
elseif ($image -is [array]) {
    $indexi = Get-Random -Minimum 0 -Maximum $image.Length
    $image = $image[$indexi]
}


copy-item "${location}\extra\vid\vid${video}.mkv" "${_destinationPath}\module-2\video.mkv" -Force
copy-item "${location}\extra\img\img${image}.bmp" "${_destinationPath}\module-2\image.bmp" -Force
