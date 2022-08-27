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
                # this could be done with pure regex but alas
                # if someone passed in a shortcut html, expand it
                $temp = @()
                foreach ($char in $cleanedcolor.ToCharArray()) {
                    $temp += $char, $char
                }
                $cleanedcolor = $temp -join ""
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

function Get-ColorApi {
    [cmdletbinding()]
    param(
        $Color, 
        $Count = 4
    )
    $Color = $Color -replace '#'
    Invoke-RestMethod "https://www.thecolorapi.com/scheme?hex=$Color&mode=monochrome&count=$Count&format=json" -Verbose
}

$wintermthemes = Get-Content windows-terminal-themes.json | ConvertFrom-Json

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
    
    $themearray = @()
    foreach ($themeroot in $themegroup.Group) {
        $theme = $themeroot.Theme
        if ($theme.selectionBackground) {
            # no idea
        }
        # if mode = light, hover = next darker
        # if mode = dark, hover = next lighter
        $yellow     = Get-ColorApi -Color $theme.yellow
        $red        = Get-ColorApi -Color $theme.red
        $green      = Get-ColorApi -Color $theme.green
        $blue       = Get-ColorApi -Color $theme.blue
        $purple     = Get-ColorApi -Color $theme.purple
        $cyan       = Get-ColorApi -Color $theme.cyan
        $background = Get-ColorApi -Color $theme.background
        $foreground = Get-ColorApi -Color $theme.foreground

        $themearray += [pscustomobject]@{
            "Mode"              = $themeroot.Mode
            "BorderRadius"      = "0.475rem"
            "FontFamily"        = "'Inter' sans-serif"
            "Black"             = $theme.black
            "White"             = $theme.white
            "Yellow"            = $theme.yellow
            "YellowRGBA15"      = "#26" + ($theme.yellow -replace '#')
            "YellowARGB15"      = $theme.yellow + "26"
            "YellowARGB95"      = $theme.yellow + "F2"
            "YellowHover"       = "#" + ($yellow.colors | Select-Object -Last 1).hex.clean
            "Red"               =  $theme.red
            "RedRGBA15"         = "#26" + ($theme.red -replace '#')
            "RedARGB15"         = $theme.red + "26"
            "RedARGB95"         = $theme.red + "F2"
            "RedHover"          = "#" + ($red.colors | Select-Object -Last 1).hex.clean
            "Green"             = $theme.green
            "GreenRGBA15"       = "#26" + ($theme.green -replace '#')
            "GreenARGB15"       = $theme.green + "26"
            "GreenARGB95"       = $theme.green + "F2"
            "GreenHover"        = "#" + ($green.colors | Select-Object -Last 1).hex.clean
            "Blue"              = $theme.blue
            "BlueRGBA15"        = "#26" + ($theme.blue -replace '#')
            "BlueARGB15"        = $theme.blue + "26"
            "BlueARGB95"        = $theme.blue + "F2"
            "BlueHover"         = "#" + ($blue.colors | Select-Object -Last 1).hex.clean
            "Purple"            = $theme.purple
            "PurpleRGBA15"      = "#26" + ($theme.purple -replace '#')
            "PurpleARGB15"      = $theme.purple + "26"
            "PurpleARGB95"      = $theme.purple + "F2"
            "PurpleHover"       = "#" + ($purple.colors | Select-Object -Last 1).hex.clean
            "Cyan"              = $theme.cyan
            "CyanRGBA15"        = "#26" + ($theme.cyan -replace '#')
            "CyanARGB15"        = $theme.cyan + "26"
            "CyanARGB95"        = $theme.cyan + "F2"
            "CyanHover"         = "#" + ($cyan.colors | Select-Object -Last 1).hex.clean
            "Main"              = $theme.background
            "MainSecondary"     = $theme.foreground
            "MainGamma"         = "#" + ($foreground.colors | Select-Object -First 1 -Skip 1).hex.clean
            "MainDelta"         = "#" + ($background.colors | Select-Object -First 1).hex.clean
            "OppositeSecondary" = "#" + ($background.colors | Select-Object -First 1 -Skip 1).hex.clean
            "Opposite"          = "#" + ($background.colors | Select-Object -First 1 -Skip 2).hex.clean
            "HighContrast"      = "#" + ($background.colors | Select-Object -Last 1).hex.clean
        }
        # if light theme, gamma is one darker then it gets lighter
        # main and high contract and opposite are closest
        # if dark theme, gamma is one lighter then it gets darker
    }
    $themearray | ConvertTo-Json | Out-File -FilePath $filename
}



<#
        
            cursorColor         : #353535
            selectionBackground : #d7d7d7
  
            # write out a file for each!
            # 26 for .15
            # F2 for .95

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