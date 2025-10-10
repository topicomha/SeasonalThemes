# October Theme - Halloween

## Theme Description
October's theme embraces Halloween with orange, brown, and yellow colors plus spooky and autumn-themed icons. This comprehensive theme includes an extensive prompt with support for multiple programming languages, OS indicators, and battery status.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Pumpkin Orange | `#D35400` | R:211 G:84 B:0 | Shell segment |
| Secondary Background | Dark Brown | `#A04000` | R:160 G:64 B:0 | Root segment |
| Path Background | Carrot Orange | `#E67E22` | R:230 G:126 B:34 | Path segment |
| Git Background | Yellow | `#F1C40F` | R:241 G:196 B:15 | Git segment |
| Execution Background | Dark Brown | `#523422` | R:82 G:52 B:34 | Execution time segment |
| Node Background | Purple | `#8E44AD` | R:142 G:68 B:173 | Node segment |
| Path Text | Dark Gray | `#2d3436` | R:45 G:52 B:54 | Path text |
| Light Text | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |
| Python Text | Yellow | `#FFE873` | R:255 G:232 B:115 | Python segment text |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🍂 | Fallen Leaf | U+1F342 | Shell, various | Autumn foliage |
| 💀 | Skull | U+1F480 | Path, folder | Halloween, spooky |
| 🦴 | Bone | U+1F9B4 | Home directory | Halloween, spooky |
| 🌰 | Chestnut | U+1F330 | Git branch | Fall harvest |
| 🎃 | Pumpkin | U+1F383 | Execution time | Halloween |
| 🥧 | Pie | U+1F967 | NPM icon | Fall dessert |
| 🍁 | Maple Leaf | U+1F341 | Yarn icon, various | Fall foliage |
| 🕷️ | Spider | U+1F577 | Time | Halloween |
| 👻 | Ghost | U+1F47B | Status prompt | Halloween |

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
    "folder_icon": " 💀 ",
    "home_icon": " 🦴 ",
    "style": "folder"
  },
  "template": " 💀 {{ .Path }} ",
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
    "branch_icon": "🌰 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#A04000> 📂 {{ .Staging.String }}</>{{ end }} ",
  "foreground": "#011627",
  "powerline_symbol": "\ue0b0",
  "background": "#F1C40F",
  "type": "git",
  "style": "powerline",
  "background_templates": [
    "{{ if or (.Working.Changed) (.Staging.Changed) }}#f39c12{{ end }}",
    "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#f1c40f{{ end }}",
    "{{ if gt .Ahead 0 }}#F39C12{{ end }}",
    "{{ if gt .Behind 0 }}#F39C12{{ end }}"
  ]
}
```

### Execution Time Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "style": "roundrock",
    "threshold": 0
  },
  "trailing_diamond": "\ue0b4",
  "template": " 🎃 {{ .FormattedMs }} ",
  "foreground": "#ffffff",
  "background": "#523422",
  "type": "executiontime",
  "style": "diamond"
}
```

### Status Segment
```json
{
  "properties": {
    "always_enabled": true,
    "cache_duration": "none"
  },
  "template": "👻  ",
  "foreground": "#E0F8FF",
  "type": "status",
  "style": "plain",
  "foreground_templates": [
    "{{ if gt .Code 0 }}#A04000{{ end }}"
  ]
}
```

## Visual Preview

```
┏━━❯ 🍂 pwsh <🍂> 💀 /Users/user/projects 
🌰 main ✏️ +1 ~2 -0 | 🎃 15ms 

🎃 Node 16.14.2 🍂 Python 3.9.10 🍁 Java 17.0.2                    🕷️ 2023-10-31 5:30:45

⌂━━ 👻  
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\October\davids-October.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more Halloween icons: 🧙 (Witch), 🧛 (Vampire), 🦇 (Bat)
- Enhance the spooky theme with 👁️ (Eye) for watching processes
- Use 🎭 (Theater Masks) for git status to represent changes
- Add 🔮 (Crystal Ball) for predictive segments like suggestions
- Consider using 🧠 (Brain) for memory usage in system monitoring
