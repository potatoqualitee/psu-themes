$script:UDRoot = $PSScriptRoot
$PSDefaultParameterValues["*:NavigationLayout"] = "Permanent"
$PSDefaultParameterValues["*:Logo"] = "/assets/logo.png"

Import-Module -Path (Join-Path -Path $PSScriptRoot -ChildPath init.psm1) -Force

Get-ChildItem (Join-Path -Path $PSScriptRoot -ChildPath private) -Recurse -File | ForEach-Object {
    . $PSItem.FullName
}

$pages = Get-ChildItem (Join-Path -Path $PSScriptRoot -ChildPath pages) -Recurse -File | ForEach-Object {
    & $PSItem.FullName
}

. (Join-Path -Path $PSScriptRoot -ChildPath theme.ps1)
$sidebar = . (Join-Path -Path $PSScriptRoot -ChildPath sidebar.ps1)

$parms = @{
    Title       = "kbupdate"
    StyleSheets = "/assets/theme.css"
    Theme       = $themes
    Pages       = $pages
    Navigation  = $sidebar
}

New-UDDashboard @parms