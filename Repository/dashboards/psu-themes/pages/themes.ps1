New-UDPage -Name "Select themes" -Url /theme -Content {
    $activetheme = Get-ActiveTheme
    
    $featured = "1984", "Blue Matrix", "Broadcast", "Chalk", "ChallengerDeep", "Chester", "Cyber Cube", "Dark+", "Darkside", "Dracula", "Duckbones", "Elementary", "Espresso", "FirefoxDev", "Firewatch", "Flat", "Galaxy", "Galizur", "Glorious", "Grape", "h4rithd.com", "Gruvbox", "Highway", "Hopscotch.256", "iceberg", "idletoes", "JetBrains Dracula", "Jubi", "Later This Evening", "Liquid Carbon", "lovelace", "Material", "MonaLisa", "Obsidian", "Oceanic-Next", "One", "Pencil", "potatoqualitee", "Pro", "Overnight Slumber", "PaleNightHC", "Pandodra", "Paraiso", "PaulMillr", "Pencil", "Retrowave", "Ryuuko", "Sakura", "Scarlet Protocol", "seoulbones", "Serendipity Sunset", "SleepyHollow", "Sublette", "Subliminal", "synthwave-everything", "Tinacious Design", "Tokyo", "Tomorrow Night Eighties", "Tomorrow", "Treehouse", "Twi", "Ubuntu", "Ultra", "UnderTheSea", "Urple", "Vimbones", "Violet", "Wez", "wilmersdorf", "zenbones"

    New-UDTabs -RenderOnActive -Tabs {
        New-UDTab -Text 'Featured' -Icon (New-UDIcon -Icon dragon) -Content { 
            New-UDLayout -Columns 3 -Content {
                Get-AllThemes | Where-Object { $PSItem -in $featured } | ForEach-Object {
                    New-UDElement -Tag div -Attributes @{
                        style   = @{
                            cursor       = "pointer"
                            "text-align" = "center"
                        }
                        onClick = {
                            Set-ActiveTheme ((Get-UDElement -Id $PSItem)).attributes.id
                        }
                    } -Content {
                        if ($PSItem -eq $ActiveTheme) {
                            $style = @{ "background-color" = "#BBBBC4" }
                            $title = "$PSItem (Active)"
                        } else {
                            $title = $PSItem
                        }
                        New-UDCard -Style $style -TitleAlignment Center -Title $title -Content {
                            New-UDElement -Tag "center" -Content {
                                New-UDImageZoom -Path /assets/screenshots/$PSItem-light.png -Zoom 3 -Delay 0 -Width 387 -Height 200
                            
                                New-UDElement -Tag "div" -Attributes @{
                                    style = @{
                                        "padding" = "10px"
                                    }
                                }
                            
                                New-UDImageZoom -Path /assets/screenshots/$PSItem-dark.png -Zoom 3 -Delay 0 -Width 387 -Height 200
                            }
                        }
                    } -Id $PSItem
                }
            }
        }
        
        New-UDTab -Text 'Other' -Icon (New-UDIcon -Icon drumstick_bite) -Content { 
            New-UDLayout -Columns 3 -Content {
                Get-AllThemes | Where-Object { $PSItem -notin $featured } | ForEach-Object {
                    New-UDElement -Tag div -Attributes @{
                        style   = @{
                            cursor       = "pointer"
                            "text-align" = "center"
                        }
                        onClick = {
                            Set-ActiveTheme ((Get-UDElement -Id $PSItem)).attributes.id
                        }
                    } -Content {
                        if ($PSItem -eq $ActiveTheme) {
                            $style = @{ "background-color" = "#BBBBC4" }
                            $title = "$PSItem (Active)"
                        } else {
                            $title = $PSItem
                        }
                        New-UDCard -Style $style -TitleAlignment Center -Title $title -Content {
                            New-UDElement -Tag "center" -Content {
                                New-UDImageZoom -Path /assets/screenshots/$PSItem-light.png -Zoom 3 -Delay 0 -Width 387 -Height 200
                            
                                New-UDElement -Tag "div" -Attributes @{
                                    style = @{
                                        "padding" = "10px"
                                    }
                                }
                            
                                New-UDImageZoom -Path /assets/screenshots/$PSItem-dark.png -Zoom 3 -Delay 0 -Width 387 -Height 200
                            }
                        }
                    } -Id $PSItem
                }
            }
        }
    }
}