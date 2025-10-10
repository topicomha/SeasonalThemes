# September Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px">
      Background: #8B4513<br />Text: #FFFFFF
    </td>
    <td style="background-color: #D2691E; color: #FFFFFF; padding: 5px">
      Background: #D2691E<br />Text: #FFFFFF
    </td>
    <td style="background-color: #CD853F; color: #FFFFFF; padding: 5px">
      Background: #CD853F<br />Text: #FFFFFF
    </td>
    <td style="background-color: #DAA520; color: #000000; padding: 5px">
      Background: #DAA520<br />Text: #000000
    </td>
    <td style="background-color: #A0522D; color: #FFFFFF; padding: 5px">
      Background: #A0522D<br />Text: #FFFFFF
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🍁 (Maple Leaf)
- Style: Diamond
- Colors: White text on Saddle Brown background
- Shows: Current shell name

```
╭─〈🍁 pwsh〉
╭─〈🍁 bash〉
```

<table>
  <tr>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px;">
      ╭─〈🍁 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🍂 (Fallen Leaf)
- Style: Diamond
- Colors: White text on Chocolate background
- Shows: Admin/User status

```
〈🍂 User〉
〈🍂 Admin〉
```

<table>
  <tr>
    <td style="background-color: #D2691E; color: #FFFFFF; padding: 5px;">
      〈🍂 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🌰 (Chestnut)
- Home Icon: 🏠 (House)
- Style: Powerline
- Colors: White text on Peru background
- Shows: Current directory path

```
〈🌰 ~/code〉
〈🌰 ~/code/SeasonalThemes/September〉
〈🌰 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #CD853F; color: #FFFFFF; padding: 5px;">
      〈🌰 ~/code/SeasonalThemes/September〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🦊 (Fox)
- Style: Powerline
- Colors: Black text on Goldenrod background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🦊 main〉
〈🦊 feature/new... ✏️ +2〉
〈🦊 develop 📂 +3〉
〈🦊 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #DAA520; color: #000000; padding: 5px;">
      〈🦊 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🍎 (Red Apple)
  - Error: 🦉 (Owl)
- Style: Diamond
- Colors: White text on Sienna background
- Shows: Success or failure of last command

```
〈🍎〉  (success)
〈🦉〉  (error)
```

<table>
  <tr>
    <td style="background-color: #A0522D; color: #FFFFFF; padding: 5px;">
      〈🍎〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #A0522D; color: #FFFFFF; padding: 5px;">
      〈🦉〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🍁 node v18.19.0〉
〈🍂 python 3.11.0〉
〈🌰 java 17.0.9〉
〈🦊 .NET 7.0.405〉
〈🍎 go 1.21.6〉
〈🦉 rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px;">
      〈🍁 node v18.19.0〉
    </td>
    <td style="background-color: #D2691E; color: #FFFFFF; padding: 5px;">
      〈🍂 python 3.11.0〉
    </td>
    <td style="background-color: #CD853F; color: #FFFFFF; padding: 5px;">
      〈🌰 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #DAA520; color: #000000; padding: 5px;">
      〈🦊 .NET 7.0.405〉
    </td>
    <td style="background-color: #A0522D; color: #FFFFFF; padding: 5px;">
      〈🍎 go 1.21.6〉
    </td>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px;">
      〈🦉 rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🍁 Windows〉
〈🍂 100%〉
〈🌰 75%〉
〈🦊 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px;">
      〈🍁 Windows〉
    </td>
    <td style="background-color: #D2691E; color: #FFFFFF; padding: 5px;">
      〈🍂 100%〉
    </td>
    <td style="background-color: #CD853F; color: #FFFFFF; padding: 5px;">
      〈🌰 75%〉
    </td>
    <td style="background-color: #DAA520; color: #000000; padding: 5px;">
      〈🦊 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🍁 pwsh〉─〈🍂 User〉─〈🌰 ~/code〉─〈🦊 main ✏️ +2〉─〈🍎〉
╰─〈🍁 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #8B4513, #D2691E, #CD853F, #DAA520, #A0522D); color: #FFFFFF; padding: 5px;">
      ╭─〈🍁 pwsh〉─〈🍂 User〉─〈🌰 ~/code〉─〈🦊 main ✏️ +2〉─〈🍎〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #8B4513; color: #FFFFFF; padding: 5px;">
      ╰─〈🍁 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Early autumn color scheme** using warm browns, oranges, and golds
- **Fall-themed icons**:
  - Maple Leaf: 🍁
  - Fallen Leaf: 🍂
  - Chestnut: 🌰
  - Fox: 🦊 (autumn forest animal)
  - Red Apple: 🍎 (fall harvest)
  - Owl: 🦉 (autumn wildlife)
- **Rich earth tones** reflecting the changing leaves
- **Warm, cozy palette** for the beginning of fall
- **Woodland creatures** representing autumn wildlife
