New-UDPage -Name Sidebar -Url /settings/sidebar -Content {
    $navs = Get-Sidebar
    
    New-UDTypography -Text General -Variant h5

    $nav = $navs | Where-Object Category -eq $null
    foreach ($item in $nav) {
        New-NavSwitch -nav $navs -item $item
    }
    
    New-UDElement -Tag p -Content {  }
    New-UDTypography -Text Settings -Variant h5

    $nav = $navs | Where-Object Category -eq "Settings"
    foreach ($item in $nav) {
        if ($item.Label -eq "Sidebar") {
            New-NavSwitch -nav $navs -item $item -Disabled
        } else {
            New-NavSwitch -nav $navs -item $item
        }
    }
}