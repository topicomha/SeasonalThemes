# December Theme - Holiday Season

## Theme Description
December's theme captures the winter holiday spirit with festive colors and holiday icons. This theme combines traditional Christmas colors with winter elements to create a cheerful, festive prompt during the holiday season.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Christmas Red | `#C80815` | R:200 G:8 B:21 | Shell segment |
| Secondary Background | Forest Green | `#046307` | R:4 G:99 B:7 | Root segment |
| Tertiary Background | Gold | `#FFD700` | R:255 G:215 B:0 | Git segment |
| Text Color | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |
| Dark Text | Dark Green | `#005500` | R:0 G:85 B:0 | Text on light backgrounds |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🎄 | Christmas Tree | U+1F384 | Shell | Holiday symbol |
| ❄️ | Snowflake | U+2744 | Root | Winter element |
| 🎁 | Wrapped Gift | U+1F381 | Path | Holiday gift |
| 🏠 | House | U+1F3E0 | Home | Winter home |
| ⛄ | Snowman | U+26C4 | Git branch | Winter character |
| 🔔 | Bell | U+1F514 | Status | Holiday bell |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🎄 {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#C80815",
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
  "template": "<parentBackground>❄️</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#046307",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🎁 ",
    "home_icon": " 🏠 ",
    "style": "folder"
  },
  "template": " 🎁 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#C80815",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "⛄ ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#046307> 📂 {{ .Staging.String }}</>{{ end }} ",
  "foreground": "#005500",
  "background": "#FFD700",
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
  "template": " {{ if eq .Status \"Success\" }}🔔{{ else }}❌{{ end }} ",
  "foreground": "#FFFFFF",
  "background": "#046307",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 🎄 pwsh 
<❄️> 🎁 /Users/user/projects 
⛄ main ✏️ +1 ~2 -0 
 🔔 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\December\davids-December.omp.json" | Invoke-Expression
```

### New Year's Theme Variant

For the New Year period at the end of December:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\December\davids-NewYearTheme.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more holiday icons: 🕯️ (Candle), 🦌 (Deer), 🧦 (Stocking)
- Include 🎅 (Santa) as a root or admin indicator
- Use 🌟 (Star) for status or execution segments
- Consider alternating red and green segments for a candy cane effect
- Add ☃️ (Snowman with Snow) for winter system monitoring
