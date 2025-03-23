for /l %%x in (1,1,2) do (
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d ".\image.bmp" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
)
exit 0
