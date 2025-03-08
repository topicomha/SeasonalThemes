# St. Patrick's Day Theme Segments

## Color Palette
<table>
  <tr>
    <td style="background-color: #006400; color: #FFFFFF; padding: 5px;">Dark Green (#006400)</td>
    <td style="background-color: #009E60; color: #FFFFFF; padding: 5px;">Shamrock Green (#009E60)</td>
    <td style="background-color: #32CD32; color: #FFFFFF; padding: 5px;">Lime Green (#32CD32)</td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">Gold (#FFD700)</td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment
- Icon: ☘️
- Style: Diamond
- Colors: White text on Dark Green background
- Shows: Current shell name
```
╭─〈☘️ pwsh〉
╭─〈☘️ bash〉
```
<table>
  <tr>
    <td style="background-color: #006400; color: #FFFFFF; padding: 5px;">
      ╭─〈☘️ pwsh〉
    </td>
  </tr>
</table>

| Environment | Example |
|------------|---------|
| Windows PowerShell | <table><tr><td style="background-color: #006400; color: #FFFFFF; padding: 5px;">╭─〈☘️ pwsh〉</td></tr></table> |
| Windows CMD | <table><tr><td style="background-color: #006400; color: #FFFFFF; padding: 5px;">╭─〈☘️ cmd〉</td></tr></table> |
| Linux Bash | <table><tr><td style="background-color: #006400; color: #FFFFFF; padding: 5px;">╭─〈☘️ bash〉</td></tr></table> |
| Linux ZSH | <table><tr><td style="background-color: #006400; color: #FFFFFF; padding: 5px;">╭─〈☘️ zsh〉</td></tr></table> |

| Windows | Linux | Other | Another |
|-|-|-|-|
| Windows Picture | Linux Picture | Other Picture | Another Picture |


### Root Segment
- Icon: 🎩
- Style: Diamond
- Colors: White text on Shamrock Green background
- Shows: Admin/User status
```
〈🎩 User〉
〈🎩 Admin〉
```
<table>
  <tr>
    <td style="background-color: #009E60; color: #FFFFFF; padding: 5px;">
      〈🎩 User〉
    </td>
  </tr>
</table>

### Path Segment
- Icon: 🍻
- Style: Powerline
- Colors: White text on Lime Green background
- Shows: Current directory path
```
〈🍻 ~/code〉
〈🍻 ~/code/SeasonalThemes/March〉
〈🍻 C:/Users/david.boyd〉
```
<table>
  <tr>
    <td style="background-color: #32CD32; color: #FFFFFF; padding: 5px;">
      〈🍻 ~/code/SeasonalThemes/March〉
    </td>
  </tr>
</table>

### Git Segment
- Icon: ☘️
- Style: Powerline
- Colors: Black text on Gold background
- Shows: 
  - Branch name (max length: 15)
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)
```
〈☘️ main〉
〈☘️ feature/new... ✏️ +2〉
〈☘️ develop 📂 +3〉
〈☘️ main ✏️ +1 📂 +2〉
```
<table>
  <tr>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈☘️ main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time
- Style: Diamond
- Colors: White text on Shamrock Green background
- Shows: Command execution duration
```
〈⌛ 1.5s〉
〈⌛ 250ms〉
〈⌛ 2m 30s〉
```
<table>
  <tr>
    <td style="background-color: #009E60; color: #FFFFFF; padding: 5px;">
      〈⌛ 1.5s〉
    </td>
  </tr>
</table>

## Complete Prompt Example
```
╭─〈☘️ pwsh〉─〈🎩 User〉─〈🍻 ~/code〉─〈☘️ main ✏️ +2〉─〈⌛ 1.5s〉
╰─〈� >〉
```
<table>
  <tr>
    <td style="background: linear-gradient(to right, #006400, #009E60, #32CD32, #FFD700, #009E60); color: #FFFFFF; padding: 5px;">
      ╭─〈☘️ pwsh〉─〈🎩 User〉─〈🍻 ~/code〉─〈☘️ main ✏️ +2〉─〈⌛ 1.5s〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #006400; color: #FFFFFF; padding: 5px;">
      ╰─〈🍀 >〉
    </td>
  </tr>
</table>
