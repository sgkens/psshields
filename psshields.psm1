using module libs\helpers.psm1
using module libs\main.psm1
using module libs\cmdlets\Invoke-ShieldsCommander.psm1

# Dynamic root path
$global:__psshields = @{ rootpath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition }

# Load color palette
$script:color_pallete = Get-Content -Path "$($global:__psshields.rootpath)\colorpallet.json" -raw | ConvertFrom-Json   

$script:platformConfig = Get-PlatformConfig

# Expose color palette globally for developer convenience
$global:__psshields.color_pallete = $script:color_pallete


# Export functions
$module_config = @{
    Function = @(
        'New-ShieldBadge', 
        'New-ProjectBadges', 
        'New-CustomBadge', 
        'New-StandardBadge',
        'Get-ColorPallete',
        'Get-ColorGroups',
        'Get-BadgePalette',
        'Get-BadgeTypes',
        'Invoke-ShieldsCommander'
    )
    alias = @(
        'ShieldsCommander'
    )
}

Export-ModuleMember @module_config