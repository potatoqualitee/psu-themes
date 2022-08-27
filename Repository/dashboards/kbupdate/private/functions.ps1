function Get-Sidebar {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath nav.json) | ConvertFrom-Json
}

function Write-Sidebar ($Data) {
    $Data | ConvertTo-Json | Out-File (Join-Path -Path $script:UDRoot -ChildPath nav.json)
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
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath colors.json) | ConvertFrom-Json
}
function Theme {
    Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath themes.json) | ConvertFrom-Json
}

function Get-Theme {
    $themes = Get-Content -Path (Join-Path -Path $script:UDRoot -ChildPath windows-terminal-themes.json) | ConvertFrom-Json
    foreach ($theme in $themes) {
        $isdark = Test-DarkColor $theme.background
        $blah = [pscustomobject]@{
            Name = $theme.Name
            Theme = switch ($isdark) {
                $false  { "Light" }
                $true   { "Dark" }
            }
        }
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
    # HSP (Highly Sensitive Ppl) equation from http:#alienryderflex.com/hsp.html
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