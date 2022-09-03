New-UDPage -Name Sidebar -Url /sidebar -Content {
    $navs = Get-Sidebar
    
    New-UDTypography -Text General -Variant h5

    $nav = $navs | Where-Object Category -eq $null
    foreach ($item in $nav) {
        New-NavSwitch -nav $navs -item $item
    }
}