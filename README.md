<p align="center"><img src="vscode/icon.png" width="128" alt="Seasonal Themes icon"></p>

<h1 align="center">Seasonal Themes</h1>

<p align="center">
  <a href="https://github.com/topicomha/SeasonalThemes/releases/latest"><img src="https://img.shields.io/github/v/release/topicomha/SeasonalThemes" alt="Latest release"></a>
  <a href="https://github.com/topicomha/SeasonalThemes/actions/workflows/check-themes.yml"><img src="https://github.com/topicomha/SeasonalThemes/actions/workflows/check-themes.yml/badge.svg" alt="Check themes"></a>
  <a href="LICENSE"><img src="https://img.shields.io/github/license/topicomha/SeasonalThemes" alt="MIT license"></a>
  <a href="#developed-with-ai"><img src="https://img.shields.io/badge/developed%20with-Claude%20Code-D97757" alt="Developed with Claude Code"></a>
</p>

A theme for every month of the year, the same everywhere I work. January is a winter night, October is pumpkins and candy corn, December turns into New Year's Eve after Christmas. Each month comes in **light and dark**, following the system's setting or the time of day.

| Program | What you get |
|---|---|
| **VS Code** | The *Seasonal Themes* extension: 26 colour themes (every month and New Year's Eve, light and dark). It switches with the month, and with the system's light/dark mode. |
| **Oh My Posh** | A prompt for every month in both modes, plus `Get-SeasonalTheme.ps1` to pick today's prompt in your shell profile. |

Every month is defined by one document, `<Month>/season.jsonc` (palette, colour roles, icons, holidays, variants and light mode), and everything else is generated from it. Open a month's folder to see its summary: previews, colours and icons, generated from that document so it's always in sync. The full detail is in each month's `theme-definition.md`.

**Months:** [January](January) · [February](February) · [March](March) · [April](April) · [May](May) · [June](June) · [July](July) · [August](August) · [September](September) · [October](October) · [November](November) · [December](December)

## Install

Download the latest [release](https://github.com/topicomha/SeasonalThemes/releases/latest).

**VS Code:** install `seasonal-themes-<version>.vsix` with **Extensions: Install from VSIX…**, then pick any *Seasonal* theme with **Preferences: Color Theme**. From then on it keeps up with the month. The `seasonalThemes.mode` setting chooses how light and dark are picked:
- `system` (default) follows the OS
- `time` switches at set hours
- `light` or `dark` fixes it.

**Oh My Posh:** unzip `oh-my-posh-themes-<version>.zip` (or clone this repo) and add one line to your profile:

```powershell
# PowerShell
oh-my-posh init pwsh --config (& ~/SeasonalThemes/Get-SeasonalTheme.ps1) | Invoke-Expression
```

```bash
# zsh (use bash for bash)
eval "$(oh-my-posh init zsh --config "$(pwsh -NoProfile -File ~/SeasonalThemes/Get-SeasonalTheme.ps1)")"
```

The prompts use emoji and [Nerd Font](https://www.nerdfonts.com) glyphs, and `Get-SeasonalTheme.ps1` needs PowerShell 7.4+.

## Developed with AI

This project is developed with AI. The code, the themes and the docs are written by [Claude Code](https://claude.com/claude-code), Anthropic's coding agent, and I review and merge its work.

- **I describe what I want**, such as a new month, a colour change or a new program. Claude Code makes the change on a branch and opens a pull request. The PR shows before/after previews, and lists the decisions that are mine to make.
- **I review and merge.** `main` only accepts pull requests. CI must pass, which means every generated file is regenerated and matches, and every text colour is readable on its background.
- **[CLAUDE.md](CLAUDE.md) is its working brief:** the goals, the `season.jsonc` format, the generator, the conventions and the workflow. It's kept up to date in the same PR as any change to them, so each session starts from how the project really works.
- **AI-written commits say so**, with a `Co-Authored-By: Claude` trailer.

Contributions from people are welcome the same way: open a pull request.

## Working on the themes

Change a month by editing its `season.jsonc`, then regenerate:

```bash
pwsh ./Generate-Themes.ps1          # regenerate everything
pwsh ./Generate-Themes.ps1 -Check   # what CI runs: fails if anything is out of date
```

Generated files are committed; never edit them by hand. [CLAUDE.md](CLAUDE.md) documents the document format, the generator, the VS Code standard and the tools.

Tagging `main` with a version (`v0.2.0`) publishes a release. Retired files are kept under `archive/*` tags (see CLAUDE.md).

## License

[MIT](LICENSE)
