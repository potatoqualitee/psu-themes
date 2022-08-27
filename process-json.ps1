$themes = Get-Content windows-terminal-themes.json | ConvertFrom-Json
. ./Repository/dashboards/kbupdate/private/functions.ps1
$allthemes = @()
foreach ($theme in $themes) {
    $isdark = Test-DarkColor $theme.background
    $name = $theme.Name
    $originalname = $name
    $keywords = " dark", " light", "_dark", "_light", "-dark", "-light", "-night", "-storm", "Storm"
    $keywords += "Night", "(Dark)", "(Light)", "-day", "Light", "Day", "dark", "light"
    
    # todo: Do something special with Tomorrow
    foreach ($keyword in $keywords) {
        $keyword = [Regex]::Escape($keyword)
        $name = $name -replace "$keyword$"
    }

    $allthemes += [pscustomobject]@{
        OName = $originalname
        Name  = $name.Trim()
        Theme = switch ($isdark) {
            $false { "Light" }
            $true { "Dark" }
        }
    }
}



