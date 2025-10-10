# May Theme - Memorial Day

## Theme Description
May's theme honors Memorial Day with patriotic colors (red, white, and blue) and symbols of honor, combined with spring elements. This theme balances the celebration of late spring with respectful remembrance.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Sunny Yellow | `#FCDC3B` | R:252 G:220 B:59 | Shell segment |
| Secondary Background | Cornflower Blue | `#6495ED` | R:100 G:149 B:237 | Root segment |
| Path Background | Kelly Green | `#4CBB17` | R:76 G:187 B:23 | Path segment |
| Git Background | Royal Blue | `#4169E1` | R:65 G:105 B:225 | Git segment |
| Python Background | Firebrick Red | `#B22222` | R:178 G:34 B:34 | Python segment |
| Shell Text | Emerald | `#50C878` | R:80 G:200 B:120 | Shell text |
| Root Text | Navy Blue | `#000080` | R:0 G:0 B:128 | Root text |
| Path Text | Brown | `#5D4037` | R:93 G:64 B:55 | Path text |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🕊️ | Dove | U+1F54A | Shell, Root | Peace symbol |
| 🎖️ | Military Medal | U+1F396 | Path, folder | Honor symbol |
| 🫡 | Saluting Face | U+1FAE1 | Home | Respect symbol |
| ☀️ | Sun | U+2600 | Git branch | Late spring |
| 🇺🇸 | US Flag | U+1F1FA U+1F1F8 | Status success | Patriotic symbol |
| 🦅 | Eagle | U+1F985 | Status error | American symbol |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🕊️ {{ .Name }} ",
  "foreground": "#50C878",
  "background": "#FCDC3B",
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
  "template": "<parentBackground>🕊️</> \uf292 ",
  "foreground": "#000080",
  "background": "#6495ED",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🎖️ ",
    "home_icon": " 🫡 ",
    "style": "folder"
  },
  "template": " 🎖️ {{ .Path }} ",
  "foreground": "#5D4037",
  "powerline_symbol": "\ue0b0",
  "background": "#4CBB17",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "☀️ ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#6495ED> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#4169E1",
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
  "template": " {{ if eq .Status \"Success\" }}🇺🇸{{ else }}🦅{{ end }} ",
  "foreground": "#FFFFFF",
  "background": "#B22222",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 🕊️ pwsh 
<🕊️> 🎖️ /Users/user/projects 
☀️ main ✏️ +1 ~2 -0 
 🇺🇸 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\May\davids-May.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more military honor icons: 🎗️ (Reminder Ribbon), 🏅 (Sports Medal)
- Include more spring elements: 🌱 (Seedling), 🌧️ (Cloud with Rain)
- Use 🌹 (Rose) for Memorial Day remembrance flowers
- Consider adding red, white, and blue segments in sequence
- Use 🔔 (Bell) for remembrance
