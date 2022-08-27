function Get-Sidebar {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath nav.json) | ConvertFrom-Json
}

function Write-Sidebar ($Data) {
    $Data | ConvertTo-Json | Out-File (Join-Path -Path $script:UDRoot -ChildPath nav.json)
}

function New-NavItem {
    param(
        [string]$Label,
        [string]$Redirect,
        [string]$Icon
    )
    New-UDListItem -Label $Label -OnClick { Invoke-UDRedirect $Redirect } -Icon (New-UDIcon -Icon $Icon -Size 1x)
}

function New-NavSwitch ($nav, $item, [switch]$disabled) {
    New-UDSwitch -Id $item.Label -Label $item.Label -Checked $item.Enabled -OnChange {
        $item.Enabled = $EventData
        Write-Sidebar -Data $nav
    } -Disabled:$disabled -Color secondary
}

function Get-Colors {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath colors.json) | ConvertFrom-Json
}
function Theme {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath themes.json) | ConvertFrom-Json
}

function Get-Theme {
    $themes = Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath windows-terminal-themes.json) | ConvertFrom-Json
    foreach ($theme in $themes) {
        $isdark = Test-DarkColor $theme.background
        $blah = [pscustomobject]@{
            Name = $theme.Name
            Theme = switch ($isdark) {
                $false  { "Light" }
                $true   { "Dark" }
            }
        }
    }
}
