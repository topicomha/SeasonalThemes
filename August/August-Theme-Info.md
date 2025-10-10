# August Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #FFA500; color: #000000; padding: 5px">
      Background: #FFA500<br />Text: #000000
    </td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px">
      Background: #FFD700<br />Text: #000000
    </td>
    <td style="background-color: #FFB347; color: #000000; padding: 5px">
      Background: #FFB347<br />Text: #000000
    </td>
    <td style="background-color: #228B22; color: #FFFFFF; padding: 5px">
      Background: #228B22<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FF8C00; color: #000000; padding: 5px">
      Background: #FF8C00<br />Text: #000000
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: ☀️ (Sun)
- Style: Diamond
- Colors: Black text on Orange background
- Shows: Current shell name

```
╭─〈☀️ pwsh〉
╭─〈☀️ bash〉
```

<table>
  <tr>
    <td style="background-color: #FFA500; color: #000000; padding: 5px;">
      ╭─〈☀️ pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🌻 (Sunflower)
- Style: Diamond
- Colors: Black text on Gold background
- Shows: Admin/User status

```
〈🌻 User〉
〈🌻 Admin〉
```

<table>
  <tr>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈🌻 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🍊 (Tangerine)
- Home Icon: 🏡 (House with Garden)
- Style: Powerline
- Colors: Black text on Pastel Orange background
- Shows: Current directory path

```
〈🍊 ~/code〉
〈🍊 ~/code/SeasonalThemes/August〉
〈🍊 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #FFB347; color: #000000; padding: 5px;">
      〈🍊 ~/code/SeasonalThemes/August〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🌿 (Herb)
- Style: Powerline
- Colors: White text on Forest Green background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🌿 main〉
〈🌿 feature/new... ✏️ +2〉
〈🌿 develop 📂 +3〉
〈🌿 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #228B22; color: #FFFFFF; padding: 5px;">
      〈🌿 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🏅 (Sports Medal)
  - Error: 🔥 (Fire)
- Style: Diamond
- Colors: Black text on Dark Orange background
- Shows: Success or failure of last command

```
〈🏅〉  (success)
〈🔥〉  (error)
```

<table>
  <tr>
    <td style="background-color: #FF8C00; color: #000000; padding: 5px;">
      〈🏅〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FF8C00; color: #000000; padding: 5px;">
      〈🔥〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈☀️ node v18.19.0〉
〈🌻 python 3.11.0〉
〈🍊 java 17.0.9〉
〈🌿 .NET 7.0.405〉
〈🏅 go 1.21.6〉
〈🔥 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #FFA500; color: #000000; padding: 5px;">
      〈☀️ node v18.19.0〉
    </td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈🌻 python 3.11.0〉
    </td>
    <td style="background-color: #FFB347; color: #000000; padding: 5px;">
      〈🍊 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #228B22; color: #FFFFFF; padding: 5px;">
      〈🌿 .NET 7.0.405〉
    </td>
    <td style="background-color: #FF8C00; color: #000000; padding: 5px;">
      〈🏅 go 1.21.6〉
    </td>
    <td style="background-color: #FFA500; color: #000000; padding: 5px;">
      〈🔥 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈☀️ Windows〉
〈🌻 100%〉
〈🍊 75%〉
〈🌿 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #FFA500; color: #000000; padding: 5px;">
      〈☀️ Windows〉
    </td>
    <td style="background-color: #FFD700; color: #000000; padding: 5px;">
      〈🌻 100%〉
    </td>
    <td style="background-color: #FFB347; color: #000000; padding: 5px;">
      〈🍊 75%〉
    </td>
    <td style="background-color: #228B22; color: #FFFFFF; padding: 5px;">
      〈🌿 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈☀️ pwsh〉─〈🌻 User〉─〈🍊 ~/code〉─〈🌿 main ✏️ +2〉─〈🏅〉
╰─〈☀️ >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #FFA500, #FFD700, #FFB347, #228B22, #FF8C00); color: #000000; padding: 5px;">
      ╭─〈☀️ pwsh〉─〈🌻 User〉─〈🍊 ~/code〉─〈🌿 main ✏️ +2〉─〈🏅〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FFA500; color: #000000; padding: 5px;">
      ╰─〈☀️ >〉
    </td>
  </tr>
</table>

## Theme Features

- **Late summer color scheme** using warm oranges, golds, and forest green
- **Harvest and summer-themed icons**:
  - Sun: ☀️
  - Sunflower: 🌻
  - Tangerine: 🍊
  - Herb: 🌿 (summer herbs)
  - Sports Medal: 🏅 (summer Olympics/sports)
  - Fire: 🔥 (summer heat)
  - House with Garden: 🏡 (summer home)
- **Warm color palette** reflecting the late summer heat
- **Harvest tones** representing the coming harvest season
- **High contrast** between segments for clear visual distinction
