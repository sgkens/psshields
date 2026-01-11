# TODO: 
#  * change this to pull from a json file at module import time allow easy extension
#  * params will automatic pull from this file using Get-PlatFromConfig
#  * and to top this off we can reference a Schema for the json file from the psshields repository
#     * To extend we just need to expand the json file
#  DEFAULT VARIABLES
#   - package
#   - namespace 
# ? Perhaps leave $platformConfig as a powershell object witch is much easy to manipulate than a json file
# ? pros 

function Get-PlatformConfig {
    [CmdletBinding()]
    [OutputType([Hashtable])]
    param()
    return $global:__psshields.platformConfig
}