function New-ShieldBadge {
    <#
    .SYNOPSIS
        Generates Shield.io badge URLs for common development platforms
    
    .DESCRIPTION
        Creates formatted Shield.io badge markdown/URLs for GitLab, GitHub, Codecov, 
        Coveralls, Docker, NPM, PowerShell Gallery, Chocolatey, and .NET packages
    
    .PARAMETER Platform
        The platform type (gitlab, github, codecov, coveralls, docker, npm, powershell, choco, dotnet)
    
    .PARAMETER Namespace
        The user/organization namespace (e.g., 'username' or 'org/repo')
    
    .PARAMETER Project
        The project/package name (required for some platforms)
    
    .PARAMETER BadgeType
        The type of badge to generate (e.g., stars, forks, pipeline, version, downloads).
        If not specified, uses the default badge type for the platform
    
    .PARAMETER LabelColor
        Background color for the label (left side). Accepts hex (without #) or color names
    
    .PARAMETER MessageColor
        Background color for the message (right side). Accepts hex (without #) or color names
    
    .PARAMETER LogoColor
        Color for the logo. Accepts hex (without #) or color names
    
    .PARAMETER Logo
        Logo name from SimpleIcons (default: platform-specific)
    
    .PARAMETER Style
        Badge style: flat, flat-square, plastic, for-the-badge, social (default: flat)
    
    .PARAMETER OutputFormat
        Output format: markdown, url, html (default: markdown)
    
    .EXAMPLE
        New-ShieldBadge -Platform github -Namespace "octocat/hello-world" -LabelColor "555" -MessageColor "blue"
        
    .EXAMPLE
        New-ShieldBadge -Platform npm -Project "@scope/package" -Style "flat-square" -OutputFormat url
        
    .EXAMPLE
        New-ShieldBadge -Platform docker -Namespace "library/nginx" -MessageColor "2496ED" -LogoColor "white"
        
    .EXAMPLE
        New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "stars"
        
    .EXAMPLE
        New-ShieldBadge -Platform github -Namespace "user/repo" -BadgeType "forks"
        
    .EXAMPLE
        New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "pipeline"
    #>
    
    [CmdletBinding()]
    [outputType([string])]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('gitlab', 'github', 'codecov', 'coveralls', 'docker', 'npm', 'powershell', 'choco', 'dotnet',
                     'packagist', 'composer', 'pypi', 'rubygems', 'crates', 'pub', 'hex', 'cpan', 'maven', 
                     'gradle', 'cargo', 'go', 'conda', 'homebrew', 'aur', 'snap', 'jsdelivr', 'jsr'
                     )]
        [string]$Platform,
        
        [Parameter(Mandatory=$true)]
        [string]$Namespace,
        
        [Parameter(Mandatory=$false)]
        [string]$Project,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('stars', 'forks', 'pipeline', 'version', 'downloads', 'issues', 'license', 
                     'build', 'coverage', 'maintained', 'dependencies', 'security', 'quality', 
                     'rating', 'docs', 'tests', 'release', 'issues', 'prs', 'contributors', 'size', 
                     'platform','workflow', 'gitlab', 'installs', 'hitsperday', 'hitsperweek', 'hitspermonth', 'hitsperyear',
                     'sizeMin', 'sizeZipped', 'likes', 'points'
                    )]
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
        
        [Parameter(Mandatory=$false)]
        [string]$Logo,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('flat', 'flat-square', 'plastic', 'for-the-badge', 'social')]
        [string]$Style = 'flat',
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('markdown', 'url', 'html')]
        [string]$OutputFormat = 'markdown'
    )
    
    $platformConfig = Get-PlatformConfig

    # Platform-specific badge configurations
    # $platformConfig = @{
    #     github = @{
    #         baseUrl = 'https://img.shields.io/github'
    #         badges = @{
    #             stars = '/stars/{namespace}'
    #             forks = '/forks/{namespace}'
    #             issues = '/issues/{namespace}'
    #             license = '/license/{namespace}'
    #             release = '/v/release/{namespace}'
    #             workflow = '/actions/workflow/status/{namespace}/{workflow}'
    #         }
    #         defaultLogo = 'github'
    #     }
    #     gitlab = @{
    #         baseUrl = 'https://img.shields.io/gitlab'
    #         badges = @{
    #             stars = '/stars/{namespace}'
    #             forks = '/forks/{namespace}'
    #             issues = '/issues/open/{namespace}'
    #             license = '/license/{namespace}'
    #             pipeline = '/pipeline-status/{namespace}'
    #             coverage = '/pipeline-coverage/{namespace}'
    #         }
    #         defaultLogo = 'gitlab'
    #     }
    #     codecov = @{
    #         baseUrl = 'https://img.shields.io/codecov/c'
    #         badges = @{
    #             coverage = '/github/{namespace}'
    #             gitlab = '/gitlab/{namespace}'
    #         }
    #         defaultLogo = 'codecov'
    #     }
    #     coveralls = @{
    #         baseUrl = 'https://img.shields.io/coveralls'
    #         badges = @{
    #             coverage = '/github/{namespace}'
    #             gitlab = '/gitlab/{namespace}'
    #         }
    #         defaultLogo = 'coveralls'
    #     }
    #     docker = @{
    #         baseUrl = 'https://img.shields.io/docker'
    #         badges = @{
    #             pulls = '/pulls/{namespace}'
    #             stars = '/stars/{namespace}'
    #             size = '/image-size/{namespace}'
    #             version = '/v/{namespace}'
    #         }
    #         defaultLogo = 'docker'
    #     }
    #     npm = @{
    #         baseUrl = 'https://img.shields.io'
    #         badges = @{
    #             version = '/npm/v/{package}'
    #             downloads = '/npm/dt/{package}'
    #             license = '/npm/l/{package}'
    #             sizeMin = '/bundlephobia/min/{package}'
    #             sizeZipped = '/bundlephobia/minzip/{package}'
    #         }
    #         defaultLogo = 'npm'
    #     }
    #     powershell = @{
    #         baseUrl = 'https://img.shields.io/powershellgallery'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             platform = '/p/{package}'
    #         }
    #         defaultLogo = 'powershell'
    #     }
    #     choco = @{
    #         baseUrl = 'https://img.shields.io/chocolatey'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #         defaultLogo = 'chocolatey'
    #     }
    #     dotnet = @{
    #         baseUrl = 'https://img.shields.io/nuget'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #         defaultLogo = 'nuget'
    #     }
    #     packagist = @{
    #         baseUrl = 'https://img.shields.io/packagist'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #             php = '/php-v/{package}'
    #         }
    #         defaultLogo = 'packagist'
    #     }
    #     composer = @{
    #         baseUrl = 'https://img.shields.io/packagist'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #         }
    #         defaultLogo = 'composer'
    #     }
    #     pypi = @{
    #         baseUrl = 'https://img.shields.io/pypi'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dm/{package}'
    #             license = '/l/{package}'
    #             python = '/pyversions/{package}'
    #             status = '/status/{package}'
    #         }
    #         defaultLogo = 'pypi'
    #     }
    #     rubygems = @{
    #         baseUrl = 'https://img.shields.io/gem'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #         }
    #         defaultLogo = 'rubygems'
    #     }
    #     crates = @{
    #         baseUrl = 'https://img.shields.io/crates'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/d/{package}'
    #             license = '/l/{package}'
    #         }
    #         defaultLogo = 'rust'
    #     }
    #     pub = @{
    #         baseUrl = 'https://img.shields.io/pub'
    #         badges = @{
    #             version = '/v/{package}'
    #             likes = '/likes/{package}'
    #             points = '/points/{package}'
    #         }
    #         defaultLogo = 'dart'
    #     }
    #     hex = @{
    #         baseUrl = 'https://img.shields.io/hexpm'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/dt/{package}'
    #             license = '/l/{package}'
    #         }
    #         defaultLogo = 'elixir'
    #     }
    #     cpan = @{
    #         baseUrl = 'https://img.shields.io/cpan'
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #         defaultLogo = 'perl'
    #     }
    #     maven = @{
    #         baseUrl = 'https://img.shields.io/maven-central'
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #         defaultLogo = 'apachemaven'
    #     }
    #     gradle = @{
    #         baseUrl = 'https://img.shields.io/maven-central'
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #         defaultLogo = 'gradle'
    #     }
    #     cargo = @{
    #         baseUrl = 'https://img.shields.io/crates'
    #         badges = @{
    #             version = '/v/{package}'
    #             downloads = '/d/{package}'
    #         }
    #         defaultLogo = 'rust'
    #     }
    #     go = @{
    #         baseUrl = 'https://img.shields.io/github'
    #         badges = @{
    #             version = '/go-mod/go-version/{namespace}'
    #         }
    #         defaultLogo = 'go'
    #     }
    #     conda = @{
    #         baseUrl = 'https://img.shields.io/conda'
    #         badges = @{
    #             version = '/v/{namespace}/{package}'
    #             downloads = '/dn/{namespace}/{package}'
    #             platform = '/pn/{namespace}/{package}'
    #         }
    #         defaultLogo = 'anaconda'
    #     }
    #     homebrew = @{
    #         baseUrl = 'https://img.shields.io/homebrew'
    #         badges = @{
    #             version = '/v/{package}'
    #             installs = '/installs/dm/{package}'
    #         }
    #         defaultLogo = 'homebrew'
    #     }
    #     aur = @{
    #         baseUrl = 'https://img.shields.io/aur'
    #         badges = @{
    #             version = '/version/{package}'
    #             votes = '/votes/{package}'
    #         }
    #         defaultLogo = 'archlinux'
    #     }
    #     snap = @{
    #         baseUrl = 'https://img.shields.io/snapcraft'
    #         badges = @{
    #             version = '/v/{package}'
    #         }
    #         defaultLogo = 'snapcraft'
    #     }
    #     jsdelivr   = @{
    #         baseUrl = 'https://img.shields.io/jsdelivr'
    #         badges = @{
    #             hitsperday   = '/npm/hd/{package}'
    #             hitsperweek  = '/npm/hw/{package}'
    #             hitspermonth = '/npm/hm/{package}'
    #             hitsperyear  = '/npm/hy/{package}'
    #         }
    #         defaultLogo = 'jsdelivr'
    #     }
    #     jsr = @{
    #         baseUrl = 'https://img.shields.io/jsr'
    #         badges = @{
    #             version = '/v/%40{namespace}'
    #         }
    #         defaultLogo = 'jsr'
    #     }
    # }
    
    # Get platform configuration
    $config = $platformConfig[$Platform]
    if (-not $config) {
        Write-Error "Platform '$Platform' not found"
        return
    }
    # check if badge type is valid for platform
    if ($BadgeType -and -not $config.badges.ContainsKey($BadgeType)) {
        $availableTypes = $config.badges.Keys -join ', '
        Write-Error "Badge type '$BadgeType' not available for platform '$Platform'. Available types: $availableTypes"
        return
    }
    
    # Determine which badge type to use
    if ($BadgeType) {
        # Validate that the badge type exists for this platform
        if (-not $config.badges.ContainsKey($BadgeType)) {
            $availableTypes = $config.badges.Keys -join ', '
            Write-Error "Badge type '$BadgeType' not available for platform '$Platform'. Available types: $availableTypes"
            return
        }
        $selectedBadgeType = $BadgeType
    } else {
        # Use default badge type based on platform
        $selectedBadgeType = switch ($Platform) {
            'github' { 'stars' }
            'gitlab' { 'pipeline' }
            'codecov' { 'coverage' }
            'coveralls' { 'coverage' }
            'docker' { 'pulls' }
            'npm' { 'version' }
            'powershell' { 'version' }
            'choco' { 'version' }
            'dotnet' { 'version' }
            'packagist' { 'version' }
            'composer' { 'version' }
            'pypi' { 'version' }
            'rubygems' { 'version' }
            'crates' { 'version' }
            'pub' { 'version' }
            'hex' { 'version' }
            'cpan' { 'version' }
            'maven' { 'version' }
            'gradle' { 'version' }
            'cargo' { 'version' }
            'go' { 'version' }
            'conda' { 'version' }
            'homebrew' { 'version' }
            'aur' { 'version' }
            'snap' { 'version' }
            'jsdelivr' { 'hitsperweek' }
            'jsr' { 'version' }
        }
    }
    
    # Build the badge URL
    $badgeTemplate = $config.badges[$selectedBadgeType]
    $badgeUrl = $config.baseUrl + $badgeTemplate
    
    # Replace placeholders
    if ($Project) {
        if($namespace){
            $badgeUrl = $badgeUrl -replace '\{package\}', "@$Namespace/$Project"
        }else{
            $badgeUrl = $badgeUrl -replace '\{package\}', $Project
        }
        $badgeUrl = $badgeUrl -replace '\{namespace\}', "$Namespace/$Project"
        # For conda which uses namespace/package format differently
        if ($Platform -eq 'conda') {
            $badgeUrl = $badgeUrl -replace '\{namespace\}/\{package\}', "$Namespace/$Project"
        }
    } else {
        $badgeUrl = $badgeUrl -replace '\{namespace\}', $Namespace
        $badgeUrl = $badgeUrl -replace '\{package\}', $Namespace
    }
    
    # Add query parameters
    $params = @()
    
    if ($Style) {
        $params += "style=$Style"
    }
    
    if ($Logo) {
        $params += "logo=$Logo"
    } elseif ($config.defaultLogo) {
        $params += "logo=$($config.defaultLogo)"
    }
    
    if ($LabelColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $LabelColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $LabelColor }
        $params += "labelColor=$colorValue"
    }
    
    if ($MessageColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $MessageColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $MessageColor }
        $params += "color=$colorValue"
    }
    
    if ($LogoColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $LogoColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $LogoColor }
        $params += "logoColor=$colorValue"
    }
    
    if ($params.Count -gt 0) {
        $badgeUrl += "?" + ($params -join "&")
    }
    
    # Format output
    switch ($OutputFormat) {
        'markdown' {
            $linkUrl = switch ($Platform) {
                'github' { "https://github.com/$Namespace" }
                'gitlab' { "https://gitlab.com/$Namespace" }
                'docker' { "https://hub.docker.com/r/$Namespace" }
                'npm' { "https://www.npmjs.com/package/$($Project ?? $Namespace)" }
                'powershell' { "https://www.powershellgallery.com/packages/$($Project ?? $Namespace)" }
                'choco' { "https://community.chocolatey.org/packages/$($Project ?? $Namespace)" }
                'dotnet' { "https://www.nuget.org/packages/$($Project ?? $Namespace)" }
                'packagist' { "https://packagist.org/packages/$($Project ?? $Namespace)" }
                'composer' { "https://packagist.org/packages/$($Project ?? $Namespace)" }
                'pypi' { "https://pypi.org/project/$($Project ?? $Namespace)" }
                'rubygems' { "https://rubygems.org/gems/$($Project ?? $Namespace)" }
                'crates' { "https://crates.io/crates/$($Project ?? $Namespace)" }
                'pub' { "https://pub.dev/packages/$($Project ?? $Namespace)" }
                'hex' { "https://hex.pm/packages/$($Project ?? $Namespace)" }
                'cpan' { "https://metacpan.org/pod/$($Project ?? $Namespace)" }
                'maven' { "https://search.maven.org/artifact/$($Project ?? $Namespace)" }
                'gradle' { "https://search.maven.org/artifact/$($Project ?? $Namespace)" }
                'cargo' { "https://crates.io/crates/$($Project ?? $Namespace)" }
                'go' { "https://pkg.go.dev/$Namespace" }
                'conda' { "https://anaconda.org/$Namespace/$Project" }
                'homebrew' { "https://formulae.brew.sh/formula/$($Project ?? $Namespace)" }
                'aur' { "https://aur.archlinux.org/packages/$($Project ?? $Namespace)" }
                'snap' { "https://snapcraft.io/$($Project ?? $Namespace)" }
                'jsdelivr' { "https://cdn.jsdelivr.net/package/npm/$($Project ?? $Namespace)" }
                'jsr' { "https://jsr.io/%40$Namespace/$($Project)" }
                default { $badgeUrl }
            }
            return "[![$Platform-$badgeType]($badgeUrl)]($linkUrl)"
        }
        'html' {
            return "<img src='$badgeUrl' alt='$Platform-$badgeType' />"
        }
        default {
            return $badgeUrl
        }
    }
}

