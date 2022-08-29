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
    $theme = Get-ActiveTheme
    Get-Content -Path (Join-Path -Path (Get-ThemeFolder) -ChildPath "$theme.json") | ConvertFrom-Json
}

function Get-ActiveTheme {
    (Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath colors.json) | ConvertFrom-Json).Theme
}


function Get-ThemeFolder {
    Join-Path -Path $script:UDRoot -ChildPath themes
}


function Set-ActiveTheme ($Theme) {
    [PSCustomObject]@{ Theme = $Theme } | ConvertTo-Json | Out-File (Join-Path -Path $script:UDRoot -ChildPath colors.json)
}

function Get-AllThemes {
    (Get-ChildItem -Path (Join-Path -Path $script:UDRoot -ChildPath themes) -Filter *.json).BaseName
}
