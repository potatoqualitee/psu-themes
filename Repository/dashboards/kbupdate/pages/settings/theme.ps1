New-UDPage -Name Theme -Url /settings/theme -Content {
    $allthemes = Get-AllThemes
    $activetheme = Get-ActiveTheme
    
    foreach ($theme in $allthemes) {
        if ($activetheme -eq "$theme") {
            $checked = $true
        } else {
            $checked = $false
        }
        <#
        New-UDSwitch -Id $theme -Label $theme -Checked $checked -OnChange {
            Set-ActiveTheme -Theme $theme
        } -Color secondary

        New-UDTableColumn -Property "myColumn" -Render {
            New-UDImage -Url $EventData.myColumn
        }
        #>
    }
    
    New-UDLayout -Columns 3 -Content {
        Get-AllThemes | Select-Object -First 100 | ForEach-Object {
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
                    }

                    New-UDImage -Url /assets/screenshots/$PSItem-dark.png -Width 256 -Height 144
                }
            } -Id $PSItem
        }
    }
}