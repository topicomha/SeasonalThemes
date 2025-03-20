# April Theme Documentation

## Color Palette

<table>
  <tr>
    <td style="background-color: #B3E88F; color: #203c17; padding: 5px">
      Background: #B3E88F<br />Text: #203C17
    </td>
    <td style="background-color: #B0FFFD; color: #202a5b; padding: 5px">
      Background: #B0FFFD<br />Text:  #202A5B
    </td>
    <td style="background-color: #EC9288; color: #4a241c; padding: 5px">
      Background: #EC9288<br />Text: #4A241C
    </td>
    <td style="background-color: #FFE4A2; color: #5c4b1d; padding: 5px">
      Background: #FFE4A2<br />Text: #5C4B1D
    </td>
    <td style="background-color: #CDA0FF; color: #4A204E; padding: 5px">
      Background: #CDA0FF<br />Text: #4A204E
    </td>
  </tr>
</table>

## Left Prompt Segments

### Shell Segment

- Icon: 🌱
- Style: Diamond
- Colors: White text on Darker Sea Green background
- Shows: Current shell name

```
╭─〈🌱 pwsh〉
╭─〈🌱 bash〉
```

<table>
  <tr>
    <td style="background-color: #5E8B7E; color: #FFFFFF; padding: 5px;">
      ╭─〈🌱 pwsh〉
    </td>
  </tr>
</table>

### Root Segment

- Icon: 🌿
- Style: Diamond
- Colors: White text on Darker Periwinkle background
- Shows: Admin/User status

```
〈🌿 User〉
〈🌿 Admin〉
```

<table>
  <tr>
    <td style="background-color: #7D92B5; color: #FFFFFF; padding: 5px;">
      〈🌿 User〉
    </td>
  </tr>
</table>

### Path Segment

- Icon: 🌻
- Style: Powerline
- Colors: White text on Darker Salmon background
- Shows: Current directory path

```
〈🌻 ~/code〉
〈🌻 ~/code/SeasonalThemes/April〉
〈🌻 C:/Users/david.boyd〉
```

<table>
  <tr>
    <td style="background-color: #C27160; color: #FFFFFF; padding: 5px;">
      〈🌻 ~/code/SeasonalThemes/April〉
    </td>
  </tr>
</table>

### Git Segment

- Icon: 🌞
- Style: Powerline
- Colors: Dark Gray text on Darker Butter Yellow background
- Shows:
  - Branch name (max length: 15)
  - Branch status
  - Working changes (✏️)
  - Staged changes (📂)
- Background changes based on git status

```
〈🌞 main〉
〈🌞 feature/new... ✏️ +2〉
〈🌞 develop 📂 +3〉
〈🌞 main ✏️ +1 📂 +2〉
```

<table>
  <tr>
    <td style="background-color: #E6D595; color: #2D2A2E; padding: 5px;">
      〈🌞 main ✏️ +1 📂 +2〉
    </td>
  </tr>
</table>

### Execution Time

- Icon: 🌈
- Style: Diamond
- Colors: White text on Darker Mint background
- Shows: Command execution duration

```
〈🌈 1.5s〉
〈🌈 250ms〉
〈🌈 2m 30s〉
```

<table>
  <tr>
    <td style="background-color: #69AC9A; color: #FFFFFF; padding: 5px;">
      〈🌈 1.5s〉
    </td>
  </tr>
</table>

## Right Prompt Segments

### Language/Tool Segments

All use Diamond style with themed backgrounds:

```
〈🐝 node v18.19.0〉
〈🦋 python 3.11.0〉
〈🐌 java 17.0.9〉
〈🐞 .NET 7.0.405〉
〈🐜 go 1.21.6〉
〈🦗 rust 1.70.0〉
〈🕷️ dart 3.0.5〉
〈🐢 angular 16.1.3〉
〈🐛 nx 16.5.1〉
〈🌸 julia 1.9.2〉
〈🌼 ruby 3.2.2〉
```

