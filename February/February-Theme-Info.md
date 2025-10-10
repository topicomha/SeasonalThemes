# February Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px">
      Background: #E60023<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FF69B4; color: #FFFFFF; padding: 5px">
      Background: #FF69B4<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FF1493; color: #FFFFFF; padding: 5px">
      Background: #FF1493<br />Text: #FFFFFF
    </td>
    <td style="background-color: #FFC0CB; color: #8B0000; padding: 5px">
      Background: #FFC0CB<br />Text: #8B0000
    </td>
    <td style="background-color: #FFB6C1; color: #8B0000; padding: 5px">
      Background: #FFB6C1<br />Text: #8B0000
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: ❤️ (Red Heart)
- Style: Diamond
- Colors: White text on Valentine Red background
- Shows: Current shell name

```
╭─〈❤️ pwsh〉
╭─〈❤️ bash〉
```

<table>
  <tr>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px;">
      ╭─〈❤️ pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 💕 (Two Hearts)
- Style: Diamond
- Colors: White text on Hot Pink background
- Shows: Admin/User status

```
〈💕 User〉
〈💕 Admin〉
```

<table>
  <tr>
    <td style="background-color: #FF69B4; color: #FFFFFF; padding: 5px;">
      〈💕 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 💘 (Heart with Arrow)
- Home Icon: 🏠 (House)
- Style: Powerline
- Colors: White text on Deep Pink background
- Shows: Current directory path

```
〈💘 ~/code〉
〈💘 ~/code/SeasonalThemes/February〉
〈💘 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #FF1493; color: #FFFFFF; padding: 5px;">
      〈💘 ~/code/SeasonalThemes/February〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 💌 (Love Letter)
- Style: Powerline
- Colors: Dark Red text on Pink background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈💌 main〉
〈💌 feature/new... ✏️ +2〉
〈💌 develop 📂 +3〉
〈💌 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #FFC0CB; color: #8B0000; padding: 5px;">
      〈💌 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 💖 (Sparkling Heart)
  - Error: 💔 (Broken Heart)
- Style: Diamond
- Colors: Dark Red text on Light Pink background
- Shows: Success or failure of last command

```
〈💖〉  (success)
〈💔〉  (error)
```

<table>
  <tr>
    <td style="background-color: #FFB6C1; color: #8B0000; padding: 5px;">
      〈💖〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FFB6C1; color: #8B0000; padding: 5px;">
      〈💔〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈❤️ node v18.19.0〉
〈💕 python 3.11.0〉
〈💘 java 17.0.9〉
〈💌 .NET 7.0.405〉
〈💖 go 1.21.6〉
〈💔 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px;">
      〈❤️ node v18.19.0〉
    </td>
    <td style="background-color: #FF69B4; color: #FFFFFF; padding: 5px;">
      〈💕 python 3.11.0〉
    </td>
    <td style="background-color: #FF1493; color: #FFFFFF; padding: 5px;">
      〈💘 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FFC0CB; color: #8B0000; padding: 5px;">
      〈💌 .NET 7.0.405〉
    </td>
    <td style="background-color: #FFB6C1; color: #8B0000; padding: 5px;">
      〈💖 go 1.21.6〉
    </td>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px;">
      〈💔 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈❤️ Windows〉
〈💕 100%〉
〈💘 75%〉
〈💌 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px;">
      〈❤️ Windows〉
    </td>
    <td style="background-color: #FF69B4; color: #FFFFFF; padding: 5px;">
      〈💕 100%〉
    </td>
    <td style="background-color: #FF1493; color: #FFFFFF; padding: 5px;">
      〈💘 75%〉
    </td>
    <td style="background-color: #FFC0CB; color: #8B0000; padding: 5px;">
      〈💌 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈❤️ pwsh〉─〈💕 User〉─〈💘 ~/code〉─〈💌 main ✏️ +2〉─〈💖〉
╰─〈❤️ >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #E60023, #FF69B4, #FF1493, #FFC0CB, #FFB6C1); color: #FFFFFF; padding: 5px;">
      ╭─〈❤️ pwsh〉─〈💕 User〉─〈💘 ~/code〉─〈💌 main ✏️ +2〉─〈💖〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #E60023; color: #FFFFFF; padding: 5px;">
      ╰─〈❤️ >〉
    </td>
  </tr>
</table>

## Theme Features

- **Valentine's Day color scheme** using various shades of pink and red
- **Love-themed icons**:
  - Red Heart: ❤️
  - Two Hearts: 💕
  - Heart with Arrow: 💘
  - Love Letter: 💌
  - Sparkling Heart: 💖
  - Broken Heart: 💔
- **Bold, romantic design** with vibrant colors
- **Consistent heart motif** across all segments
- **High contrast** between segments for clear visual separation
