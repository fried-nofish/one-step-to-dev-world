Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    Invoke-WebRequest -Uri get.scoop.sh -UseBasicParsing | Invoke-Expression
}

# enable the following block to config proxy, remind to switch to your own proxy address
if ($false) {
    scoop config proxy localhost:10809
}

if (!(Get-Command git -ErrorerAction SilentlyContinue)) {
    scoop install git
    Join-Path -Path $PSScriptRoot -ChildPath init-config-git.ps1 | Invoke-Expression
}

scoop rm main
scoop bucket add main https://gitee.com/scoop-bucket/main.git
scoop bucket add extras
scoop update

scoop install aria2
scoop config aria2-enabled $true

scoop install extras/vcredist
scoop install pwsh
scoop install winget
