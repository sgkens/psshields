# --- helper functions

function Get-PlatformConfig {
    [CmdletBinding()]
    [OutputType([PsCustomobject])]
    param()

    $platformConfig = @{
        github = @{
            baseUrl = 'https://img.shields.io/github'
            badges = @{
                stars = '/stars/{namespace}'
                forks = '/forks/{namespace}'
                issues = '/issues/{namespace}'
                license = '/license/{namespace}'
                release = '/v/release/{namespace}'
                workflow = '/actions/workflow/status/{namespace}/{workflow}'
            }
            defaultLogo = 'github'
        }
        gitlab = @{
            baseUrl = 'https://img.shields.io/gitlab'
            badges = @{
                stars = '/stars/{namespace}'
                forks = '/forks/{namespace}'
                issues = '/issues/open/{namespace}'
                license = '/license/{namespace}'
                pipeline = '/pipeline-status/{namespace}'
                coverage = '/pipeline-coverage/{namespace}'
            }
            defaultLogo = 'gitlab'
        }
        codecov = @{
            baseUrl = 'https://img.shields.io/codecov/c'
            badges = @{
                coverage = '/github/{namespace}'
                gitlab = '/gitlab/{namespace}'
            }
            defaultLogo = 'codecov'
        }
        coveralls = @{
            baseUrl = 'https://img.shields.io/coveralls'
            badges = @{
                coverage = '/github/{namespace}'
                gitlab = '/gitlab/{namespace}'
            }
            defaultLogo = 'coveralls'
        }
        docker = @{
            baseUrl = 'https://img.shields.io/docker'
            badges = @{
                pulls = '/pulls/{namespace}'
                stars = '/stars/{namespace}'
                size = '/image-size/{namespace}'
                version = '/v/{namespace}'
            }
            defaultLogo = 'docker'
        }
        npm = @{
            baseUrl = 'https://img.shields.io'
            badges = @{
                version = '/npm/v/{package}'
                downloads = '/npm/dt/{package}'
                license = '/npm/l/{package}'
                sizeMin = '/bundlephobia/min/{package}'
                sizeZipped = '/bundlephobia/minzip/{package}'
            }
            defaultLogo = 'npm'
        }
        powershell = @{
            baseUrl = 'https://img.shields.io/powershellgallery'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
                platform = '/p/{package}'
            }
            defaultLogo = 'powershell'
        }
        choco = @{
            baseUrl = 'https://img.shields.io/chocolatey'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
            }
            defaultLogo = 'chocolatey'
        }
        dotnet = @{
            baseUrl = 'https://img.shields.io/nuget'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
            }
            defaultLogo = 'nuget'
        }
        packagist = @{
            baseUrl = 'https://img.shields.io/packagist'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
                license = '/l/{package}'
                php = '/php-v/{package}'
            }
            defaultLogo = 'packagist'
        }
        composer = @{
            baseUrl = 'https://img.shields.io/packagist'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
                license = '/l/{package}'
            }
            defaultLogo = 'composer'
        }
        pypi = @{
            baseUrl = 'https://img.shields.io/pypi'
            badges = @{
                version = '/v/{package}'
                downloads = '/dm/{package}'
                license = '/l/{package}'
                python = '/pyversions/{package}'
                status = '/status/{package}'
            }
            defaultLogo = 'pypi'
        }
        rubygems = @{
            baseUrl = 'https://img.shields.io/gem'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
            }
            defaultLogo = 'rubygems'
        }
        crates = @{
            baseUrl = 'https://img.shields.io/crates'
            badges = @{
                version = '/v/{package}'
                downloads = '/d/{package}'
                license = '/l/{package}'
            }
            defaultLogo = 'rust'
        }
        pub = @{
            baseUrl = 'https://img.shields.io/pub'
            badges = @{
                version = '/v/{package}'
                likes = '/likes/{package}'
                points = '/points/{package}'
            }
            defaultLogo = 'dart'
        }
        hex = @{
            baseUrl = 'https://img.shields.io/hexpm'
            badges = @{
                version = '/v/{package}'
                downloads = '/dt/{package}'
                license = '/l/{package}'
            }
            defaultLogo = 'elixir'
        }
        cpan = @{
            baseUrl = 'https://img.shields.io/cpan'
            badges = @{
                version = '/v/{package}'
            }
            defaultLogo = 'perl'
        }
        maven = @{
            baseUrl = 'https://img.shields.io/maven-central'
            badges = @{
                version = '/v/{package}'
            }
            defaultLogo = 'apachemaven'
        }
        gradle = @{
            baseUrl = 'https://img.shields.io/maven-central'
            badges = @{
                version = '/v/{package}'
            }
            defaultLogo = 'gradle'
        }
        cargo = @{
            baseUrl = 'https://img.shields.io/crates'
            badges = @{
                version = '/v/{package}'
                downloads = '/d/{package}'
            }
            defaultLogo = 'rust'
        }
        go = @{
            baseUrl = 'https://img.shields.io/github'
            badges = @{
                version = '/go-mod/go-version/{namespace}'
            }
            defaultLogo = 'go'
        }
        conda = @{
            baseUrl = 'https://img.shields.io/conda'
            badges = @{
                version = '/v/{namespace}/{package}'
                downloads = '/dn/{namespace}/{package}'
                platform = '/pn/{namespace}/{package}'
            }
            defaultLogo = 'anaconda'
        }
        homebrew = @{
            baseUrl = 'https://img.shields.io/homebrew'
            badges = @{
                version = '/v/{package}'
                installs = '/installs/dm/{package}'
            }
            defaultLogo = 'homebrew'
        }
        aur = @{
            baseUrl = 'https://img.shields.io/aur'
            badges = @{
                version = '/version/{package}'
                votes = '/votes/{package}'
            }
            defaultLogo = 'archlinux'
        }
        snap = @{
            baseUrl = 'https://img.shields.io/snapcraft'
            badges = @{
                version = '/v/{package}'
            }
            defaultLogo = 'snapcraft'
        }
        jsdelivr   = @{
            baseUrl = 'https://img.shields.io/jsdelivr'
            badges = @{
                hitsperday   = '/npm/hd/{package}'
                hitsperweek  = '/npm/hw/{package}'
                hitspermonth = '/npm/hm/{package}'
                hitsperyear  = '/npm/hy/{package}'
            }
            defaultLogo = 'jsdelivr'
        }
        jsr = @{
            baseUrl = 'https://img.shields.io/jsr'
            badges = @{
                version = '/v/%40{namespace}'
            }
            defaultLogo = 'jsr'
        }
    }
    return $platformConfig
}

