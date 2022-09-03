$global:UDRoot = $script:UDRoot = (Resolve-Path "$PSScriptRoot/../Repository\dashboards\psu-themes").Path
return $PSScriptRoot
. "$script:UDRoot\private\functions.ps1"
$files = Get-ChildItem "$script:UDRoot\themes\*json" #| Select-Object -First 10

foreach ($file in $files) {
    $theme = $file.BaseName
    Set-ActiveTheme -Theme $theme
    if ($Env:CI) {
        $colorfile = Join-Path -Path $script:UDRoot -ChildPath colors.json
        docker cp $colorfile powershelluniversal:/root/.PowerShellUniversal/Repository/dashboards/psu-themes/colors.json
    }
    Start-Sleep 2
    $screenshots = Join-Path -Path $PSScriptRoot -ChildPath screenshots.js
    node $screenshots "$theme"
}