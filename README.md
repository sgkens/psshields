<div align="center">
    <img src="https://raw.githubusercontent.com/phellams/phellams-general-resources/main/logos/psshields/dist/png/psshields-128x128.png" alt="PWSL Logo">
    <h1><strong>PsShields</strong></h1>
    <p><b>Shield.io Badge Generator</b></p>
    <p>A PowerShell module for generating Shield.io badge URLs and markdown for your README files. Supports 25+ platforms including GitHub, GitLab, Docker, NPM, PyPI, Packagist (PHP/Composer), Crates.io (Rust), Pub.dev (Dart), Hex.pm (Elixir), RubyGems, Maven, Conda, Homebrew, and more!</p>
    <small>Available on <strong>MacOS</strong>, <strong>Linux</strong>, and <strong>Windows</strong></small><br>
    <span>🚨 <strong>Requirement:</strong> none.</span>
    <br><br>
    <span>
        <a href="https://github.com/phellams/psshields#Cmdlets"><b>Cmdlets</b></a> 🔸
        <a href="https://github.com/phellams/psshields#function-Reference"><b>Function Reference</b></a> 🔸
        <a href="https://www.powershellgallery.com/packages/psshields"><b>PSGallery</b></a> 🔸
        <a href="https://chocolatey.org/packages/psshields"><b>Chocolatey</b></a>
    </span>
    <hr>
    <a href='https://gitlab.com/phellams' target='_blank'><img src='https://img.shields.io/gitlab/license/phellams/psshields?style=flat-square&logo=gitlab&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='gitlab-license' /></a> <a href='https://gitlab.com/phellams' target='_blank'><img src='https://img.shields.io/gitlab/pipeline-status/phellams/psshields?style=flat-square&logo=gitlab&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='gitlab-pipeline' /></a> <a href='https://gitlab.com/phellams' target='_blank'><img src='https://img.shields.io/gitlab/issues/open/phellams/psshields?style=flat-square&logo=gitlab&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='gitlab-issues' /></a>  <a href='https://www.powershellgallery.com/packages/psshields' target='_blank'><img src='https://img.shields.io/powershellgallery/v/@phellams/psshields?style=flat-square&logo=powershell&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='powershell-version' /></a> <a href='https://community.chocolatey.org/packages/psshields' target='_blank'><img src='https://img.shields.io/chocolatey/v/@phellams/psshields?style=flat-square&logo=chocolatey&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='choco-version' /></a> <a href='https://img.shields.io/codecov/c/github/phellams/psshields?style=flat-square&logo=codecov&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' target='_blank'><img src='https://img.shields.io/codecov/c/github/phellams/psshields?style=flat-square&logo=codecov&labelColor=%23080808&color=%236c6c6c&logoColor=%239e9e9e' alt='codecov-coverage' /></a>
    <br><br>
    <img src="https://raw.githubusercontent.com/phellams/phellams-general-resources/main/misc/hr/hr-style-solution.svg" alt="hr-style-solution" >
</div>


## **Features** 

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
- **Tab Completion** - Auto-complete for all **256 ANSI Color Palette**, **Color Groups**, **badge types**, and **platforms**
    - **badge types**, **platforms** automaticly pull the config from this function.
    - **colors**, and **colorgroups** pull from `colorpallet.json` file
- **Main Congiration** - `Get-PlatformConfig` is the core of the module that holds shields configuration structure, this is where you would add additional configration for new badges extending support for more badges
- **Shields Commander** - Main cmdlet to interact with the tool
    - **Actions**:
        - Output **Color Pallete** - Full 256 color palette
        - Output **Color Groups** - List all Color groups
        - Output **Badge Types** - Badge types for all platforms
        - Output **Badge Pallete** - The full 256 color palette in badge preview format
        - Output **Raw Color List** - The full 256 color palette from json file
        - Output **Define Badge Sets** - List of defined badge sets eg : jsm, psm, docker, nuget etc.
        - output **Output Defined Badges** - Generate badges from defined badge sets eg : jsm, psm, docker, nuget
        - output **Single Badge from the defined badge sets** - Generate a single badge by omitting `-Set` forces `<switch>` to default witch requires `-Platform` and `-BadgeType`, allows a single badge outside of defined badge sets using colorsets and format from defined badge sets
        - output **Custom Badges** - Create any badge with custom labels, messages, and colors
        - Output **Preview** of all badges


