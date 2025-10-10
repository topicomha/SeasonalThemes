# August Theme - Late Summer

## Theme Description
August's theme captures the essence of late summer with warm golden tones, beach vibes, and harvest imagery. The theme balances bright summer colors with elements representing the coming harvest season.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Golden Yellow | `#FFD700` | R:255 G:215 B:0 | Shell segment, sun representation |
| Secondary Background | Turquoise | `#40E0D0` | R:64 G:224 B:208 | Path segment, ocean water |
| Tertiary Background | Dark Orange | `#FF8C00` | R:255 G:140 B:0 | Root segment, sunset colors |
| Git Background | Sea Green | `#2E8B57` | R:46 G:139 B:87 | Git segment |
| Python Background | Khaki | `#F0E68C` | R:240 G:230 B:140 | Python segment, sand color |
| Execution Background | Teal | `#008080` | R:0 G:128 B:128 | Execution time segment |
| Status Background | Mustard Yellow | `#FFDB58` | R:255 G:219 B:88 | Status segment |
| Dark Text | Black | `#000000` | R:0 G:0 B:0 | Text on light backgrounds |
| Light Text | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| ☀️ | Sun | U+2600 | Shell | Summer sun |
| 🏖️ | Beach with Umbrella | U+1F3D6 | Root | Summer vacation |
| 🌴 | Palm Tree | U+1F334 | Folder | Summer/tropical |
| 🏡 | Home | U+1F3E1 | Home directory | Home in summer |
| 🌻 | Sunflower | U+1F33B | Path | Late summer bloom |
| 🌾 | Sheaf of Rice | U+1F33E | Git branch | Harvest beginning |
| 🍉 | Watermelon | U+1F349 | Success status | Summer fruit |
| 🔥 | Fire | U+1F525 | Error status | Summer heat |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "☀️ {{ .Name }} ",
  "foreground": "#000000",
  "background": "#FFD700",
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
  "template": "<parentBackground>🏖️</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#FF8C00",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🌴 ",
    "home_icon": " 🏡 ",
    "style": "folder"
  },
  "template": " 🌻 {{ .Path }} ",
  "foreground": "#000000",
  "powerline_symbol": "\ue0b0",
  "background": "#40E0D0",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "🌾 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#FF8C00> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#2E8B57",
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
  "template": " {{ if eq .Status \"Success\" }}🍉{{ else }}🔥{{ end }} ",
  "foreground": "#111111",
  "background": "#FFDB58",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ ☀️ pwsh 
<🏖️> 🌻 /Users/user/projects 
🌾 main ✏️ +1 ~2 -0 
 🍉 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\August\davids-August.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more summer fruit icons: 🍇 🍑 🍓 to represent harvest season
- Consider using sunset gradient colors for a late summer evening feel
- Add 🌅 (Sunset) icon for time-related segments
- Include 🏊 (Swimming) icons for a summer recreation theme
