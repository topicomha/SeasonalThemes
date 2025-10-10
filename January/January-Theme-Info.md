# January Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px">
      Background: #E0FFFF<br />Text: #0A1172
    </td>
    <td style="background-color: #ADD8E6; color: #0A1172; padding: 5px">
      Background: #ADD8E6<br />Text: #0A1172
    </td>
    <td style="background-color: #B0E0E6; color: #0A1172; padding: 5px">
      Background: #B0E0E6<br />Text: #0A1172
    </td>
    <td style="background-color: #87CEFA; color: #0A1172; padding: 5px">
      Background: #87CEFA<br />Text: #0A1172
    </td>
    <td style="background-color: #E6F7FF; color: #0A1172; padding: 5px">
      Background: #E6F7FF<br />Text: #0A1172
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: ❄️ (Snowflake)
- Style: Diamond
- Colors: Navy Blue text on Light Cyan background
- Shows: Current shell name

```
╭─〈❄️ pwsh〉
╭─〈❄️ bash〉
```

<table>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      ╭─〈❄️ pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: ☃️ (Snowman)
- Style: Diamond
- Colors: Navy Blue text on Light Blue background
- Shows: Admin/User status

```
〈☃️ User〉
〈☃️ Admin〉
```

<table>
  <tr>
    <td style="background-color: #ADD8E6; color: #0A1172; padding: 5px;">
      〈☃️ User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: ❄️ (Snowflake)
- Home Icon: 🏠 (House)
- Style: Powerline
- Colors: Navy Blue text on Powder Blue background
- Shows: Current directory path

```
〈❄️ ~/code〉
〈❄️ ~/code/SeasonalThemes/January〉
〈❄️ C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #B0E0E6; color: #0A1172; padding: 5px;">
      〈❄️ ~/code/SeasonalThemes/January〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: ⛷️ (Skier)
- Style: Powerline
- Colors: Navy Blue text on Light Sky Blue background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈⛷️ main〉
〈⛷️ feature/new... ✏️ +2〉
〈⛷️ develop 📂 +3〉
〈⛷️ main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #87CEFA; color: #0A1172; padding: 5px;">
      〈⛷️ main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🧊 (Ice Cube)
  - Error: 🥶 (Freezing Face)
- Style: Diamond
- Colors: Navy Blue text on Light Cyan background
- Shows: Success or failure of last command

```
〈🧊〉  (success)
〈🥶〉  (error)
```

<table>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      〈🧊〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      〈🥶〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈❄️ node v18.19.0〉
〈☃️ python 3.11.0〉
〈❄️ java 17.0.9〉
〈🏠 .NET 7.0.405〉
〈⛷️ go 1.21.6〉
〈🧊 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      〈❄️ node v18.19.0〉
    </td>
    <td style="background-color: #ADD8E6; color: #0A1172; padding: 5px;">
      〈☃️ python 3.11.0〉
    </td>
    <td style="background-color: #B0E0E6; color: #0A1172; padding: 5px;">
      〈❄️ java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #87CEFA; color: #0A1172; padding: 5px;">
      〈⛷️ .NET 7.0.405〉
    </td>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      〈🧊 go 1.21.6〉
    </td>
    <td style="background-color: #ADD8E6; color: #0A1172; padding: 5px;">
      〈☃️ rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈❄️ Windows〉
〈☃️ 100%〉
〈❄️ 75%〉
〈⛷️ 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      〈❄️ Windows〉
    </td>
    <td style="background-color: #ADD8E6; color: #0A1172; padding: 5px;">
      〈☃️ 100%〉
    </td>
    <td style="background-color: #B0E0E6; color: #0A1172; padding: 5px;">
      〈❄️ 75%〉
    </td>
    <td style="background-color: #87CEFA; color: #0A1172; padding: 5px;">
      〈⛷️ 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈❄️ pwsh〉─〈☃️ User〉─〈❄️ ~/code〉─〈⛷️ main ✏️ +2〉─〈🧊〉
╰─〈❄️ >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #E0FFFF, #ADD8E6, #B0E0E6, #87CEFA, #E0FFFF); color: #0A1172; padding: 5px;">
      ╭─〈❄️ pwsh〉─〈☃️ User〉─〈❄️ ~/code〉─〈⛷️ main ✏️ +2〉─〈🧊〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #E0FFFF; color: #0A1172; padding: 5px;">
      ╰─〈❄️ >〉
    </td>
  </tr>
</table>

## Theme Features

- **Winter blues color scheme** using various shades of blue and cyan
- **Winter-themed icons**:
  - Snowflake: ❄️
  - Snowman: ☃️
  - House: 🏠 (winter home)
  - Skier: ⛷️
  - Ice Cube: 🧊
  - Freezing Face: 🥶
- **Clean, icy look** with light backgrounds and dark blue text
- **Monochromatic palette** for a cohesive winter aesthetic
- **Bright, refreshing design** for the new year
