# November Theme - Thanksgiving

## Theme Description
November's theme features warm autumn colors and Thanksgiving-related icons. The theme represents the height of fall with deep orange, brown, and golden tones along with fall foliage and feast imagery.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Warm Orange | `#D35400` | R:211 G:84 B:0 | Shell segment |
| Secondary Background | Dark Brown | `#A04000` | R:160 G:64 B:0 | Root segment |
| Path Background | Pumpkin Orange | `#E67E22` | R:230 G:126 B:34 | Path segment |
| Path Text | Dark Gray | `#2d3436` | R:45 G:52 B:54 | Path text for contrast |
| Light Text | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |
| Yellow Accent | Bright Yellow | `#FFFB38` | R:255 G:251 B:56 | Root text |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🍂 | Fallen Leaf | U+1F342 | Shell, root | Autumn foliage |
| 🦃 | Turkey | U+1F983 | Folder | Thanksgiving symbol |
| 🍁 | Maple Leaf | U+1F341 | Home | Fall foliage |
| 🍗 | Poultry Leg | U+1F357 | Path | Thanksgiving feast |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🍂 {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#D35400",
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
  "template": "<parentBackground>🍂</> \uf292 ",
  "foreground": "#FFFB38",
  "background": "#A04000",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🦃 ",
    "home_icon": " 🍁 ",
    "style": "folder"
  },
  "template": " 🍗🍗🍗 {{ .Path }} ",
  "foreground": "#2d3436",
  "powerline_symbol": "\ue0b0",
  "background": "#E67E22",
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
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#A04000> 📂 {{ .Staging.String }}</>{{ end }} ",
  "foreground": "#2d3436",
  "background": "#E67E22",
  "type": "git",
  "style": "powerline"
}
```

## Visual Preview

```
┏━━❯ 🍂 pwsh 
<🍂> 🍗🍗🍗 /Users/user/projects 
🍁 main ✏️ +1 ~2 -0 
...
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\November\davids-november.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more Thanksgiving food icons: 🥧 (Pie), 🌽 (Corn), 🍠 (Sweet Potato)
- Include 🍽️ (Plate with Utensils) for command execution segments
- Use 🦃 (Turkey) more prominently throughout the theme
- Consider adding 🍂 (Fallen Leaf) variations in different segments
- Use 🍊 (Tangerine) for autumn fruit representation
