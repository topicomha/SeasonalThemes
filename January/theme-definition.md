# January Theme - Winter Wonderland

## Theme Description
The January theme captures the essence of winter with cool blues, whites, and winter-related icons. It's designed to evoke the feeling of a crisp winter day with snow-covered landscapes.

## Color Palette

| Element | Color Name | Hex Code | RGB | Purpose |
|---------|------------|----------|-----|---------|
| Primary Background | Navy Blue | `#000080` | rgb(0, 0, 128) | Shell segment background |
| Secondary Background | Steel Blue | `#4682B4` | rgb(70, 130, 180) | Root segment background |
| Tertiary Background | Sea Green | `#2E8B57` | rgb(46, 139, 87) | Git segment background |
| Primary Text | White | `#FFFFFF` | rgb(255, 255, 255) | Most text elements |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| ❄️ | Snowflake | U+2744 | Shell | Represents winter/snow |
| ⛄ | Snowman | U+26C4 | Root | Winter character |
| 🎿 | Skiing | U+1F3BF | Path | Winter activity |
| 🏔️ | Snow-capped Mountain | U+1F3D4 | Home | Winter landscape |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "❄️ {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#000080",
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
  "template": "<parentBackground>⛄</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#4682B4",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🎿 ",
    "home_icon": " 🏔️ ",
    "style": "folder"
  },
  "template": " 🎿 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#2E8B57",
  "type": "path",
  "style": "powerline"
}
```

## Visual Preview

```
┏━━❯ ❄️ pwsh 
<⛄> 🎿 /Users/user/projects 
...
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\January\davids-January.omp.json" | Invoke-Expression
```

## Customization Tips

- Modify the blue tones to be lighter or darker based on your terminal background
- Add snowflake icons (❄️) to more segments for a consistent winter theme
- Consider adding a light blue battery segment to represent "cold" winter energy
