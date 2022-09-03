$nav = Get-Sidebar | Where-Object Enabled
$links = $nav | Where-Object Category -eq $null
$settings = $nav | Where-Object Category -eq Settings

New-UDList -Content {
    foreach ($link in $links) {
        New-NavItem -Label $link.Label -Redirect $link.Redirect -Icon $link.Icon
    }
    
    if ($settings) {
        New-UDListItem -Label Settings -Id drawerSettings -Icon (New-UDIcon -Icon wrench -Size 1x) -Children {
            foreach ($setting in $settings) {
                New-NavItem -Label $setting.Label -Redirect $setting.Redirect -Icon $setting.Icon
            }
        }
    }
}