<table>
  <tr>
    <td style="background-color: #5E8B7E; color: #FFFFFF; padding: 5px;">
      〈🐝 node v18.19.0〉
    </td>
    <td style="background-color: #7D92B5; color: #FFFFFF; padding: 5px;">
      〈🦋 python 3.11.0〉
    </td>
    <td style="background-color: #C27160; color: #FFFFFF; padding: 5px;">
      〈🐌 java 17.0.9〉
    </td>
    <td style="background-color: #B090B0; color: #FFFFFF; padding: 5px;">
      〈🐞 .NET 7.0.405〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #E6D595; color: #2D2A2E; padding: 5px;">
      〈🐜 go 1.21.6〉
    </td>
    <td style="background-color: #69AC9A; color: #FFFFFF; padding: 5px;">
      〈🦗 rust 1.70.0〉
    </td>
    <td style="background-color: #5E8B7E; color: #FFFFFF; padding: 5px;">
      〈🕷️ dart 3.0.5〉
    </td>
    <td style="background-color: #E6B195; color: #2D2A2E; padding: 5px;">
      〈🐢 angular 16.1.3〉
    </td>
  </tr>
</table>

### Cloud Segments

All use Diamond style:

```
〈☂️ az-func-prod〉
〈⛅ aws-dev〉
〈🌧️ k8s-prod〉
```

<table>
  <tr>
    <td style="background-color: #87AACC; color: #2D2A2E; padding: 5px;">
      〈☂️ az-func-prod〉
    </td>
    <td style="background-color: #69AC9A; color: #FFFFFF; padding: 5px;">
      〈⛅ aws-dev〉
    </td>
    <td style="background-color: #7D92B5; color: #FFFFFF; padding: 5px;">
      〈🌧️ k8s-prod〉
    </td>
  </tr>
</table>

### System Segments

```
〈🌅 WSL〉
〈🔋 100%〉
〈⚡️ 75%〉
〈🕰️ 3:04 PM〉
```

<table>
  <tr>
    <td style="background-color: #C27160; color: #FFFFFF; padding: 5px;">
      〈🌅 WSL〉
    </td>
    <td style="background-color: #5E8B7E; color: #FFFFFF; padding: 5px;">
      〈🔋 100%〉
    </td>
    <td style="background-color: #69AC9A; color: #FFFFFF; padding: 5px;">
      〈⚡️ 75%〉
    </td>
    <td style="background-color: #B090B0; color: #FFFFFF; padding: 5px;">
      〈🕰️ 3:04 PM〉
    </td>
  </tr>
</table>

## Complete Prompt Example

```
╭─〈🌱 pwsh〉─〈🌿 User〉─〈🌻 ~/code〉─〈🌞 main ✏️ +2〉─〈🌈 1.5s〉
╰─〈🍀 >〉
```

<table>
  <tr>
    <td style="background: linear-gradient(to right, #5E8B7E, #7D92B5, #C27160, #E6D595, #69AC9A); color: #FFFFFF; padding: 5px;">
      ╭─〈🌱 pwsh〉─〈🌿 User〉─〈🌻 ~/code〉─〈🌞 main ✏️ +2〉─〈🌈 1.5s〉
    </td>
  </tr>
  <tr>
    <td style="background-color: #5E8B7E; color: #FFFFFF; padding: 5px;">
      ╰─〈🍀 >〉
    </td>
  </tr>
</table>

## Theme Features

- **Spring-inspired color palette** with enhanced contrast for better readability
- **Nature-themed icons**:
  - Plants: 🌱 🌿 🌻 🌸 🌼
  - Weather: 🌞 🌈 ⛅ ☂️ 🌧️ 🌅
  - Insects: 🐝 🦋 🐌 🐞 🐜 🦗 🕷️ 🐢 🐛
- **Comprehensive segment coverage** for various development environments
- **Error indicator** changes color for better visibility
- **Cohesive design** with complementary colors and consistent styling
