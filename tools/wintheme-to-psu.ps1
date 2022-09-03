. $(Resolve-Path -Path $PSScriptRoot\..\Repository\dashboards\psu-themes\private\functions.ps1)
function Get-Shade {
<#
    Get-Shade -Hex "#69c" -Luminance 0      # returns "#6699cc"
    Get-Shade -Hex "6699CC" -Luminance 0.2  # "#7ab8f5" - 20% lighter
    Get-Shade -Hex "69C"  -Luminance -0.5   # "#334d66" - 50% darker
    Get-Shade -Hex "000" -Luminance 1       # "#000000" - true black cannot be made lighter!
#>
    [cmdletbinding()]
    param(
        [Alias("Color")]
        [string]$Hex,
        [string]$CompareColor = $Hex,
        [string]$Luminance = "-0.25"
    )
    
    $hex = $hex -replace "#"
    if ($hex.Length -eq 3) {
        # if someone passed in a shortcut html, expand it
        $hex = $hex[0] + $hex[0] + $hex[1] + $hex[1] + $hex[2] + $hex[2]
    }

    if ([double]$Luminance -lt 0) {
        $new = pastel color $Hex | pastel darken $Luminance.Replace("-","") | pastel format hex
        do {
            $new = pastel color $new | pastel darken 0.01 | pastel format hex
        }
        until ((Test-Contrast -Color1 $CompareColor -Color2 $new) -or ($new -match "000000"))
        $new
    } else {
        $new = pastel color $Hex | pastel lighten $Luminance.Replace("-","") | pastel format hex
        do {
            $new = pastel color $new | pastel lighten 0.01 | pastel format hex
        }
        until ((Test-Contrast -Color1 $CompareColor -Color2 $new) -or ($new -match "ffffff"))
        $new
    }
}

$wintermthemes = Get-Content (Get-ChildItem -Recurse $PSScriptRoot\*windows-terminal-themes.json) | ConvertFrom-Json
# $wintermthemes = $wintermthemes | Select-Object -First 10
# Where-Object Name -in Elementary, "Blue Matrix"

$allthemes = @()
foreach ($theme in $wintermthemes) {
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
        Mode  = switch ($isdark) {
                $false { "light" }
                $true { "dark" }
            }
        Theme = $theme
    }
}

$themegroups = $allthemes | Group-Object -Property Name

