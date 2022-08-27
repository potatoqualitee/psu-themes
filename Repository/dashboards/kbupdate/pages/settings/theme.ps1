New-UDPage -Name Sidebar -Url /settings/theme -Content {
    $themez = Get-Theme
    
    New-UDTypography -Text General -Variant h5

    $nav = $themez | Where-Object Category -eq $null
    foreach ($item in $nav) {
        New-NavSwitch -nav $themez -item $item
    }
    
    New-UDElement -Tag p -Content {  }
    New-UDTypography -Text Settings -Variant h5

    $nav = $themez | Where-Object Category -eq "Settings"
    foreach ($item in $nav) {
        if ($item.Label -eq "Sidebar") {
            New-NavSwitch -nav $themez -item $item -Disabled
        } else {
            New-NavSwitch -nav $themez -item $item
        }
    }
}