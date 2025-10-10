# March Theme - St. Patrick's Day

## Theme Description
March's theme celebrates St. Patrick's Day with various shades of green, shamrocks, and Irish-themed icons. This theme brings the luck of the Irish to your terminal with festive elements.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Dark Green | `#006400` | R:0 G:100 B:0 | Shell segment |
| Secondary Background | Shamrock Green | `#009E60` | R:0 G:158 B:96 | Root segment |
| Path Background | Lime Green | `#32CD32` | R:50 G:205 B:50 | Path segment |
| Git Background | Kelly Green | `#4CBB17` | R:76 G:187 B:23 | Git segment |
| Python Background | Irish Green | `#169B62` | R:22 G:155 B:98 | Python segment |
| Text Color | White | `#FFFFFF` | R:255 G:255 B:255 | Most text elements |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| ☘️ | Shamrock | U+2618 | Shell | St. Patrick's symbol |
| 🎩 | Top Hat | U+1F3A9 | Root | Leprechaun hat |
| 🍻 | Clinking Beer Mugs | U+1F37B | Path, folder | Irish celebration |
| 🤞 | Crossed Fingers | U+1F91E | Home | Luck symbol |
| 🍀 | Four Leaf Clover | U+1F340 | Git branch | Good luck symbol |
| 🌈 | Rainbow | U+1F308 | Status | Pot of gold reference |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "☘️ {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#006400",
  "type": "shell",
  "style": "diamond"
}
```

### Root Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "template": "<parentBackground>🎩</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#009E60",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🍻 ",
    "home_icon": " 🤞 ",
    "max_depth": 3,
    "style": "folder"
  },
  "template": " 🍻 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#32CD32",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "🍀 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#009E60> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#4CBB17",
  "foreground": "#FFFFFF",
  "type": "git",
  "style": "powerline"
}
```

### Status Segment
```json
{
  "properties": {
    "always_enabled": true,
    "cache_duration": "none"
  },
  "trailing_diamond": "\ue0b4\u2500\u2500\u2500\u256e",
  "template": " {{ if eq .Status \"Success\" }}🌈{{ else }}☘️{{ end }} ",
  "foreground": "#FFFFFF",
  "background": "#169B62",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ ☘️ pwsh 
<🎩> 🍻 /Users/user/projects 
🍀 main ✏️ +1 ~2 -0 
 🌈 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\March\davids-March.omp.json" | Invoke-Expression
```

## Customization Tips

- Add gold coin (💰) icons for a treasure theme
- Include 🇮🇪 (Irish Flag) for special segments
- Use 🥃 (Whiskey Glass) instead of beer mugs for a different take
- Consider using 🧙 (Wizard) as an alternative to the leprechaun hat
- Add darker green backgrounds for higher contrast with white text
