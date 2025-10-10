# December Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px">
      Background: #C80815<br />Text: #FFFFFF
    </td>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px">
      Background: #046307<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FFD700; color: #005500; padding: 5px">
      Background: #FFD700<br />Text: #005500
    </td>
    <td style="background-color: #FFFFFF; color: #005500; padding: 5px">
      Background: #FFFFFF<br />Text: #005500
    </td>
    <td style="background-color: #006DB3; color: #FFFFFF; padding: 5px">
      Background: #006DB3<br />Text: #FFFFFF
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🎄 (Christmas Tree)
- Style: Diamond
- Colors: White text on Christmas Red background
- Shows: Current shell name

```
╭─〈🎄 pwsh〉
╭─〈🎄 bash〉
```

<table>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      ╭─〈🎄 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: ❄️ (Snowflake)
- Style: Diamond
- Colors: White text on Forest Green background
- Shows: Admin/User status

```
〈❄️ User〉
〈❄️ Admin〉
```

<table>
  <tr>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px;">
      〈❄️ User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🎁 (Wrapped Gift)
- Home Icon: 🏠 (House)
- Style: Powerline
- Colors: White text on Forest Green background
- Shows: Current directory path

```
〈🎁 ~/code〉
〈🎁 ~/code/SeasonalThemes/December〉
〈🎁 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px;">
      〈🎁 ~/code/SeasonalThemes/December〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: ⛄ (Snowman)
- Style: Powerline
- Colors: Dark Green text on Gold background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈⛄ main〉
〈⛄ feature/new... ✏️ +2〉
〈⛄ develop 📂 +3〉
〈⛄ main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #FFD700; color: #005500; padding: 5px;">
      〈⛄ main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time Segment

- Icon: ⏱️ (Stopwatch)
- Style: Powerline
- Colors: White text on Blue background
- Shows: Command execution duration

```
〈⏱️ 1.5s〉
〈⏱️ 250ms〉
〈⏱️ 2m 30s〉
```

<table>
  <tr>
    <td style="background-color: #006DB3; color: #FFFFFF; padding: 5px;">
      〈⏱️ 1.5s〉
    </td>
  </tr>
</table>

### Status Segment

- Icon: 🔔 (Bell)
- Style: Diamond
- Colors: White text on Christmas Red background
- Shows: Success or failure of last command

```
〈🔔〉  (success)
〈🔔〉  (error - changes color)
```

<table>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      〈🔔〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🎄 node v18.19.0〉
〈❄️ python 3.11.0〉
〈🎁 java 17.0.9〉
〈🏠 .NET 7.0.405〉
〈⛄ go 1.21.6〉
〈🔔 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      〈🎄 node v18.19.0〉
    </td>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px;">
      〈❄️ python 3.11.0〉
    </td>
    <td style="background-color: #FFD700; color: #005500; padding: 5px;">
      〈🎁 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #006DB3; color: #FFFFFF; padding: 5px;">
      〈🏠 .NET 7.0.405〉
    </td>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      〈⛄ go 1.21.6〉
    </td>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px;">
      〈🔔 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🎄 Windows〉
〈❄️ 100%〉
〈🎁 75%〉
〈⏱️ 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      〈🎄 Windows〉
    </td>
    <td style="background-color: #046307; color: #FFFFFF; padding: 5px;">
      〈❄️ 100%〉
    </td>
    <td style="background-color: #FFD700; color: #005500; padding: 5px;">
      〈🎁 75%〉
    </td>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      〈⏱️ 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🎄 pwsh〉─〈❄️ User〉─〈🎁 ~/code〉─〈⛄ main ✏️ +2〉─〈🔔〉
╰─〈🎄 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #C80815, #046307, #046307, #FFD700, #C80815); color: #FFFFFF; padding: 5px;">
      ╭─〈🎄 pwsh〉─〈❄️ User〉─〈🎁 ~/code〉─〈⛄ main ✏️ +2〉─〈🔔〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #C80815; color: #FFFFFF; padding: 5px;">
      ╰─〈🎄 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Holiday color scheme** using traditional Christmas colors of red and green with gold accents
- **Winter and festive-themed icons**:
  - Christmas Tree: 🎄
  - Snowflake: ❄️
  - Wrapped Gift: 🎁
  - House: 🏠 (winter home)
  - Snowman: ⛄
  - Bell: 🔔
- **High contrast design** for excellent visibility and festive mood
- **Gold accents** add a touch of holiday sparkle
- **Consistent holiday motif** across all segments