## **Installation**

Phellams modules are available from [**PowerShell Gallery**](https://www.powershellgallery.com/packages/commitfusion) and [**Chocolatey**](https://chocolatey.org/packages/commitfusion). you can access the raw assets via [**Gitlab Generic Assets**](https://gitlab.com/phellams/commitfusion/-/packages?orderBy=name&sort=desc&search[]=commitfusion) or nuget repository via [**Gitlab Packages**](https://gitlab.com/phellams/commitfusion/-/packages/?orderBy=name&sort=desc&search[]=commitfusion&type=NuGet).



|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|
|-|-|-|
|📦 PSGallery | <a href="https://www.powershellgallery.com/packages/psshields"> <img src="https://img.shields.io/powershellgallery/v/psshields?label=version&style=flat-square&logoColor=blue&labelColor=23CD5C5C&color=%231E3D59" alt="powershellgallery"></a> | <img src="https://img.shields.io/powershellgallery/dt/psshields?style=flat-square&logoColor=blue&label=downloads&labelColor=23CD5C5C&color=%231E3D59" alt="powershellgallery-downloads"> |
|📦 Chocolatey | <a href="https://community.chocolatey.org/packages/psshields/"><img src="https://img.shields.io/chocolatey/v/psshields?label=version&include_prereleases&style=flat-square&logoColor=blue&labelColor=23CD5C5C&color=%231E3D59" alt="chocolatey"/></a> | <img src="https://img.shields.io/chocolatey/dt/psshields?style=flat-square&logoColor=blue&label=downloads&include_prereleases&labelColor=23CD5C5C&color=%231E3D59" alt="chocolatey-downloads"> |

### Additinonal Installation Options:
 
|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|▓▓▓▓▒▒▒▒░░░|
|-|-|-|
|💼 Releases/Tags | <a href="https://gitlab.com/phellams/psshields/-/releases"> <img src="https://img.shields.io/gitlab/v/release/phellams%2Fpsshields?include_prereleases&style=flat-square&logoColor=%2300B2A9&labelColor=%23CD5C5C&color=%231E3D59" alt="gitlab-release"></a> | <a href="https://gitlab.com/phellams/psshields/-/tags"> <img src="https://img.shields.io/gitlab/v/tag/phellams%2Fpsshields?include_prereleases&style=flat-square&logoColor=%&labelColor=%23CD5C5C&color=%231E3D59" alt="gitlab tags"></a> |

#### 📦 GitLab Packages

Using `nuget`: See the [**packages**](https://gitlab.com/phellams/psshields/-/packages?orderBy=name&sort=asc&search[]=psshields&type=NuGet) page for installation instructions.

> For instructions on adding `nuget` **sources** packages from *GitLab* see [**Releases**](https://github.com/sgkens/psshields/releases) artifacts or via the [**Packages**](https://gitlab.com/phellams/psshields/-/packages?orderBy=name&sort=asc&search[]=psshields&type=NuGet) page.

#### 🧺 Generic Asset

The latest release artifacts can be downloaded from the [**Generic Assets Artifacts**](https://gitlab.com/phellams/psshields/-/packages?orderBy=type&sort=desc&type=Generic) page.

#### 💾 Git Clone

```bash
# Clone the repository
git clone https://gitlab.com/phellams/psshields.git
cd psshields
import-module .\
```

## **Quick Start**

The Main `Invoke-ShieldsCommander` cmdlet can be used control the entire process, or you can use the aliases `ShieldsCommander` and `ShieldSC`

```powershell
Invoke-ShieldsCommander @params

# or alias 1
ShieldsCommander @params

# or alias 2
ShieldSC @params
```
🔵 Generate a single badge from the Available Badge types:

```powershell
# Find you badge 
Invoke-ShieldsCommander -ViewBadgeTypes -Platform gitlab

# Generate badge
Invoke-ShieldsCommander -Reponame "my-project" `
                        -Namespace "my-organization" `
                        -Platform gitlab `
                        -BadgeType "version" `
                        -Colorset matrix-console
```

🔵 View Available Badges and Colors with the `-ViewBadgeTypes`, `-ViewColorPallete`, `-ViewBadgePallete` and `-ViewColorGroups`.

```powershell
# Output all platform types and Badge Types
Invoke-ShieldsCommander -ViewBadgeTypes

# Output Selected platform types and Badge Types
Invoke-ShieldsCommander -ViewBadgeTypes -Platform gitlab

# Output Available Colors filtered by Groupname 
# - options: standard, bright, extended_216, grayscale
Invoke-ShieldsCommander -ViewBadgePallete -GroupName standard 

# Output Available Colors filtered by Groupname
# - options: standard, bright, extended_216, grayscale
Invoke-ShieldsCommander -ViewColorPallete -GroupName extended_216

# View color groups
Invoke-ShieldsCommander -ViewColorGroups
```

🔵 Preview colorsets with the `-Colorsets`


```powershell
Invoke-ShieldsCommander -Preview
```

### **Defined Badges**

Generate badges for a Project, you can find list of defined badge sets with the `-DefinedBadgesSets <switch> `

```powershell
Invoke-ShieldsCommander -DefinedBadgesSets
```

🔵 Generates badges for a **JavaScript** project with the matrix-console colorset

```powershell
Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization" -Set jsm -Colorset matrix-console
```

🔵 Generates badges for a **Powershell Module** project with the matrix-console colorset

```powershell
Invoke-ShieldsCommander -Reponame "my-project" -Namespace "my-organization" -Set psm -Colorset matrix-console
```

### **Custom Badges**

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

## **Function Reference**

### `Invoke-ShieldsCommander`

Main cmdlet for generating badges.

**Alias**: `ShieldsCommander`, `ShieldSC`

**Syntax**

```pre
Invoke-ShieldsCommander [-Reponame <string>] [-Namespace <string>] [-Colorset <string>] 
                        [-BadgeType <string>] [-LabelColor <string>] [-MessageColor <string>]
                        [-LogoColor <string>] [-Logo <string>] [-Style <string>]
                        [-OutputFormat <string>] [-Preview <switch>] 
                        [-ViewBadgeTypes <switch>] [-ViewColorGroups <switch>] 
                        [-ViewBadgePallete <switch>] [-ViewColorPallete <switch>] 
                        [-DefinedBadgesSets <switch>] [-Colorsets <switch>]   
```

**Parameters:**
- `Reponame` - Project/package name
- `Namespace` - User/organization namespace
- `Colorset` - Colorset name
- `BadgeType` - Specific badge type to generate (stars, forks, pipeline, version, downloads, etc.). Use `Get-BadgeTypes` to see available types
- `LabelColor` - Label background color (hex without # or color name)
- `MessageColor` - Message background color (hex without # or color name)
- `LogoColor` - Logo color (hex without # or color name)
- `Logo` - Logo name from SimpleIcons
- `Style` - Badge style (flat, flat-square, plastic, for-the-badge, social)
- `OutputFormat` - Output format (markdown, url, html)
- `Preview` - Show preview of all badges
- `ViewBadgeTypes` - View available badge types
- `ViewColorGroups` - View available color groups
- `ViewBadgePallete` - View available badge colors
- `ViewColorPallete` - View available color palettes
- `DefinedBadgesSets` - View defined badge sets
- `Colorsets` - Preview colorsets
- `preview` - Show preview of all badges
- `Set` - Set of badges to generate. Valid options are 'jsm', 'psm', 'docker', 'nuget'.

🔻 Returns Multiple data types based on output format

**Examples:**

🔵 Generate a single badge by omitting `-Set` forces `<switch>` to default witch requires `-Platform` and `-BadgeType`

```powershell
Invoke-ShieldsCommander -Reponame "my-project" `
                        -Namespace "my-organization" `
                        -Platform gitlab `
                        -BadgeType version `
                        -Colorset matrix-console `
                        -OutputFormat url
```

🔵 Generate a set `jsm(JavaScript Module)` from the defined badges sets, you can find list of defined badge sets with the `-DefinedBadgesSets <switch> `

```powershell
Invoke-ShieldsCommander -Reponame "my-project" `
                        -Namespace "my-organization" `
                        -Set jsm `
                        -Colorset matrix-console `
                        -OutputFormat url
```

### `New-ShieldBadge`

Creates platform-specific badge used by `Invoke-ShieldsCommander` to platform-specific badges

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

### `Get-BadgeTypes`

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

## **Color Reference**

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

## **Badge Styles**

Shield.io supports multiple visual styles:

- **flat** (default) - Flat design with subtle shadows
- **flat-square** - Completely flat with no shadows
- **plastic** - Glossy plastic appearance
- **for-the-badge** - Large, bold badges
- **social** - GitHub-style social badges

**Example:**
```powershell
New-CustomBadge -Label "style" `
                -Message "for-the-badge" `
                -MessageColor "blue" `
                -Style "for-the-badge"
```

## **Use Cases**

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

## **Output Formats**

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

## **Contributing**

Contributions are welcome! Please fork the repository and submit a **Merge Request** (MR) targeting the `develop` branch.

1. **Fork the Project**
   Click the "Fork" button in the top right corner of the repository page.

2. **Clone your Fork**
   ```bash
   git clone [https://gitlab.com/YOUR_USERNAME/pwsl.git](https://gitlab.com/YOUR_USERNAME/pwsl.git)
   cd pwslmerge_requests/new)
   ```

3. Create a Feature Branch Ensure you base your work on the develop branch:
   ```bash
   git switch develop
   git switch -c feature/AmazingFeature
   ```

4. Commit your Changes
   ```bash
   git commit -m 'feat: Add some AmazingFeature'
   ```

5. Push to the Branch
   ```bash
   git push origin feature/AmazingFeature
   ```

6. Open a Merge Request

   <a href="https://gitlab.com/phellams/psshields/-/merge_requests/new"><img src="https://img.shields.io/badge/Open_Merge_Request-GitLab-orange?style=flat-square&logo=gitlab"></a>
   > https://gitlab.com/phellams/psshields/-/merge_requests/new

## **Resources**

- [Shield.io Documentation](https://shields.io/)
- [Simple Icons](https://simpleicons.org/) - Logo reference
- [GitLab CI/CD](https://docs.gitlab.com/ee/ci/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [ASCII Color Code Referenc]() - Wikki
- [IAumentCompliotion]() MS wikki
- [Phellams-Automator]() Link repo and docker container
- [ColorConsole]() link to repo
- [AsciiTableView]() # link to repo

## **Acknowledgements**

🔹 [**@Shield.io**](https://shields.io/) - Shields.io documenation and examples \
🔹 [**@Simple Icons**](https://simpleicons.org/) - Simple icons used with Shields.io

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## **Support**

- 📝 [Documentation](https://gitlab.com/phellams/psshields/-/wikis/home)
- 🐛 [Issue Tracker](https://gitlab.com/phellams/psshields/-/issues)
- 💬 [Discussions](https://gitlab.com/phellams/psshields/-/issues)

---

**Made with ❤️ for the DevOps community**