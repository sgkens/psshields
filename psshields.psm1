using module libs\helpers.psm1
using module libs\main.psm1
using module cmdlets\Get-PlatformConfig.psm1
using module cmdlets\Get-DefinedColorSets.psm1
using module cmdlets\Invoke-ShieldsCommander.psm1

# Dynamic root path
$global:__psshields = @{ rootpath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition   }
$global:__psshields.definedcolorsets = Get-Content "$($global:__psshields.rootpath)\libs\definedcolorsets.json" -raw | ConvertFrom-Json
$global:__psshields.platformConfig = Get-Content -Path "$($global:__psshields.rootpath)\libs\platformconfig.json" -raw | ConvertFrom-Json -AsHashtable

# Load color palette !NOTE: other cmelts in other files cant see this scope so forced to use global
# $script:color_pallete = Get-Content -Path "$($global:__psshields.rootpath)\libs\colorpallet.json" -raw | ConvertFrom-Json   

# Expose color palette globally for developer convenience
$global:__psshields.color_pallete = Get-Content -Path "$($global:__psshields.rootpath)\libs\colorpallet.json" -raw | ConvertFrom-Json   
$global:__psshields.asciitableview = @{
    noheader = $false
    colorpallet = @{ 
        connectors = "gray"; 
        HozLine = "red"; 
        VerLine = "red"; 
        juctions = "cyan"; 
        header = 'red'; 
        #row = 'darkgray';
        title = 'yellow';
        Summarytitle = 'yellow'
    } 
    borderStyle = "Single" # None, Single, Double, Rounded, Minimal, Bold, Dotted, Dashed, ASCII, Stars, Block, LightBlock, MediumBlock, DarkBlock, HeavyBlock
}  

# Export functions
$module_config = @{
    Function = @(
        'New-ShieldBadge', 
        # 'New-ProjectBadges', 
        'New-CustomBadge', 
        # 'New-StandardBadge',
        'Get-ColorPallete',
        'Get-ColorGroups',
        'Get-BadgePalette',
        'Get-BadgeTypes',
        'Get-PlatformConfig',
        'Get-DefinedColorSets'
        'Invoke-ShieldsCommander'
    )
    alias = @(
        'ShieldsCommander'
    )
}

Export-ModuleMember @module_config