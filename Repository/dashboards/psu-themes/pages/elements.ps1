New-UDPage -Name 'Elements' -Url '/elements' -Content {
    New-UDElement -Tag 'div' -Id 'mainContainer' -Content {
        $colors = Get-Colors
        $common = $colors | Where-Object Mode -eq common

        New-UDTypography -Text "This is the demo dashboard for Universal Dashboard. Check out the various pages to view all the controls."

        New-UDButton -Text 'Download Template' -OnClick {
            Invoke-UDRedirect https://ironmansoftware.com/powershell-universal/templates
        }

        # ALERTS
        New-UDTypography -Variant h2 -Text 'Alerts'
        New-UDTypography -Variant subheading -Text 'Alerts provide a simple way to communicate information to a user.'
        New-UDElement -Tag 'hr'

        New-UDAlert -Severity 'error' -Text 'This is an error alert — check it out!' 
        New-UDAlert -Severity 'warning' -Text 'This is an warning alert — check it out!'
        New-UDAlert -Severity 'info' -Text 'This is an error info — check it out!' 
        New-UDAlert -Severity 'success' -Text 'This is an success alert — check it out!'
        New-UDAlert -Severity 'error' -Content { New-UDHtml 'This is an error alert — <strong>check it out!</strong>' } -Title "Error"
        New-UDAlert -Severity 'warning' -Content { New-UDHtml 'This is an warning alert — <strong>check it out!</strong>' } -Title "Warning"
        New-UDAlert -Severity 'info' -Content { New-UDHtml 'This is an error info — <strong>check it out!</strong>' } -Title "Info"
        New-UDAlert -Severity 'success' -Content { New-UDHtml 'This is an success alert — <strong>check it out!</strong>' } -Title "Success"

        # BUTTONS
        New-UDTypography -Variant h2 -Text 'Buttons'
        New-UDTypography -Variant subheading -Text 'Buttons allow users to take actions, and make choices, with a single tap.'
        New-UDElement -Tag 'hr'

        New-UDTypography -Variant h3 -Text 'Contained'
        New-UDButton -Variant 'contained' -Text 'Default' (New-UDIcon -Icon trash)
        New-UDButton -Variant 'contained' -Color 'primary' -Text 'Primary'
        New-UDButton -Variant 'contained' -Color 'secondary' -Text 'Secondary'
        New-UDButton -Variant 'contained' -Color 'info' -Text 'Info' (New-UDIcon -Icon bolt)
        New-UDButton -Variant 'contained' -Color 'warning' -Text 'Warning'
        New-UDButton -Variant 'contained' -Color 'error' -Text 'Error'
        New-UDButton -Variant 'contained' -Color 'success' -Text 'Success'

        New-UDTypography -Variant h3 -Text 'Outlined'
        New-UDButton -Variant 'outlined' -Text 'Default'
        New-UDButton -Variant 'outlined' -Color 'primary' -Text 'Primary'
        New-UDButton -Variant 'outlined' -Color 'secondary' -Text 'Secondary'
        New-UDButton -Variant 'outlined' -Color 'info' -Text 'Info'
        New-UDButton -Variant 'outlined' -Color 'warning' -Text 'Warning'
        New-UDButton -Variant 'outlined' -Color 'error' -Text 'Error'
        New-UDButton -Variant 'outlined' -Color 'success' -Text 'Success' (New-UDIcon -Icon save)

        New-UDTypography -Variant h3 -Text 'Text'
        New-UDButton -Variant 'text' -Text 'Default'
        New-UDButton -Variant 'text' -Color 'primary' -Text 'Primary'
        New-UDButton -Variant 'text' -Color 'secondary' -Text 'Secondary'
        New-UDButton -Variant 'text' -Color 'info' -Text 'Info'
        New-UDButton -Variant 'text' -Color 'warning' -Text 'Warning'
        New-UDButton -Variant 'text' -Color 'error' -Text 'Error'
        New-UDButton -Variant 'text' -Color 'success' -Text 'Success'

        # TOAST
        New-UDTypography -Variant h2 -Text 'Toast Notifications'
        New-UDTypography -Variant subheading -Text 'These specific types can be used throughout based on needs.'
        New-UDElement -Tag 'hr'

        New-UDButton -Variant 'contained' -Text 'Default' -OnClick {
            Show-UDToast -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'primary' -Text 'Primary' -OnClick {
            Show-UDToast -BackgroundColor $common.BlueARGB95 -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'secondary' -Text 'Secondary' -OnClick {
            Show-UDToast -BackgroundColor $common.CyanARGB95 -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'info' -Text 'Info' -OnClick {
            Show-UDToast -BackgroundColor $common.PurpleARGB95 -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'warning' -Text 'Warning' -OnClick {
            Show-UDToast -BackgroundColor $common.YellowARGB95 -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'error' -Text 'Error' -OnClick {
            Show-UDToast -BackgroundColor $common.RedARGB95 -Message 'Hello!' -Duration 3000
        }
        New-UDButton -Variant 'contained' -Color 'success' -Text 'Success' -OnClick {
            Show-UDToast -BackgroundColor $common.GreenARGB95 -Message 'Hello!' -Duration 3000
        }

        # CHIPS
        New-UDTypography -Variant h2 -Text 'Chip'
        New-UDTypography -Variant subheading -Text 'Chips are compact elements that represent an input, attribute, or action. Chips allow users to enter information, make selections, filter content, or trigger actions. While included here as a standalone component, the most common use will be in some form of input, so some of the behavior demonstrated here is not shown in context.'
        New-UDElement -Tag 'hr'
        New-UDChip -Label 'Basic'
        New-UDChip -Label 'Basic' -Icon (New-UDIcon -Icon 'user')
        New-UDChip -Label 'OnClick' -OnClick {
            Show-UDToast -Message 'Hello!'
        }
        New-UDChip -Label 'OnDelete' -OnClick {
            Show-UDToast -Message 'Goodbye!'
        }

        New-UDTypography -Variant h2 -Text 'DateTime'
        New-UDTypography -Variant subheading -Text "The New-UDDateTime component is used for formatting dates and times within the client's browser. By using the client's browser, you can format the time based on the local time zone and locale settings for the user."

        New-UDElement -tag p -Content {
            New-UDDateTime -InputObject (Get-Date)
        }
        
        New-UDElement -tag p -Content {
            New-UDDateTime -InputObject (Get-Date) -Format 'DD/MM/YYYY'
        }

        # ICONS
        New-UDTypography -Variant h2 -Text 'Icon'
        New-UDElement -Tag 'hr'
        New-UDIcon -Icon 'address_book'
        New-UDIcon -Icon 'address_book' -Size 'sm'
        New-UDIcon -Icon 'address_book' -Size 'lg'
        New-UDIcon -Icon 'address_book' -Size '5x'
        New-UDIcon -Icon 'address_book' -Size '10x'
        New-UDIcon -Icon 'address_book' -Size '5x' -Rotation 90
        New-UDIcon -Icon 'address_book' -Size '5x' -Border
        New-UDIcon -Icon 'address_book' -Size '5x' -Style @{
            backgroundColor = $theme.Green
        }

        New-UDTypography -Variant h2 -Text 'Icon Search'
        New-UDElement -Tag 'hr'
        New-UDTextbox -Id 'txtIconSearch' -Label 'Search' 
        New-UDButton -Text 'Search' -ClassName 'mt-3' -OnClick {
            Sync-UDElement -Id 'icons'
        }

        New-UDElement -tag 'p' -Content {}

        New-UDDynamic -Id 'icons' -Content {
            $Icons = [Enum]::GetNames([UniversalDashboard.Models.FontAwesomeIcons])
            $IconSearch = (Get-UDElement -Id 'txtIconSearch').value
            if ($null -ne $IconSearch -and $IconSearch -ne '') {
                $Icons = $Icons.where({ $_ -match $IconSearch })

                foreach ($icon in $icons) {
                    New-UDIcon -Icon $icon -Size lg
                }
            }
        }

        # LISTS
        New-UDTypography -Variant h2 -Text 'List'
        New-UDElement -Tag 'hr'
        New-UDList -Content {
            New-UDListItem -Label 'Inbox' -Icon (New-UDIcon -Icon envelope -Size 2x) -SubTitle 'New Stuff'
            New-UDListItem -Label 'Drafts' -Icon (New-UDIcon -Icon edit -Size 2x) -SubTitle "Stuff I'm working on "
            New-UDListItem -Label 'Trash' -Icon (New-UDIcon -Icon trash -Size 2x) -SubTitle 'Stuff I deleted'
            New-UDListItem -Label 'Spam' -Icon (New-UDIcon -Icon bug -Size 2x) -SubTitle "Stuff I didn't want"
        }

        New-UDList -Content {
            New-UDListItem -Label 'Inbox' -Icon (New-UDIcon -Icon envelope -Size 2x) -SubTitle 'New Stuff'
            New-UDListItem -Label 'Drafts' -Icon (New-UDIcon -Icon edit -Size 2x) -SubTitle "Stuff I'm working on "
            New-UDListItem -Label 'Trash' -Icon (New-UDIcon -Icon trash -Size 2x) -SubTitle 'Stuff I deleted'
            New-UDListItem -Label 'Spam' -Icon (New-UDIcon -Icon bug -Size 2x) -SubTitle "Stuff I didn't want" -OnClick {
                Show-UDToast -Message 'Clicked'
            }
        }

        # TABLES
        New-UDTypography -Variant h2 -Text 'Table'
        New-UDElement -Tag 'hr'
        $Data = @(
            @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
        ) 

        New-UDTable -Data $Data -Title 'Custom Simple'

        New-UDElement -Tag div -Content {
            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            $Columns = @(
                New-UDTableColumn -Property Dessert -Title "A Dessert"
                New-UDTableColumn -Property Calories -Title Calories 
                New-UDTableColumn -Property Fat -Title Fat 
                New-UDTableColumn -Property Carbs -Title Carbs 
                New-UDTableColumn -Property Protein -Title Protein 
            )

            New-UDTable -Id 'customColumnsTable' -Data $Data -Columns $Columns -Title 'Custom Columns'
        }
        New-UDElement -Tag div -Content {

            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 1; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 200; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            $Columns = @(
                New-UDTableColumn -Property Dessert -Title Dessert -Render { 
                    New-UDButton -Id "btn$($EventData.Dessert)" -Text "Click for Dessert!" -OnClick { Show-UDToast -Message $EventData.Dessert } 
                }
                New-UDTableColumn -Property Calories -Title Calories 
                New-UDTableColumn -Property Fat -Title Fat 
                New-UDTableColumn -Property Carbs -Title Carbs 
                New-UDTableColumn -Property Protein -Title Protein 
            )

            New-UDTable -Data $Data -Columns $Columns -Sort -Export -Title 'Custom Rendering'
        }
        New-UDElement -Tag div -Content {

            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            $Columns = @(
                New-UDTableColumn -Property Dessert -Title Dessert -Render { 
                    New-UDButton -Id "btn$($EventData.Dessert)" -Text "Click for Dessert!" -OnClick { Show-UDToast -Message $EventData.Dessert } 
                }
                New-UDTableColumn -Property Calories -Title Calories -Width 5 -Truncate
                New-UDTableColumn -Property Fat -Title Fat 
                New-UDTableColumn -Property Carbs -Title Carbs 
                New-UDTableColumn -Property Protein -Title Protein 
            )

            New-UDTable -Data $Data -Columns $Columns -Sort -Title 'Custom Width'
        }

        New-UDElement -Tag div -Content {

            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            $Columns = @(
                New-UDTableColumn -Property Dessert -Title "A Dessert" -Filter -FilterType AutoComplete
                New-UDTableColumn -Property Calories -Title Calories -Filter -FilterType Range
                New-UDTableColumn -Property Fat -Title Fat -Filter -FilterType Range
                New-UDTableColumn -Property Carbs -Title Carbs -Filter -FilterType Range
                New-UDTableColumn -Property Protein -Title Protein -Filter -FilterType Range
            )

            New-UDTable -Id 'customColumnsTable' -Data $Data -Columns $Columns -ShowFilter -Title 'Filters'
        }
        
        New-UDElement -Tag div -Content {
            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            New-UDTable -Data $Data -Paging -PageSize 2 -Title 'Paging'
        }
        
        New-UDElement -Tag div -Content {
            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 
            
            New-UDTable -Data $Data -ShowSort -Title 'Sorting'
        }

        New-UDElement -Tag div -Content {
            $Data = @(
                @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
            ) 

            New-UDTable -Id 'service_table' -Data $Data -Title 'Selection' -ShowSearch -ShowPagination -ShowSelection -Dense -OnRowSelection {
                $Item = $EventData
                Show-UDToast -Message "$($Item | out-string)"
            }
            New-UDButton -Text "GET Rows" -OnClick {
                $value = Get-UDElement -Id "service_table"
                Show-UDToast -Message "$( $value.selectedRows | Out-String )"
            }
        }

        New-UDTypography -Variant h2 -Text 'Tree View'
        New-UDElement -Tag 'hr'
        New-UDTreeView -Node {
            New-UDTreeNode -Name 'Level 1' -Children {
                New-UDTreeNode -Name 'Level 2 - Item 1' 
                New-UDTreeNode -Name 'Level 2 - Item 2'
                New-UDTreeNode -Name 'Level 2 - Item 3' -Children {
                    New-UDTreeNode -Name 'Level 3'
                }
            }
        }

        New-UDTypography -Variant h2 -Text Typography
        New-UDElement -Tag 'hr'
        @("h1", "h2", "h3", "h4", "h5", "h6", "subtitle1", "subtitle2", "body1", "body2", 
            "caption", "button", "overline", "srOnly", "inherit", 
            "display4", "display3", "display2", "display1", "headline", "title", "subheading") | ForEach-Object {
            New-UDTypography -Variant $_ -Text $_ -GutterBottom
            New-UDElement -Tag 'p' -Content { }
        }

        
        New-UDTypography -Variant h2 -Text 'Charts'
        New-UDElement -Tag 'hr'

        # CHARTS
        # Some charts are commented out becuase the syntax from the docs does not work with setting a BorderColor. See https://github.com/ironmansoftware/issues/issues/1447.

        # CHART.JS - BASIC BAR CHART
        # $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        # New-UDChartJS -Type 'bar' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor $common.BlueARGB15 -BorderColor $common.Blue
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        $Dataset = New-UDChartJSDataset -DataProperty CPU -Label 'CPU' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $Options = @{
            Type          = 'bar'
            Data          = $Data
            Dataset       = $Dataset
            LabelProperty = "ProcessName"
        }

        New-UDChartJS @Options

        # CHART.JS - STACKED BAR CHART
        $GraphPrep = @(
            @{ RAM = "Server1"; AvailableRam = 128; UsedRAM = 10 }
            @{ RAM = "Server2"; AvailableRam = 64; UsedRAM = 63 }
            @{ RAM = "Server3"; AvailableRam = 48; UsedRAM = 40 }
            @{ RAM = "Server4"; AvailableRam = 64;; UsedRAM = 26 }
            @{ RAM = "Server5"; AvailableRam = 128; UsedRAM = 120 }
        )

        $AvailableRamDataSet = New-UDChartJSDataset -DataProperty AvailableRAM -Label 'Available' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $UsedRamDataset = New-UDChartJSDataset -DataProperty UsedRAM -Label 'Used' -BackgroundColor $common.PurpleARGB15 -HoverBackgroundColor $common.Purple -BorderColor $common.Purple -HoverBorderColor $common.Purple -BorderWidth 1
        $Options = @{
            Type          = 'bar'
            Data          = $GraphPrep
            Dataset       = @($AvailableRamDataSet, $UsedRamDataset)
            LabelProperty = "RAM"
            Options       = @{
                scales = @{
                    xAxes = @(
                        @{
                            stacked = $true
                        }
                    )
                    yAxes = @(
                        @{
                            stacked = $true
                        }
                    )
                }
            }
        } 

        New-UDChartJS @Options

        # CHART.JS - HORIZONTAL BAR CHART
        # $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        # New-UDChartJS -Type 'horizontalBar' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor $common.BlueARGB15 -BorderColor $common.Blue -BorderWidth 1
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        $Dataset = New-UDChartJSDataset -DataProperty CPU -Label 'CPU' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $Options = @{
            Type          = 'horizontalBar'
            Data          = $Data
            Dataset       = $Dataset
            LabelProperty = "ProcessName"
        }

        New-UDChartJS @Options

        # CHART.JS - LINE CHART
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        New-UDChartJS -Type 'line' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor $common.BlueARGB15 -BorderColor $common.Blue

        # CHART.JS - DOUGHNUT CHART
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        New-UDChartJS -Type 'doughnut' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor @(
            $common.Purple, 
            $theme.PurpleHover,
            $common.Blue,
            $theme.BlueHover,
            $common.Green,
            $theme.GreenHover,
            $common.Red,
            $theme.RedHover,
            $common.Yellow,
            $common.Cyan
        ) -BorderColor @(
            $common.Purple,
            $theme.PurpleHover,
            $common.Blue,
            $theme.BlueHover,
            $common.Green,
            $theme.GreenHover,
            $common.Red,
            $theme.RedHover,
            $common.Yellow,
            $common.Cyan
        ) -HoverBackgroundColor @(
            $theme.PurpleHover,
            $common.Purple,
            $theme.BlueHover,
            $common.Blue,
            $theme.GreenHover,
            $common.Green,
            $theme.RedHover,
            $common.Red,
            $theme.YellowHover,
            $theme.CyanHover
        )

        # CHART.JS - PIE CHART
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        New-UDChartJS -Type 'pie' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor @(
            $common.Purple, 
            $theme.PurpleHover
            $common.Blue,
            $theme.BlueHover,
            $common.Green,
            $theme.GreenHover,
            $common.Red,
            $theme.RedHover,
            $common.Yellow,
            $common.Cyan
        ) -BorderColor @(
            $common.Purple,
            $theme.PurpleHover,
            $common.Blue,
            $theme.BlueHover,
            $common.Green,
            $theme.GreenHover,
            $common.Red,
            $theme.RedHover,
            $common.Yellow,
            $common.Cyan
        ) -HoverBackgroundColor @(
            $theme.PurpleHover,
            $common.Purple,
            $theme.BlueHover,
            $common.Blue,
            $theme.GreenHover,
            $common.Green,
            $theme.RedHover,
            $common.Red,
            $theme.YellowHover,
            $theme.CyanHover
        )

        # CHART.JS - RADAR CHART
        #$Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        #New-UDChartJS -Type 'radar' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor $common.BlueARGB15 -BorderColor $common.Blue
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
        $CPUDataset = New-UDChartJSDataset -DataProperty CPU -Label CPU -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $MemoryDataset = New-UDChartJSDataset -DataProperty HandleCount -Label 'Handle Count' -BackgroundColor $common.PurpleARGB15 -HoverBackgroundColor $common.Purple -BorderColor $common.Purple -HoverBorderColor $common.Purple -BorderWidth 1
        $Options = @{
            Type          = 'radar'
            Data          = $Data
            Dataset       = @($CPUDataset, $MemoryDataset)
            LabelProperty = "ProcessName"
        }

        New-UDChartJS @Options

        # CHART.JS - BAR CHART WITH HOVER
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
        $Dataset = New-UDChartJSDataset -DataProperty CPU -Label 'CPU' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $Options = @{
            Type                 = 'bar'
            Data                 = $Data
            Dataset              = $Dataset
            LabelProperty        = 'ProcessName'
        }

        New-UDChartJS @Options

        # CHART.JS - BAR CHART WITH MULTIPLE DATA SETS
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
        $CPUDataset = New-UDChartJSDataset -DataProperty CPU -Label CPU -BackgroundColor $common.PurpleARGB15 -HoverBackgroundColor $common.Purple -BorderColor $common.Purple -HoverBorderColor $common.Purple -BorderWidth 1
        $MemoryDataset = New-UDChartJSDataset -DataProperty HandleCount -Label 'Handle Count' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $Options = @{
            Type          = 'bar'
            Data          = $Data
            Dataset       = @($CPUDataset, $MemoryDataset)
            LabelProperty = "ProcessName"
        }

        New-UDChartJS @Options

        # CHART.JS - BAR CHART WITH CLICK EVENTS
        $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10
        $Dataset = New-UDChartJSDataset -DataProperty CPU -Label 'CPU' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
        $Options = @{
            Type          = 'bar'
            Data          = $Data
            Dataset       = $Dataset
            LabelProperty = "ProcessName"
            OnClick       = { 
                Show-UDToast -Message $Body
            }
        }

        New-UDChartJS @Options

        # CHART.JS - BAR CHART WITH DYNAMIC CONTENT
        New-UDDynamic -Content {
            $Data = 1..10 | % { 
                [PSCustomObject]@{ Name = $_; value = get-random }
            }
            $Dataset = New-UDChartJSDataset -DataProperty Value -Label 'Value' -BackgroundColor $common.BlueARGB15 -HoverBackgroundColor $common.Blue -BorderColor $common.Blue -HoverBorderColor $common.Blue -BorderWidth 1
            $Options = @{
                Type          = 'bar'
                Data          = $Data
                Dataset       = $Dataset
                LabelProperty = "Name"
            }
            New-UDChartJS @Options
        } -AutoRefresh -AutoRefreshInterval 10

        # CHART.JS - CHART WITH MONITOR
        New-UDChartJSMonitor -LoadData {
            Get-Random -Max 100 | Out-UDChartJSMonitorData
        } -Labels "Random" -ChartBackgroundColor $common.BlueARGB15 -ChartBorderColor $common.Blue -RefreshInterval 5

        # NIVO CHART - BAR CHART
        $Data = 1..10 | ForEach-Object { 
            $item = Get-Random -Max 1000 
            [PSCustomObject]@{
                Name  = "Test$item"
                Value = $item
            }
        }
        New-UDNivoChart -Id 'autoRefreshingNivoBar' -Bar -Keys "value" -IndexBy 'name' -Data $Data -Height 500 -Width 1000

        $Data = @(
            @{
                country  = 'USA'
                burgers  = (Get-Random -Minimum 10 -Maximum 100)
                fries    = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country  = 'Germany'
                burgers  = (Get-Random -Minimum 10 -Maximum 100)
                fries    = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
            @{
                country  = 'Japan'
                burgers  = (Get-Random -Minimum 10 -Maximum 100)
                fries    = (Get-Random -Minimum 10 -Maximum 100)
                sandwich = (Get-Random -Minimum 10 -Maximum 100)
            }
        )

        $Pattern = New-UDNivoPattern -Dots -Id 'dots' -Background "inherit" -Color $common.Purple -Size 4 -Padding 1 -Stagger
        $Fill = New-UDNivoFill -ElementId "fries" -PatternId 'dots'

        New-UDNivoChart -Definitions $Pattern -Fill $Fill -Bar -Data $Data -Height 400 -Width 900 -Keys @('burgers', 'fries', 'sandwich') -IndexBy 'country'

        New-UDDynamic -Content {
            $Data = 1..10 | ForEach-Object { 
                $item = Get-Random -Max 1000 
                [PSCustomObject]@{
                    Name  = "Test$item"
                    Value = $item
                }
            }
            New-UDNivoChart -Id 'autoRefreshingNivoBar' -Bar -Keys "Value" -IndexBy 'name' -Data $Data -Height 500 -Width 1000
        } -AutoRefresh

        $TreeData = @{
            Name     = "root"
            children = @(
                @{
                    Name     = "first"
                    children = @(
                        @{
                            Name  = "first-first"
                            Count = 7
                        }
                        @{
                            Name  = "first-second"
                            Count = 8
                        }
                    )
                },
                @{
                    Name  = "second"
                    Count = 21
                }
            )
        }

        New-UDNivoChart -Bubble -Data $TreeData -Value "count" -Identity "name" -Height 500 -Width 800

        $Data = @()
        for ($i = 365; $i -gt 0; $i--) {
            $Data += @{
                day   = (Get-Date).AddDays($i * -1).ToString("yyyy-MM-dd")
                value = Get-Random
            }
        }

        $From = (Get-Date).AddDays(-365)
        $To = Get-Date

        New-UDNivoChart -Calendar -Data $Data -From $From -To $To -Height 500 -Width 1000 -MarginTop 50 -MarginRight 130 -MarginBottom 50 -MarginLeft 60

        $Data = @(
            @{
                state = "idaho"
                cats  = 72307
                dogs  = 23429
                moose = 23423
                bears = 784
            }
            @{
                state = "wisconsin"
                cats  = 2343342
                dogs  = 3453623
                moose = 1
                bears = 23423
            }
            @{
                state = "montana"
                cats  = 9234
                dogs  = 3973457
                moose = 23472
                bears = 347303
            }
            @{
                state = "colorado"
                cats  = 345973789
                dogs  = 0237234
                moose = 2302
                bears = 2349772
            }
        )
        New-UDNivoChart -Heatmap -Data $Data -IndexBy 'state' -keys @('cats', 'dogs', 'moose', 'bears') -Height 500 -Width 1000 -MarginTop 50 -MarginRight 130 -MarginBottom 50 -MarginLeft 60

        [array]$Data = [PSCustomObject]@{
            id   = "DataSet"
            data = (1..20 | ForEach-Object {
                    $item = Get-Random -Max 500 
                    [PSCustomObject]@{
                        x = "Test$item"
                        y = $item
                    }
                })
        }
        New-UDNivoChart -Line -Data $Data -Height 500 -Width 1000 -LineWidth 1

        $Data = 1..10 | ForEach-Object { 
            @{
                "Adam"  = Get-Random 
                "Alon"  = Get-Random 
                "Lee"   = Get-Random 
                "Frank" = Get-Random 
                "Bill"  = Get-Random 
            }
        }

        New-UDNivoChart -Stream -Data $Data -Height 500 -Width 1000 -Keys @("adam", "alon", "lee", "frank", "bill")

        $TreeData = @{
            Name     = "root"
            children = @(
                @{
                    Name     = "first"
                    children = @(
                        @{
                            Name  = "first-first"
                            Count = 7
                        }
                        @{
                            Name  = "first-second"
                            Count = 8
                        }
                    )
                },
                @{
                    Name  = "second"
                    Count = 21
                }
            )
        }

        New-UDNivoChart -Treemap -Data $TreeData -Value "count" -Identity "name" -Height 500 -Width 800

        # PROGRESS
        New-UDTypography -Variant h2 -Text 'Progress'
        New-UDElement -Tag 'hr'
        New-UDProgress -Circular -Color $common.Blue
        New-UDProgress
        New-UDProgress -PercentComplete 75

        # MAPS
        New-UDTypography -Variant h2 -Text 'Maps'
        New-UDElement -Tag 'hr'
        New-UDMap -Endpoint {
            New-UDMapRasterLayer -TileServer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' 
            New-UDMapHeatmapLayer -Points @(
                @(-37.9019339833, 175.3879181167, "625"),
                @(-37.90920365, 175.4053418167, "397"),
                @(-37.9057407667, 175.39478875, "540"),
                @(-37.9243174333, 175.4220341833, "112"),
                @(-37.8992012333, 175.3666729333, "815"),
                @(-37.9110874833, 175.4102195833, "360"),
                @(-37.9027096, 175.3913196333, "591"),
                @(-37.9011183833, 175.38410915, "655"),
                @(-37.9234701333, 175.4155696333, "181"),
                @(-37.90254175, 175.3926162167, "582"),
                @(-37.92450575, 175.4246711167, "90"),
                @(-37.9242924167, 175.4289432833, "47"),
                @(-37.8986079833, 175.3685293333, "801")
            )
        } -Height '500px'


        <#
        New-UDTypography -Variant h2 -Text 'Backdrop' 
        New-UDBackdrop -Id 'backdrop' -Content {
            New-UDTypography -Text "Loading..." -Variant h2
        } -Open -OnClick {
            Set-UDElement -Id 'backdrop' -Properties @{
                open = $false
            }
        }
    #>
        # MODALS
        New-UDTypography -Variant h2 -Text 'Modal'
        New-UDElement -Tag 'hr'
        New-UDButton -Text 'Basic' -OnClick {
            Show-UDModal -Content {
                New-UDTypography -Text "Hello"
            }
        }

        New-UDButton -Text 'Full Screen' -OnClick {
            Show-UDModal -Content {
                New-UDTypography -Text "Hello"
            } -Footer {
                New-UDButton -Text "Close" -OnClick { Hide-UDModal }
            }  -FullScreen
        }

        # INPUTS
        New-UDTypography -Variant h2 -Text 'Inputs'
        New-UDElement -Tag 'hr'
        New-UDAutocomplete -Options @('Test', 'Test2', 'Test3', 'Test4')
        New-UDAutocomplete -OnLoadOptions { 
            @('Test', 'Test2', 'Test3', 'Test4') | Where-Object { $_ -match $Body } | ConvertTo-Json
        } -OnChange {
            Show-UDToast $Body 
        }
        
        # CHECKBOXES
        New-UDTypography -Variant h2 -Text 'Checkbox'
        New-UDElement -Tag 'hr'
        $Icon = New-UDIcon -Icon angry -Size lg -Regular
        $CheckedIcon = New-UDIcon -Icon angry -Size lg
        New-UDCheckBox -Icon $Icon -CheckedIcon $CheckedIcon -Style @{color = $common.Blue }

        New-UDCheckBox -OnChange {
            Show-UDToast -Title 'Checkbox' -Message $Body
        }

        New-UDCheckBox -Label 'Demo' -LabelPlacement start
        New-UDCheckBox -Label 'Demo' -LabelPlacement top
        New-UDCheckBox -Label 'Demo' -LabelPlacement bottom
        New-UDCheckBox -Label 'Demo' -LabelPlacement end

        # CODE EDITOR
        New-UDTypography -Variant h2 -Text 'Code Editor'
        New-UDElement -Tag 'hr'
        New-UDCodeEditor -Height '500' -Language 'powershell'

        # DATE PICKERS
        New-UDTypography -Variant h2 -Text 'Date Picker'
        New-UDElement -Tag 'hr'
        New-UDDatePicker -OnChange {
            Show-UDToast -Message $body
        }
        New-UDDatePicker -Variant static
        New-UDDatePicker -Locale fr
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Small
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Medium
        New-UDFloatingActionButton -Icon (New-UDIcon -Icon user) -Size Large

        # FORM
        New-UDTypography -Variant h2 -Text 'Form'
        New-UDElement -Tag 'hr'
        New-UDForm -Content {
            New-UDTextbox -Id 'txtTextField'
            New-UDCheckbox -Id 'chkCheckbox'
        } -OnSubmit {
            Show-UDToast -Message $EventData.txtTextField
            Show-UDToast -Message $EventData.chkCheckbox
        }

        # FORM WITH VALIDATION
        New-UDForm -Content {
            New-UDTextbox -Id 'txtValidateForm'
        } -OnValidate {
            $FormContent = $EventData

            if ($FormContent.txtValidateForm -eq $null -or $FormContent.txtValidateForm -eq '') {
                New-UDFormValidationResult -ValidationError "txtValidateForm is required"
            } else {
                New-UDFormValidationResult -Valid
            }
        } -OnSubmit {
            Show-UDToast -Message $Body
        }

        New-UDRadioGroup -Label "Day" -Content {
            New-UDRadio -Label Monday -Value 'monday'
            New-UDRadio -Label Tuesday -Value 'tuesday'
            New-UDRadio -Label Wednesday -Value 'wednesday'
            New-UDRadio -Label Thursday -Value 'thursday'
            New-UDRadio -Label Friday -Value 'friday'
            New-UDRadio -Label Saturday -Value 'saturday'
            New-UDRadio -Label Sunday -Value 'sunday'
        } -OnChange { Show-UDToast -Message $Body }

        New-UDSelect -Option {
            New-UDSelectOption -Name 'One' -Value 1
            New-UDSelectOption -Name 'Two' -Value 2
            New-UDSelectOption -Name 'Three' -Value 3
        } -OnChange { Show-UDToast -Message $EventData }

        New-UDSlider -OnChange {
            Show-UDToast -Message $Body 
        }

        New-UDSwitch -OnChange { Show-UDToast -Message $EventData }

        New-UDTextbox -Label 'Standard' -Placeholder 'Textbox'
        New-UDTextbox -Label 'Disabled' -Placeholder 'Textbox' -Disabled
        New-UDTextbox -Label 'Textbox' -Value 'With value'

        New-UDTimePicker
        New-UDTimePicker -Locale fr

        New-UDTransferList -Item {
            New-UDTransferListItem -Name 'test1' -Value 1
            New-UDTransferListItem -Name 'test2' -Value 2
            New-UDTransferListItem -Name 'test3' -Value 3
            New-UDTransferListItem -Name 'test4' -Value 4
            New-UDTransferListItem -Name 'test5' -Value 5
        } 

        # NAVIGATION
        New-UDTypography -Variant h2 -Text 'Navigation' 
        New-UDElement -Tag 'hr'
        New-UDStepper -Steps {
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 1" }
                New-UDTextbox -Id 'txtStep1' -Value $EventData.Context.txtStep1
            } -Label "Step 1"
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 2" }
                New-UDElement -tag 'div' -Content { "Previous data: $Body" }
                New-UDTextbox -Id 'txtStep2' -Value $EventData.Context.txtStep2
            } -Label "Step 2"
            New-UDStep -OnLoad {
                New-UDElement -tag 'div' -Content { "Step 3" }
                New-UDElement -tag 'div' -Content { "Previous data: $Body" }
                New-UDTextbox -Id 'txtStep3' -Value $EventData.Context.txtStep3
            } -Label "Step 3"
        } -OnFinish {
            New-UDTypography -Text 'Nice! You did it!' -Variant h3
            New-UDElement -Tag 'div' -Id 'result' -Content { $Body }
        }

        New-UDTabs -Tabs {
            New-UDTab -Text 'Item One' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item One' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
            New-UDTab -Text 'Item Two' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item Two' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
            New-UDTab -Text 'Item Three' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item Three' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
        }

        New-UDTabs -Tabs {
            New-UDTab -Text 'Item One' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item One' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
            New-UDTab -Text 'Item Two' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item Two' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
            New-UDTab -Text 'Item Three' -Content {
                New-UDElement -Tag 'div' -Content  {
                    New-UDTypography -Text 'Item Three' -Variant 'h2' 
                } -Attributes @{
                    style = @{
                        padding = '3rem'
                    }
                }
            }
        } -Orientation vertical


        New-UDTypography -Variant h2 -Text 'Layout'
        New-UDElement -Tag 'hr'
        New-UDGrid -Container -Content {
            New-UDGrid -Item -ExtraSmallSize 12 -Content {
                New-UDPaper -Content { "xs-12" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 6 -Content {
                New-UDPaper -Content { "xs-6" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 6 -Content {
                New-UDPaper -Content { "xs-6" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 3 -Content {
                New-UDPaper -Content { "xs-3" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 3 -Content {
                New-UDPaper -Content { "xs-3" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 3 -Content {
                New-UDPaper -Content { "xs-3" } -Elevation 2
            }
            New-UDGrid -Item -ExtraSmallSize 3 -Content {
                New-UDPaper -Content { "xs-3" } -Elevation 2
            }
        }

        New-UDDynamic -Id 'spacingGrid' -Content {
            $Spacing = (Get-UDElement -Id 'spacingSelect').value

            New-UDGrid -Spacing $Spacing -Container -Content {
                New-UDGrid -Item -ExtraSmallSize 3 -Content {
                    New-UDPaper -Content { "xs-3" } -Elevation 2
                }
                New-UDGrid -Item -ExtraSmallSize 3 -Content {
                    New-UDPaper -Content { "xs-3" } -Elevation 2
                }
                New-UDGrid -Item -ExtraSmallSize 3 -Content {
                    New-UDPaper -Content { "xs-3" } -Elevation 2
                }
                New-UDGrid -Item -ExtraSmallSize 3 -Content {
                    New-UDPaper -Content { "xs-3" } -Elevation 2
                }
            }
        }

        New-UDSelect -Id 'spacingSelect' -Label Spacing -Option {
            for ($i = 0; $i -lt 10; $i++) {
                New-UDSelectOption -Name $i -Value $i
            }
        } -OnChange { Sync-UDElement -Id 'spacingGrid' } -DefaultValue 3


        New-UDTypography -Variant h2 -Text 'Transitions'
        New-UDElement -Tag 'hr'
        New-UDTransition -Id 'test' -Content {
            New-UDCard -Text "Hey"
        } -In -Fade -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTransition -Id 'test2' -Content {
            New-UDCard -Text "Hey"
        } -In -Collapse -CollapseHeight 100 -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test2' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTransition -Id 'test3' -Content {
            New-UDCard -Text "Hey"
        } -In -Fade -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test3' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTransition -Id 'test4' -Content {
            New-UDCard -Text "Hey"
        } -In -Slide -SlideDirection 'left' -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test4' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTransition -Id 'test5' -Content {
            New-UDCard -Text "Hey"
        } -In -Grow -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test5' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTransition -Id 'test6' -Content {
            New-UDCard -Text "Hey"
        } -In -Zoom -Timeout 1000

        New-UDSwitch -OnChange {
            Set-UDElement -Id 'test6' -Properties @{
                in = $EventData -eq 'True'
            }
        } -Checked $true

        New-UDTypography -Variant h2 -Text Surfaces
        New-UDElement -Tag 'hr'
        New-UDCard -Title 'Simple Card' -Content {
            "This is some content"
        }

        $Header = New-UDCardHeader -Title "Name"

        $Footer = New-UDCardFooter -Content {
            New-UDButton -Variant text -Text 'Stop' -OnClick {
                Show-UDToast -Message 'Stopping VM...' -Duration 5000
                Start-Sleep 5
                Sync-UDElement -Id "Name_card"
            }
        }

        $Body = New-UDCardBody -Content {
            "Info about this VM"
        }

        $Expand = New-UDCardExpand -ClassName 'p-3' -Content {
            "More info about this VM"
        }

        New-UDStyle -Style '.ud-mu-cardexpand { display: block !important }' -Content {
            New-UDCard -Body $Body -Header $Header -Footer $Footer -Expand $Expand
        }

        New-UDPaper -Elevation 0 -Content {} 
        New-UDPaper -Elevation 1 -Content {} 
        New-UDPaper -Elevation 3 -Content {}
        New-UDPaper -Square -Content {}
        New-UDPaper -Content { } -Style @{ 
            backgroundColor = $common.Green
        }

        New-UDExpansionPanelGroup -Children {
            New-UDExpansionPanel -Title "Hello" -Children {}

            New-UDExpansionPanel -Title "Hello" -Id 'expContent' -Children {
                New-UDElement -Tag 'div' -Content { "Hello" }
            }
        }

        New-UDTypography -Variant h2 -Text 'Interaction'
        New-UDElement -Tag 'hr'
        New-UDButton -Text 'Clipboard' -OnClick {
            Set-UDClipboard -Data 'Hello, there!' -ToastOnSuccess
        }

        New-UDButton -Text 'JavaScript' -OnClick {
            Invoke-UDJavaScript -JavaScript 'alert("Hello!")'
        }

        New-UDButton -Text 'Toast' -OnClick {
            SHow-UDToast "Hey"
        }

        New-UDElement -Tag 'p' -Content { }
    }
}