function Get-ColorPallete {
    [CmdletBinding()]
    [OutputType([PsCustomobject[]])]
    param()
    return (Get-Content -Path "$($global:__psshields.rootpath)\colorpallet.json" -raw | ConvertFrom-Json).colorGroups.colors
}

function Get-ColorGroups {
    <#
    .SYNOPSIS
        Returns all color groups from the color palette
    
    .DESCRIPTION
        Retrieves the complete color groups structure from the color palette JSON file
    
    .EXAMPLE
        Get-ColorGroups
        
    .EXAMPLE
        $groups = Get-ColorGroups
        $groups | ForEach-Object { Write-Host "Group: $($_.group)" }
    #>
    [CmdletBinding()]
    [OutputType([PsCustomobject[]])]
    param()
    return (Get-Content -Path "$($global:__psshields.rootpath)\colorpallet.json" -raw | ConvertFrom-Json).colorGroups
}

function Get-BadgeTypes {
    <#
    .SYNOPSIS
        Lists available badge types for each platform
    
    .DESCRIPTION
        Shows all available badge types that can be generated for each platform.
        Useful for discovering what badges are available.
    
    .PARAMETER Platform
        Optional. Filter by specific platform
    
    .EXAMPLE
        Get-BadgeTypes
        
    .EXAMPLE
        Get-BadgeTypes -Platform gitlab
        
    .EXAMPLE
        Get-BadgeTypes -Platform github
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$Platform
    )
    
    # Pull platform configuration
    $platformConfig = Get-PlatformConfig
    # Platform configurations (same as in New-ShieldBadge)
    # $platformConfig = @{
    #     github = @{
    #         badges = @{
    #             stars = '/stars/{namespace}'
    #             forks = '/forks/{namespace}'
    #             issues = '/issues/{namespace}'
    #             license = '/license/{namespace}'
    #             release = '/v/release/{namespace}'
    #             workflow = '/actions/workflow/status/{namespace}/{workflow}'
    #         }
    #     }
    #     gitlab = @{
    #         badges = @{
    #             stars = '/stars/{namespace}'
    #             forks = '/forks/{namespace}'
    #             issues = '/issues/open/{namespace}'
    #             pipeline = '/pipeline-status/{namespace}'
    #             license = '/license/{namespace}'
    #             coverage = '/pipeline-coverage/{namespace}'
    #         }
    #     }
    #     codecov = @{
    #         badges = @{
    #             coverage = '/github/{namespace}'
    #             gitlab = '/gitlab/{namespace}'
    #         }
    #     }
    #     coveralls = @{
    #         badges = @{
    #             coverage = '/github/{namespace}'
    #             gitlab = '/gitlab/{namespace}'
    #         }
    #     }
    #     docker = @{
    #         badges = @{
    #             pulls = '/pulls/{namespace}'
    #             stars = '/stars/{namespace}'
    #             size = '/image-size/{namespace}'
    #             version = '/v/{namespace}'
    #         }
    #     }
    #     npm = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #             size = '/bundle-size/{package}'
    #         }
    #     }
    #     powershell = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             platform = '/p/{package}'
    #         }
    #     }
    #     choco = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #     }
    #     dotnet = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #     }
    #     packagist = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #             php = '/php-v/{package}'
    #         }
    #     }
    #     composer = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #         }
    #     }
    #     pypi = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dm/{package}'
    #             license = '/l/{package}'
    #             python = '/pyversions/{package}'
    #             status = '/status/{package}'
    #         }
    #     }
    #     rubygems = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #     }
    #     crates = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/d/{package}'
    #             license = '/l/{package}'
    #         }
    #     }
    #     pub = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             likes = '/likes/{package}'
    #             points = '/points/{package}'
    #         }
    #     }
    #     hex = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #         }
    #     }
    #     cpan = @{
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #     }
    #     maven = @{
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #     }
    #     gradle = @{
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #     }
    #     cargo = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/d/{package}'
    #         }
    #     }
    #     go = @{
    #         badges = @{
    #             version = '/go-mod/go-version/{namespace}'
    #         }
    #     }
    #     conda = @{
    #         badges = @{
    #             version = '/v/{namespace}/{package}'
    #             downloads = '/dn/{namespace}/{package}'
    #             platform = '/pn/{namespace}/{package}'
    #         }
    #     }
    #     homebrew = @{
    #         badges = @{
    #             version = '/v/{package}'
    #             installs = '/installs/dm/{package}'
    #         }
    #     }
    #     aur = @{
    #         badges = @{
    #             version = '/version/{package}'
    #             votes = '/votes/{package}'
    #         }
    #     }
    #     snap = @{
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #     }
    #     jsdelivr = @{
    #         badges = @{
    #             hitsperday = '/npm/hd/{package}'
    #             hitsperweek = '/npm/hw/{package}'
    #             hitspermonth = '/npm/hm/{package}'
    #             hitsperyear = '/npm/hy/{package}'
    #         }
    #     }
    #     jsr = @{
    #         badges = @{
    #             version = '/jsr/v/%40{namespace}/{package}'
    #         }
    #     }
        
    # }
    
    # Stying options
    $HeaderLine = $(New-ColorConsole -String ("$([char]0x2550)" * 80) -Color DarkRed -format 'italic')

    if ($Platform) {
        $config = $platformConfig[$Platform]
        if (-not $config) {
            Write-Error "Platform '$Platform' not found"
            return
        }        
        [console]::WriteLine("$HeaderLine")
        [console]::WriteLine("Available badge types for '$(New-ColorConsole -S $Platform -Color 'Green' -format 'italic')':")
        [console]::WriteLine("$HeaderLine")
        
        foreach ($badgeType in $config.badges.Keys | Sort-Object) {
            [console]::WriteLine("  - $badgeType")
        }
        [console]::WriteLine("")
    } else {
        [console]::WriteLine("$HeaderLine")
        [console]::WriteLine("List of available badge types:")
        [console]::WriteLine("$HeaderLine")
        foreach ($plat in $platformConfig.Keys | Sort-Object) {
            $config = $platformConfig[$plat]
            $badgeTypes = $config.badges.Keys -join ', '
            
            [console]::WriteLine("")
            [console]::WriteLine("$(New-ColorConsole -S $plat.PadRight(15) -Color 'Green' -format 'italic') : $badgeTypes")
        }
        [console]::WriteLine("")
    }
}

