# July Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #000080; color: #FFFFFF; padding: 5px">
      Background: #000080<br />Text: #FFFFFF
    </td>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px">
      Background: #B22222<br />Text: #FFFFFF
    </td>
    <td style="background-color: #3C3B6E; color: #FFFFFF; padding: 5px">
      Background: #3C3B6E<br />Text: #FFFFFF
    </td>
    <td style="background-color: #B31942; color: #FFFFFF; padding: 5px">
      Background: #B31942<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FFFFFF; color: #000080; padding: 5px">
      Background: #FFFFFF<br />Text: #000080
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🎆 (Fireworks)
- Style: Diamond
- Colors: White text on Navy Blue background
- Shows: Current shell name

```
╭─〈🎆 pwsh〉
╭─〈🎆 bash〉
```

<table>
  <tr>
    <td style="background-color: #000080; color: #FFFFFF; padding: 5px;">
      ╭─〈🎆 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🦅 (Eagle)
- Style: Diamond
- Colors: White text on Firebrick Red background
- Shows: Admin/User status

```
〈🦅 User〉
〈🦅 Admin〉
```

<table>
  <tr>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🦅 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🎇 (Sparkler)
- Home Icon: 🏛️ (Classical Building)
- Style: Powerline
- Colors: White text on Old Glory Blue background
- Shows: Current directory path

```
〈🎇 ~/code〉
〈🎇 ~/code/SeasonalThemes/July〉
〈🎇 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #3C3B6E; color: #FFFFFF; padding: 5px;">
      〈🎇 ~/code/SeasonalThemes/July〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🌟 (Glowing Star)
- Style: Powerline
- Colors: White text on Old Glory Red background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🌟 main〉
〈🌟 feature/new... ✏️ +2〉
〈🌟 develop 📂 +3〉
〈🌟 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #B31942; color: #FFFFFF; padding: 5px;">
      〈🌟 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time Segment

- Icon: ⏱️ (Stopwatch)
- Style: Powerline
- Colors: White text on Air Force Blue background
- Shows: Command execution duration

```
〈⏱️ 1.5s〉
〈⏱️ 250ms〉
〈⏱️ 2m 30s〉
```

<table>
  <tr>
    <td style="background-color: #0A3161; color: #FFFFFF; padding: 5px;">
      〈⏱️ 1.5s〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🇺🇸 (US Flag)
  - Error: 🧨 (Firecracker)
- Style: Diamond
- Colors: White text on Firebrick Red background
- Shows: Success or failure of last command

```
〈🇺🇸〉  (success)
〈🧨〉   (error)
```

<table>
  <tr>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🇺🇸〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🧨〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🎆 node v18.19.0〉
〈🦅 python 3.11.0〉
〈🎇 java 17.0.9〉
〈🏛️ .NET 7.0.405〉
〈🌟 go 1.21.6〉
〈🧨 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #000080; color: #FFFFFF; padding: 5px;">
      〈🎆 node v18.19.0〉
    </td>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🦅 python 3.11.0〉
    </td>
    <td style="background-color: #3C3B6E; color: #FFFFFF; padding: 5px;">
      〈🎇 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #B31942; color: #FFFFFF; padding: 5px;">
      〈🏛️ .NET 7.0.405〉
    </td>
    <td style="background-color: #0A3161; color: #FFFFFF; padding: 5px;">
      〈🌟 go 1.21.6〉
    </td>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🧨 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🎆 Windows〉
〈🔋 100%〉
〈⚡️ 75%〉
〈⏱️ 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #000080; color: #FFFFFF; padding: 5px;">
      〈🎆 Windows〉
    </td>
    <td style="background-color: #B22222; color: #FFFFFF; padding: 5px;">
      〈🔋 100%〉
    </td>
    <td style="background-color: #3C3B6E; color: #FFFFFF; padding: 5px;">
      〈⚡️ 75%〉
    </td>
    <td style="background-color: #B31942; color: #FFFFFF; padding: 5px;">
      〈⏱️ 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🎆 pwsh〉─〈🦅 User〉─〈🎇 ~/code〉─〈🌟 main ✏️ +2〉─〈🇺🇸〉
╰─〈🎆 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #000080, #B22222, #3C3B6E, #B31942, #B22222); color: #FFFFFF; padding: 5px;">
      ╭─〈🎆 pwsh〉─〈🦅 User〉─〈🎇 ~/code〉─〈🌟 main ✏️ +2〉─〈🇺🇸〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #000080; color: #FFFFFF; padding: 5px;">
      ╰─〈🎆 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Independence Day color scheme** using patriotic red, white, and blue
- **Celebration-themed icons**:
  - Fireworks: 🎆
  - Sparkler: 🎇
  - US Flag: 🇺🇸
  - Eagle: 🦅
  - Firecracker: 🧨
  - Classical Building: 🏛️ (monument/capitol)
  - Glowing Star: 🌟
- **Bold contrasting colors** for excellent visibility in bright outdoor settings
- **Segments are styled** to create a stars and stripes visual effect
- **Success indicator** uses the US Flag for a patriotic touch
