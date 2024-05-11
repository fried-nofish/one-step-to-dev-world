scoop install fzf zoxide

if (!(Test-Path -Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File -Force
}

zoxide init powershell --hook prompt | Out-File -FilePath $PROFILE -Append

Write-Host "Feeding zoxide with local directories."
Get-ChildItem -Path $env:USERPROFILE -Recurse | ForEach-Object -Process {
    if ($_.PSIsContainer) {
        zoxide add $_.FullName
    }
}

. $PROFILE
