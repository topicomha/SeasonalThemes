# May Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #50C878; color: #FFFFFF; padding: 5px">
      Background: #50C878<br />Text: #FFFFFF - Emerald Green (May birthstone)
    </td>
    <td style="background-color: #FCDC3B; color: #000000; padding: 5px">
      Background: #FCDC3B<br />Text: #000000 - Buttercup Yellow
    </td>
    <td style="background-color: #6495ED; color: #000080; padding: 5px">
      Background: #6495ED<br />Text: #000080 - Cornflower Blue
    </td>
    <td style="background-color: #B57EDC; color: #FFFFFF; padding: 5px">
      Background: #B57EDC<br />Text: #FFFFFF - Lavender Purple
    </td>
    <td style="background-color: #4CBB17; color: #5D4037; padding: 5px">
      Background: #4CBB17<br />Text: #5D4037 - Meadow Green
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🌻 (Sunflower - spring flower)
- Style: Diamond
- Colors: Emerald Green text on Buttercup Yellow background
- Shows: Current shell name

<table>
  <tr>
    <td style="background-color: #FCDC3B; color: #50C878; padding: 5px;">
      ╭─〈🌻 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🕊️ (Dove - Memorial Day peace symbol)
- Style: Diamond
- Colors: Navy Blue text on Cornflower Blue background
- Shows: Admin/User status

<table>
  <tr>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈🕊️ User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🎖️ (Medal - Memorial Day honor)
- Style: Powerline
- Colors: Rich Soil text on Meadow Green background
- Shows: Current directory path

<table>
  <tr>
    <td style="background-color: #4CBB17; color: #5D4037; padding: 5px;">
      〈🎖️ ~/code/SeasonalThemes/May〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: ☀️ (Sun - Spring sunshine)
- Style: Powerline
- Colors: Rich Soil text on Lavender Purple background
- Shows:
  - Branch name
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)
- Background changes based on git status

<table>
  <tr>
    <td style="background-color: #B57EDC; color: #5D4037; padding: 5px;">
      〈☀️ main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time

- Icon: ⏱️ (Clock - Timing)
- Style: Diamond
- Colors: Navy Blue text on Cornflower Blue background
- Shows: Command execution duration

<table>
  <tr>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈⏱️ 1.5s〉
    </td>
  </tr>
</table>

## Right Prompt Segments

### Language/Tool Segments

All use Diamond style with themed backgrounds:

<table>
  <tr>
    <td style="background-color: #FCDC3B; color: #50C878; padding: 5px;">
      〈🐝 node v18.19.0〉
    </td>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈🦋 python 3.11.0〉
    </td>
    <td style="background-color: #4CBB17; color: #5D4037; padding: 5px;">
      〈🎁 java 17.0.9〉
    </td>
    <td style="background-color: #50C878; color: #FCDC3B; padding: 5px;">
      〈🎀 .NET 7.0.405〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #B57EDC; color: #5D4037; padding: 5px;">
      〈🇺🇸 go 1.21.6〉
    </td>
    <td style="background-color: #FCDC3B; color: #50C878; padding: 5px;">
      〈🍖 rust 1.70.0〉
    </td>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈❤️ dart 3.0.5〉
    </td>
    <td style="background-color: #4CBB17; color: #5D4037; padding: 5px;">
      〈🍔 angular 16.1.3〉
    </td>
  </tr>
</table>

### Cloud Segments

All use Diamond style:

<table>
  <tr>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈✨ az-func-prod〉
    </td>
    <td style="background-color: #4CBB17; color: #5D4037; padding: 5px;">
      〈🌭 aws-dev〉
    </td>
    <td style="background-color: #50C878; color: #FCDC3B; padding: 5px;">
      〈🫡 k8s-prod〉
    </td>
  </tr>
</table>

### System Segments

<table>
  <tr>
    <td style="background-color: #B57EDC; color: #5D4037; padding: 5px;">
      〈🪟 Windows〉
    </td>
    <td style="background-color: #FCDC3B; color: #50C878; padding: 5px;">
      〈🍢 75%〉
    </td>
    <td style="background-color: #6495ED; color: #000080; padding: 5px;">
      〈👨‍🍳 3:04 PM〉
    </td>
  </tr>
</table>

## Bottom Prompt

<table>
  <tr>
    <td style="color: #4CBB17; padding: 5px;">
      ⌂──🌻
    </td>
    <td style="color: #6495ED; padding: 5px;">
      🐞 
    </td>
  </tr>
</table>

## Complete Prompt Example

<table>
  <tr>
    <td style="background: linear-gradient(to right, #FCDC3B, #6495ED, #4CBB17, #B57EDC, #6495ED); padding: 5px;">
      <span style="color: #50C878;">╭─〈🌻 pwsh〉</span><span style="color: #000080;">─〈🕊️ User〉</span><span style="color: #5D4037;">─〈🎖️ ~/code〉</span><span style="color: #5D4037;">─〈☀️ main ✏️ +2〉</span><span style="color: #000080;">─〈⏱️ 1.5s〉</span>─────────────<span style="color: #50C878;">〈🐝 node v18.19.0〉</span><span style="color: #000080;">─〈🦋 python 3.11.0〉</span><span style="color: #000080;">─〈👨‍🍳 3:04 PM〉</span>
    </td>
  </tr>
  <tr>
    <td style="padding: 5px;">
      <span style="color: #4CBB17;">⌂──🌻</span> <span style="color: #6495ED;">🐞 </span>
    </td>
  </tr>
</table>

## Theme Features

- **May-inspired color palette** featuring:
  - Emerald Green (May's birthstone)
  - Buttercup Yellow (spring flowers)
  - Cornflower Blue (May skies)
  - Lavender Purple (spring flowering plants)
  - Meadow Green (fresh spring growth)

- **Seasonal iconography** representing May's three themes:
  
  - **Spring Icons**
    - 🌻 Sunflower
    - ☀️ Sun
    - 🐝 Bee
    - 🦋 Butterfly
    - 🐞 Ladybug
    - ✨ Sparkles

  - **Mother's Day Icons**
    - ❤️ Heart
    - 💐 Bouquet
    - 🎁 Gift
    - 🎀 Ribbon

  - **Memorial Day Icons**
    - 🕊️ Dove (peace)
    - 🎖️ Medal (honor)
    - 🇺🇸 Flag (patriotism)
    - 🫡 Salute (respect)

  - **BBQ/Cookout Icons** (Memorial Day tradition)
    - 🍖 Meat
    - 🍔 Hamburger
    - 🔥 Fire/Grill
    - 🌭 Hot dog
    - 🍢 Skewer
    - 👨‍🍳 Chef

- **Enhanced visuals** with complementary colors for better readability
- **Error indication** that changes color when commands fail
- **Balanced representation** of all three May themes