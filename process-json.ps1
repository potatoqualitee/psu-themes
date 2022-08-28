function Test-DarkColor {
    <#
    .SYNOPSIS
    Tests an rgb or hex value to see if it's considered light or dark

    .PARAMETER Color
    The color to test in Hex or RGB
    
    .NOTES
    Thanks to:
    https://github.com/EvotecIT/PSSharedGoods/blob/master/Public/Converts/Convert-Color.ps1
    https://awik.io/determine-color-bright-dark-using-javascript/

    .EXAMPLE
    Test-DarkColor ffffff
    False
    
    .EXAMPLE
    Test-DarkColor 000000
    True

    .EXAMPLE
    Test-DarkColor "rgb(255,255,255)"
    False

    .EXAMPLE
    Test-DarkColor "rgb(255,255,255)"
    VERBOSE: 255
    VERBOSE: 255
    VERBOSE: 255
    VERBOSE: 255
    False
   
    #>
    [cmdletbinding()]
    param(
        [string[]]$Color
    )
    # Clean up
    if ($first = $Color[1]) {
        $cleanedcolor = $Color -join ","
        if ($first -notmatch "rgb" -and $first -notmatch "\(") {
            $cleanedcolor = "rgb($cleanedcolor)"
        }
    } else {
        $cleanedcolor = "$Color"
    }
    $cleanedcolor = $cleanedcolor.Replace('#','')
    $cleanedcolor = $cleanedcolor.Replace(' ','')

    if ($cleanedcolor -match '^rgb') {
        try {
            # If RGB --> store the red, green, blue values in separate variables
            $rgb = $cleanedcolor -match '^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*(\d+(?:\.\d+)?))?\)$'
            if (-not $rgb) {
                $rgb = $cleanedcolor -match '^([01]?[0-9]?[0-9]|2[0-4][0-9]|25[0-5])$'
            }
            
            $r = [convert]::ToInt32($matches[1])
            $g = [convert]::ToInt32($matches[2])
            $b = [convert]::ToInt32($matches[3])
        } catch {
            Write-Warning "$cleanedcolor isnt a valid rgb color for the purposes of the script: $PSItem"
            return
        }
    } else {
        
        try {
            $null = [int]::Parse($cleanedcolor,[System.Globalization.NumberStyles]::HexNumber)
            if ($cleanedcolor.Length -eq 3) {
                # if someone passed in a shortcut html, expand it
                $cleanedcolor = $cleanedcolor[0] + $cleanedcolor[0] + $cleanedcolorex[1] + $cleanedcolor[1] + $cleanedcolor[2] + $cleanedcolor[2]
            }
            $r = $cleanedcolor.Remove(2, 4)
            $g = $cleanedcolor.Remove(4, 2)
            $g = $g.remove(0, 2)
            $b = $cleanedcolor.Remove(0, 4)
            $r = [convert]::ToInt32($r, 16)
            $g = [convert]::ToInt32($g, 16)
            $b = [convert]::ToInt32($b, 16)
        } catch {
            Write-Warning "$cleanedcolor is not a valid hex for the purposes of the script"
            return
        }
    }
    
    $r, $g, $b | Write-Verbose
    # HSP equation from http://alienryderflex.com/hsp.html
    $hsp = [math]::Sqrt(
        0.299 * ($r * $r) +
        0.587 * ($g * $g) +
        0.114 * ($b * $b)
    )

    # Using the HSP value, determine whether the $cleanedcolor is light or dark
    if ($hsp -gt 127.5) {
        $hsp | Write-Verbose
        return $false
    } else {
        $hsp | Write-Verbose
        return $true
    }
}

function Get-InvertedColor {
    [cmdletbinding()]
    param(
        [Alias("Color")]
        $Hex
    )
    
    $hex = $hex -replace "#"
    if ($hex.Length -eq 3) {
        # if someone passed in a shortcut html, expand it
        $hex = $hex[0] + $hex[0] + $hex[1] + $hex[1] + $hex[2] + $hex[2]
    }

    $rgb = "#"
    for ($i = 0; $i -lt 3; $i++) {
        $number = $i * 2
        $what = $hex.substring($number, 2)
        $c = [convert]::ToInt32($what, 16)
        $opposite = (255 - $c)
        $c = '{0:X4}' -f $opposite
        $rgb += ("00" + $c).SubString($c.length)
    }
    -join $rgb
}

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
        $Hex,
        $Luminance = -0.25
    )
    $hex = $hex -replace "#"
    if ($hex.Length -eq 3) {
        # if someone passed in a shortcut html, expand it
        $hex = $hex[0] + $hex[0] + $hex[1] + $hex[1] + $hex[2] + $hex[2]
    }

    $rgb = "#", $c, $i
    for ($i = 0; $i -lt 3; $i++) {
        $number = $i * 2
        $what = $hex.substring($number, 2)
        $c = [convert]::ToInt32($what, 16)
        $max = [Math]::Max(0, $c + ($c * $Luminance))
        $min = [Math]::Min($max, 255)
        $c = '{0:X4}' -f $min
        $rgb += ("00" + $c).SubString($c.length)
    }
    -join $rgb
}

function Get-ColorApi {
    [cmdletbinding()]
    param(
        $Color,
        $Count = 4
    )
    $Color = $Color -replace '#'
    Invoke-RestMethod "https://www.thecolorapi.com/scheme?hex=$Color&mode=monochrome&count=$Count&format=json"
}


