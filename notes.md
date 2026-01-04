# Dev Notes

## Updating and adding new types

- types must be set in three places `Get-BadgeTypes`, `New-ShieldBadge`, and `New-StandardBadge`
  - update validatesets for each platform and badge type to allow new types
  - add types to hashtable objects located in the `$platformConfig` variable in the `Get-BadgeTypes` function and `New-ShieldBadge` function