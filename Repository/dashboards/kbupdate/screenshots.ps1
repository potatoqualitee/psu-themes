$global:UDRoot = $script:UDRoot = $PSScriptRoot
. "$PSScriptRoot\private\functions.ps1"
$files = Get-ChildItem "$PSScriptRoot\themes\*json"

foreach ($file in $files) {
    $theme = $file.BaseName
    Set-ActiveTheme -Theme $theme
    Start-Sleep 2
    $screenshots = Join-Path -Path $script:UDRoot -ChildPath screenshots.js
    node $screenshots "$theme"
}