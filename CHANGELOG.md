# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-04-07

### Added
- **Core:** `Invoke-ShieldsCommander` as the primary entry point for badge generation.
- **TUI:** Integrated `auspex` and `asciitableview` for rich terminal feedback.
- **Data:** 25+ platform configurations and 30+ color sets defined in JSON.
- **Foundations:** Established `CONTEXT-SOURCE/` and strict `PSScriptAnalyzer` rules.
- **Argument Completion:** Initial foundations for color and badge type tab completion.

### Changed
- **Architecture:** Replaced `miniforge` dependency with `auspex`.
- **Structure:** Centralized data definitions into `libs/definitions/`.
- **README:** Updated visual badges and installation instructions.

### Fixed
- Fixed redundant platform configurations in cmdlets.
- Resolved workspace structure inconsistencies for `GEMINI.md` compliance.
