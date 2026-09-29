# Changelog

## 0.2.0

- Every month (and New Year's Eve) now comes in light and dark: 26 themes.
- `seasonalThemes.mode` chooses between them: follow the system's light/dark setting (default), switch at set times (`lightFrom` / `darkFrom`), or always light or dark.
- Theme files are named by mode (`themes/october-dark.json`, `october-light.json`) and labels end in `· Dark` / `· Light`.

## 0.1.0

- First release: 12 monthly themes and a New Year's Eve variant, generated from each month's `season.jsonc`.
- Switches to the current month's theme automatically while a Seasonal theme is active (`seasonalThemes.autoSwitch`).
- Replaces the fall-only [Fall-VSCode-Theme](https://github.com/topicomha/Fall-VSCode-Theme) extension.
