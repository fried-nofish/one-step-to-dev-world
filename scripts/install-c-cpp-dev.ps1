Join-Path -Path $PSScriptRoot -ChildPath ../deps/RefreshEnv.ps1 -Resolve | Import-Module

scoop install gcc
scoop install llvm clangd
scoop install cmake make ninja vcpkg pkg-config

# set default cmake generator to make
[Environment]::SetEnvironmentVariable('CMAKE_GENERATOR', 'Ninja', 'User')

# cmake might prefer to use clang, but llvm-clang installed via scoop includes only the
# bare compiler, explicitly specifying gcc to avoid possible link errors
[Environment]::SetEnvironmentVariable('CC', (Get-Command gcc).Source, 'User')
[Environment]::SetEnvironmentVariable('CXX', (Get-Command g++).Source, 'User')

Update-SessionEnvironment

# install recommanded c/c++ extensions for vscode
code ext install `
    ms-vscode.cpptools `
    ms-vscode.cpptools-themes `
    ms-vscode.cpptools-extension-pack `
    twxs.cmake `
    ms-vscode.cmake-tools `
    xaver.clang-format `
    llvm-vs-code-extensions.vscode-clangd

# cpptools conflicts with clangd, use clangd as the default c/c++ language server
code --disable-extension ms-vscode.cpptools

# bear helps to generate compile_commands.json for clangd, but build from sources would
# cost much time
# enable the following block if you indeed want to install bear
if ($false) {
    Push-Location $env:TEMP
    $bearInstallDir = "$env:APPDATA\bear"
    git clone https://github.com/rizsotto/Bear.git
    cmake -B build-bear -S Bear -DCMAKE_INSTALL_PREFIX=$bearInstallDir
    cmake --build build-bear --target install --config Release
    [Environment]::SetEnvironmentVariable('Path', "$env:Path;$bearInstallDir\bin", 'User')
    Update-SessionEnvironment
    Pop-Location
}
