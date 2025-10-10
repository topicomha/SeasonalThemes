# April Theme - Spring & Easter

## Theme Description
April's theme celebrates spring renewal with pastel colors, Easter elements, and spring flowers. This cheerful theme incorporates rabbits, eggs, and spring blooms to bring the feeling of spring renewal to your terminal.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Light Green | `#B3E88F` | R:179 G:232 B:143 | Shell segment |
| Secondary Background | Light Cyan | `#B0FFFD` | R:176 G:255 B:253 | Root segment |
| Path Background | Light Salmon | `#EC9288` | R:236 G:146 B:136 | Path segment |
| Git Background | Light Yellow | `#FFFFA7` | R:255 G:255 B:167 | Git segment |
| Python Background | Light Purple | `#D8BFD8` | R:216 G:191 B:216 | Python segment |
| Text Color | Deep Forest Green | `#203C17` | R:32 G:60 B:23 | Shell text |
| Root Text | Navy Blue | `#202A5B` | R:32 G:42 B:91 | Root text |
| Path Text | Mahogany | `#4A241C` | R:74 G:36 B:28 | Path text |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🐰 | Rabbit | U+1F430 | Shell | Easter bunny |
| 🌿 | Herb | U+1F33F | Root | Spring growth |
| 🌻 | Sunflower | U+1F33B | Path, folder | Spring bloom |
| 🏡 | House with Garden | U+1F3E1 | Home | Spring home |
| 🌞 | Sun with Face | U+1F31E | Git branch | Spring sunshine |
| 🌸 | Cherry Blossom | U+1F338 | Status success | Spring flower |
| 🐣 | Hatching Chick | U+1F423 | Status error | Easter element |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🐰 {{ .Name }} ",
  "foreground": "#203C17",
  "background": "#B3E88F",
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
  "template": "<parentBackground>🌿</> \uf292 ",
  "foreground": "#202A5B",
  "background": "#B0FFFD",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🌻 ",
    "home_icon": " 🏡 ",
    "style": "folder"
  },
  "template": " 🌻 {{ .Path }} ",
  "foreground": "#4A241C",
  "powerline_symbol": "\ue0b0",
  "background": "#EC9288",
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
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#B0FFFD> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#FFFFA7",
  "foreground": "#203C17",
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
  "template": " {{ if eq .Status \"Success\" }}🌸{{ else }}🐣{{ end }} ",
  "foreground": "#203C17",
  "background": "#D8BFD8",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 🐰 pwsh 
<🌿> 🌻 /Users/user/projects 
🌞 main ✏️ +1 ~2 -0 
 🌸 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\April\davids-April.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more Easter icons: 🥚 (Egg), 🧺 (Basket)
- Include 🌷 (Tulip) and 🌼 (Blossom) for spring flower variety
- Use 🌈 (Rainbow) for spring weather elements
- Consider adding 🦋 (Butterfly) for spring wildlife
- Use ☔ (Umbrella with Rain) for "April showers" references
