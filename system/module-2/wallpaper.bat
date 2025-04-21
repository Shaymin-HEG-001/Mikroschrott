:: Change Wallpaper
:: Thanks to: https://gist.github.com/utilmind/a8a4b60cac52ad0088f8f7edba0b7531
@echo off
::
set "wallpaperSource=.\image.bmp"
set "wallpaperTarget=%UserProfile%\AppData\Local\Microsoft\Windows\Themes\TranscodedWallpaper"
:: BTW we also have optimized wallpaper in the Roaming folder, but don't touch it. Let Windows manage it: "%UserProfile%\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper"
::
echo The wallpaper path is %wallpaperTarget%
copy %wallpaperSource% %wallpaperTarget%

REG ADD "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "%wallpaperTarget%" /f
:: BTW, it also there: \HKCU\SOFTWARE\Microsoft\Internet Explorer\Desktop\General /v WallpaperSource
REG ADD "HKCU\Control Panel\Desktop" /v "WallpaperStyle" /t REG_SZ /d 2 /f
REG ADD "HKCU\Control Panel\Desktop" /v "SnapSizing" /t REG_SZ /d 1 /f
REG ADD "HKCU\Control Panel\Desktop" /v "TileWallpaper" /t REG_SZ /d 0 /f
REG DELETE "HKCU\Control Panel\Desktop" /v "TranscodedImageCache" /f

:: Background type: Picture=0, Solid Color=1, SlideShow=2.
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /v "BackgroundType" /t REG_DWORD /d 00000000 /f

:: Turn off Active Desktop (if it's turned on)
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoActiveDesktop" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoActiveDesktopChanges" /t REG_DWORD /d 00000001 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "ForceActiveDesktopOn" /t REG_DWORD /d 00000000 /f

:: CLEANUP.
:: Don't delete this. Just clear current value. Reference: https://www.winhelponline.com/blog/clear-background-wallpaper-history-windows-10-registry/
REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers" /v "CurrentWallpaperPath" /t REG_SZ /d "" /f
:: AK: old cleanup from 2009, probably not necessary in Windows 10, but just for sure...
REG DELETE "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v "NoChangingWallPaper" /f



:: APPLY. Weirdest thing. It's doesn't apply immediately
:: Some people experienced the same problem: https://social.technet.microsoft.com/Forums/ie/en-US/72a9b4bf-071b-47cd-877d-0c0629a9eb90/how-change-the-wallpaperbackground-with-a-command-line-?forum=w7itproui
:: Let's try to apply N times...
for /L %%i in (1,1,50) do (
    echo Reload %%i of 50
    start RUNDLL32.EXE user32.dll, UpdatePerUserSystemParameters
)
