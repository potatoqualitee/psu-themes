try {
    $root = Resolve-Path -Path "$($PSScriptRoot)\..\..\" -ErrorAction Stop
} catch {
    $root = Resolve-Path -Path C:\github\psu-themes
}
New-PSUPublishedFolder -RequestPath "/assets" -Path (Resolve-Path -Path "$root\Repository\dashboards\psu-themes\assets")