foreach ($themegroup in $themegroups) {
    $themename = $themegroup.Name
    Write-Output "Processing $themename"
    $resolved = Resolve-Path -Path "$PSScriptRoot\..\Repository\dashboards\psu-themes\themes"
    $filename = Join-Path -Path $resolved -ChildPath "$themename.json"
    $theme = $themegroup.Group[0].Theme
    $themearray = @()

    $themearray += [pscustomobject]@{
            "Mode"         = "common"
            "Enabled"      = "false"
            "BorderRadius" = "0.475rem"
            "FontFamily"   = "'Inter', sans-serif"
            "Black"        = $theme.black
            "White"        = $theme.white
            "Yellow"       = $theme.yellow
            "YellowRGBA15" = "#26" + ($theme.yellow -replace '#')
            "YellowARGB15" = $theme.yellow + "26"
            "YellowARGB95" = $theme.yellow + "F2"
            "Red"          =  $theme.red
            "RedRGBA15"    = "#26" + ($theme.red -replace '#')
            "RedARGB15"    = $theme.red + "26"
            "RedARGB95"    = $theme.red + "F2"
            "Green"        = $theme.green
            "GreenRGBA15"  = "#26" + ($theme.green -replace '#')
            "GreenARGB15"  = $theme.green + "26"
            "GreenARGB95"  = $theme.green + "F2"
            "Blue"         = $theme.blue
            "BlueRGBA15"   = "#26" + ($theme.blue -replace '#')
            "BlueARGB15"   = $theme.blue + "26"
            "BlueARGB95"   = $theme.blue + "F2"
            "Purple"       = $theme.purple
            "PurpleRGBA15" = "#26" + ($theme.purple -replace '#')
            "PurpleARGB15" = $theme.purple + "26"
            "PurpleARGB95" = $theme.purple + "F2"
            "Cyan"         = $theme.cyan
            "CyanRGBA15"   = "#26" + ($theme.cyan -replace '#')
            "CyanARGB15"   = $theme.cyan + "26"
            "CyanARGB95"   = $theme.cyan + "F2"
    }
    foreach ($themeroot in $themegroup.Group) {
        $theme = $themeroot.Theme
        if ((Test-DarkColor $theme.background)) {
            # DARK THEME
            $main = Get-Shade -Hex $theme.background -Luminance -0.3
            $maingamma = Get-Shade -Hex $theme.background
            $maindelta = Get-Shade -Hex $theme.background -Luminance 0.3
            $oppositesec = Get-Shade -Hex (Get-InvertedColor $theme.background) -Luminance -0.08
            $opposite = Get-Shade -Hex (Get-InvertedColor $theme.background) -Luminance -0.1

            $themearray += [pscustomobject]@{
                "Mode"              = $themeroot.Mode
                "Enabled"           = "true"
                "Main"              = $main
                "MainSecondary"     = $theme.background
                "MainGamma"         = $maingamma
                "MainDelta"         = $maindelta
                "OppositeSecondary" = $oppositesec
                "Opposite"          = $opposite
                "HighContrast"      = Get-InvertedColor $theme.background
                "CyanHover"         = Get-Shade -Color $theme.brightCyan -Luminance 0.25
                "PurpleHover"       = Get-Shade -Color $theme.brightPurple -Luminance 0.25
                "BlueHover"         = Get-Shade -Color $theme.brightBlue -Luminance 0.25
                "GreenHover"        = Get-Shade -Color $theme.brightGreen -Luminance 0.25
                "RedHover"          = Get-Shade -Color $theme.brightRed -Luminance 0.25
                "YellowHover"       = Get-Shade -Color $theme.brightYellow -Luminance 0.25
            }
            if ($themegroup.Group.Mode -notcontains "light") {
                # LIGHT THEME
                $themearray += [pscustomobject]@{
                    "Mode"              = "light"
                    "Enabled"           = "true"
                    "Main"              = Get-InvertedColor $main
                    "MainSecondary"     = Get-InvertedColor $theme.background
                    "MainGamma"         = Get-InvertedColor $maingamma
                    "MainDelta"         = Get-InvertedColor $maindelta
                    "OppositeSecondary" = Get-InvertedColor $oppositesec
                    "Opposite"          = Get-InvertedColor $opposite
                    "HighContrast"      = $theme.background
                    "CyanHover"         = Get-Shade -Color $theme.cyan
                    "PurpleHover"       = Get-Shade -Color $theme.purple
                    "BlueHover"         = Get-Shade -Color $theme.blue
                    "GreenHover"        = Get-Shade -Color $theme.green
                    "RedHover"          = Get-Shade -Color $theme.red
                    "YellowHover"       = Get-Shade -Color $theme.yellow
                }
            }
        } else {            
            $main = Get-Shade -Hex $theme.background -Luminance 0.01
            $maingamma = Get-Shade -Hex $theme.background
            $maindelta = Get-Shade -Hex $theme.background -Luminance -0.2
            $oppositesec = Get-Shade -Hex $theme.background -Luminance -0.2
            $opposite = Get-Shade -Hex $theme.background -Luminance -0.2

            $themearray += [pscustomobject]@{
                # LIGHT THEME
                "Mode"              = $themeroot.Mode
                "Enabled"           = "true"
                "Main"              = $main
                "MainSecondary"     = $theme.background
                "MainGamma"         = $maingamma 
                "MainDelta"         = $maindelta
                "OppositeSecondary" = $oppositesec
                "Opposite"          = $opposite
                "HighContrast"      = Get-InvertedColor $theme.background
                "CyanHover"         = Get-Shade -Color $theme.cyan
                "PurpleHover"       = Get-Shade -Color $theme.purple
                "BlueHover"         = Get-Shade -Color $theme.blue
                "GreenHover"        = Get-Shade -Color $theme.green
                "RedHover"          = Get-Shade -Color $theme.red
                "YellowHover"       = Get-Shade -Color $theme.yellow
            }
            
            if ($themegroup.Group.Mode -notcontains "dark") {
                # DARK THEME
                $themearray += [pscustomobject]@{
                    "Mode"              = "dark"
                    "Enabled"           = "true"
                    "Main"              = Get-InvertedColor $main
                    "MainSecondary"     = Get-InvertedColor $theme.background
                    "MainGamma"         = Get-InvertedColor $maingamma
                    "MainDelta"         = Get-InvertedColor $maindelta
                    "OppositeSecondary" = Get-InvertedColor $oppositesec
                    "Opposite"          = Get-InvertedColor $opposite
                    "HighContrast"      = Get-InvertedColor $theme.background
                    "CyanHover"         = Get-Shade -Color $theme.brightCyan -Luminance 0.25
                    "PurpleHover"       = Get-Shade -Color $theme.brightPurple -Luminance 0.25
                    "BlueHover"         = Get-Shade -Color $theme.brightBlue -Luminance 0.25
                    "GreenHover"        = Get-Shade -Color $theme.brightGreen -Luminance 0.25
                    "RedHover"          = Get-Shade -Color $theme.brightRed -Luminance 0.25
                    "YellowHover"       = Get-Shade -Color $theme.brightYellow -Luminance 0.25
                }
            }
        }
    }
    $themearray | ConvertTo-Json | Out-File -FilePath $filename -Encoding ascii
}