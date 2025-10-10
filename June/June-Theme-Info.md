# June Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px">
      Background: #87CEEB<br />Text: #000000
    </td>
    <td style="background-color: #40E0D0; color: #000000; padding: 5px">
      Background: #40E0D0<br />Text: #000000
    </td>
    <td style="background-color: #98FB98; color: #000000; padding: 5px">
      Background: #98FB98<br />Text: #000000
    </td>
    <td style="background-color: #FFFFE0; color: #000000; padding: 5px">
      Background: #FFFFE0<br />Text: #000000
    </td>
    <td style="background-color: #FFB6C1; color: #000000; padding: 5px">
      Background: #FFB6C1<br />Text: #000000
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 😎 (Smiling Face with Sunglasses)
- Style: Diamond
- Colors: Black text on Sky Blue background
- Shows: Current shell name

```
╭─〈😎 pwsh〉
╭─〈😎 bash〉
```

<table>
  <tr>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px;">
      ╭─〈😎 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🏄 (Person Surfing)
- Style: Diamond
- Colors: Black text on Turquoise background
- Shows: Admin/User status

```
〈🏄 User〉
〈🏄 Admin〉
```

<table>
  <tr>
    <td style="background-color: #40E0D0; color: #000000; padding: 5px;">
      〈🏄 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🏖️ (Beach with Umbrella)
- Home Icon: 🏝️ (Desert Island)
- Style: Powerline
- Colors: Black text on Mint Green background
- Shows: Current directory path

```
〈🏖️ ~/code〉
〈🏖️ ~/code/SeasonalThemes/June〉
〈🏖️ C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #98FB98; color: #000000; padding: 5px;">
      〈🏖️ ~/code/SeasonalThemes/June〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🌞 (Sun with Face)
- Style: Powerline
- Colors: Black text on Light Yellow background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🌞 main〉
〈🌞 feature/new... ✏️ +2〉
〈🌞 develop 📂 +3〉
〈🌞 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #FFFFE0; color: #000000; padding: 5px;">
      〈🌞 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🍉 (Watermelon)
  - Error: 🌋 (Volcano)
- Style: Diamond
- Colors: Black text on Light Pink background
- Shows: Success or failure of last command

```
〈🍉〉  (success)
〈🌋〉  (error)
```

<table>
  <tr>
    <td style="background-color: #FFB6C1; color: #000000; padding: 5px;">
      〈🍉〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FFB6C1; color: #000000; padding: 5px;">
      〈🌋〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈😎 node v18.19.0〉
〈🏄 python 3.11.0〉
〈🏖️ java 17.0.9〉
〈🌞 .NET 7.0.405〉
〈🍉 go 1.21.6〉
〈🌋 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px;">
      〈😎 node v18.19.0〉
    </td>
    <td style="background-color: #40E0D0; color: #000000; padding: 5px;">
      〈🏄 python 3.11.0〉
    </td>
    <td style="background-color: #98FB98; color: #000000; padding: 5px;">
      〈🏖️ java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FFFFE0; color: #000000; padding: 5px;">
      〈🌞 .NET 7.0.405〉
    </td>
    <td style="background-color: #FFB6C1; color: #000000; padding: 5px;">
      〈🍉 go 1.21.6〉
    </td>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px;">
      〈🌋 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈😎 Windows〉
〈🏄 100%〉
〈🏖️ 75%〉
〈🌞 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px;">
      〈😎 Windows〉
    </td>
    <td style="background-color: #40E0D0; color: #000000; padding: 5px;">
      〈🏄 100%〉
    </td>
    <td style="background-color: #98FB98; color: #000000; padding: 5px;">
      〈🏖️ 75%〉
    </td>
    <td style="background-color: #FFFFE0; color: #000000; padding: 5px;">
      〈🌞 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈😎 pwsh〉─〈🏄 User〉─〈🏖️ ~/code〉─〈🌞 main ✏️ +2〉─〈🍉〉
╰─〈😎 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #87CEEB, #40E0D0, #98FB98, #FFFFE0, #FFB6C1); color: #000000; padding: 5px;">
      ╭─〈😎 pwsh〉─〈🏄 User〉─〈🏖️ ~/code〉─〈🌞 main ✏️ +2〉─〈🍉〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #87CEEB; color: #000000; padding: 5px;">
      ╰─〈😎 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Summer vacation color scheme** using bright beach colors
- **Summer activity and beach-themed icons**:
  - Sunglasses: 😎
  - Surfing: 🏄
  - Beach: 🏖️
  - Desert Island: 🏝️
  - Sun: 🌞
  - Watermelon: 🍉
  - Volcano: 🌋 (summer heat)
- **Light, cheerful colors** for the beginning of summer
- **Pastel palette** for a carefree summer vibe
- **High readability** with dark text on light backgrounds
