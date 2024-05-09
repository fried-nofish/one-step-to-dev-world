Push-Location HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced
# set value to 1 if you want to hide file extensions
Set-ItemProperty -Path . -Name HideFileExt -Value 0
Pop-Location

# restart explorer to apply the change
Stop-Process -Name explorer
