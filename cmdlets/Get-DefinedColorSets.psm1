function Get-DefinedColorSets {
    [CmdletBinding()]
    param ()
    return $global:__psshields.definedcolorsets
}