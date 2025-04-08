@echo off
if not "%1" == "min" start /MIN cmd /c %0 min & exit/b >nul 2>&1
for /l %%x in (1,1,50) do (
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d ".\image.bmp" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
)
exit 0