function Get-BadgePalette {
    <#
    .SYNOPSIS
        Displays the color palette with ANSI color codes
    
    .DESCRIPTION
        Returns ANSI escaped color strings grouped by color group names.
        Shows each color with its actual ANSI color code for visual preview.
    
    .PARAMETER GroupName
        Optional. Filter by specific color group (standard, bright, extended_216, grayscale)
    
    .PARAMETER ShowCodes
        Display the ANSI code numbers alongside the colors
    
    .PARAMETER Compact
        Display colors in a compact grid format (useful for extended_216 and grayscale)
    
    .EXAMPLE
        Get-BadgePalette
        
    .EXAMPLE
        Get-BadgePalette -GroupName "standard"
        
    .EXAMPLE
        Get-BadgePalette -ShowCodes
        
    .EXAMPLE
        Get-BadgePalette -GroupName "extended_216" -Compact
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [ValidateSet('standard', 'bright', 'extended_216', 'grayscale')]
        [string]$GroupName,
        
        [Parameter(Mandatory=$false)]
        [switch]$ShowCodes,
        
        [Parameter(Mandatory=$false)]
        [switch]$Compact
    )
    
    $colorGroups = Get-ColorGroups
    
    # Filter by group name if specified
    if ($GroupName) {
        $colorGroups = $colorGroups | Where-Object { $_.group -eq $GroupName }
    }
    
    foreach ($group in $colorGroups) {
        [console]::WriteLine("")
        [console]::WriteLine("$([char]0x2550)" * 80)
        [console]::WriteLine(" COLOR GROUP: $($group.group.ToUpper())")
        [console]::WriteLine("$([char]0x2550)" * 80)
        [console]::WriteLine("")
        
        # Compact mode for large color sets
        if ($Compact -and ($group.colors.Count -gt 16)) {
            $colorsPerRow = 8
            $colorIndex = 0
            $currentRow = @()
            
            foreach ($color in $group.colors) {
                $code = $color.code
                $name = $color.name
                
                $currentRow += @{ code = $code; name = $name }
                $colorIndex++
                
                # New line after specified columns
                if ($colorIndex % $colorsPerRow -eq 0) {
                    # Print color blocks
                    $blockLine = ""
                    foreach ($c in $currentRow) {
                        if ($ShowCodes) {
                            $blockLine += "$($c.code.ToString().PadLeft(3)) "
                        }
                        $blockLine += "`e[48;5;$($c.code)m  `e[0m "
                    }
                    [console]::WriteLine($blockLine)
                    
                    # Print color names if ShowCodes
                    if ($ShowCodes) {
                        $nameLine = ""
                        foreach ($c in $currentRow) {
                            $nameLine += "$($c.name.PadRight(4))"
                        }
                        [console]::WriteLine($nameLine)
                    }
                    [console]::WriteLine("")
                    
                    $currentRow = @()
                }
            }
            
            # Handle remaining colors
            if ($currentRow.Count -gt 0) {
                $blockLine = ""
                foreach ($c in $currentRow) {
                    if ($ShowCodes) {
                        $blockLine += "$($c.code.ToString().PadLeft(3)) "
                    }
                    $blockLine += "`e[48;5;$($c.code)m  `e[0m "
                }
                [console]::WriteLine($blockLine)
                
                if ($ShowCodes) {
                    $nameLine = ""
                    foreach ($c in $currentRow) {
                        $nameLine += "$($c.name.PadRight(4))"
                    }
                    [console]::WriteLine($nameLine)
                }
                [console]::WriteLine("")
            }
        }
        else {
            # Standard detailed view
            $maxNameLength = ($group.colors.name | Measure-Object -Maximum -Property Length).Maximum
            $nameWidth = [Math]::Max($maxNameLength + 2, 20)
            
            foreach ($color in $group.colors) {
                $code = $color.code
                $name = $color.name
                $hex = $color.hex
                $rgb = $color.rgb -join ', '
                
                if ($ShowCodes) {
                    # Format: CODE | NAME | COLOR BLOCK | HEX | RGB
                    $line = " $($code.ToString().PadLeft(3)) $([char]0x2502) "
                    $line += "$($name.PadRight($nameWidth))"
                    $line += "`e[48;5;${code}m          `e[0m"
                    $line += "  $($hex.PadRight(9))"
                    $line += "  RGB($rgb)"
                    [console]::WriteLine($line)
                } else {
                    # Format: NAME | COLOR BLOCK | HEX | BULLET
                    $line = " $($name.PadRight($nameWidth))"
                    $line += "`e[48;5;${code}m          `e[0m"
                    $line += "  $($hex.PadRight(9))"
                    $line += "  `e[38;5;${code}m$([char]0x25CF)`e[0m"
                    [console]::WriteLine($line)
                }
            }
        }
        
        [console]::WriteLine("")
        [console]::WriteLine("$([char]0x2500)" * 80)
    }
    
    [console]::WriteLine("")
}

