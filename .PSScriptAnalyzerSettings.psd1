@{
    Rules = @{
        PSAvoidUsingWriteHost = @{ Enable = $true }
        PSUseApprovedVerbs = @{ Enable = $true }
        PSAvoidUsingPlainTextForPassword = @{ Enable = $true }
        PSAvoidUsingAlias = @{ Enable = $true }
        PSAvoidUsingPositionalParameters = @{ Enable = $true }
        PSAvoidUsingEmptyCatchBlock = @{ Enable = $true }
        PSAvoidUsingBrokenHashAlgorithms = @{ Enable = $true }
        PSAvoidDefaultValueSwitchParameter = @{ Enable = $true }
        PSAvoidDefaultValueForMandatoryParameter = @{ Enable = $true }
        PSAvoidAssignmentToAutomaticVariable = @{ Enable = $true }
        PSAvoidGlobalVars = @{ Enable = $false } # We use $global:__psshields for palette state
        PSReviewUnusedParameter = @{ Enable = $true }
        PSUseSingularNouns = @{ Enable = $true }
        PSUseDeclaredVarsMoreThanAssignments = @{ Enable = $true }
    }
}
