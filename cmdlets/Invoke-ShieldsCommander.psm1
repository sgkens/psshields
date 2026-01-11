# include dependencies
using module ..\libs\New-ColorConsole.psm1
using module ..\libs\Write-AsciiTable.psm1
using module .\Get-DefinedColorSets.psm1
using module ..\libs\argumentcompleters.psm1
using module ..\libs\miniforge.psm1

function Invoke-ShieldsCommander {
    <#
    .SYNOPSIS
        The Commander function for all psshields cmdlets, this is the main function you want to interact with.
    .DESCRIPTION
        The Commander function for all psshields cmdlets, this is the main function you want to interact with.
    .PARAMETER Reponame
        The name of the repository. If not provided, the current directory name is used.
    .PARAMETER Namespace
        The namespace or user/organization name for the repository.
    .PARAMETER Set
        The set of badges to generate. Valid options are 'jsm', 'psm', 'docker', 'nuget'.    
    .PARAMETER Style
        The style of the badge. Valid options are 'flat', 'flat-square', 'social', and 'for-the-badge'. 
    .PARAMETER Colorsets
        The color scheme for the badge. Valid options include various predefined color sets.
    .PARAMETER ViewColorsets
        If specified, lists all available color sets.
    .PARAMETER Platform
        if you didnt specify a set a single badge will be generated outsite of the sets, and will need addtion information, plateform
    .PARAMETER BadgeType
        if you didnt specify a set a single badge will be generated outsite of the sets, and will need addtion information, BadgeType                                                
    .PARAMETER preview
        If specified, opens a preview of the generated badge in the default web browser.
    .PARAMETER OutputFormat
        If specified, The output format currently supports: 'markdown', 'html', 'url'. (default: markdown)
    .PARAMETER ViewBadgeTypes
        If specified, Outputs the available badge types. (Get-BadgeTypes), you can use the -plateform parameter to filter by -plateform
    .PARAMETER ViewBadgePallete
        If specified, Outputs the available color pallete. (Get-ColorPallete)
    .PARAMETER PalleteGroup
        if specified with -ViewBadgePallete filters the color group by name Current options: standard, bright, extended_216, grayscale
    .PARAMETER ShowCodes
        if specified -ViewBadgePallete displays the color codes
    .PARAMETER Compact
        if specified -ViewBadgePallete displays the color codes in a compact grid
    .PARAMETER ViewRawColorPallete
        If specified, Outputs the available color pallete. (Get-BadgePallete)
    .PARAMETER ViewColorGroups
        If specified, Outputs the available color pallete. (Get-ColorGroups)
    .EXAMPLE
        # Generates badges for a JavaScript project with the matrix-console colorset
        Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization|username" -Set jsm -Colorset matrix-console

        # Generates badges for a PowerShell project with the matrix-console colorset
        Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization|username" -Set psm -Colorset matrix-console

        # Generates badges for a Docker project with the matrix-console colorset
        Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization|username" -Set docker -Colorset matrix-console

        # Generates badges for a NuGet project with the matrix-console colorset
        Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization|username" -Set nuget -Colorset matrix-console
    .EXAMPLE
        # Output badge Previews
        Invoke-ShieldsCommander -Preview

        # Output RawColors(developed for testing)
        Invoke-ShieldsCommander -ViewRawColorPallete

        # Output Badge Color Pallete
        Invoke-ShieldsCommander -ViewColorPallete

        # Output Badge Types
        Invoke-ShieldsCommander -ViewBadgeTypes
                                    
    #>
    # NOTE! : Add badged param array allowing generation from json file
    [Alias('ShieldsCommander')]
    [cmdletbinding()]
    param(
        [parameter(Mandatory=$false)]
        [string]$Reponame,

        [parameter(Mandatory=$false)]
        [string]$Namespace, 

        [parameter(Mandatory=$false)]
        [validateSet('jsm', 'psm', 'docker', 'nuget', 'custom', 'jekyll-theme-gem', 'gem')]
        [string]$Set,

        [parameter(Mandatory=$false)]
        [ArgumentCompleter([PlatformTypeCompleter])]
        [string]$Platform, 

        [parameter(Mandatory=$false)]
        [ArgumentCompleter([BadgeTypeCompleter])]
        [string]$BadgeType,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$LabelColor,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$MessageColor,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$LogoColor,

        [parameter(Mandatory=$false)]
        [validateSet('flat', 'flat-square', 'social', 'for-the-badge')]
        [string]$Style,
        
        [parameter(Mandatory=$false)]
        [validateSet('html','markdown','url')]
        [string]$OutputFormat,
        
        [parameter(Mandatory=$false)]
        [validateSet(
            'cyberpunk', 'neon-nights', 'azure-tech', 'matrix-console', 'synthwave', 'royal-tech',
            'professional-blue', 'slate-clean', 'corporate-dark', 'executive',  'teal-accent', 'trust-blue',
            'magma', 'sunset-glow', 'critical-alert', 'amber-lamps', 'cherry-blossom', 'midas-gold',
            'forest-guard', 'camouflage', 'ocean-foam', 'earth-tone', 'glacier-ice', 'toxic-waste',
            'monolith', 'noir', 'brushed-metal', 'carbon-maroon', 'stealth-bomber', 'typewriter',
            'old-paper', 'military-issue', 'dusty-rose', 'leather-bound', 'faded-denim', 'brick-house',
            'construction', 'bio-hazard', 'safety-cone', 'high-contrast', 'glitch-pop', 'medical-alert',
            'nebula-core', 'void-walker', 'alien-tech', 'solar-flare', 'moon-base', 'hyper-drive',
            'cotton-candy', 'baby-blue', 'minty-fresh', 'vanilla-cream', 'lilac-dream', 'peach-fuzz',
            'emerald-city', 'ruby-red', 'sapphire-night', 'amethyst-glow', 'diamond-cut' , 'topaz-fire'
        )]
        [string]$ColorSet,

        [parameter(Mandatory=$false)]
        [switch]$ViewColorSets,
        
        [parameter(Mandatory=$false)]
        [switch]$Preview, 

        [parameter(Mandatory=$false)]
        [switch]$ViewBadgeTypes,

        [parameter(Mandatory=$false)]
        [switch]$ViewColorPallete,

        [parameter(Mandatory=$false)]
        [ValidateSet('standard', 'bright', 'extended_216', 'grayscale')]
        [string]$PalleteGroup,

        [parameter(Mandatory=$false)]
        [switch]$ShowCodes,

        [parameter(Mandatory=$false)]
        [switch]$Compact,

        [parameter(Mandatory=$false)]
        [switch]$ViewRawColorPallete, 

        [parameter(Mandatory=$false)]
        [switch]$ViewColorGroups,

        [parameter(Mandatory=$false)]
        [switch]$Raw
    )

    begin {

        # Sanity checks and defaults
        if(!$reponame){ $reponame = (Get-Location).Path.Split('\')[-1] }
        if(!$style){ $style = 'flat-square' }
        if(!$OutputFormat){ $OutputFormat = 'markdown' }
        if(!$colorset){$colorset = 'azure-tech' }

        $AsciiTableView_config = $global:__psshields.asciitableview

        # --- DEFINE THE COLORSET ARRAY HERE ----
        # ---------------------------------------
        $color_sets = Get-DefinedColorSets

        $color_pallete = Get-ColorPallete

        # Select the color set or use default
        $selected_color_set = $color_sets | Where-Object { $_.ColorSet -eq $colorset }
        if ($selected_color_set) {
            $LabelColor = $selected_color_set.LabelColor
            $MessageColor = $selected_color_set.MessageColor
            $LogoColor = $selected_color_set.LogoColor
        }

        function New-AsciiColorString {
            param (
                [string]$ColorCode,
                [string]$Text
            )
                $escapeSequence = [char]27
                $reset = "${escapeSequence}[0m"
                return "${escapeSequence}[38;5;${ColorCode}m$Text$reset"
        }
    }
    process{

        # Call the helper functions
        if ($ViewBadgeTypes) {
            
            # Return via AsciiTable with red theme
            if($platform){
                Get-BadgeTypes -platform $platform 
                return
            }else{
                Get-BadgeTypes
                return
            }
        }
        if ($ViewColorGroups) {

            # Return via AsciiTable with red theme
            if($raw){
                Get-ColorGroups -raw
                return
            }else{
                Get-ColorGroups
                return
            }

        }
        if ($ViewColorPallete) {
            # Takes 3 params -GroupName 'GroupName' -ShowCodes -Compact
            if(!$GroupName){
                Get-BadgePalette      
            }
            elseif($GroupName -and !$ShowCodes -or !$Compact){
                Get-BadgePalette -GroupName $GroupName
            }else{
                Get-BadgePalette -GroupName $GroupName -ShowCodes:$ShowCodes -Compact:$Compact
            }
            return
        }

        if ($ViewRawColorPallete) {
            $colorpallet = Get-ColorPallete
            if($raw){
                $colorpallet
                return
            }else{
                $colorpallet | Write-AsciiTable -Title "Color Pallete" -SummaryTitle "Displaying color count:" -ColorPallet $AsciiTableView_config.colorpallet
                return 
            }

        }

        if($ViewColorSets){
            if($raw){
                $color_sets | Select-Object colorset, logocolor, Labelcolor, MessageColor
                return;
            }else {
                $color_sets | Write-AsciiTable -Title "Color Sets" `
                                               -SummaryTitle "Displaying color count:" `
                                               -Property colorset, logocolor, Labelcolor, MessageColor `
                                               -ColorPallet $AsciiTableView_config.colorpallet `
                                               -TrimContent `
                                               -format @{
                                                    colorset = { New-ColorConsole -String $args[0] -Color darkcyan -Format italic }
                                                    logocolor = {
                                                        [int]$colorCode = $color_pallete | where-object{ $_.name -eq $args[0] } | Select-Object -ExpandProperty Code
                                                        New-AsciiColorString -ColorCode 84 -Text $args[0]
                                                        $colorCode=$null
                                                    }
                                                    Labelcolor = {
                                                        [int]$colorCode = $color_pallete | where-object{ $_.name -eq $args[0] } | Select-Object -ExpandProperty Code
                                                        New-AsciiColorString -ColorCode 85 -Text $args[0]
                                                        $colorCode=$null
                                                    }
                                                    MessageColor = {
                                                        [int]$colorCode = $color_pallete | where-object{ $_.name -eq $args[0] } | Select-Object -ExpandProperty Code
                                                        New-AsciiColorString -ColorCode 166 -Text $args[0]
                                                        $colorCode=$null
                                                    }
                                               }
                return;
            }
        }


        if($preview){
            # 1. Build a lookup table from your Get-ColorPallete function
            #    This converts the list into a fast Hash Table (Name -> Code)
            $PaletteMap = @{}
            try {
                $rawPalette = Get-ColorPallete
                foreach ($item in $rawPalette) {
                    $PaletteMap[$item.name] = $item.code
                }
            }
            catch {
                Write-Warning "Could not run Get-ColorPallete. Ensure the function is loaded."
                return
            }

            # 2. Define ANSI Constants
            $ESC = [char]27
            $Reset = "$ESC[0m"

            # Helper function to get ANSI code string
            function Get-AnsiColor {
                param ($Name, $IsBackground = $false)
                
                # Default to White(15) or Black(0) if name not found
                $code = if ($PaletteMap.ContainsKey($Name)) { $PaletteMap[$Name] } else { 15 }
                
                if ($IsBackground) {
                    return "$ESC[48;5;${code}m"
                } else {
                    return "$ESC[38;5;${code}m"
                }
            }

            # 3. Render the Badges
            foreach ($theme in $color_sets) {
                
                # --- Prepare Color Codes ---
                $LogoFG   = Get-AnsiColor -Name $theme.LogoColor    -IsBackground $false
                $LogoBG   = Get-AnsiColor -Name "black"             -IsBackground $true
                
                $LabelFG  = Get-AnsiColor -Name "white"             -IsBackground $false
                $LabelBG  = Get-AnsiColor -Name $theme.LabelColor   -IsBackground $true
                
                $MsgFG    = Get-AnsiColor -Name $theme.LabelColor   -IsBackground $false # Text matches label bg
                $MsgBG    = Get-AnsiColor -Name $theme.MessageColor -IsBackground $true

                # --- Build the Strings ---
                
                # Part 1: Logo ( Black Background, Theme Logo Color )
                $PartLogo = "$LogoBG$LogoFG ● $Reset"
                
                # Part 2: Label ( Theme Label Background, White Text )
                # Padding the string to 20 chars for alignment
                $LabelText = " " + $theme.ColorSet.PadRight(20) + " "
                $PartLabel = "$LabelBG$LabelFG$LabelText$Reset"
                
                # Part 3: Message ( Theme Message Background, Text is the Label Color )
                $PartMsg   = "$MsgBG$MsgFG STATUS OK $Reset"

                # --- Output Line ---
                Write-Host "Previewing: " -NoNewline
                # Combine parts without spaces (ANSI codes handle the separation)
                Write-Host "$PartLogo$PartLabel$PartMsg"
            }
        } else {
            $badges = $null
            switch ($set) {
                'jsm' { 
                    $badges = @(
                        @{ Platform = 'gitlab'; BadgeType = 'license'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'pipeline'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'issues'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'npm'; BadgeType = 'version'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'jsr'; BadgeType = 'version'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'jsdelivr'; BadgeType = 'hitsperweek'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'npm'; BadgeType = 'version'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }, # for umpkg rename link and left shield should the same
                        @{ Platform = 'npm'; BadgeType = 'sizeMin'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }, # for umpkg rename link and left shield should the same            
                        @{ Platform = 'npm'; BadgeType = 'sizeZipped'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat } # for umpkg rename link and left shield should the same            
                    )
                }
                'psm' {
                    $badges = @(
                        @{ Platform = 'gitlab'; BadgeType = 'license'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'pipeline'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'issues'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'contributors'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'powershell'; BadgeType = 'version'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'choco'; BadgeType = 'version'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'codecov'; BadgeType = 'coverage'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }
                    )
                }
                'ruby' {
                    return 'Ruby Project Shields not yet implemented';
                }
                'jekyll-theme' {
                    return 'jekyll-theme Project Shields not yet implemented';
                }
                'custom' {
                    # The Simple Generic Bages 
                    return 'custom Shields not yet implemented';

                }
                default {
                    if(!$platform -or !$BadgeType) {
                        return 'No Platform or BadgeType specified';
                    }
                    $badges = @(
                        # default will hangle single badge types using defineBadgeSet
                        @{ Platform = $platform; BadgeType = $BadgeType; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }
                    )
                }
            }


            # Output complete badge set
            [string]$badge_string = ''

            foreach ($badge in $badges) {
                write-host "New-ShieldBadge $($badge.Platform) | $($badge.BadgeType) | $($badge.Project) | $($badge.LabelColor) | $($badge.MessageColor) | $($badge.Namespace) | $($badge.Style) | $($badge.LogoColor)"
                $badge_string += "$(New-ShieldBadge @badge) "
            }
        
            return $badge_string;
        }
    }
}
