# Seasonal Themes

A theme for every month of the year, the same everywhere I work. January is a winter night, October is pumpkins and candy corn, December turns into New Year's Eve after Christmas. Each month comes in **light and dark**, following the system's setting or the time of day.

| Program | What you get |
|---|---|
| **VS Code** | The *Seasonal Themes* extension: 26 colour themes (every month and New Year's Eve, light and dark). It switches with the month, and with the system's light/dark mode. |
| **Oh My Posh** | A prompt for every month in both modes, plus `Get-SeasonalTheme.ps1` to pick today's prompt in your shell profile. |

Every month is defined by one document, `<Month>/season.jsonc` (palette, colour roles, icons, holidays, variants and light mode), and everything else is generated from it. Each month folder has a `theme-definition.md` page with its palette, roles and previews.

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

## Working on the themes

Change a month by editing its `season.jsonc`, then regenerate:

```bash
pwsh ./Generate-Themes.ps1          # regenerate everything
pwsh ./Generate-Themes.ps1 -Check   # what CI runs: fails if anything is out of date
```

Generated files are committed; never edit them by hand. [CLAUDE.md](CLAUDE.md) documents the document format, the generator, the VS Code standard, the tools and the workflow.

Changes go to `main` through pull requests; CI must pass. Tagging `main` with a version (`v0.2.0`) publishes a release.

## License

[MIT](LICENSE)
