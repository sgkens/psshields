# include dependencies
using module ..\libs\New-ColorConsole.psm1
using module ..\libs\Write-AsciiTable.psm1
using module .\Get-DefinedColorSets.psm1
using module ..\libs\argumentcompleters.psm1
using module ..\libs\auspex.psm1

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
            "cyberpunk",
            "neon-nights",
            "azure-tech",
            "matrix-console",
            "synthwave",
            "royal-tech",
            "professional-blue",
            "slate-clean",
            "corporate-dark",
            "executive",
            "teal-accent",
            "trust-blue",
            "magma",
            "sunset-glow",
            "critical-alert",
            "amber-lamps",
            "cherry-blossom",
            "midas-gold",
            "forest-guard",
            "camouflage",
            "ocean-foam",
            "earth-tone",
            "glacier-ice",
            "toxic-waste",
            "monolith",
            "noir",
            "brushed-metal",
            "carbon-maroon",
            "stealth-bomber",
            "typewriter",
            "old-paper",
            "military-issue",
            "dusty-rose",
            "leather-bound",
            "faded-denim",
            "brick-house",
            "construction",
            "bio-hazard",
            "safety-cone",
            "high-contrast",
            "glitch-pop",
            "medical-alert",
            "nebula-core",
            "void-walker",
            "alien-tech",
            "solar-flare",
            "moon-base",
            "hyper-drive",
            "cotton-candy",
            "baby-blue",
            "mint-fresh",
            "vanilla-cream",
            "lilac-dream",
            "peach-fuzz",
            "emerald-city",
            "ruby-red",
            "sapphire-night",
            "amethyst-glow",
            "diamond-cut",
            "topaz-fire",
            "mainframe",
            "deep-web",
            "blood-code",
            "terminal-green",
            "lux-dark",
            "arctic-base",
            "deep-glacier",
            "snow-storm",
            "permafrost",
            "dust-bowl",
            "safari-tech",
            "canyon-rock",
            "desert-sun",
            "grape-soda",
            "electric-lime",
            "bubblegum",
            "blue-razz",
            "hazard-zone",
            "caution-tape",
            "factory-floor",
            "blue-collar",
            "obsidian",
            "phantom",
            "deep-sea-dark",
            "night-shade",
            "blood-moon",
            "matrix-deep",
            "mono-blue",
            "mono-green",
            "mono-orange",
            "mono-red",
            "mono-purple",
            "mono-grey",
            "ghost-writer",
            "under-the-radar",
            "industrial-stealth"
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
        # define $nulls
        $color_sets = $null
        $defined_sets = $null
        $color_pallete = $null
        # ---------------------------------------
        $color_sets = Get-DefinedColorSets
        $color_pallete = Get-ColorPallete
        $defined_sets = Get-DefinedSets

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
                    foreach ($badge in (auspex $defined_sets read "jsm.badges")) {

                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].project" $reponame
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].labelcolor" $LabelColor 
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].messagecolor" $MessageColor 
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].namespace" $Namespace 
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].style" $style 
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].logocolor" $LogoColor 
                        auspex $defined_sets create "jsm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].outputformat" $OutputFormat 
                    }
                    $badges = $defined_sets.jsm.badges
                }
                'psm' {
                    foreach ($badge in (auspex $defined_sets read "psm.badges")) {
                        $platform = auspex $defined_sets read "psm.badges[badgetype=$badge_type].platform"
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].project" $reponame
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].labelcolor" $LabelColor 
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].messagecolor" $MessageColor 
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].namespace" $Namespace 
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].style" $style 
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].logocolor" $LogoColor 
                        auspex $defined_sets create "psm.badges[badgetype=$($badge.BadgeType)&platform=$($badge.platform)].outputformat" $OutputFormat    
                    }
                    $badges = $defined_sets.psm.badges
                }
                'ruby' {
                    $all_scoped_badges = auspex $defined_sets read "ruby.badges[badgetype].BadgeType"
                    foreach ($badge_type in $all_scoped_badges) {
                        $platform = auspex $defined_sets read "ruby.badges[badgetype=$badge_type].platform"
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].project $reponame
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].labelcolor $LabelColor 
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].messagecolor $MessageColor 
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].namespace $Namespace 
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].style $style 
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].logocolor $LogoColor 
                        auspex $defined_sets create ruby.badges[badgetype=$badge_type].outputformat $OutputFormat    
                    }
                    $badges = $defined_sets.ruby.badges
                }
                'jekyll' {
                    $all_scoped_badges = auspex $defined_sets read "jekyll.badges[badgetype].BadgeType"
                    foreach ($badge_type in $all_scoped_badges) {
                        $platform = auspex $defined_sets read "jekyll.badges[badgetype=$badge_type].platform"
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].project $reponame
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].labelcolor $LabelColor 
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].messagecolor $MessageColor 
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].namespace $Namespace 
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].style $style 
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].logocolor $LogoColor 
                        auspex $defined_sets create jekyll.badges[badgetype=$badge_type].outputformat $OutputFormat    
                    }
                    $badges = $defined_sets.psm.badges
                }
                'custom' {
                    # Switch to custom badge intead of sets
                        @{ Platform = $platform; BadgeType = $BadgeType; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }

                    $badges = @(
                        @{ Platform = $platform; BadgeType = $BadgeType; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat }
                    )
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
                if($BadgeType -eq 'custom') {
                    write-host "Generating Custom Badge for $($badge.BadgeType) -> $($badge.Platform)"
                    $badge_string += "$(New-CustomBadge @badge) "
                }else{
                    write-host "Generating Set for $($badge.BadgeType) -> $($badge.Platform)"
                    $badge_string += New-ShieldBadge -platform $badge.Platform `
                                                     -BadgeType $badge.BadgeType `
                                                     -Project $badge.Project `
                                                     -LabelColor $badge.LabelColor `
                                                     -MessageColor $badge.MessageColor `
                                                     -Namespace $badge.Namespace `
                                                     -Style $badge.Style `
                                                     -LogoColor $badge.LogoColor `
                                                     -OutputFormat $badge.OutputFormat
                    $badge_string += ' '
                }
            }
        
            # return the final badge string
            return $badge_string;
        }ee
    }
}
