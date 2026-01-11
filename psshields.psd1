@{
    RootModule         = 'psshields.psm1'
    ModuleVersion      = '0.5.1'
    GUID               = '019a8acf-6f78-706b-95f6-5bbeefe81d16'
    Author             = 'Garvey k. Snow'
    CompanyName        = 'Phellams'
    Copyright          = '(c) 2026 Garvey k. Snow. All rights reserved.'
    Description        = 'Generating Shield.io badge URLs and markdown for your README files. Supports 25+ platforms including GitHub, GitLab, Docker, NPM, PyPI, Packagist (PHP/Composer), Crates.io (Rust), Pub.dev (Dart), Hex.pm (Elixir), RubyGems, Maven, Conda, Homebrew, and more!'
    FunctionsToExport  = @(
        'New-ShieldBadge', 
        # 'New-ProjectBadges', 
        'New-CustomBadge', 
        # 'New-StandardBadge',
        'Get-ColorPallete',
        'Get-ColorGroups',
        'Get-BadgePalette',
        'Get-BadgeTypes',
        'Get-PlatformConfig',
        'Get-DefinedColorSets',
        'Invoke-ShieldsCommander'
    )
    CmdletsToExport    = @()
    VariablesToExport  = @()
    AliasesToExport     = @(
        'ShieldsCommander'
    )
    PrivateData        = @{
        PSData = @{
            Tags                     = @('shield.io', 'badge', 'CLI', 'PowerShell', 'Documentation', 'readme', 'GitHub', 'GitLab', 'NPM', 'PyPI', 'Packagist', 'Crates', 'Pub.dev', 'Hex.pm', 'RubyGems', 'Maven', 'Conda', 'Homebrew')
            ReleaseNotes             = @{
                # '1.2.1' = 'Initial release with New-PHWriter cmdlet for custom help formatting and enhanced layout.'
            }
            RequireLicenseAcceptance = $false
            LicenseUri               = 'https://choosealicense.com/licenses/mit'
            ProjectUri               = 'https://gitlab.com/phellams/psshields.git'
            IconUri                  = 'https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/psshields/dist/png/psshields-128x128.png'
            # CHOCOLATE ---------------------
            ChocoDescription         = 'Generating Shield.io badge URLs and markdown for your README files. Supports 25+ platforms including GitHub, GitLab, Docker, NPM, PyPI, Packagist (PHP/Composer), Crates.io (Rust), Pub.dev (Dart), Hex.pm (Elixir), RubyGems, Maven, Conda, Homebrew, and more!'
            LicenseUrl               = 'https://choosealicense.com/licenses/mit'
            ProjectUrl               = 'https://github.com/phellams/psshields'
            IconUrl                  = 'https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/psshields/dist/png/psshields-128x128.png'
            Docsurl                  = 'https://pages.gitlab.io/sgkens/ptoml'
            MailingListUrl           = 'https://github.com/phellams/psshields/issues'
            projectSourceUrl         = 'https://github.com/phellams/psshields'
            bugTrackerUrl            = 'https://github.com/phellams/psshields/issues'
            Summary                  = 'Generating Shield.io badge URLs and markdown for your README files. Supports 25+ platforms including GitHub, GitLab, Docker, NPM, PyPI, Packagist (PHP/Composer), Crates.io (Rust), Pub.dev (Dart), Hex.pm (Elixir), RubyGems, Maven, Conda, Homebrew, and more!'
            # CHOCOLATE ---------------------
            Prerelease               = 'prerelease+build.1'

        }        
    }
    RequiredModules    = @()
    RequiredAssemblies = @()
    FormatsToProcess   = @()
    TypesToProcess     = @()
    NestedModules      = @()
    ScriptsToProcess   = @()
}
