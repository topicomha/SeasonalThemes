# New Year Theme Definition

## Description
A festive New Year theme with celebratory icons and a modern color scheme of black, white, gold, blue, and silver. Perfect for ringing in the new year with a fresh terminal look.

## Color Palette
| Name      | Hex     | Usage                        |
|-----------|---------|------------------------------|
| Black     | #000000 | Background for shell segment |
| White     | #FFFFFF | Text for most segments       |
| Gold      | #FFD700 | Accent color for festive elements |
| Dodger Blue | #1E90FF | Secondary accent for cool contrast |
| Silver    | #808080 | Path background |

## Icons
- 🧑 - Person (shell)
- 🥂 - Champagne glasses (root, python, rust)
- 🎇 - Fireworks (path, java, dart)
- ⭐ - Star (git branch, .NET, angular)
- ⏱️ - Stopwatch (execution time)
- 🎉 - Party popper (node, go, nx)
- 🥳 - Partying face (home directory)
- 🍾 - Champagne bottle (Windows)
- ❄️ - Snowflake (battery discharging)
- 🔋 - Battery (fully charged)
- ⚡️ - Lightning (charging)
- 🕺 - Dancing person (status)

## Shell Configuration
```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "properties": {
            "cache_duration": "none"
          },
          "leading_diamond": "\u256d\u2500\ue0b6",
          "template": "🧑 {{ .Name }} ",
          "foreground": "#FFFFFF",
          "background": "#000000",
          "type": "shell",
          "style": "diamond"
        },
        {
          "properties": {
            "cache_duration": "none"
          },
          "template": "<parentBackground>🥂</> \uf292 ",
          "foreground": "#FFD700",
          "background": "#1E90FF",
          "type": "root",
          "style": "diamond"
        },
        {
          "properties": {
            "cache_duration": "none",
            "folder_icon": " 🎇 ",
            "home_icon": " 🥳 ",
            "style": "folder"
          },
          "template": " 🎇 {{ .Path }} ",
          "foreground": "#FFFFFF",
          "powerline_symbol": "\ue0b0",
          "background": "#808080",
          "type": "path",
          "style": "powerline"
        },
        {
          "properties": {
            "branch_icon": "⭐ ",
            "cache_duration": "none",
            "fetch_status": true,
            "fetch_upstream_icon": true
          },
          "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#808080> 📂 {{ .Staging.String }}</>{{ end }} ",
          "foreground": "#000000",
          "powerline_symbol": "\ue0b0",
          "background": "#FFD700",
          "type": "git",
          "style": "powerline",
          "background_templates": [
            "{{ if or (.Working.Changed) (.Staging.Changed) }}#FFD700{{ end }}",
            "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#FFD700{{ end }}",
            "{{ if gt .Ahead 0 }}#FFD700{{ end }}",
            "{{ if gt .Behind 0 }}#FFD700{{ end }}"
          ]
        },
        {
          "properties": {
            "cache_duration": "none",
            "style": "roundrock",
            "threshold": 0
          },
          "trailing_diamond": "\ue0b4",
          "template": " ⏱️ {{ .FormattedMs }} ",
          "foreground": "#000000",
          "background": "#FFD700",
          "type": "executiontime",
          "style": "diamond"
        }
      ]
    }
  ]
}
```

## Installation
To use this theme with Oh My Posh:

1. Save the JSON configuration to a file (e.g., `davids-NewYearTheme.omp.json`)
2. Set the theme in your shell profile:

For PowerShell:
```powershell
oh-my-posh init pwsh --config ~/path/to/davids-NewYearTheme.omp.json | Invoke-Expression
```

For Bash:
```bash
eval "$(oh-my-posh init bash --config ~/path/to/davids-NewYearTheme.omp.json)"
```

For ZSH:
```zsh
eval "$(oh-my-posh init zsh --config ~/path/to/davids-NewYearTheme.omp.json)"
```
