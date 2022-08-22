New-UDPage -Name Sample -Url / -Content {
    $colors = Get-Colors
    $common = $colors | Where-Object Mode -eq common

    New-UDElement -Tag 'div' -Id 'mainContainer' -Content {
        New-UDRow -Columns {
            New-UDColumn -LargeSize 4 -Content {
                New-UDCard -Title 'Newsletter Signup' -TitleAlignment 'center' -Content {
                    New-UDForm -ButtonVariant 'contained' -Content {
                        New-UDTextbox -Label 'Name' -Placeholder 'Muffin Man' -Id 'txtNameField'
                        New-UDTextbox -Label 'Email' -Placeholder '123candycanelane@northpole.com'
                        New-UDCheckbox -Label 'Are you a human?' -Color 'primary' -Checked $true
                    
                        New-UDSelect -Label 'What is your favorite drink?' -ClassName 'form-select' -Option {
                            New-UDSelectOption -Name "Pop" -Value 1
                            New-UDSelectOption -Name "Water" -Value 2
                            New-UDSelectOption -Name "Juice" -Value 3
                        } -DefaultValue '1'
                    
                        New-UDSwitch -Color 'primary' -Label 'Do you like pizza?' -Checked $true
                    
                        New-UDDatePicker
                    
                        New-UDTimePicker
                    
                        New-UDRadioGroup -Label 'Choose your favorite dessert:' -Children {
                            New-UDRadio -Value 'Pie' -Label 'Pie'
                            New-UDRadio -Value 'Cake' -Label 'Cake'
                            New-UDRadio -Value 'Cookies' -Label 'Cookies'
                        }

                        New-UDTypography -Variant body1 -Text 'How much do you like chocolate?'
                        New-UDSlider -Value 50
                    } -OnValidate {
                        $FormContent = $EventData
            
                        if ($FormContent.txtNameField -eq $null -or $FormContent.txtNameField -eq '') {
                            New-UDFormValidationResult -ValidationError "Please enter your name."
                        } else {
                            New-UDFormValidationResult -Valid
                        }
                    } -OnSubmit {
                        New-UDTypography -Text 'Thanks!'
                        Show-UDToast -BackgroundColor $common.GreenARGB95 -Message 'Good Answers!'
                    } 
                }
                New-UDCard -Title 'Notifications' -TitleAlignment 'center' -Content {
                    New-UDAlert -Severity 'error' -Content { New-UDHtml 'This is an error alert — <strong>check it out!</strong>' } -Title "Error"
                    New-UDAlert -Severity 'warning' -Content { New-UDHtml 'This is an warning alert — <strong>check it out!</strong>' } -Title "Warning"
                    New-UDAlert -Severity 'info' -Content { New-UDHtml 'This is an error info — <strong>check it out!</strong>' } -Title "Info"
                    New-UDAlert -Severity 'success' -Content { New-UDHtml 'This is an success alert — <strong>check it out!</strong>' } -Title "Success" -ClassName 'mb-0'
                }
                New-UDCard -Title 'Switches' -TitleAlignment 'center' -Content {
                    New-UDSwitch -Label 'Default' -Checked $true
                    New-UDSwitch -Label 'Default Disabled' -Checked $true -Disabled
                    New-UDSwitch -Color 'primary' -Label 'Primary' -Checked $true
                    New-UDSwitch -Color 'primary' -Label 'Primary Disabled' -Checked $true -Disabled
                    New-UDSwitch -Color 'secondary' -Label 'Secondary' -Checked $true
                    New-UDSwitch -Color 'secondary' -Label 'Secondary Disabled' -Checked $true -Disabled
                }
                New-UDCard -Title 'List with Icons' -TitleAlignment 'center' -Content {
                    New-UDList -Content {
                        New-UDListItem -Label 'Inbox' -Icon (New-UDIcon -Icon envelope -Size 2x -Color $common.Blue) -SubTitle 'New Stuff'
                        New-UDListItem -Label 'Drafts' -Icon (New-UDIcon -Icon edit -Size 2x -Color $common.Blue) -SubTitle "Stuff I'm working on"
                    }
                }
            }
            New-UDColumn -LargeSize 8 -Content {
                New-UDRow -Columns {
                    New-UDColumn -LargeSize 6 -Content {
                        New-UDCard -Title 'Shopping List' -TitleAlignment 'center' -Content {
                            $Data = @(
                                @{Groceries = 'Frozen yoghurt';}
                                @{Groceries = 'Ice cream sandwich';}
                                @{Groceries = 'Eclair';}
                                @{Groceries = 'Cupcake';}
                                @{Groceries = 'Gingerbread';}
                                @{Groceries = 'Fudge Bars';}
                            ) 
        
                            New-UDTable -Id 'grocery_table' -Data $Data -ShowSelection -OnRowSelection {
                                Show-UDToast -BackgroundColor $common.GreenARGB95 -Message 'Success!'
                            }
                        }
                    }
                    New-UDColumn -LargeSize 6 -Content {
                        New-UDCard -Title 'Progress' -TitleAlignment 'center' -Content {
                            New-UDProgress
                            New-UDElement -Tag 'div' -Content {
                                New-UDProgress -Circular -Color $common.Blue
                                New-UDProgress -Circular -Color $common.Green
                                New-UDProgress -Circular -Color $common.Pink
                                New-UDProgress -Circular -Color $common.Purple
                            } -Attributes @{
                                style = @{
                                    padding = '1rem 0 .5rem'
                                    textAlign = 'center'
                                }
                            }
                            New-UDProgress -PercentComplete 75
                        }
                        New-UDCard -Title 'Checkboxes' -TitleAlignment 'center' -Content {
                            $Icon = New-UDIcon -Icon angry -Size lg -Regular
                            $CheckedIcon = New-UDIcon -Icon angry -Size lg
                            New-UDCheckBox -Icon $Icon -CheckedIcon $CheckedIcon -Style @{color = $common.Blue }
        
                            New-UDCheckBox -Label 'Demo' -LabelPlacement start
                            New-UDCheckBox -Label 'Demo' -LabelPlacement top
                            New-UDCheckBox -Label 'Demo' -LabelPlacement bottom
                            New-UDCheckBox -Label 'Demo' -LabelPlacement end
                            New-UDElement -Tag 'hr'
                            New-UDCheckbox -Label 'Default'
                            New-UDCheckbox -Label 'Primary' -Color 'primary'
                            New-UDCheckbox -Label 'Secondary' -Color 'secondary'
                        }
                    }
                }
                New-UDCard -Title 'Buttons with Toast' -TitleAlignment 'center' -Content {
                    New-UDButton -Variant 'contained' -Text 'Default' (New-UDIcon -Icon trash) -OnClick {
                        Show-UDToast -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'contained' -Color 'primary' -Text 'Primary' -OnClick {
                        Show-UDToast -BackgroundColor $common.BlueARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'contained' -Color 'secondary' -Text 'Secondary' -OnClick {
                        Show-UDToast -BackgroundColor $common.PinkARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'contained' -Color 'info' -Text 'Info' (New-UDIcon -Icon bolt) -OnClick {
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

                    New-UDElement -Tag 'hr'

                    New-UDButton -Variant 'outlined' -Text 'Default' -OnClick {
                        Show-UDToast -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'primary' -Text 'Primary' -OnClick {
                        Show-UDToast -BackgroundColor $common.BlueARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'secondary' -Text 'Secondary' -OnClick {
                        Show-UDToast -BackgroundColor $common.PinkARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'info' -Text 'Info' -OnClick {
                        Show-UDToast -BackgroundColor $common.PurpleARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'warning' -Text 'Warning' -OnClick {
                        Show-UDToast -BackgroundColor $common.YellowARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'error' -Text 'Error' -OnClick {
                        Show-UDToast -BackgroundColor $common.RedARGB95 -Message 'Hello!' -Duration 3000
                    }
                    New-UDButton -Variant 'outlined' -Color 'success' -Text 'Success' (New-UDIcon -Icon save) -OnClick {
                        Show-UDToast -BackgroundColor $common.GreenARGB95 -Message 'Hello!' -Duration 3000
                    }
                }
                New-UDCard -Title 'Transfer List' -TitleAlignment 'center' -Content {
                    New-UDTransferList -ClassName 'transfer-list' -Item {
                        New-UDTransferListItem -Name 'test1' -Value 1
                        New-UDTransferListItem -Name 'test2' -Value 2
                        New-UDTransferListItem -Name 'test3' -Value 3
                    } 
                }
                New-UDCard -Title 'Doughnut Chart' -TitleAlignment 'center' -Content {
                    $Data = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10 
                    New-UDChartJS -Type 'doughnut' -Data $Data -DataProperty CPU -LabelProperty ProcessName -BackgroundColor @(
                        $common.Purple, 
                        $common.PurpleHover,
                        $common.Blue,
                        $common.BlueHover,
                        $common.Green,
                        $common.GreenHover,
                        $common.Red,
                        $common.RedHover,
                        $common.Yellow,
                        $common.Pink
                    ) -BorderColor @(
                        $common.Purple,
                        $common.PurpleHover,
                        $common.Blue,
                        $common.BlueHover,
                        $common.Green,
                        $common.GreenHover,
                        $common.Red,
                        $common.RedHover,
                        $common.Yellow,
                        $common.Pink
                    ) -HoverBackgroundColor @(
                        $common.PurpleHover,
                        $common.Purple,
                        $common.BlueHover,
                        $common.Blue,
                        $common.GreenHover,
                        $common.Green,
                        $common.RedHover,
                        $common.Red,
                        $common.YellowHover,
                        $common.PinkHover
                    )
                }
                New-UDCard -Content {
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
                }
            }
        }
        New-UDGrid -Container -Content {
            New-UDGrid -Item -ExtraSmallSize 12 -Content {
                New-UDCard -Title 'Table with Paging' -TitleAlignment 'center' -Content {
                    $Data = @(
                        @{Dessert = 'Frozen yoghurt'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                        @{Dessert = 'Ice cream sandwich'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                        @{Dessert = 'Eclair'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                        @{Dessert = 'Cupcake'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                        @{Dessert = 'Gingerbread'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                        @{Dessert = 'Pudding'; Calories = 159; Fat = 6.0; Carbs = 24; Protein = 4.0 }
                    ) 

                    New-UDTable -Data $Data -Paging -PageSize 3
                }
            }
        }
    }
}