using module libs\helpers.psm1
using module libs\main.psm1
using module cmdlets\Get-PlatformConfig.psm1
using module cmdlets\Get-DefinedColorSets.psm1
using module cmdlets\Get-DefinedSets.psm1
using module cmdlets\Invoke-ShieldsCommander.psm1

# Load global configurations
$global:__psshields = @{ rootpath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition   }
$global:__psshields.definedcolorsets = Get-Content "$($global:__psshields.rootpath)\libs\definitions\definedcolorsets.json" -raw | ConvertFrom-Json
$global:__psshields.platformConfig = Get-Content -Path "$($global:__psshields.rootpath)\libs\definitions\platformconfig.json" -raw | ConvertFrom-Json -AsHashtable
$global:__psshields.definedsets = Get-Content "$($global:__psshields.rootpath)\libs\definitions\definedsets.json" -raw | ConvertFrom-Json 
$global:__psshields.color_pallete = Get-Content -Path "$($global:__psshields.rootpath)\libs\definitions\colorpallet.json" -raw | ConvertFrom-Json   

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
        'Get-DefinedColorSets',
        'Get-DefinedSets',
        'Invoke-ShieldsCommander'
    )
    alias = @(
        'ShieldsCommander'
    )
}

Export-ModuleMember @module_config