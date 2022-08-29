$global:UDRoot = $script:UDRoot = $PSScriptRoot
. "$PSScriptRoot\private\functions.ps1"
$files = Get-ChildItem "$PSScriptRoot\themes\*json"

foreach ($file in $files) {
    $theme = $file.BaseName
    Set-ActiveTheme -Theme $theme
    Start-Sleep 2
    node $script:UDRoot\screenshots.js "$theme"
}