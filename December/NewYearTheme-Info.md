# New Year Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #000000; color: #FFFFFF; padding: 5px">
      Background: #000000<br />Text: #FFFFFF
    </td>
    <td style="background-color: #1E90FF; color: #FFFFFF; padding: 5px">
      Background: #1E90FF<br />Text: #FFFFFF
    </td>
    <td style="background-color: #808080; color: #FFFFFF; padding: 5px">
      Background: #808080<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px">
      Background: #FFD700<br />Text: #000000
    </td>
    <td style="background-color: #FFFFFF; color: #000000; padding: 5px">
      Background: #FFFFFF<br />Text: #000000
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🧑 (Person)
- Style: Diamond
- Colors: White text on Black background
- Shows: Current shell name

```
╭─〈🧑 pwsh〉
╭─〈🧑 bash〉
```

<table>
  <tr>
    <td style="background-color: #000000; color: #FFFFFF; padding: 5px;">
      ╭─〈🧑 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🥂 (Champagne glasses)
- Style: Diamond
- Colors: Gold text on Dodger Blue background
- Shows: Admin/User status

```
〈🥂 User〉
〈🥂 Admin〉
```

<table>
  <tr>
    <td style="background-color: #1E90FF; color: #FFD700; padding: 5px;">
      〈🥂 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🎇 (Fireworks)
- Home Icon: 🥳 (Partying face)
- Style: Powerline
- Colors: White text on Silver background
- Shows: Current directory path

```
〈🎇 ~/code〉
〈🎇 ~/code/SeasonalThemes/December〉
〈🎇 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #808080; color: #FFFFFF; padding: 5px;">
      〈🎇 ~/code/SeasonalThemes/December〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: ⭐ (Star)
- Style: Powerline
- Colors: Black text on Gold background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈⭐ main〉
〈⭐ feature/new... ✏️ +2〉
〈⭐ develop 📂 +3〉
〈⭐ main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈⭐ main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time Segment

- Icon: ⏱️ (Stopwatch)
- Style: Diamond
- Colors: Black text on Gold background
- Shows: Execution time of last command

```
〈⏱️ 42ms〉
〈⏱️ 1.2s〉
〈⏱️ 3m45s〉
```

<table>
  <tr>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈⏱️ 1.2s〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🎉 node v18.19.0〉
〈🥂 python 3.11.0〉
〈🎇 java 17.0.9〉
〈⭐ .NET 7.0.405〉
〈🎉 go 1.21.6〉
〈🥂 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #000000; color: #FFFFFF; padding: 5px;">
      〈🎉 node v18.19.0〉
    </td>
    <td style="background-color: #1E90FF; color: #FFD700; padding: 5px;">
      〈🥂 python 3.11.0〉
    </td>
    <td style="background-color: #808080; color: #FFFFFF; padding: 5px;">
      〈🎇 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #000000; color: #FFFFFF; padding: 5px;">
      〈⭐ .NET 7.0.405〉
    </td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈🎉 go 1.21.6〉
    </td>
    <td style="background-color: #1E90FF; color: #FFFFFF; padding: 5px;">
      〈🥂 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🍾 Windows〉
〈🔋 100%〉
〈❄️ 75%〉
〈🎉🥂 2024-01-01 12:00:00 AM〉
```

<table>
  <tr>
    <td style="background-color: #000000; color: #FFFFFF; padding: 5px;">
      〈🍾 Windows〉
    </td>
    <td style="background-color: #33DD2D; color: #FFFFFF; padding: 5px;">
      〈🔋 100%〉
    </td>
    <td style="background-color: #fff34e; color: #000000; padding: 5px;">
      〈❄️ 75%〉
    </td>
    <td style="background-color: #000000; color: #FFD700; padding: 5px;">
      〈🎉🥂 2024-01-01 12:00:00 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🧑 pwsh〉─〈🥂 User〉─〈🎇 ~/code〉─〈⭐ main ✏️ +2〉─〈⏱️ 42ms〉
╰─〈🕺 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #000000, #1E90FF, #808080, #FFD700); padding: 5px;">
      ╭─〈🧑 pwsh〉─〈🥂 User〉─〈🎇 ~/code〉─〈⭐ main ✏️ +2〉─〈⏱️ 42ms〉
    </td>
  </tr>
  <tr>
    <td style="color: #FFD700; padding: 5px;">
      ╰─〈🕺 >〉
    </td>
  </tr>
</table>

## Theme Features

- **New Year Celebration theme** with festive colors and icons
- **Celebration-themed icons**:
  - Person: 🧑
  - Champagne glasses: 🥂
  - Fireworks: 🎇
  - Star: ⭐
  - Stopwatch: ⏱️
  - Party popper: 🎉
  - Partying face: 🥳
  - Champagne bottle: 🍾
  - Dancing person: 🕺
  - Battery/Weather icons: 🔋⚡️❄️
- **Elegant color scheme** combining black, white, gold, blue, and silver
- **Festive yet professional look** appropriate for New Year celebrations
- **Good contrast and readability** while maintaining a celebratory feel
