New-UDPage -Name Theme -Url /settings/theme -Content {
    $allthemes = Get-AllThemes
    $activetheme = Get-ActiveTheme
    
    foreach ($theme in $allthemes) {
        if ($activetheme -eq "$theme") {
            $checked = $true
        } else {
            $checked = $false
        }
    }
    
    New-UDLayout -Columns 3 -Content {
        Get-AllThemes | ForEach-Object {
            New-UDElement -Tag div -Attributes @{
                style   = @{
                    cursor       = "pointer"
                    "text-align" = "center"
                }
                onClick = {
                    Set-ActiveTheme ((Get-UDElement -Id $PSItem)).attributes.id
                }
            } -Content {
                New-UDCard -TitleAlignment Center -Title $PSItem -Content {
                    New-UDImage -Url /assets/screenshots/$PSItem-light.png -Width 256 -Height 144 -Attributes @{
                        style           = @{ 
                            paddingRight = "26px"
                        }
                    } -ClassName "photo"

                    New-UDImage -Url /assets/screenshots/$PSItem-dark.png -Width 256 -Height 144 -ClassName "photo"
                }
            } -Id $PSItem
        }
    }
}