$wintermthemes = Get-Content (Get-ChildItem -Recurse C:\github\psu-themes\*windows-terminal-themes.json) | ConvertFrom-Json
$wintermthemes = $wintermthemes | Where-Object name -eq retrowave

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
    $filename = Join-Path -Path themes -ChildPath "$themename.json"
    $theme = $themegroup.Group[0].Theme
    $themearray = @()
    $yellow     = Get-Shade -Color $theme.yellow
    $red        = Get-Shade -Color $theme.red
    $green      = Get-Shade -Color $theme.green
    $blue       = Get-Shade -Color $theme.blue
    $purple     = Get-Shade -Color $theme.purple
    $cyan       = Get-Shade -Color $theme.cyan

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
            "YellowHover"  = $yellow
            "Red"          =  $theme.red
            "RedRGBA15"    = "#26" + ($theme.red -replace '#')
            "RedARGB15"    = $theme.red + "26"
            "RedARGB95"    = $theme.red + "F2"
            "RedHover"     = $red
            "Green"        = $theme.green
            "GreenRGBA15"  = "#26" + ($theme.green -replace '#')
            "GreenARGB15"  = $theme.green + "26"
            "GreenARGB95"  = $theme.green + "F2"
            "GreenHover"   = $green
            "Blue"         = $theme.blue
            "BlueRGBA15"   = "#26" + ($theme.blue -replace '#')
            "BlueARGB15"   = $theme.blue + "26"
            "BlueARGB95"   = $theme.blue + "F2"
            "BlueHover"    = $blue
            "Purple"       = $theme.purple
            "PurpleRGBA15" = "#26" + ($theme.purple -replace '#')
            "PurpleARGB15" = $theme.purple + "26"
            "PurpleARGB95" = $theme.purple + "F2"
            "PurpleHover"  = $purple
            "Cyan"         = $theme.cyan
            "CyanRGBA15"   = "#26" + ($theme.cyan -replace '#')
            "CyanARGB15"   = $theme.cyan + "26"
            "CyanARGB95"   = $theme.cyan + "F2"
            "CyanHover"    = $cyan
    }
    foreach ($themeroot in $themegroup.Group) {
        $theme = $themeroot.Theme
        $background = Get-ColorApi -Color $theme.background
        $foreground = Get-ColorApi -Color $theme.foreground

        $themearray += [pscustomobject]@{
            "Mode"              = $themeroot.Mode
            "Enabled"           = "false"
            "Main"              = $theme.background
            "MainSecondary"     = "#" + ($background.colors | Select-Object -First 1 -Skip 1).hex.clean
            "MainGamma"         = "#" + ($background.colors | Select-Object -First 1 -Skip 1).hex.clean
            "MainDelta"         = "#" + ($background.colors | Select-Object -First 1).hex.clean
            "OppositeSecondary" = "#" + ($background.colors | Select-Object -First 1 -Skip 1).hex.clean
            "Opposite"          = "#" + ($background.colors | Select-Object -First 1 -Skip 2).hex.clean
            "HighContrast"      = Get-InvertedColor $theme.background
        }
    }
    $themearray | ConvertTo-Json | Out-File -FilePath $filename
}
<#
{
  "name": "Retrowave",
  "black": "#181A1F",
  "red": "#FF16B0",
  "green": "#929292",
  "yellow": "#fcee54",
  "blue": "#46BDFF",
  "purple": "#FF92DF",
  "cyan": "#df81fc",
  "white": "#FFFFFF",
  "brightBlack": "#FF16B0",
  "brightRed": "#f85353",
  "brightGreen": "#fcee54",
  "brightYellow": "#ffffff",
  "brightBlue": "#46BDFF",
  "brightPurple": "#FF92DF",
  "brightCyan": "#ff901f",
  "brightWhite": "#ffffff",
  "background": "#070825",
  "foreground": "#46BDFF"
}

# KBUPATE
    "Mode": "dark",
    "Enabled": true,
    "Main": "#0D0F31",
    "MainSecondary": "#070825",
    "MainGamma": "#454761",
    "MainDelta": "#A2A2AA",
    "Opposite": "#c9d1d9",
    "OppositeSecondary": "#8b949e",
    "HighContrast": "#ffffff"
#>

<#
    Get-Shade -Hex "#69c" -Luminance 0      # returns "#6699cc"
    Get-Shade -Hex "6699CC" -Luminance 0.2  # "#7ab8f5" - 20% lighter
    Get-Shade -Hex "69C"  -Luminance -0.5   # "#334d66" - 50% darker
    Get-Shade -Hex "000" -Luminance 1       # "#000000" - true black cannot be made lighter!
#>
<#
Overview:
* Main - This is the main background of the page
* MainSecondary - Usually use on “cards” or an element imminently on top of something with the “Main” color.
* MainGamma - Usually used when layered on top of an element with the color “MainSecondary”. So for instant, this is the color of table headers and also borders.
* MainDelta - This is rarely used, but available to use on top of “MainGamma” elements or as a hover background color.
* Opposite - This is the opposite color of “Main”. This is usually the main text color.
* OppositeSecondary- This is mostly used as a “muted” text color if needed and a shade a tad darker than “Opposite”.

Dark Mode:
* Main - Darkest color on the page
* MainSecondary - A shade lighter than “Main”
* MainGamma - A shade lighter than “MainSecondary”
* MainDelta - A shade lighter than “MainGamma”

Light Mode:
* Main - A shade darker than “MainSecondary”
* MainSecondary - The lightest color on the page
* MainGamma - A shade darker than “Main”
* MainDelta - A shade darker than “MainGamma”
#>
