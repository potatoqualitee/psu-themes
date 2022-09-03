$colors = Get-Colors
$common = $colors | Where-Object Mode -eq common
$dark = $colors | Where-Object Mode -eq dark

# add some defaults
$light = $colors | Where-Object Mode -eq light
if (-not $light) {
    $colors += [pscustomobject]@{
        "Mode"              = "light"
        "Enabled"           = "true"
        "Main"              = "#f6f8fa"
        "MainSecondary"     = "#DEDEDE"
        "MainGamma"         = "#B8B8C2"
        "MainDelta"         = "#c6c8ca"
        "Opposite"          = "#24292f"
        "OppositeSecondary" = "#57606a"
        "HighContrast"      = "#000000"
    }
}
if (-not $dark) {
    $colors += [pscustomobject]@{
        "Mode"              = "dark"
        "Enabled"           = "true"
        "Main"              = "#0D0F31"
        "MainSecondary"     = "#070825"
        "MainGamma"         = "#454761"
        "MainDelta"         = "#A2A2AA"
        "Opposite"          = "#c9d1d9"
        "OppositeSecondary" = "#8b949e"
        "HighContrast"      = "#ffffff"
    }
    $dark = $colors | Where-Object Mode -eq dark
}
$shadows = @()
1..25 | ForEach-Object { $shadows += "none" }
$themes = @{}

