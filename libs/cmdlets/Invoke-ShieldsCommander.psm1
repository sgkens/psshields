# include dependencies
using module ..\New-ColorConsole.psm1
using module ..\Write-AsciiTable.psm1

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
    .PARAMETER Colorset
        The color scheme for the badge. Valid options include various predefined color sets.
    .PARAMETER Colorsets
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
    .PARAMETER GroupName
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
        [string]$reponame,

        [parameter(Mandatory=$false)]
        [string]$Namespace, 

        [parameter(Mandatory=$false)]
        [validateSet('jsm', 'psm', 'docker', 'nuget', 'custom')]
        [string]$set,
        # if single we need to hangle it by adding in addtional params that are not manditory
        # add checks in begin to check for param presence if not then return exception or just return
        # we need: platform and BadgeType
        # Not expanding this function to allow single bagdye generation to make use of the rest of the function 
        # as the colors and previews are good feature

        [parameter(Mandatory=$false)]
        [ValidateSet('gitlab', 'github', 'codecov', 'coveralls', 'docker', 'npm', 'powershell', 'choco', 'dotnet',
                     'packagist', 'composer', 'pypi', 'rubygems', 'crates', 'pub', 'hex', 'cpan', 'maven', 
                     'gradle', 'cargo', 'go', 'conda', 'homebrew', 'aur', 'snap', 'jsdelivr', 'status', 'license')]
        [string]$platform, 

        [parameter(Mandatory=$false)]
        [ValidateSet('stars', 'forks', 'pipeline', 'version', 'downloads', 'issues', 'license', 
                     'build', 'coverage', 'maintained', 'dependencies', 'security', 'quality', 
                     'rating', 'docs', 'tests', 'release', 'issues', 'prs', 'contributors', 'size', 
                     'platform','workflow', 'gitlab', 'installs', 'hitsperday', 'hitsperweek', 'hitspermonth', 'hitsperyear',
                     'sizeMin', 'sizeZipped', 'likes', 'points'
                    )]
        [string]$BadgeType,

        [parameter(Mandatory=$false)]
        [validateSet('flat', 'flat-square', 'social', 'for-the-badge')]
        [string]$style,
        
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
        [string]$colorset,

        [parameter(Mandatory=$false)]
        [switch]$colorsets,
        
        [parameter(Mandatory=$false)]
        [switch]$preview, 

        [parameter(Mandatory=$false)]
        [switch]$ViewBadgeTypes,

        [parameter(Mandatory=$false)]
        [switch]$ViewBadgePallete,

        [parameter(Mandatory=$false)]
        [ValidateSet('standard', 'bright', 'extended_216', 'grayscale')]
        [string]$GroupName,

        [parameter(Mandatory=$false)]
        [switch]$ShowCodes,

        [parameter(Mandatory=$false)]
        [switch]$Compact,

        [parameter(Mandatory=$false)]
        [switch]$ViewRawColorPallete
    )

    begin {

        # Sanity checks and defaults
        if(!$reponame){ $reponame = (Get-Location).Path.Split('\')[-1] }
        if(!$style){ $style = 'flat-square' }
        if(!$OutputFormat){ $OutputFormat = 'markdown' }
        if(!$colorset){$colorset = 'azure-tech' }

        # --- DEFINE THE COLORSET ARRAY HERE ----
        # ---------------------------------------
        $color_sets = @(
            # --- GROUP: MODERN TECH & CYBER ---
            @{LabelColor = 'magenta3'; MessageColor = 'cyan1'; LogoColor = 'white'; ColorSet = 'cyberpunk' }
            @{LabelColor = 'purple4'; MessageColor = 'springgreen1'; LogoColor = 'fuchsia'; ColorSet = 'neon-nights' }
            @{LabelColor = 'darkblue'; MessageColor = 'dodgerblue1'; LogoColor = 'cyan1'; ColorSet = 'azure-tech' }
            @{LabelColor = 'grey3'; MessageColor = 'green1'; LogoColor = 'lime'; ColorSet = 'matrix-console' }
            @{LabelColor = 'deeppink4'; MessageColor = 'hotpink'; LogoColor = 'aquamarine1'; ColorSet = 'synthwave' }
            @{LabelColor = 'navyblue'; MessageColor = 'gold1'; LogoColor = 'yellow1'; ColorSet = 'royal-tech' }

            # --- GROUP: PROFESSIONAL & CORPORATE ---
            @{LabelColor = 'steelblue3'; MessageColor = 'white'; LogoColor = 'white'; ColorSet = 'professional-blue' }
            @{LabelColor = 'darkslategray3'; MessageColor = 'black'; LogoColor = 'cyan2'; ColorSet = 'slate-clean' }
            @{LabelColor = 'navy'; MessageColor = 'grey85'; LogoColor = 'dodgerblue1'; ColorSet = 'corporate-dark' }
            @{LabelColor = 'indigo'; MessageColor = 'lavender'; LogoColor = 'plum1'; ColorSet = 'executive' }
            @{LabelColor = 'darkcyan'; MessageColor = 'aquamarine1'; LogoColor = 'white'; ColorSet = 'teal-accent' }
            @{LabelColor = 'royalblue1'; MessageColor = 'white'; LogoColor = 'gold1'; ColorSet = 'trust-blue' }

            # --- GROUP: HEAT & WARNING ---
            @{LabelColor = 'maroon'; MessageColor = 'orange1'; LogoColor = 'yellow1'; ColorSet = 'magma' }
            @{LabelColor = 'orangered1'; MessageColor = 'yellow1'; LogoColor = 'white'; ColorSet = 'sunset-glow' }
            @{LabelColor = 'darkred'; MessageColor = 'white'; LogoColor = 'red1'; ColorSet = 'critical-alert' }
            @{LabelColor = 'darkorange3'; MessageColor = 'navajowhite1'; LogoColor = 'gold1'; ColorSet = 'amber-lamps' }
            @{LabelColor = 'crimson'; MessageColor = 'mistyrose1'; LogoColor = 'white'; ColorSet = 'cherry-blossom' }
            @{LabelColor = 'darkgoldenrod'; MessageColor = 'gold1'; LogoColor = 'yellow1'; ColorSet = 'midas-gold' }

            # --- GROUP: NATURE & EARTH ---
            @{LabelColor = 'darkgreen'; MessageColor = 'springgreen2'; LogoColor = 'green1'; ColorSet = 'forest-guard' }
            @{LabelColor = 'darkolivegreen'; MessageColor = 'khaki1'; LogoColor = 'yellow1'; ColorSet = 'camouflage' }
            @{LabelColor = 'seagreen3'; MessageColor = 'white'; LogoColor = 'springgreen1'; ColorSet = 'ocean-foam' }
            @{LabelColor = 'saddlebrown'; MessageColor = 'tan'; LogoColor = 'gold1'; ColorSet = 'earth-tone' }
            @{LabelColor = 'darkslategray2'; MessageColor = 'darkcyan'; LogoColor = 'cyan1'; ColorSet = 'glacier-ice' }
            @{LabelColor = 'chartreuse4'; MessageColor = 'greenyellow'; LogoColor = 'white'; ColorSet = 'toxic-waste' }

            # --- GROUP: DARK, METAL & MONOCHROME ---
            @{LabelColor = 'grey7'; MessageColor = 'grey89'; LogoColor = 'red1'; ColorSet = 'monolith' }
            @{LabelColor = 'black'; MessageColor = 'white'; LogoColor = 'white'; ColorSet = 'noir' }
            @{LabelColor = 'grey23'; MessageColor = 'silver'; LogoColor = 'cyan1'; ColorSet = 'brushed-metal' }
            @{LabelColor = 'grey15'; MessageColor = 'maroon'; LogoColor = 'red1'; ColorSet = 'carbon-maroon' }
            @{LabelColor = 'grey11'; MessageColor = 'dodgerblue2'; LogoColor = 'deepskyblue1'; ColorSet = 'stealth-bomber' }
            @{LabelColor = 'grey30'; MessageColor = 'grey100'; LogoColor = 'green1'; ColorSet = 'typewriter' }

            # --- GROUP: VINTAGE & RETRO ---
            @{LabelColor = 'navajowhite3'; MessageColor = 'saddlebrown'; LogoColor = 'maroon'; ColorSet = 'old-paper' }
            @{LabelColor = 'darkkhaki'; MessageColor = 'cornsilk1'; LogoColor = 'gold1'; ColorSet = 'military-issue' }
            @{LabelColor = 'rosybrown'; MessageColor = 'mistyrose1'; LogoColor = 'white'; ColorSet = 'dusty-rose' }
            @{LabelColor = 'tan'; MessageColor = 'black'; LogoColor = 'darkorange'; ColorSet = 'leather-bound' }
            @{LabelColor = 'cadetblue'; MessageColor = 'aliceblue'; LogoColor = 'white'; ColorSet = 'faded-denim' }
            @{LabelColor = 'indianred'; MessageColor = 'white'; LogoColor = 'gold1'; ColorSet = 'brick-house' }

            # --- GROUP: HIGH VISIBILITY & ALERT ---
            @{LabelColor = 'yellow1'; MessageColor = 'black'; LogoColor = 'red1'; ColorSet = 'construction' }
            @{LabelColor = 'chartreuse1'; MessageColor = 'black'; LogoColor = 'magenta1'; ColorSet = 'bio-hazard' }
            @{LabelColor = 'orange1'; MessageColor = 'black'; LogoColor = 'white'; ColorSet = 'safety-cone' }
            @{LabelColor = 'cyan1'; MessageColor = 'black'; LogoColor = 'magenta1'; ColorSet = 'high-contrast' }
            @{LabelColor = 'magenta1'; MessageColor = 'white'; LogoColor = 'yellow1'; ColorSet = 'glitch-pop' }
            @{LabelColor = 'white'; MessageColor = 'red1'; LogoColor = 'black'; ColorSet = 'medical-alert' }

            # --- GROUP: DEEP SPACE & SCIFI ---
            @{LabelColor = 'midnightblue'; MessageColor = 'plum1'; LogoColor = 'cyan1'; ColorSet = 'nebula-core' } 
            @{LabelColor = 'black'; MessageColor = 'darkviolet'; LogoColor = 'fuchsia'; ColorSet = 'void-walker' }
            @{LabelColor = 'darkslateblue'; MessageColor = 'lightcyan1'; LogoColor = 'springgreen1'; ColorSet = 'alien-tech' }
            @{LabelColor = 'indigo'; MessageColor = 'gold1'; LogoColor = 'orange1'; ColorSet = 'solar-flare' }
            @{LabelColor = 'grey11'; MessageColor = 'deepskyblue3'; LogoColor = 'white'; ColorSet = 'moon-base' }
            @{LabelColor = 'darkmagenta'; MessageColor = 'violet'; LogoColor = 'cyan1'; ColorSet = 'hyper-drive' }

            # --- GROUP: SOFT & PASTEL ---
            @{LabelColor = 'lightpink1'; MessageColor = 'deeppink4'; LogoColor = 'white'; ColorSet = 'cotton-candy' }
            @{LabelColor = 'lightskyblue1'; MessageColor = 'navy'; LogoColor = 'dodgerblue1'; ColorSet = 'baby-blue' }
            @{LabelColor = 'palegreen1'; MessageColor = 'darkgreen'; LogoColor = 'green1'; ColorSet = 'mint-fresh' }
            @{LabelColor = 'wheat1'; MessageColor = 'saddlebrown'; LogoColor = 'orange3'; ColorSet = 'vanilla-cream' }
            @{LabelColor = 'lavender'; MessageColor = 'purple4'; LogoColor = 'mediumorchid1'; ColorSet = 'lilac-dream' }
            @{LabelColor = 'peachpuff'; MessageColor = 'red4'; LogoColor = 'coral'; ColorSet = 'peach-fuzz' }

            # --- GROUP: ELEMENTAL & GEMSTONE ---
            @{LabelColor = 'turquoise4'; MessageColor = 'turquoise2'; LogoColor = 'white'; ColorSet = 'emerald-city' }
            @{LabelColor = 'darkred'; MessageColor = 'red1'; LogoColor = 'gold1'; ColorSet = 'ruby-red' }
            @{LabelColor = 'darkblue'; MessageColor = 'cyan1'; LogoColor = 'white'; ColorSet = 'sapphire-night' }
            @{LabelColor = 'purple4'; MessageColor = 'mediumorchid1'; LogoColor = 'white'; ColorSet = 'amethyst-glow' }
            @{LabelColor = 'grey50'; MessageColor = 'white'; LogoColor = 'cyan1'; ColorSet = 'diamond-cut' }
            @{LabelColor = 'darkorange3'; MessageColor = 'yellow1'; LogoColor = 'white'; ColorSet = 'topaz-fire' }
        )

        # Select the color set or use default
        $selected_color_set = $color_sets | Where-Object { $_.ColorSet -eq $colorset }
        if ($selected_color_set) {
            $LabelColor = $selected_color_set.LabelColor
            $MessageColor = $selected_color_set.MessageColor
            $LogoColor = $selected_color_set.LogoColor
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

        if ($ViewBadgePallete) {
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
            Get-ColorPallete
            return
        }

        # if($colorsets){ 
        #     $color_sets | select-Object colorset, logocolor, Labelcolor, MessageColor
        #     return;    
        # }

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
            
            switch ($set) {
                'jsm' { 
                    $badges = @(
                        @{ Platform = 'gitlab'; BadgeType = 'license'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'pipeline'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'issues'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
                        @{ Platform = 'gitlab'; BadgeType = 'contributors'; Project = $reponame; LabelColor = $LabelColor; MessageColor = $MessageColor; Namespace = $Namespace; Style = $style; LogoColor = $LogoColor; OutputFormat = $OutputFormat },
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
