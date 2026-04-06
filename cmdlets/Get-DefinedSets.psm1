function Get-DefinedSets {
    <#
    .SYNOPSIS
        Retrieves the predefined badge sets available in the psshields module.
    
    .DESCRIPTION
        The Get-DefinedSets cmdlet fetches a list of predefined badge sets that can be used to generate badges using the psshields module. Each set contains a collection of badge configurations for various platforms and badge types.
    
    .OUTPUTS
        An array of objects representing the predefined badge sets.
    
    .EXAMPLE
        PS> Get-DefinedSets
    
        This command retrieves all predefined badge sets available in the psshields module.
    #>
    [CmdletBinding()]
    [OutputType([PsCustomobject[]])]
    param()
    return $global:__psshields.definedsets
}