ForEach ($theme in $colors) {
    $themes += @{
        $theme.Mode = @{
            palette    = @{
                mode       = $theme.Mode
                background = @{
                    default = $theme.Main
                }
                text       = @{
                    primary   = $theme.Opposite
                    secondary = $theme.OppositeSecondary
                    disabled  = $theme.OppositeSecondary
                }
                primary    = @{
                    main         = $common.Blue
                    dark         = $theme.BlueRGBA15
                    light        = $common.Blue
                    contrastText = $common.Black
                }
                secondary  = @{
                    main         = $common.Cyan
                    dark         = $theme.CyanRGBA15
                    light        = $common.CyanRGBA15
                    contrastText = $common.Black
                }
                warning    = @{
                    main         = $common.Yellow
                    dark         = $theme.YellowRGBA15
                    light        = $common.Yellow
                    contrastText = $common.Black
                }
                error      = @{
                    main         = $common.Red
                    dark         = $theme.RedRGBA15
                    light        = $common.Red
                    contrastText = $common.Black
                }
                success    = @{
                    main         = $common.Green
                    dark         = $theme.GreenRGBA15
                    light        = $common.Green
                    contrastText = $common.Black
                }
                info       = @{
                    main         = $common.Purple
                    dark         = $theme.PurpleRGBA15
                    light        = $common.Purple
                    contrastText = $common.Black
                }
            }
            shape      = @{
                borderRadius = $common.BorderRadius
            }
            shadows    = $shadows
            typography = @{
                fontFamily = $common.FontFamily
                # Additional styles for fonts can be found in theme.css
            }
            overrides  = @{
                MuiAppBar          = @{
                    root = @{
                        backgroundColor = $theme.MainSecondary
                        backgroundImage = 'none'
                        borderBottom    = '1px solid ' + $theme.MainGamma
                        paddingRight    = '18px'
                        paddingLeft     = '18px'
                    }
                }
                MuiDrawer          = @{
                    paper = @{
                        backgroundColor                           = $dark.MainSecondary
                        color                                     = $dark.Opposite
                        zIndex                                    = 1202 # Comment out this line in order to show the default header with logo
                        flex                                      = '0 0 250px'
                        maxWidth                                  = '250px'
                        minWidth                                  = '250px'
                        width                                     = '250px !important'
                        borderRight                               = '1px solid ' + $dark.MainGamma
                        '.MuiList-subheader'                      = @{
                            paddingLeft  = '.5rem'
                            paddingRight = '.5rem'
                        }
                        '.MuiList-root'                           = @{
                            paddingTop = 0
                        }
                        '.MuiListItem-root'                       = @{
                            paddingLeft = '18px !important'
                            cursor      = "pointer"
                            '&:hover'   = @{
                                background   = $dark.MainGamma
                                borderRadius = $common.BorderRadius
                            }
                        }
                        '#drawerSettings + .MuiCollapse-root'     = @{
                            paddingLeft = '18px'
                        }
                        '.MuiListItemIcon-root, .MuiSvgIcon-root' = @{
                            color = $dark.Opposite
                        }
                        '.MuiToolbar-root'                        = @{
                            backgroundImage    = 'url(/assets/logo.png)'
                            backgroundSize     = '80%'
                            backgroundRepeat   = 'no-repeat'
                            marginLeft         = '18px'
                            marginTop          = '1px'
                            backgroundPosition = 'left center'
                        }
                    }
                }
                MuiPaper           = @{
                    root = @{
                        backgroundColor = $theme.MainSecondary
                        backgroundImage = 'none'
                    }
                }
                MuiToolbar         = @{
                    root = @{
                        paddingLeft  = '0 !important'
                        paddingRight = '0 !important'
                    }
                }
                MuiListItem        = @{
                    root = @{
                        paddingLeft = 0
                    }
                }
                MuiListItemIcon    = @{
                    root = @{
                        color       = $theme.Opposite
                        minWidth    = 'auto'
                        marginRight = '1rem'
                    }
                }
                MuiCard            = @{
                    root = @{
                        border = '1px solid ' + $theme.MainGamma
                    }
                }
                MuiCardHeader      = @{
                    root = @{
                        paddingBottom = 0
                    }
                }
                MuiFormControl     = @{
                    root = @{
                        width = '100%'
                    }
                }
                MuiInput           = @{
                    root = @{
                        '&:before' = @{
                            borderBottom = '2px solid ' + $theme.MainGamma
                        }
                    }
                }
                MuiFormLabel       = @{
                    root = @{
                        color = $theme.Opposite
                    }
                }
                MuiSwitch          = @{
                    switchBase = @{
                        color = $theme.MainGamma
                    }
                }
                MuiGrid            = @{
                    root = @{
                        '&.transfer-list' = @{
                            '.MuiPaper-root'  = @{
                                border = '1px solid ' + $theme.MainGamma
                            }
                            'button + button' = @{
                                marginLeft = '0 !important'
                            }
                        }
                    }
                }
                MuiStepIcon        = @{
                    text = @{
                        fill = $dark.Main
                    }
                    root = @{
                        color = $dark.Opposite
                    }
                }
                MuiAlert           = @{
                    icon            = @{
                        opacity = 1
                    }
                    standardWarning = @{
                        backgroundColor = $common.YellowRGBA15
                        borderColor     = $common.Yellow
                        color           = $theme.HighContrast
                    }
                    standardError   = @{
                        backgroundColor = $common.RedRGBA15
                        borderColor     = $common.Red
                        color           = $theme.HighContrast
                    }
                    standardSuccess = @{
                        backgroundColor = $common.GreenRGBA15
                        borderColor     = $common.Green
                        color           = $theme.HighContrast
                    }
                    standardInfo    = @{
                        backgroundColor = $common.PurpleRGBA15
                        borderColor     = $common.Purple
                        color           = $theme.HighContrast
                    }
                    # Additional styles for alerts can be found in theme.css
                }
                MuiTableContainer  = @{
                    root = @{
                        backgroundColor                    = "unset"
                        borderRadius                       = 0;
                        backgroundImage                    = 'none'
                        margin                             = '0 !important'
                        'div[class*="makeStyles-search-"]' = @{
                            background  = $theme.MainGamma
                            marginRight = 0
                        }
                        'h5, .MuiTypography-h5'            = @{
                            marginBottom = '0 !important'
                        }
                    }
                }
                MuiTable           = @{
                    root = @{
                        borderCollapse = 'separate'
                    }
                }
                MuiTablePagination = @{
                    toolbar       = @{
                        paddingLeft  = '0 !important'
                        paddingRight = '0 !important'
                    }
                    spacer        = @{
                        display = 'none'
                    }
                    displayedRows = @{
                        marginRight = 'auto'
                    }
                }
                MuiTableCell       = @{
                    head   = @{
                        backgroundColor = $theme.MainGamma
                    }
                    root   = @{
                        borderBottom = '1px solid ' + $theme.MainGamma
                    }
                    footer = @{
                        borderTop = '1px solid ' + $theme.MainGamma
                    }
                }
                MuiTableBody       = @{
                    root = @{
                        'tr:nth-child(even)' = @{
                            backgroundColor = $theme.Main
                        }
                        'tr:nth-child(odd)'  = @{
                            backgroundColor = $theme.MainSecondary
                        }
                    }
                }
                MuiTableRow        = @{
                    root = @{
                        '&:last-child td' = @{
                            borderBottom = 0
                        }
                    }
                }
                MuiButton          = @{
                    root               = @{
                        fontWeight          = 600
                        margin              = '0 0 .25rem !important'
                        '+ .MuiButton-root' = @{
                            marginLeft = '0.5rem !important'
                        }
                    }
                    contained          = @{
                        color = $common.Black
                    }
                    outlined           = @{
                        '&:hover' = @{
                            color = $common.Black
                        }
                    }
                    containedInherit   = @{
                        backgroundColor = $theme.MainGamma
                        color           = $theme.Opposite
                        '&:hover'       = @{
                            backgroundColor = $theme.MainDelta
                        }
                    }
                    containedPrimary   = @{
                        '&:hover' = @{
                            backgroundColor = $theme.BlueHover
                        }
                    }
                    containedSecondary = @{
                        '&:hover' = @{
                            backgroundColor = $theme.CyanHover
                        }
                    }
                    containedInfo      = @{
                        '&:hover' = @{
                            backgroundColor = $theme.PurpleHover
                        }
                    }
                    containedWarning   = @{
                        '&:hover' = @{
                            backgroundColor = $theme.YellowHover
                        }
                    }
                    containedError     = @{
                        '&:hover' = @{
                            backgroundColor = $theme.RedHover
                        }
                    }
                    containedSuccess   = @{
                        '&:hover' = @{
                            backgroundColor = $theme.GreenHover
                        }
                    }
                    outlinedInherit    = @{
                        borderColor = $theme.MainGamma
                        '&:hover'   = @{
                            backgroundColor = $theme.MainGamma
                            color           = $theme.Opposite
                        }
                    }
                    outlinedPrimary    = @{
                        borderColor = $common.Blue
                        '&:hover'   = @{
                            backgroundColor = $common.Blue
                        }
                    }
                    outlinedSecondary  = @{
                        borderColor = $common.Cyan
                        '&:hover'   = @{
                            backgroundColor = $common.Cyan
                        }
                    }
                    outlinedInfo       = @{
                        borderColor = $common.Purple
                        '&:hover'   = @{
                            backgroundColor = $common.Purple
                        }
                    }
                    outlinedWarning    = @{
                        borderColor = $common.Yellow
                        '&:hover'   = @{
                            backgroundColor = $common.Yellow
                        }
                    }
                    outlinedError      = @{
                        borderColor = $common.Red
                        '&:hover'   = @{
                            backgroundColor = $common.Red
                        }
                    }
                    outlinedSuccess    = @{
                        borderColor = $common.Green
                        '&:hover'   = @{
                            backgroundColor = $common.Green
                        }
                    }
                }
            }
        }
    }
}
