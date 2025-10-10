# June Theme - Summer Vacation

## Theme Description
June's theme celebrates the beginning of summer with bright beach colors, vacation vibes, and outdoor activity icons. This fun theme brings the carefree feeling of summer vacation to your terminal with cool blues, sunny yellows, and beach-themed icons.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Sky Blue | `#87CEEB` | R:135 G:206 B:235 | Shell segment |
| Secondary Background | Turquoise | `#40E0D0` | R:64 G:224 B:208 | Root segment |
| Path Background | Mint Green | `#98FB98` | R:152 G:251 B:152 | Path segment |
| Git Background | Light Yellow | `#FFFFE0` | R:255 G:255 B:224 | Git segment |
| Python Background | Light Pink | `#FFBCD9` | R:255 G:188 B:217 | Python segment |
| Execution Background | Light Blue | `#87CEFA` | R:135 G:206 B:250 | Execution time segment |
| Status Background | Light Pink | `#FFB6C1` | R:255 G:182 B:193 | Status segment |
| Text Color | Black | `#000000` | R:0 G:0 B:0 | Text on light backgrounds |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 😎 | Smiling Face with Sunglasses | U+1F60E | Shell | Summer cool |
| 🏄 | Person Surfing | U+1F3C4 | Root | Summer activity |
| 🏖️ | Beach with Umbrella | U+1F3D6 | Folder | Summer location |
| 🏝️ | Desert Island | U+1F3DD | Home | Vacation destination |
| 🕶️ | Sunglasses | U+1F576 | Path | Summer accessory |
| 🌞 | Sun with Face | U+1F31E | Git branch | Summer sunshine |
| 🍉 | Watermelon | U+1F349 | Success status | Summer fruit |
| 🌋 | Volcano | U+1F30B | Error status | Summer heat |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "😎 {{ .Name }} ",
  "foreground": "#000000",
  "background": "#87CEEB",
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
  "template": "<parentBackground>🏄</> \uf292 ",
  "foreground": "#000000",
  "background": "#40E0D0",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🏖️ ",
    "home_icon": " 🏝️ ",
    "style": "folder"
  },
  "template": " 🕶️ {{ .Path }} ",
  "foreground": "#000000",
  "powerline_symbol": "\ue0b0",
  "background": "#98FB98",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "🌞 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#40E0D0> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#FFFFE0",
  "foreground": "#000000",
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
  "template": " {{ if eq .Status \"Success\" }}🍉{{ else }}🌋{{ end }} ",
  "foreground": "#000000",
  "background": "#FFB6C1",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 😎 pwsh 
<🏄> 🕶️ /Users/user/projects 
🌞 main ✏️ +1 ~2 -0 
 🍉 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\June\davids-June.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more summer activity icons: 🏊 (Swimming), ⛵ (Sailboat), 🏐 (Volleyball)
- Include summer treat icons: 🍦 (Ice Cream), 🍹 (Tropical Drink)
- Use 🌊 (Ocean Wave) for git/path segments
- Consider adding 👙 (Bikini) or 🩴 (Flip-Flop) for summer vacation items
- Use 🎓 (Graduation Cap) for graduation season references
