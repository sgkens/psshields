# PSSHIELDS - TODOS

- [x] update `[gitlab]` tag to also referce the badge subtype for better readbility
- [x] Add additional helper function called `Invoke-SheldsCommander` to allow for more complex badge types and allow then generation of bagdes for `json`, `yml`(Requires `YamlDotNet`(powershell module)), and `toml`(Requires `ptoml`(powershell module(`WIP`)))
  - [x] Add custom Themes for defined badges create interal set and set default switch to pull from json file
- [ ] Implement supports for condition bases percentage
- [ ] Implement `Invoke-ShieldsCommander` to control all other pshields functions
  - [x] Add support for `New-CustomBagdge` in `Invoke-SheldsCommander`
  - [x] Add Support for `Get-BadgeTypes` in `Invoke-SheldsCommander`
  - [x] Add Support for `Get-BadgePalette` in `Invoke-SheldsCommander`
  - [x] Add Support for `Get-ColorPallete` in `Invoke-SheldsCommander`
- [ ] Inhance `Get-ColorPallete` to output Name wrapped in the ASCII color codes
- [ ] bring in asciitableview to output psobject in style, use universion theme