# NOTE!: Invoke-ShieldsCommander is to replace project bages
function New-ProjectBadges {
    <#
    .SYNOPSIS
        Generates a complete set of badges for a project
    
    .EXAMPLE
        New-ProjectBadges -GitHub "username/repo" -NPM "@scope/package"
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$false)]
        [string]$GitHub,
        
        [Parameter(Mandatory=$false)]
        [string]$GitLab,
        
        [Parameter(Mandatory=$false)]
        [string]$Docker,
        
        [Parameter(Mandatory=$false)]
        [string]$NPM,
        
        [Parameter(Mandatory=$false)]
        [string]$PowerShell,
        
        [Parameter(Mandatory=$false)]
        [string]$Chocolatey,
        
        [Parameter(Mandatory=$false)]
        [string]$DotNet,
        
        [Parameter(Mandatory=$false)]
        [string]$Packagist,
        
        [Parameter(Mandatory=$false)]
        [string]$PyPI,
        
        [Parameter(Mandatory=$false)]
        [string]$RubyGems,
        
        [Parameter(Mandatory=$false)]
        [string]$Crates,
        
        [Parameter(Mandatory=$false)]
        [string]$Pub,
        
        [Parameter(Mandatory=$false)]
        [string]$Hex,
        
        [Parameter(Mandatory=$false)]
        [string]$Maven,
        
        [Parameter(Mandatory=$false)]
        [string]$Go,
        
        [Parameter(Mandatory=$false)]
        [string]$Conda,
        
        [Parameter(Mandatory=$false)]
        [string]$Homebrew,

        [Parameter(Mandatory=$false)]
        [string]$jsdelivr,

        [Parameter(Mandatory=$false)]
        [string]$jsr,
        
        [Parameter(Mandatory=$false)]
        [string]$Style = 'flat'
    )
    
    $badges = @()
    
    if ($GitHub) {
        $badges += New-ShieldBadge -Platform github -Namespace $GitHub -Style $Style
    }
    
    if ($GitLab) {
        $badges += New-ShieldBadge -Platform gitlab -Namespace $GitLab -Style $Style
    }
    
    if ($Docker) {
        $badges += New-ShieldBadge -Platform docker -Namespace $Docker -Style $Style
    }
    
    if ($NPM) {
        $badges += New-ShieldBadge -Platform npm -Project $NPM -Style $Style
    }
    
    if ($PowerShell) {
        $badges += New-ShieldBadge -Platform powershell -Project $PowerShell -Style $Style
    }
    
    if ($Chocolatey) {
        $badges += New-ShieldBadge -Platform choco -Project $Chocolatey -Style $Style
    }
    
    if ($DotNet) {
        $badges += New-ShieldBadge -Platform dotnet -Project $DotNet -Style $Style
    }
    
    if ($Packagist) {
        $badges += New-ShieldBadge -Platform packagist -Project $Packagist -Style $Style
    }
    
    if ($PyPI) {
        $badges += New-ShieldBadge -Platform pypi -Project $PyPI -Style $Style
    }
    
    if ($RubyGems) {
        $badges += New-ShieldBadge -Platform rubygems -Project $RubyGems -Style $Style
    }
    
    if ($Crates) {
        $badges += New-ShieldBadge -Platform crates -Project $Crates -Style $Style
    }
    
    if ($Pub) {
        $badges += New-ShieldBadge -Platform pub -Project $Pub -Style $Style
    }
    
    if ($Hex) {
        $badges += New-ShieldBadge -Platform hex -Project $Hex -Style $Style
    }
    
    if ($Maven) {
        $badges += New-ShieldBadge -Platform maven -Project $Maven -Style $Style
    }
    
    if ($Go) {
        $badges += New-ShieldBadge -Platform go -Namespace $Go -Style $Style
    }
    
    if ($Conda) {
        # Conda expects namespace/package format
        $badges += New-ShieldBadge -Platform conda -Namespace $Conda -Style $Style
    }
    
    if ($Homebrew) {
        $badges += New-ShieldBadge -Platform homebrew -Project $Homebrew -Style $Style
    }

    if ($jsdelivr) {
        $badges += New-ShieldBadge -Platform jsdelivr -Project $jsdelivr -Style $Style
    }

    if ($jsr) {
        $badges += New-ShieldBadge -Platform jsr -Namespace $jsr -Style $Style
    }
    
    return $badges -join "`n"
}

