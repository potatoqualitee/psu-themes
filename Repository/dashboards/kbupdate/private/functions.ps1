function Get-Sidebar {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath nav.json) | ConvertFrom-Json
}

function Write-Sidebar ($Data) {
    $Data | ConvertTo-Json | Out-File (Join-Path -Path $script:UDRoot -ChildPath nav.json) -Encoding ascii
}

function New-NavItem {
    param(
        [string]$Label,
        [string]$Redirect,
        [string]$Icon
    )
    New-UDListItem -Label $Label -OnClick { Invoke-UDRedirect $Redirect } -Icon (New-UDIcon -Icon $Icon -Size 1x)
}

function New-NavSwitch ($nav, $item, [switch]$disabled) {
    New-UDSwitch -Id $item.Label -Label $item.Label -Checked $item.Enabled -OnChange {
        $item.Enabled = $EventData
        Write-Sidebar -Data $nav
    } -Disabled:$disabled -Color secondary
}

function Get-Colors {
    $theme = Get-ActiveTheme
    Get-Content -Path (Join-Path -Path (Get-ThemeFolder) -ChildPath "$theme.json") | ConvertFrom-Json
}

function Get-ActiveTheme {
    (Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath colors.json) | ConvertFrom-Json).Theme
}


function Get-ThemeFolder {
    Join-Path -Path $script:UDRoot -ChildPath themes
}


function Set-ActiveTheme ($Theme) {
    [PSCustomObject]@{ Theme = $Theme } | ConvertTo-Json | Out-File (Join-Path -Path $script:UDRoot -ChildPath colors.json) -Encoding ascii
}

function Get-AllThemes {
    (Get-ChildItem -Path (Join-Path -Path $script:UDRoot -ChildPath themes) -Filter *.json).BaseName
}

function Get-Rgb {
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
    
    $r, $g, $b
}

function Get-Hsp {
    [cmdletbinding()]
    param(
        [string]$Color
    )
    $r, $g, $b = Get-Rgb $Color
    
    # HSP equation from http://alienryderflex.com/hsp.html
    [math]::Sqrt(
        0.299 * ($r * $r) +
        0.587 * ($g * $g) +
        0.114 * ($b * $b)
    )
}


function Get-Contrast {
    [cmdletbinding()]
    param(
        [string]$Color1,
        [string]$Color2
    )
    $one = Get-Hsp $Color1
    $two = Get-Hsp $Color2
    
    if ($one -ge $two) {
        $first = $one
        $second = $two
    } else {
        $first = $two
        $second = $one
    }

    $first - $second
}

function Test-Contrast {
    [cmdletbinding()]
    param(
        [string]$Color1,
        [string]$Color2
    )

    $diff = Get-Contrast $Color1 $Color2

    if ($diff -gt 50) {
        $true
    } else {
        $false
    }
}

    

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
    $r, $g, $b = Get-Rgb $Color
    $hsp = Get-Hsp $Color

    # Using the HSP value, determine whether the color is light or dark
    if ($hsp -gt 127.5) {
        $hsp | Write-Verbose
        return $false
    } else {
        $hsp | Write-Verbose
        return $true
    }
}