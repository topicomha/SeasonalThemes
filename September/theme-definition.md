# September Theme - Back to School & Early Autumn

## Theme Description
September's theme represents the transition from summer to fall with autumn colors and back-to-school elements. This theme combines the early fall foliage colors with academic icons to capture the essence of September.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Brown | `#8B4513` | R:139 G:69 B:19 | Shell segment, tree bark |
| Secondary Background | Burnt Sienna | `#A0522D` | R:160 G:82 B:45 | Root segment, autumn color |
| Path Background | Goldenrod | `#DAA520` | R:218 G:165 B:32 | Path segment, autumn leaves |
| Git Background | Peru | `#CD853F` | R:205 G:133 B:63 | Git segment |
| Python Background | Dark Goldenrod | `#B8860B` | R:184 G:134 B:11 | Python segment |
| Execution Background | Chocolate | `#D2691E` | R:210 G:105 B:30 | Execution time segment |
| Status Background | Firebrick | `#B22222` | R:178 G:34 B:34 | Status segment, apple color |
| Text Color | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🍎 | Red Apple | U+1F34E | Shell | Back to school |
| 📚 | Books | U+1F4DA | Root | Education |
| 📓 | Notebook | U+1F4D3 | Folder | School supplies |
| 🏫 | School | U+1F3EB | Home directory | Home base |
| 🍂 | Fallen Leaf | U+1F342 | Path | Fall season |
| 🍁 | Maple Leaf | U+1F341 | Git branch | Autumn foliage |
| 🍏 | Green Apple | U+1F34F | Success status | School symbol |
| 🍎 | Red Apple | U+1F34E | Error status | Teacher's mark |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🍎 {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#8B4513",
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
  "template": "<parentBackground>📚</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#A0522D",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 📓 ",
    "home_icon": " 🏫 ",
    "style": "folder"
  },
  "template": " 🍂 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#DAA520",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "🍁 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#A0522D> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#CD853F",
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
  "template": " {{ if eq .Status \"Success\" }}🍏{{ else }}🍎{{ end }} ",
  "foreground": "#FFFFFF",
  "background": "#B22222",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 🍎 pwsh 
<📚> 🍂 /Users/user/projects 
🍁 main ✏️ +1 ~2 -0 
 🍏 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\September\davids-September.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more school supply icons: ✏️ 📏 📐 for various segments
- Include 📚 (Books) icon in multiple places to reinforce the education theme
- Consider using 🎒 (Backpack) as an alternative home icon
- Add 📝 (Memo) or 📄 (Document) icons for file-related segments