function New-CustomBadge {
    <#
    .SYNOPSIS
        Creates a custom Shield.io badge with any label and message
    
    .DESCRIPTION
        Generates a standard Shield.io badge with custom text, colors, and styling.
        Perfect for status badges, version tags, or any custom indicators.
    
    .PARAMETER Label
        The left side text of the badge
    
    .PARAMETER Message
        The right side text/value of the badge
    
    .PARAMETER LabelColor
        Background color for the label (left side). Accepts hex (without #) or color names
    
    .PARAMETER MessageColor
        Background color for the message (right side). Accepts hex (without #) or color names
    
    .PARAMETER Logo
        Logo name from SimpleIcons (optional)
    
    .PARAMETER LogoColor
        Color for the logo. Accepts hex (without #) or color names
    
    .PARAMETER Style
        Badge style: flat, flat-square, plastic, for-the-badge, social (default: flat)
    
    .PARAMETER OutputFormat
        Output format: markdown, url, html (default: markdown)
    
    .PARAMETER Link
        Optional URL to link the badge to (only used in markdown/html output)
    
    .EXAMPLE
        New-CustomBadge -Label "status" -Message "stable" -MessageColor "green"
        
    .EXAMPLE
        New-CustomBadge -Label "build" -Message "passing" -LabelColor "555" -MessageColor "brightgreen" -Logo "github"
        
    .EXAMPLE
        New-CustomBadge -Label "version" -Message "1.0.0" -MessageColor "blue" -Style "flat-square"
        
    .EXAMPLE
        New-CustomBadge -Label "license" -Message "MIT" -MessageColor "orange" -Link "https://opensource.org/licenses/MIT"
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Label,
        
        [Parameter(Mandatory=$true)]
        [string]$Message,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$LabelColor,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$MessageColor,
        
        [Parameter(Mandatory=$false)]
        [string]$Logo,
        
        [Parameter(Mandatory=$false)]
        [ArgumentCompleter([ColorCompleter])]
        [string]$LogoColor,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('flat', 'flat-square', 'plastic', 'for-the-badge', 'social')]
        [string]$Style = 'flat',
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('markdown', 'url', 'html')]
        [string]$OutputFormat = 'markdown',
        
        [Parameter(Mandatory=$false)]
        [string]$Link
    )
    
    # URL encode the label and message
    $encodedLabel = [System.Web.HttpUtility]::UrlEncode($Label)
    $encodedMessage = [System.Web.HttpUtility]::UrlEncode($Message)
    
    # Build the base URL - using static badge format
    $badgeUrl = "https://img.shields.io/badge/$encodedLabel-$encodedMessage"
    
    # Add query parameters
    $params = @()
    
    if ($MessageColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $MessageColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $MessageColor }
        # Message color goes in the URL path for static badges
        $badgeUrl += "-$colorValue"
    }
    
    if ($Style) {
        $params += "style=$Style"
    }
    
    if ($Logo) {
        $params += "logo=$Logo"
    }
    
    if ($LabelColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $LabelColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $LabelColor }
        $params += "labelColor=$colorValue"
    }
    
    if ($LogoColor) {
        # Convert color name to hex if it's a named color
        $colorObj = $script:color_pallete.colorGroups.colors | Where-Object { $_.name -eq $LogoColor } | Select-Object -First 1
        $colorValue = if ($colorObj) { $colorObj.hex -replace '^#', '' } else { $LogoColor }
        $params += "logoColor=$colorValue"
    }
    
    if ($params.Count -gt 0) {
        $badgeUrl += "?" + ($params -join "&")
    }
    
    # Format output
    switch ($OutputFormat) {
        'markdown' {
            if ($Link) {
                return "[![$Label]($badgeUrl)]($Link)"
            } else {
                return "![$Label]($badgeUrl)"
            }
        }
        'html' {
            if ($Link) {
                return "<a href='$Link'><img src='$badgeUrl' alt='$Label' /></a>"
            } else {
                return "<img src='$badgeUrl' alt='$Label' />"
            }
        }
        default {
            return $badgeUrl
        }
    }
}

