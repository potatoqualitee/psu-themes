New-UDPage -Name Icons -Url icons -Content {
    New-UDElement -Tag 'div' -Attributes @{
        style = @{
            margin = '10px'
        }
    }

    $iconfile = Join-Path -Path $script:UDRoot -ChildPath "assets\icons.txt"
    $icons = Get-Content -Path $iconfile
    
    $array = @()
    $i = 0
    do {
        $first = $icons[$i]
        $i++
        $second = $icons[$i]
        $i++
        
        $array += @{
            Icon1 = $first
            Icon2 = $second
        }
    } while ($i -lt $icons.Length)
    
    New-UDElement -Tag 'div' -Attributes @{
        style = @{
            width = '100%'
        }
    } -Content {
        New-UDTable -Id Cute -Data $array -Columns @(
            New-UDTableColumn -Property Icon1 -Title Name -Width 300  -IncludeInSearch
            New-UDTableColumn -Property Icon -Title Icon -Render {
                New-UDIcon -Icon $EventData.Icon1 -Size 3x
            }
            New-UDTableColumn -Property Icon2 -Title Name -Width 300  -IncludeInSearch
            New-UDTableColumn -Property Name -Title Icon -Render {
                if ($EventData.Icon2) {
                    New-UDIcon -Icon $EventData.Icon2 -Size 3x -ErrorAction Stop
                }
            }
        ) -StickyHeader -ShowFilter -ShowSearch -Title "Supported Icons"
    }
}