<# Class: ColorValidator - Validates color names #>
class ColorValidator : System.Management.Automation.ValidateArgumentsAttribute {
    [void] Validate([object] $arguments, [System.Management.Automation.EngineIntrinsics] $engineIntrinsics) {
        $validColors = $script:color_pallete.colorGroups.colors.name
        if ($validColors -notcontains $arguments) {
            throw "Invalid color name. Use Get-ColorPallete to see valid colors."
        }
    }
}

<# ArgumentCompleter for color parameters #>
class ColorCompleter : System.Management.Automation.IArgumentCompleter {
    [System.Collections.Generic.IEnumerable[System.Management.Automation.CompletionResult]] CompleteArgument(
        [string] $commandName,
        [string] $parameterName,
        [string] $wordToComplete,
        [System.Management.Automation.Language.CommandAst] $commandAst,
        [System.Collections.IDictionary] $fakeBoundParameters
    ) {
        $results = [System.Collections.Generic.List[System.Management.Automation.CompletionResult]]::new()
        
        # Get colors from the global palette
        $colors = $script:color_pallete.colorGroups.colors
        
        foreach ($color in $colors) {
            if ($color.name -like "$wordToComplete*") {
                $completionText = $color.name
                $listItemText = $color.name
                $resultType = [System.Management.Automation.CompletionResultType]::ParameterValue
                $toolTip = "Hex: $($color.hex) | RGB: $($color.rgb -join ',')"
                
                $results.Add([System.Management.Automation.CompletionResult]::new(
                    $completionText,
                    $listItemText,
                    $resultType,
                    $toolTip
                ))
            }
        }
        
        return $results
    }
}