function New-StandardBadge {
    <#
    .SYNOPSIS
        Creates common standard badges with preset configurations
    
    .PARAMETER Type
        The type of standard badge (status, license, version, build, coverage, downloads, etc.)
    
    .PARAMETER Value
        The value/message for the badge
    
    .PARAMETER Style
        Badge style: flat, flat-square, plastic, for-the-badge, social (default: flat)
    
    .PARAMETER OutputFormat
        Output format: markdown, url, html (default: markdown)
    
    .PARAMETER Link
        Optional URL to link the badge to
    
    .EXAMPLE
        New-StandardBadge -Type "status" -Value "stable"
        
    .EXAMPLE
        New-StandardBadge -Type "license" -Value "MIT" -Link "https://opensource.org/licenses/MIT"
        
    .EXAMPLE
        New-StandardBadge -Type "build" -Value "passing" -Style "flat-square"
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('status', 'license', 'version', 'build', 'coverage', 'downloads', 
                     'maintained', 'dependencies', 'security', 'quality', 'rating',
                     'docs', 'tests', 'release', 'issues', 'prs', 'contributors', 'size', 
                     'platform','workflow', 'gitlab', 'installs', 'github', 'codecov', 
                     'coveralls', 'docker', 'npm', 'powershell', 'choco', 'dotnet',
                     'packagist', 'composer', 'pypi', 'rubygems', 'crates', 'pub', 'hex', 
                     'cpan', 'maven', 'gradle', 'cargo', 'go', 'conda', 'hoimmebrew', 
                     'aur', 'snap', 'jsdelivr', 'jsr'
                     )]
        [string]$Type,
        
        [Parameter(Mandatory=$true)]
        [string]$Value,
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('flat', 'flat-square', 'plastic', 'for-the-badge', 'social')]
        [string]$Style = 'flat',
        
        [Parameter(Mandatory=$false)]
        [ValidateSet('markdown', 'url', 'html')]
        [string]$OutputFormat = 'markdown',
        
        [Parameter(Mandatory=$false)]
        [string]$Link
    )
    
    # Define standard badge configurations
    $badgeConfigs = @{
        status = @{
            label = 'status'
            colorMap = @{
                stable = 'green'
                beta = 'yellow'
                alpha = 'orange'
                experimental = 'red'
                deprecated = 'lightgrey'
            }
        }
        license = @{
            label = 'license'
            colorMap = @{
                MIT = 'blue'
                Apache = 'blue'
                GPL = 'blue'
                BSD = 'blue'
                ISC = 'blue'
            }
            defaultColor = 'blue'
        }
        version = @{
            label = 'version'
            defaultColor = 'blue'
        }
        build = @{
            label = 'build'
            colorMap = @{
                passing = 'brightgreen'
                failing = 'red'
                pending = 'yellow'
                unknown = 'lightgrey'
            }
        }
        coverage = @{
            label = 'coverage'
            colorMap = @{
                '100%' = 'brightgreen'
                '90%' = 'green'
                '80%' = 'yellowgreen'
                '70%' = 'yellow'
                '60%' = 'orange'
            }
            defaultColor = 'red'
        }
        downloads = @{
            label = 'downloads'
            defaultColor = 'blue'
        }
        maintained = @{
            label = 'maintained'
            colorMap = @{
                yes = 'brightgreen'
                no = 'red'
            }
        }
        dependencies = @{
            label = 'dependencies'
            colorMap = @{
                'up to date' = 'brightgreen'
                outdated = 'orange'
                vulnerable = 'red'
            }
        }
        security = @{
            label = 'security'
            colorMap = @{
                verified = 'brightgreen'
                unverified = 'yellow'
                vulnerable = 'red'
            }
        }
        quality = @{
            label = 'code quality'
            colorMap = @{
                A = 'brightgreen'
                B = 'green'
                C = 'yellow'
                D = 'orange'
                F = 'red'
            }
        }
        rating = @{
            label = 'rating'
            defaultColor = 'blue'
        }
        docs = @{
            label = 'docs'
            colorMap = @{
                passing = 'brightgreen'
                failing = 'red'
            }
        }
        tests = @{
            label = 'tests'
            colorMap = @{
                passing = 'brightgreen'
                failing = 'red'
            }
        }
        release = @{
            label = 'release'
            defaultColor = 'blue'
        }
        issues = @{
            label = 'issues'
            defaultColor = 'yellow'
        }
        prs = @{
            label = 'pull requests'
            defaultColor = 'blue'
        }
        contributors = @{
            label = 'contributors'
            defaultColor = 'blue'
        }
    }
    
    $config = $badgeConfigs[$Type]
    $label = $config.label
    
    # Determine color based on value
    $color = $config.defaultColor
    if ($config.colorMap -and $config.colorMap.ContainsKey($Value)) {
        $color = $config.colorMap[$Value]
    }
    
    # If it's a percentage, try to match the number
    if ($Type -eq 'coverage' -and $Value -match '(\d+)%') {
        $percent = [int]$matches[1]
        if ($percent -ge 90) { $color = 'brightgreen' }
        elseif ($percent -ge 80) { $color = 'green' }
        elseif ($percent -ge 70) { $color = 'yellowgreen' }
        elseif ($percent -ge 60) { $color = 'yellow' }
        elseif ($percent -ge 50) { $color = 'orange' }
        else { $color = 'red' }
    }
    
    # Create the badge
    $params = @{
        Label = $label
        Message = $Value
        MessageColor = $color
        Style = $Style
        OutputFormat = $OutputFormat
    }
    
    if ($Link) {
        $params.Link = $Link
    }
    
    return New-CustomBadge @params
}