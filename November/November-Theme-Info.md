# November Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px">
      Background: #D35400<br />Text: #FFFFFF
    </td>
    <td style="background-color: #E67E22; color: #000000; padding: 5px">
      Background: #E67E22<br />Text: #000000
    </td>
    <td style="background-color: #F39C12; color: #000000; padding: 5px">
      Background: #F39C12<br />Text: #000000
    </td>
    <td style="background-color: #7D6608; color: #FFFFFF; padding: 5px">
      Background: #7D6608<br />Text: #FFFFFF
    </td>
    <td style="background-color: #6E2C00; color: #FFFFFF; padding: 5px">
      Background: #6E2C00<br />Text: #FFFFFF
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🍂 (Fallen Leaf)
- Style: Diamond
- Colors: White text on Burnt Orange background
- Shows: Current shell name

```
╭─〈🍂 pwsh〉
╭─〈🍂 bash〉
```

<table>
  <tr>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px;">
      ╭─〈🍂 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🦃 (Turkey)
- Style: Diamond
- Colors: Black text on Orange background
- Shows: Admin/User status

```
〈🦃 User〉
〈🦃 Admin〉
```

<table>
  <tr>
    <td style="background-color: #E67E22; color: #000000; padding: 5px;">
      〈🦃 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🍁 (Maple Leaf)
- Home Icon: 🏠 (House)
- Style: Powerline
- Colors: Black text on Amber background
- Shows: Current directory path

```
〈🍁 ~/code〉
〈🍁 ~/code/SeasonalThemes/November〉
〈🍁 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #F39C12; color: #000000; padding: 5px;">
      〈🍁 ~/code/SeasonalThemes/November〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🌰 (Chestnut)
- Style: Powerline
- Colors: White text on Dark Gold background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🌰 main〉
〈🌰 feature/new... ✏️ +2〉
〈🌰 develop 📂 +3〉
〈🌰 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #7D6608; color: #FFFFFF; padding: 5px;">
      〈🌰 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🍽️ (Plate with Cutlery)
  - Error: 🔥 (Fire)
- Style: Diamond
- Colors: White text on Dark Brown background
- Shows: Success or failure of last command

```
〈🍽️〉  (success)
〈🔥〉  (error)
```

<table>
  <tr>
    <td style="background-color: #6E2C00; color: #FFFFFF; padding: 5px;">
      〈🍽️〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #6E2C00; color: #FFFFFF; padding: 5px;">
      〈🔥〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🍂 node v18.19.0〉
〈🦃 python 3.11.0〉
〈🍁 java 17.0.9〉
〈🌰 .NET 7.0.405〉
〈🍽️ go 1.21.6〉
〈🔥 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px;">
      〈🍂 node v18.19.0〉
    </td>
    <td style="background-color: #E67E22; color: #000000; padding: 5px;">
      〈🦃 python 3.11.0〉
    </td>
    <td style="background-color: #F39C12; color: #000000; padding: 5px;">
      〈🍁 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #7D6608; color: #FFFFFF; padding: 5px;">
      〈🌰 .NET 7.0.405〉
    </td>
    <td style="background-color: #6E2C00; color: #FFFFFF; padding: 5px;">
      〈🍽️ go 1.21.6〉
    </td>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px;">
      〈🔥 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🍂 Windows〉
〈🦃 100%〉
〈🍁 75%〉
〈🌰 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px;">
      〈🍂 Windows〉
    </td>
    <td style="background-color: #E67E22; color: #000000; padding: 5px;">
      〈🦃 100%〉
    </td>
    <td style="background-color: #F39C12; color: #000000; padding: 5px;">
      〈🍁 75%〉
    </td>
    <td style="background-color: #7D6608; color: #FFFFFF; padding: 5px;">
      〈🌰 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🍂 pwsh〉─〈🦃 User〉─〈🍁 ~/code〉─〈🌰 main ✏️ +2〉─〈🍽️〉
╰─〈🍂 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #D35400, #E67E22, #F39C12, #7D6608, #6E2C00); padding: 5px;">
      ╭─〈🍂 pwsh〉─〈🦃 User〉─〈🍁 ~/code〉─〈🌰 main ✏️ +2〉─〈🍽️〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #D35400; color: #FFFFFF; padding: 5px;">
      ╰─〈🍂 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Autumn harvest color scheme** with rich oranges, ambers, and browns
- **Thanksgiving-themed icons**:
  - Fallen Leaf: 🍂
  - Turkey: 🦃
  - Maple Leaf: 🍁 
  - Chestnut: 🌰
  - Plate with Cutlery: 🍽️ (feast)
  - Fire: 🔥 (hearth)
  - House: 🏠
- **Warm, comforting colors** representing autumn harvest and Thanksgiving
- **Rich golden and brown tones** for a cozy November feel
- **Harvest and feast motifs** appropriate for Thanksgiving season
