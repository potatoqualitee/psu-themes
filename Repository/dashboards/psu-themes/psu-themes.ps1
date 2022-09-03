$script:UDRoot = $PSScriptRoot
$PSDefaultParameterValues["*:NavigationLayout"] = "Permanent"
$PSDefaultParameterValues["*:Logo"] = "/assets/logo.png"

Import-Module (Resolve-Path -Path "$PSScriptRoot\private\UDImageZoom\0.0.1\UDImageZoom.psd1")

Get-ChildItem (Join-Path -Path $PSScriptRoot -ChildPath private) -Recurse -File | ForEach-Object {
    . $PSItem.FullName
}

$pages = Get-ChildItem (Join-Path -Path $PSScriptRoot -ChildPath pages) -Recurse -File | ForEach-Object {
    & $PSItem.FullName
}

. (Join-Path -Path $PSScriptRoot -ChildPath theme.ps1)
$sidebar = . (Join-Path -Path $PSScriptRoot -ChildPath sidebar.ps1)


$parms = @{
    Title       = "psu-themes"
    StyleSheets = "/assets/theme.css"
    Theme       = $themes
    Pages       = $pages
    Navigation  = $sidebar
}

New-UDDashboard @parms