# Theme Generator Script

This script provides functionality to generate or update Oh My Posh theme files from the `theme-definition.md` files in each month's folder. The script parses the markdown documentation and extracts the JSON segments to create/update the `.omp.json` files.

## How It Works

1. For each month folder, the script:
   - Reads the `theme-definition.md` file
   - Extracts all JSON code blocks
   - Assembles them into a complete theme file
   - Writes or updates the corresponding `.omp.json` file

## Usage Example

```powershell
# Generate theme from a specific month's definition
./Generate-Theme.ps1 -Month "January"

# Generate all themes from all month definitions
./Generate-Theme.ps1 -All
```

## Script Content

Save this as `Generate-Theme.ps1` in the root directory:

```powershell
param(
    [string]$Month,
    [switch]$All
)

function Extract-JsonBlocks {
    param(
        [string]$MarkdownContent
    )
    
    $jsonBlocks = @{}
    $pattern = "(?<=```json\r?\n)(.+?)(?=\r?\n```)"
    $matches = [regex]::Matches($MarkdownContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    foreach ($match in $matches) {
        $jsonContent = $match.Groups[1].Value.Trim()
        
        # Determine which segment this is
        if ($jsonContent -match '"type":\s*"shell"') {
            $jsonBlocks["shell"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"root"') {
            $jsonBlocks["root"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"path"') {
            $jsonBlocks["path"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"git"') {
            $jsonBlocks["git"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"executiontime"') {
            $jsonBlocks["executiontime"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"status"') {
            $jsonBlocks["status"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"python"') {
            $jsonBlocks["python"] = $jsonContent
        }
        elseif ($jsonContent -match '"type":\s*"node"') {
            $jsonBlocks["node"] = $jsonContent
        }
        # Add more segment type detections as needed
    }
    
    return $jsonBlocks
}

function Generate-ThemeFile {
    param(
        [string]$MonthName
    )
    
    Write-Host "Generating theme for $MonthName..." -ForegroundColor Cyan
    
    $monthDir = Join-Path -Path $PSScriptRoot -ChildPath $MonthName
    $definitionFile = Join-Path -Path $monthDir -ChildPath "theme-definition.md"
    $themeOutputFile = Join-Path -Path $monthDir -ChildPath "davids-$MonthName.omp.json"
    
    if (-not (Test-Path $definitionFile)) {
        Write-Host "Definition file not found for $MonthName. Skipping..." -ForegroundColor Yellow
        return
    }
    
    # Read the definition file
    $definitionContent = Get-Content -Path $definitionFile -Raw
    
    # Extract JSON blocks
    $jsonBlocks = Extract-JsonBlocks -MarkdownContent $definitionContent
    
    # Create the segments array
    $segments = @()
    foreach ($key in @("shell", "root", "path", "git", "python", "executiontime", "status")) {
        if ($jsonBlocks.ContainsKey($key)) {
            $segments += $jsonBlocks[$key]
        }
    }
    
    # Build the theme file content
    $themeContent = @"
{
  "`$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        $($segments -join ",`n        ")
      ],
      "newline": true
    },
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "template": "\u2570\u2500\ue0b6 ",
          "foreground": "#FFD700",
          "type": "text",
          "style": "plain"
        }
      ]
    }
  ],
  "final_space": true,
  "version": 2
}
"@

    # Write the theme file
    Set-Content -Path $themeOutputFile -Value $themeContent
    Write-Host "Theme file created/updated at: $themeOutputFile" -ForegroundColor Green
}

# Main script execution
if ($All) {
    $months = @("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
    foreach ($monthName in $months) {
        if (Test-Path (Join-Path -Path $PSScriptRoot -ChildPath $monthName)) {
            Generate-ThemeFile -MonthName $monthName
        }
    }
} elseif ($Month) {
    Generate-ThemeFile -MonthName $Month
} else {
    Write-Host "Please specify either -Month or -All parameter." -ForegroundColor Red
}
```

## Future Enhancements

1. **Theme Preview Generation**: Add functionality to generate ASCII art previews of the themes.

2. **Color Extraction**: Automatically extract colors from the color palette table.

3. **Icon Management**: Maintain a central repository of icons with their Unicode values.

4. **Interactive Editor**: Create a simple web-based editor for modifying themes visually.

5. **Version Control**: Track changes between theme versions.

## Note on Implementation

This is a basic implementation that demonstrates the concept. The actual script would need to:

- Handle more complex JSON structures
- Manage special cases like right-aligned blocks
- Deal with commenting and special segments
- Validate JSON output

For a complete implementation, consider expanding this script or developing a more robust solution in Python or Node.js.
