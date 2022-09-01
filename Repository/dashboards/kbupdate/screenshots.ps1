$global:UDRoot = $script:UDRoot = $PSScriptRoot
. "$PSScriptRoot\private\functions.ps1"
$files = Get-ChildItem "$PSScriptRoot\themes\*json" | Select-Object -First 10

foreach ($file in $files) {
    $theme = $file.BaseName
    Set-ActiveTheme -Theme $theme
    if ($Env:CI) {
        Write-Warning "CI environment detected"
        $colorfile = Join-Path -Path $script:UDRoot -ChildPath colors.json
        Write-Warning $colorfile
        docker cp $colorfile powershelluniversal:/root/.PowerShellUniversal/Repository/dashboards/kbupdate/colors.json
    }
    Start-Sleep 2
    $screenshots = Join-Path -Path $script:UDRoot -ChildPath screenshots.js
    node $screenshots "$theme"
}