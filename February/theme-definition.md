# February Theme - Valentine's Day

## Theme Description
February's theme celebrates Valentine's Day with romantic reds, pinks, and heart icons. This theme brings a warm, loving feel to your terminal during the month of romance.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Deep Pink | `#FF1493` | R:255 G:20 B:147 | Shell segment background |
| Secondary Background | Light Pink | `#FFB6C1` | R:255 G:182 B:193 | Root segment background |
| Accent Color | Red | `#FF0000` | R:255 G:0 B:0 | Special highlights |
| Primary Text | White | `#FFFFFF` | R:255 G:255 B:255 | Most text elements |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| ❤️ | Red Heart | U+2764 | Shell | Symbol of love |
| 💘 | Heart with Arrow | U+1F498 | Root | Cupid's arrow |
| 💝 | Heart with Ribbon | U+1F49D | Path | Gift of love |
| 💐 | Bouquet | U+1F490 | Home | Valentine's flowers |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "❤️ {{ .Name }} ",
  "foreground": "#FFFFFF",
  "background": "#FF1493",
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
  "template": "<parentBackground>💘</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#FFB6C1",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 💝 ",
    "home_icon": " 💐 ",
    "style": "folder"
  },
  "template": " 💝 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#FF0000",
  "type": "path",
  "style": "powerline"
}
```

## Visual Preview

```
┏━━❯ ❤️ pwsh 
<💘> 💝 /Users/user/projects 
...
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\February\davids-February.omp.json" | Invoke-Expression
```

## Customization Tips

- Add more heart variations: 💓 💗 💖 💕 for different segments
- Use darker red backgrounds with white text for better readability
- Consider adding light pink backgrounds with dark red text for contrast
- Include rose (🌹) icons for a classic Valentine's touch
