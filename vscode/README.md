# Seasonal Themes

A colour theme for every month of the year, plus a New Year's Eve variant at the end of December. Each month has its own palette and its own feel (a winter-night January, a chalkboard September, a pumpkin-and-charcoal October), but every theme follows the same standard, so VS Code always looks and behaves consistently.

The themes come from the same month documents (`season.jsonc`) as the matching [Oh My Posh](https://ohmyposh.dev) prompts in [SeasonalThemes](https://github.com/topicomha/SeasonalThemes), so the editor and the terminal match.

## Themes

| | Theme | |
|---|---|---|
| ❄️ | Seasonal 01 · January — Winter Wonderland | steel-blue ice status bar on polar night |
| 🌹 | Seasonal 02 · February — Valentine's Day | rose and hot pink on red wine |
| ☘️ | Seasonal 03 · March — St. Patrick's Day | shamrock and gold in a pub snug |
| 🐰 | Seasonal 04 · April — Spring Showers | pastels in a night garden |
| 🕊️ | Seasonal 05 · May — May Flowers | buttercup and cornflower at dusk |
| 🌞 | Seasonal 06 · June — Summer Break | summer sky and sunshine over night surf |
| 🎆 | Seasonal 07 · July — Independence Day | red, white and blue fireworks |
| ☀️ | Seasonal 08 · August — Late Summer | golden sun and turquoise water |
| 🍎 | Seasonal 09 · September — Back to School | apple red on a chalkboard |
| 🍂 | Seasonal 10 · October — Halloween | pumpkin and candy corn on charcoal |
| 🍂 | Seasonal 11 · November — Thanksgiving | roast brown by the hearth |
| 🎄 | Seasonal 12 · December — Holiday Season | Christmas red and evergreen |
| 🥳 | Seasonal 12 · December — New Year's Eve | champagne gold and fireworks blue (Dec 26–31) |

Pick one with **Preferences: Color Theme** (`Ctrl+K Ctrl+T`). Every month's page in the repository has a preview (`<Month>/vscode-preview.svg`).

## Switching with the month

While a Seasonal theme is active, the extension switches to the current month's theme on startup and checks again every hour, so it changes soon after midnight on the first of the month. It never switches away from a theme that isn't one of these.

- **Seasonal Themes: Use This Month's Theme** (command palette) switches to today's theme from any theme.
- Set `"seasonalThemes.autoSwitch": false` to keep whichever Seasonal theme you pick.

## Building

The themes are generated; don't edit `themes/*.json` or `package.json` by hand. From the repository root:

```bash
pwsh ./Generate-Themes.ps1            # regenerate every month's files, including these themes
cd vscode && npx @vscode/vsce package # build seasonal-themes-<version>.vsix
```

Install the `.vsix` with **Extensions: Install from VSIX...**.
