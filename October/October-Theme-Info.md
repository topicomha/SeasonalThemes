# October Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px">
      Background: #FF6B35<br />Text: #000000
    </td>
    <td style="background-color: #F7C59F; color: #000000; padding: 5px">
      Background: #F7C59F<br />Text: #000000
    </td>
    <td style="background-color: #004E89; color: #FFFFFF; padding: 5px">
      Background: #004E89<br />Text: #FFFFFF
    </td>
    <td style="background-color: #2A9D8F; color: #FFFFFF; padding: 5px">
      Background: #2A9D8F<br />Text: #FFFFFF
    </td>
    <td style="background-color: #E9C46A; color: #000000; padding: 5px">
      Background: #E9C46A<br />Text: #000000
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🎃 (Jack-O-Lantern)
- Style: Diamond
- Colors: Black text on Burnt Orange background
- Shows: Current shell name

```
╭─〈🎃 pwsh〉
╭─〈🎃 bash〉
```

<table>
  <tr>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px;">
      ╭─〈🎃 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 👻 (Ghost)
- Style: Diamond
- Colors: Black text on Peach background
- Shows: Admin/User status

```
〈👻 User〉
〈👻 Admin〉
```

<table>
  <tr>
    <td style="background-color: #F7C59F; color: #000000; padding: 5px;">
      〈👻 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🍁 (Maple Leaf)
- Home Icon: 🏚️ (Derelict House)
- Style: Powerline
- Colors: White text on Deep Blue background
- Shows: Current directory path

```
〈🍁 ~/code〉
〈🍁 ~/code/SeasonalThemes/October〉
〈🍁 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #004E89; color: #FFFFFF; padding: 5px;">
      〈🍁 ~/code/SeasonalThemes/October〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🦇 (Bat)
- Style: Powerline
- Colors: White text on Deep Teal background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)

```
〈🦇 main〉
〈🦇 feature/new... ✏️ +2〉
〈🦇 develop 📂 +3〉
〈🦇 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #2A9D8F; color: #FFFFFF; padding: 5px;">
      〈🦇 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Status Segment

- Icons: 
  - Success: 🍬 (Candy)
  - Error: 🕸️ (Spider Web)
- Style: Diamond
- Colors: Black text on Golden Yellow background
- Shows: Success or failure of last command

```
〈🍬〉  (success)
〈🕸️〉  (error)
```

<table>
  <tr>
    <td style="background-color: #E9C46A; color: #000000; padding: 5px;">
      〈🍬〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #E9C46A; color: #000000; padding: 5px;">
      〈🕸️〉
    </td>
  </tr>
</table>

## Programming Language Segments

All use Diamond style with themed backgrounds:

```
〈🎃 node v18.19.0〉
〈👻 python 3.11.0〉
〈🍁 java 17.0.9〉
〈🦇 .NET 7.0.405〉
〈🍬 go 1.21.6〉
〈🕸️ rust 1.70.0〉
```

<table>
  <tr>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px;">
      〈🎃 node v18.19.0〉
    </td>
    <td style="background-color: #F7C59F; color: #000000; padding: 5px;">
      〈👻 python 3.11.0〉
    </td>
    <td style="background-color: #004E89; color: #FFFFFF; padding: 5px;">
      〈🍁 java 17.0.9〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #2A9D8F; color: #FFFFFF; padding: 5px;">
      〈🦇 .NET 7.0.405〉
    </td>
    <td style="background-color: #E9C46A; color: #000000; padding: 5px;">
      〈🍬 go 1.21.6〉
    </td>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px;">
      〈🕸️ rust 1.70.0〉
    </td>
  </tr>
</table>

## System Segments

```
〈🎃 Windows〉
〈👻 100%〉
〈🍁 75%〉
〈🦇 10:04 AM〉
```

<table>
  <tr>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px;">
      〈🎃 Windows〉
    </td>
    <td style="background-color: #F7C59F; color: #000000; padding: 5px;">
      〈👻 100%〉
    </td>
    <td style="background-color: #004E89; color: #FFFFFF; padding: 5px;">
      〈🍁 75%〉
    </td>
    <td style="background-color: #2A9D8F; color: #FFFFFF; padding: 5px;">
      〈🦇 10:04 AM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🎃 pwsh〉─〈👻 User〉─〈🍁 ~/code〉─〈🦇 main ✏️ +2〉─〈🍬〉
╰─〈🎃 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #FF6B35, #F7C59F, #004E89, #2A9D8F, #E9C46A); color: #000000; padding: 5px;">
      ╭─〈🎃 pwsh〉─〈👻 User〉─〈🍁 ~/code〉─〈🦇 main ✏️ +2〉─〈🍬〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #FF6B35; color: #000000; padding: 5px;">
      ╰─〈🎃 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Halloween color scheme** combining autumn tones with spooky accents
- **Halloween-themed icons**:
  - Jack-O-Lantern: 🎃
  - Ghost: 👻
  - Maple Leaf: 🍁 (fall foliage)
  - Bat: 🦇
  - Candy: 🍬 (trick or treat)
  - Spider Web: 🕸️
  - Derelict House: 🏚️ (haunted house)
- **Bold, contrasting colors** for a dramatic Halloween mood
- **Mix of warm autumnal tones** and cool spooky accents
- **Playful yet mysterious feel** appropriate for the Halloween season
