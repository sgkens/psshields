<div align="center">
    <img src="https://gitlab.com/namespace/project/-/raw/master/logo.png" alt="Shield.io Badge Generator Logo">
    <h1>Shield.io Badge Generator</h1>
    <p>Generate Shield.io Badges for Your README Files</p>
    <blockquote>A PowerShell module for generating Shield.io badge URLs and markdown for your README files. Supports 25+ platforms including GitHub, GitLab, Docker, NPM, PyPI, Packagist (PHP/Composer), Crates.io (Rust), Pub.dev (Dart), Hex.pm (Elixir), RubyGems, Maven, Conda, Homebrew, and more!</blockquote>
</div>

<br>

## Badges

[![GitLab Pipeline](https://img.shields.io/gitlab/pipeline-status/namespace/project?style=flat&logo=gitlab)](https://gitlab.com/namespace/project)
[![License](https://img.shields.io/badge/license-MIT-blue?style=flat)](LICENSE)
[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/ShieldBadgeGenerator?style=flat&logo=powershell)](https://www.powershellgallery.com/packages/ShieldBadgeGenerator)
[![Status](https://img.shields.io/badge/status-stable-green?style=flat)](https://gitlab.com/namespace/project)

## Features

- **256 ANSI Color Palette** - Complete color reference with hex, RGB, and ANSI codes
- **25+ Platform Support** - Pre-configured badges for:
  - **Version Control**: GitHub, GitLab
  - **Containers**: Docker
  - **JavaScript/TypeScript**: NPM
  - **Python**: PyPI, Conda
  - **PHP**: Packagist, Composer
  - **Rust**: Crates.io, Cargo
  - **Dart/Flutter**: Pub.dev
  - **Elixir**: Hex.pm
  - **Ruby**: RubyGems
  - **Go**: Go Modules
  - **.NET**: NuGet
  - **Java**: Maven, Gradle
  - **PowerShell**: PowerShell Gallery
  - **Perl**: CPAN
  - **PowerShell Core Modules**: PowerShell Gallery, chocolatey
  - **Package Managers**: Chocolatey, Homebrew, AUR, Snap
  - **CI/CD**: Codecov, Coveralls
- **Custom Badge Creation** - Create any badge with custom labels, messages, and colors
- **Standard Badge Presets** - Common badges with smart color mapping (status, build, coverage, etc.)
- **Multiple Output Formats** - Markdown, URL, or HTML
- **Full Styling Support** - All Shield.io styles: flat, flat-square, plastic, for-the-badge, social
- **Tab Completion** - Auto-complete for all 256 ANSI colors with hex/RGB tooltip
- **Shields Commander** - Main entry point for generating badges from the 

## Installation

### From PowerShell Gallery
```powershell
Install-Module -Name ShieldBadgeGenerator
```

### Manual Installation
```powershell
# Clone the repository
git clone https://gitlab.com/namespace/project.git

# Import the module
Import-Module ./ShieldBadgeGenerator.psm1
```

## Quick Start

PsShields provides a number of cmdlets for generating badges, you can either use these directly or use the Shields Commander to generate badges from your terminal.



### Platform-Specific Badges

```powershell
# GitHub repository badges
New-ShieldBadge -Platform github -Namespace "octocat/hello-world"

# GitHub with specific badge type
New-ShieldBadge -Platform github -Namespace "user/repo" -BadgeType "stars"
New-ShieldBadge -Platform github -Namespace "user/repo" -BadgeType "forks"
New-ShieldBadge -Platform github -Namespace "user/repo" -BadgeType "issues"
New-ShieldBadge -Platform github -Namespace "user/repo" -BadgeType "license"

# GitLab badges
New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "pipeline"
New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "stars"
New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "coverage"
New-ShieldBadge -Platform gitlab -Namespace "group/project" -BadgeType "forks"

# Docker Hub
New-ShieldBadge -Platform docker -Namespace "library/nginx" -BadgeType "pulls"
New-ShieldBadge -Platform docker -Namespace "library/nginx" -BadgeType "stars"
New-ShieldBadge -Platform docker -Namespace "library/nginx" -BadgeType "size"

# NPM package (JavaScript/TypeScript)
New-ShieldBadge -Platform npm -Project "@scope/package-name" -BadgeType "version"
New-ShieldBadge -Platform npm -Project "@scope/package-name" -BadgeType "downloads"
New-ShieldBadge -Platform npm -Project "package-name" -BadgeType "license"

# PyPI package (Python)
New-ShieldBadge -Platform pypi -Project "requests" -BadgeType "version"
New-ShieldBadge -Platform pypi -Project "requests" -BadgeType "downloads"
New-ShieldBadge -Platform pypi -Project "requests" -BadgeType "python"

# Packagist package (PHP/Composer)
New-ShieldBadge -Platform packagist -Project "symfony/console"

# Crates.io package (Rust)
New-ShieldBadge -Platform crates -Project "serde" -BadgeType "version"
New-ShieldBadge -Platform crates -Project "serde" -BadgeType "downloads"

# Pub.dev package (Dart/Flutter)
New-ShieldBadge -Platform pub -Project "flutter_bloc" -BadgeType "version"
New-ShieldBadge -Platform pub -Project "flutter_bloc" -BadgeType "likes"

# Discover available badge types for a platform
Get-BadgeTypes -Platform gitlab
Get-BadgeTypes -Platform github
Get-BadgeTypes  # Show all platforms
```

### Custom Badges

```powershell
# Simple custom badge
New-CustomBadge -Label "status" -Message "stable" -MessageColor "green"

# With logo and custom colors
New-CustomBadge -Label "build" -Message "passing" `
    -LabelColor "555" `
    -MessageColor "brightgreen" `
    -Logo "gitlab" `
    -Style "flat-square"

# With hyperlink
New-CustomBadge -Label "license" -Message "MIT" `
    -MessageColor "blue" `
    -Link "https://opensource.org/licenses/MIT"
```

### Standard Badges with Presets

```powershell
# Status badge (auto-colored: stable=green, beta=yellow, etc.)
New-StandardBadge -Type "status" -Value "stable"

# Build badge (auto-colored: passing=green, failing=red)
New-StandardBadge -Type "build" -Value "passing"

# Coverage with automatic coloring
New-StandardBadge -Type "coverage" -Value "85%"

# Quality grade (A-F)
New-StandardBadge -Type "quality" -Value "A"
```

### Generate Multiple Badges for a Project

```powershell
# Create a complete badge set
New-ProjectBadges `
    -GitLab "group/project" `
    -Docker "username/image" `
    -NPM "@scope/package" `
    -PowerShell "ModuleName" `
    -Style "flat-square"
```

## Function Reference

### `New-ShieldBadge`

Creates platform-specific badges for development services.

**Parameters:**
- `Platform` - Platform type (gitlab, github, codecov, coveralls, docker, npm, powershell, choco, dotnet, packagist, composer, pypi, rubygems, crates, pub, hex, cpan, maven, gradle, cargo, go, conda, homebrew, aur, snap)
- `Namespace` - User/organization namespace
- `Project` - Project/package name (optional, platform-dependent)
- `BadgeType` - Specific badge type to generate (stars, forks, pipeline, version, downloads, etc.). Use `Get-BadgeTypes` to see available types
- `LabelColor` - Label background color (hex without # or color name)
- `MessageColor` - Message background color (hex without # or color name)
- `LogoColor` - Logo color (hex without # or color name)
- `Logo` - Logo name from SimpleIcons
- `Style` - Badge style (flat, flat-square, plastic, for-the-badge, social)
- `OutputFormat` - Output format (markdown, url, html)

**Example:**
```powershell
New-ShieldBadge -Platform gitlab `
    -Namespace "group/project" `
    -LabelColor "555" `
    -MessageColor "fc6d26" `
    -Style "flat-square"
```

### `New-CustomBadge`

Creates custom badges with any label and message.

**Parameters:**
- `Label` - Left side text
- `Message` - Right side text/value
- `LabelColor` - Label background color
- `MessageColor` - Message background color
- `Logo` - Logo name from SimpleIcons
- `LogoColor` - Logo color
- `Style` - Badge style
- `OutputFormat` - Output format (markdown, url, html)
- `Link` - Optional URL to link the badge to

**Example:**
```powershell
New-CustomBadge -Label "API" -Message "v2.0" `
    -MessageColor "blue" `
    -Logo "swagger" `
    -Link "https://api.example.com/docs"
```

### `New-StandardBadge`

Creates common badges with preset configurations and smart color mapping.

**Parameters:**
- `Type` - Badge type (status, license, version, build, coverage, downloads, etc.)
- `Value` - Badge value/message
- `Style` - Badge style
- `OutputFormat` - Output format
- `Link` - Optional URL to link the badge to

**Supported Types:**
- `status` - stable, beta, alpha, experimental, deprecated
- `license` - MIT, Apache, GPL, BSD, ISC
- `version` - any version string
- `build` - passing, failing, pending, unknown
- `coverage` - percentage with auto-coloring (100%=green, <50%=red)
- `downloads`, `maintained`, `dependencies`, `security`, `quality`, `rating`, `docs`, `tests`, `release`, `issues`, `prs`, `contributors`

**Example:**
```powershell
# Status badge with auto-coloring
New-StandardBadge -Type "status" -Value "stable"

# Coverage with percentage-based coloring
New-StandardBadge -Type "coverage" -Value "92%"

# License with link
New-StandardBadge -Type "license" -Value "MIT" `
    -Link "https://opensource.org/licenses/MIT"
```

### `New-ProjectBadges`

Generates a complete badge set for a project across multiple platforms.

**Parameters:**
- `GitHub` - GitHub namespace (user/repo)
- `GitLab` - GitLab namespace (group/project)
- `Docker` - Docker Hub namespace
- `NPM` - NPM package name
- `PowerShell` - PowerShell Gallery module name
- `Chocolatey` - Chocolatey package name
- `DotNet` - NuGet package name
- `Packagist` - Packagist package name (PHP/Composer)
- `PyPI` - PyPI package name (Python)
- `RubyGems` - RubyGems package name (Ruby)
- `Crates` - Crates.io package name (Rust)
- `Pub` - Pub.dev package name (Dart/Flutter)
- `Hex` - Hex.pm package name (Elixir)
- `Maven` - Maven Central artifact coordinates
- `Go` - Go module path
- `Conda` - Conda package (namespace/package format)
- `Homebrew` - Homebrew formula name
- `Style` - Badge style for all badges

**Example:**
```powershell
New-ProjectBadges `
    -GitLab "mygroup/myproject" `
    -Docker "myuser/myimage" `
    -PyPI "my-python-package" `
    -NPM "@myorg/mypackage" `
    -Crates "my-rust-crate" `
    -Style "flat-square"
```

#### `Get-BadgeTypes`

Lists all available badge types for each platform.

**Parameters:**
- `Platform` - Optional. Filter by specific platform

**Examples:**
```powershell
# See all available badge types for all platforms
Get-BadgeTypes

# See badge types for GitLab
Get-BadgeTypes -Platform gitlab

# Output:
# Available badge types for 'gitlab':
#   - coverage
#   - forks
#   - issues
#   - pipeline
#   - stars

# See badge types for GitHub
Get-BadgeTypes -Platform github

# See badge types for NPM
Get-BadgeTypes -Platform npm
```

## Color Reference

The module includes a complete 256 ANSI color palette JSON file with:
- Color names
- Hex codes
- RGB values
- ANSI codes
- Grouped by categories (standard, bright, extended, grayscale)

### Using Colors

Colors can be specified as:
- **Named colors**: `"blue"`, `"green"`, `"brightgreen"`, `"orange"`, `"red"`
- **Hex codes** (without #): `"fc6d26"`, `"00ff00"`, `"333333"`
- **Shield.io color names**: `"success"`, `"important"`, `"critical"`, `"informational"`

### Common GitLab Colors
```powershell
# GitLab brand orange
-MessageColor "fc6d26"

# GitLab pipeline status colors
-MessageColor "green"     # Success
-MessageColor "orange"    # Warning
-MessageColor "red"       # Failed
-MessageColor "blue"      # Running
```

## Badge Styles

Shield.io supports multiple visual styles:

- **flat** (default) - Flat design with subtle shadows
- **flat-square** - Completely flat with no shadows
- **plastic** - Glossy plastic appearance
- **for-the-badge** - Large, bold badges
- **social** - GitHub-style social badges

**Example:**
```powershell
New-CustomBadge -Label "style" -Message "for-the-badge" `
    -MessageColor "blue" `
    -Style "for-the-badge"
```

## Use Cases

### README.md Header
```powershell
# Generate a complete header
$badges = @(
    (New-StandardBadge -Type "status" -Value "stable")
    (New-StandardBadge -Type "license" -Value "MIT" -Link "./LICENSE")
    (New-ShieldBadge -Platform gitlab -Namespace "group/project")
    (New-StandardBadge -Type "coverage" -Value "95%")
)

$badges -join " "
```

### CI/CD Pipeline Status
```powershell
# Show pipeline status for multiple branches
New-CustomBadge -Label "main" -Message "passing" -MessageColor "green"
New-CustomBadge -Label "develop" -Message "passing" -MessageColor "green"
New-CustomBadge -Label "staging" -Message "pending" -MessageColor "yellow"
```

### Package Versions
```powershell
# Show versions across multiple registries
New-ShieldBadge -Platform npm -Project "my-package"
New-ShieldBadge -Platform pypi -Project "my-python-package"
New-ShieldBadge -Platform crates -Project "my-rust-crate"
New-ShieldBadge -Platform packagist -Project "vendor/package"
New-ShieldBadge -Platform rubygems -Project "my-gem"
New-ShieldBadge -Platform pub -Project "my-flutter-package"
New-ShieldBadge -Platform powershell -Project "MyModule"
New-ShieldBadge -Platform docker -Namespace "user/image"
```

### Project Statistics
```powershell
# Display project metrics
New-StandardBadge -Type "contributors" -Value "42"
New-StandardBadge -Type "downloads" -Value "10k+"
New-StandardBadge -Type "issues" -Value "3 open"
```

## Output Formats

### Markdown (default)
```powershell
New-CustomBadge -Label "test" -Message "example" -OutputFormat markdown
# Output: [![test](https://img.shields.io/badge/test-example-blue)](link)
```

### URL Only
```powershell
New-CustomBadge -Label "test" -Message "example" -OutputFormat url
# Output: https://img.shields.io/badge/test-example-blue
```

### HTML
```powershell
New-CustomBadge -Label "test" -Message "example" -OutputFormat html
# Output: <img src='https://img.shields.io/badge/test-example-blue' alt='test' />
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Merge Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Resources

- [Shield.io Documentation](https://shields.io/)
- [Simple Icons](https://simpleicons.org/) - Logo reference
- [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [PowerShell Gallery](https://www.powershellgallery.com/)

## Support

- 📝 [Documentation](https://gitlab.com/namespace/project/-/wikis/home)
- 🐛 [Issue Tracker](https://gitlab.com/namespace/project/-/issues)
- 💬 [Discussions](https://gitlab.com/namespace/project/-/issues)

---

**Made with ❤️ for the DevOps community**