# July Theme - Independence Day

## Theme Description
July's theme celebrates Independence Day (for the US) with patriotic red, white, and blue colors, stars, stripes, and traditional American symbols. The theme incorporates elements of celebration like fireworks and national pride symbols.

## Color Palette

| Element | Color Name | Hex Code | RGB Values | Purpose |
|---------|------------|----------|------------|---------|
| Primary Background | Navy Blue | `#000080` | R:0 G:0 B:128 | Shell segment |
| Secondary Background | Firebrick Red | `#B22222` | R:178 G:34 B:34 | Root segment |
| Path Background | Old Glory Blue | `#3C3B6E` | R:60 G:59 B:110 | Path segment |
| Git Background | Old Glory Red | `#B31942` | R:179 G:25 B:66 | Git segment |
| Python Background | White | `#FFFFFF` | R:255 G:255 B:255 | Python segment |
| Execution Background | Air Force Blue | `#0A3161` | R:10 G:49 B:97 | Execution time segment |
| Status Background | Firebrick Red | `#B22222` | R:178 G:34 B:34 | Status segment |
| Text Color | White | `#FFFFFF` | R:255 G:255 B:255 | Text on dark backgrounds |
| Python Text | Navy Blue | `#000080` | R:0 G:0 B:128 | Python text |

## Icons

| Icon | Name | Unicode | Segment | Purpose |
|------|------|---------|---------|---------|
| 🎆 | Fireworks | U+1F386 | Shell | Celebration |
| 🦅 | Eagle | U+1F985 | Root | American symbol |
| 🎇 | Sparkler | U+1F387 | Path, folder | Celebration |
| 🏛️ | Classical Building | U+1F3DB | Home | Capitol/monument |
| 🌟 | Glowing Star | U+1F31F | Git branch | Star symbol |
| 🇺🇸 | US Flag | U+1F1FA U+1F1F8 | Success status | National symbol |
| 🧨 | Firecracker | U+1F9E8 | Error status | Celebration |

## Segments Configuration

### Shell Segment
```json
{
  "properties": {
    "cache_duration": "none"
  },
  "leading_diamond": "\u256d\u2500\ue0b6",
  "template": "🎆 {{ .Name }} ",
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
  "template": "<parentBackground>🦅</> \uf292 ",
  "foreground": "#FFFFFF",
  "background": "#B22222",
  "type": "root",
  "style": "diamond"
}
```

### Path Segment
```json
{
  "properties": {
    "cache_duration": "none",
    "folder_icon": " 🎇 ",
    "home_icon": " 🏛️ ",
    "style": "folder"
  },
  "template": " 🎇 {{ .Path }} ",
  "foreground": "#FFFFFF",
  "powerline_symbol": "\ue0b0",
  "background": "#3C3B6E",
  "type": "path",
  "style": "powerline"
}
```

### Git Segment
```json
{
  "properties": {
    "branch_icon": "🌟 ",
    "cache_duration": "none",
    "fetch_status": true,
    "fetch_upstream_icon": true
  },
  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} ✏️ {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }}<#B22222> 📂 {{ .Staging.String }}</>{{ end }} ",
  "background": "#B31942",
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
  "template": " {{ if eq .Status \"Success\" }}🇺🇸{{ else }}🧨{{ end }} ",
  "foreground": "#FFFFFF",
  "background": "#B22222",
  "type": "status",
  "style": "diamond"
}
```

## Visual Preview

```
┏━━❯ 🎆 pwsh 
<🦅> 🎇 /Users/user/projects 
🌟 main ✏️ +1 ~2 -0 
 🇺🇸 
┗━━❯ 
```

## Usage

Add to your PowerShell profile:
```powershell
oh-my-posh init pwsh --config "C:\path\to\SeasonalThemes\July\davids-July.omp.json" | Invoke-Expression
```

## Customization Tips

- Alternate red, white, and blue segments for a striped effect
- Add 🗽 (Statue of Liberty) as an alternative home icon
- Include 🎺 (Trumpet) for celebration sounds
- Use 🎉 (Party Popper) for successful executions
- Consider adding 🍖 (Meat on Bone) for barbecue references
