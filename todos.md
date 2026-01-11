# `psshields` Development Roadmap

**Status Legend:** `[x]` Complete | `[ ]` Pending | `[-]` Cancelled/Deferred

* [x] **GitLab Tag:** Update `[gitlab]` tag to reference the badge subtype for improved readability.
* [x] **Helper Function (`Invoke-ShieldsCommander`):** Implement helper to handle complex badge types and generation logic.
* [x] Support generation from `json`.
* [-] Support generation from `yml` (Requires `YamlDotNet`).
* [-] Support generation from `toml` (Requires `ptoml` - *WIP*).
* [x] **Themes:** Implement custom themes (internal set) with a default switch to pull from JSON configuration.


* [ ] **Conditional Logic:** Implement support for condition-based percentages.
* [ ] **Controller Logic:** Finalize `Invoke-ShieldsCommander` to control all other `psshields` functions.
  * [x] Integrate `New-CustomBadge`.
  * [x] Integrate `Get-BadgeTypes`.
  * [x] Integrate `Get-BadgePalette`.
  * [x] Integrate `Get-ColorPalette`.


* [ ] **Output Styling (`Get-ColorPalette`):** Enhance output to wrap the Name in ASCII color codes.
  * [-] *Deferred:* Idea discontinued due to object padding issues; to be revisited in future iterations.


* [x] **TUI Formatting:** Integrate `asciitableview` to output `PSObject` data using the "Universe" theme.
* [x] **Platform Logic:** Update `Invoke-ShieldsCommander` default repository platform logic.
* Added logic to toggle between GitHub and GitLab defaults using parameters (e.g., `-GitLab`, `-GitHub`) instead of defaulting strictly to GitLab.


* [ ] **Output Enhancements:**
* [ ] **Generation Summary:** Update output to display Project Type, Badge Count, and visual examples (limit 3) for verification.
* **View Functions:**
* [x] Compact the badge type output (adjust newlines).
* [ ] **Preview Mode:** Add `-Preview` parameter to filter arrays and display only the selected color set.



* [ ] **Documentation Generation:** Integrate `PHWriter` for help generation.
  * Limit scope to exposed functions: `Invoke-ShieldsCommander`, `New-BadgeType`, `New-CustomBadge`, and `New-ProjectBadge`.
  * *Note: `New-ProjectBadge` to be deprecated in favor of `Invoke-ShieldsCommander` upon release.*


* [ ] **README:** Complete documentation with detailed function references and usage examples.
* [ ] **Gitlab-Pages** with single page theme, allows readme to be not so usage fat but build and deployable information.
