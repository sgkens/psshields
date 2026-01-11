using module ..\cmdlets\Get-PlatformConfig.psm1
# --- helper functions

function Get-ColorPallete {
    [CmdletBinding()]
    [OutputType([PsCustomobject[]])]
    param()
    return ($global:__psshields.color_pallete).colorGroups.colors
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
    return ($global:__psshields.color_pallete).colorGroups
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

    # Stying options
    $HeaderLine = $(New-ColorConsole -String ("$([char]0x2550)" * 80) -Color DarkRed -format 'italic')

    if ($Platform) {
        $config = $platformConfig[$Platform]
        if (-not $config) {
            Write-Error "Platform '$Platform' not found"
            return
        }        
        [console]::WriteLine("$HeaderLine")
        [console]::WriteLine("( $(New-ColorConsole -S "$($config.badges.count)" -Color 'Green') ) Available badge types for '$(New-ColorConsole -S $Platform -Color 'Green' -format 'italic')':")
        [console]::WriteLine("$HeaderLine")
        
        foreach ($badgeType in $config.badges.Keys | Sort-Object) {
            [console]::WriteLine("  ─ $badgeType")
        }
        [console]::WriteLine("")
    } else {
        [console]::WriteLine("$HeaderLine")
        [console]::WriteLine("$(New-ColorConsole -S "List all ( $(New-ColorConsole -S "$($platformConfig.count)" -Color 'Green') ) of available badge types:" -Color darkgray -format 'bold')")
        [console]::WriteLine("$(New-ColorConsole -S ' • Filter with the -Platform' -Color darkyellow -format 'italic')")
        [console]::WriteLine("$HeaderLine")
        [console]::WriteLine("")
        foreach ($plat in $platformConfig.Keys | Sort-Object) {
            $config = $platformConfig[$plat]
            $badgeTypes = $config.badges.Keys -join ', '
            
            # [console]::WriteLine("")
            [console]::WriteLine("$(New-ColorConsole -S $plat.PadRight(15) -Color cyan -format 'italic', 'bold') : $badgeTypes")
        }
        # [console]::WriteLine("") #note! remove padding
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