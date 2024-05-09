Join-Path -Path $PSScriptRoot -ChildPath ../deps/RefreshEnv.ps1 -Resolve | Import-Module | Out-Null

winget install Microsoft.WindowsTerminal

winget install Microsoft.VisualStudioCode.CLI Microsoft.VisualStudioCode
Update-SessionEnvironment
$vscInstallDir = (Get-Command code.cmd).Source | Split-Path -Parent | Split-Path -Parent
code version use stable --install-dir $vscInstallDir

# install recommanded extensions for vscode
code ext install `
    MS-CEINTL.vscode-language-pack-zh-hans `
    usernamehw.errorlens `
    VisualStudioExptTeam.vscodeintellicode `
    vadimcn.vscode-lldb `
    alefragnani.Bookmarks `
    formulahendry.code-runner `
    Gruntfuggly.todo-tree
