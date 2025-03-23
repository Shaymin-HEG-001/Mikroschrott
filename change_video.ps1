Write-Output "Enter number of video from extra folder"
$vid = Read-Host

if($vid -eq 0){
    Remove-Item ".\Microsoft\module-2\video.mkv"
    Copy-Item ".\extra\vid0.mkv" ".\Microsoft\module-2\video.mkv"
}
elseif ($vid -eq 1){
    Remove-Item ".\Microsoft\module-2\video.mkv"
    Copy-Item ".\extra\vid1.mkv" ".\Microsoft\module-2\video.mkv"
}
elseif ($vid -eq 2){
    Remove-Item ".\Microsoft\module-2\video.mkv"
    Copy-Item ".\extra\vid2.mkv" ".\Microsoft\module-2\video.mkv"
}
elseif ($vid -eq 3){
    Remove-Item ".\Microsoft\module-2\video.mkv"
    Copy-Item ".\extra\vid3.mkv" ".\Microsoft\module-2\video.mkv"
}