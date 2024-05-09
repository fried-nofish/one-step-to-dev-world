New-Module -Script {

function Show-Menu {
    <#
    .SYNOPSIS
        Generates a dynamic console menu featuring a list of options, allowing users to
        navigate and select choices using their keyboard arrows.
    .DESCRIPTION
        The Show-Menu function is used to display a dynamic menu in the console. It takes
        a title and a list of options as parameters. The title is optional and defaults to
        "Please make a selection...". The list of options is mandatory. The function will
        display the title in green, followed by the list of options. The user can then make
        a selection from the options provided.
    .EXAMPLE
        $MenuData += [PSCustomObject]@{Id = 1; DisplayName = "Menu Option 1"}, `
                     [PSCustomObject]@{Id = 2; DisplayName = "Menu Option 2"}, `
                     [PSCustomObject]@{Id = 3; DisplayName = "Menu Option 3"}
        Show-Menu -DynamicMenuTitle "Main Menu" -DynamicMenuList $MenuData
        This example shows how to use the Show-Menu function to display a menu with a custom title and three options.
    .NOTES
        Version: 20231115.01
        Author:  Ryan Dunton https://github.com/ryandunton
    #>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [string]
        $DynamicMenuTitle = "Please make a selection...",
        [Parameter(Mandatory=$true)]
        [array]
        $DynamicMenuList
    )

    begin {
        Write-Host "[+] $DynamicMenuTitle" -ForegroundColor Green
        # Create space for the menu
        $i=0
        while ($i -lt $DynamicMenuList.Count) {
            $i++
            Write-Host ""
        }
    }

    process {
        # Set initial selection index
        $SelectedValueIndex = 0
        # Display the menu and handle user input
        do {
            # Move cursor to top of menu area
            [Console]::SetCursorPosition(0, [Console]::CursorTop - $DynamicMenuList.Count)
            for ($i = 0; $i -lt $DynamicMenuList.Count; $i++) {
                if ($i -eq $SelectedValueIndex) {
                    Write-Host "[>] $($DynamicMenuList[$i].DisplayName)" -NoNewline
                } else {
                    Write-Host "[ ] $($DynamicMenuList[$i].DisplayName)" -NoNewline
                }
                #Clear any extra characters from previous lines
                $SpacesToClear = [Math]::Max(0, ($DynamicMenuList[0].Length - $DynamicMenuList[$i].Length))
                Write-Host (" " * $SpacesToClear) -NoNewline
                Write-Host ""
            }
            # Get user input
            $KeyInfo = $Host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown')
            # Process arrow key input
            switch ($KeyInfo.VirtualKeyCode) {
                38 {  # Up arrow
                    $SelectedValueIndex = [Math]::Max(0, $SelectedValueIndex - 1)
                }
                40 {  # Down arrow
                    $SelectedValueIndex = [Math]::Min($DynamicMenuList.Count - 1, $SelectedValueIndex + 1)
                }
            }
        } while ($KeyInfo.VirtualKeyCode -ne 13)  # Enter key
        $SelectedValue = $DynamicMenuList[$SelectedValueIndex]
    }

    end {
        return $SelectedValue.Id
    }
}

Export-ModuleMember -Function Show-Menu

}
