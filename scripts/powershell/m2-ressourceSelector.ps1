# Copy Video/Wallpaper for Module 2
if ($video -eq -1) { $video = Get-ChildItem -Path "${_resourcesPath}\vid" -Filter *.mkv | Select-Object -ExpandProperty Name  }
if ($video -is [array]) {
    $indexv = Get-Random -Minimum 0 -Maximum $video.Length
    $video = $video[$indexv]
}

if ($image -eq -1) { $image = Get-ChildItem -Path "${_resourcesPath}\img" -Filter *.bmp | Select-Object -ExpandProperty Name }
if ($image -is [array]) {
    $indexi = Get-Random -Minimum 0 -Maximum $image.Length
    $image = $image[$indexi]
}

copy-item $_resourcesPath\vid\$video "${_destinationPath}\module-2\video.mkv" -Force
copy-item $_resourcesPath\img\$image "${_destinationPath}\module-2\image.bmp" -Force
