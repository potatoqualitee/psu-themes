$IndexJs = Get-ChildItem "$PSScriptRoot\index.*.bundle.js"
$AssetId = [UniversalDashboard.Services.AssetService]::Instance.RegisterAsset($IndexJs.FullName)

function New-UDImageZoom {
    <#
    .SYNOPSIS
    Zooms into an image
    
    .DESCRIPTION
    This component is using react-img-zoom to gracefully zoom into an image
    
    .PARAMETER Id
    The ID of this component

    .PARAMETER Path
    Specify the full path to the image to be loaded

    .PARAMETER Zoom
    Specify how much the zoom should be this is an integer value defaulted to 3

    .PARAMETER Height
    Specify the height of the image to be displayed this is an integer value only and represents pixels
    
    .PARAMETER Width
    Specify the width of the image to be displayed this is an integer value only and represents pixels

    .PARAMETER Delay
    Specify the amount of delay whilst zooming in and out. This is a decimal value which is defaulted to 0.6

    .EXAMPLE
    New-UDImageZoom -Path /UD/CoolImage.png -Height 400 -Width 400 -Zoom 5 -Delay 0.8
    #>
    
    param(
        [Parameter()]
        [string]$Id = (New-Guid).ToString(),
        [Parameter()]
        [string]$Path,
        [Parameter()]
        [int]$Zoom =3,
        [Parameter()]
        [int]$Height,
        [Parameter()]
        [int]$Width,
        [Parameter()]
        [decimal]$Delay = 0.6
    )

    End {
        @{
            assetId = $AssetId 
            isPlugin = $true 
            type = "udimagezoom"
            id = $Id

            img = $Path
            zoomScale = $Zoom
            height = $Height
            width = $Width
            transitionTime = $Delay
        }
    }
}