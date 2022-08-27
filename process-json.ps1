$themes = Get-Content windows-terminal-themes.json | ConvertFrom-Json
. ./Repository/dashboards/kbupdate/private/functions.ps1
foreach ($theme in $themes) {
    $isdark = Test-DarkColor $theme.background
    [pscustomobject]@{
    Name = $theme.Name
    Theme = switch ($isdark) {
        $false  { "Light" }
        $true   { "Dark" }
    }
    }
}