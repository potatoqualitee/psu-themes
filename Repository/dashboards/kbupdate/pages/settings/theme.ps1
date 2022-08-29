New-UDPage -Name Theme -Url /settings/theme -Content {
    $allthemes = Get-AllThemes
    
    New-UDTypography -Text Themes -Variant h5
    $activetheme = Get-ActiveTheme
    
    foreach ($theme in $allthemes) {
        if ($activetheme -eq "$theme") {
            $checked = $true
        } else {
            $checked = $false
        }
        New-UDSwitch -Id $theme -Label $theme -Checked $checked -OnChange {
            Set-ActiveTheme -Theme $theme
        } -Color secondary
    }
}