$global:UDRoot = $script:UDRoot = "C:\github\psu-themes\Repository\dashboards\kbupdate"
. C:\github\psu-themes\Repository\dashboards\kbupdate\private\functions.ps1
$files = Get-ChildItem C:\github\psu-themes\Repository\dashboards\kbupdate\themes\*json

foreach ($file in $files) {
    $theme = $file.BaseName
    Set-ActiveTheme -Theme $theme
    write-warning "'$theme'"
    Start-Sleep 2
    node .\screenshots.js "$theme"
}

