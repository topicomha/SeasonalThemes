# Renders the VS Code extension manifest: templates/vscode-package.json plus one theme entry per
# month and variant. Called once by Generate-Themes.ps1 with every month's resolved seasons.
param([object[]]$Seasons, [string]$Root)

Set-StrictMode -Version Latest

$manifest = Get-Content -Raw (Join-Path $Root 'templates' 'vscode-package.json') | ConvertFrom-Json -AsHashtable

$manifest.contributes.themes = @(foreach ($entry in $Seasons) {
    $season = $entry.Season
    # Must match the vscode-theme target's output path in Generate-Themes.ps1.
    $slug = $entry.Month.ToLower() + ($entry.Variant ? "-$($entry.Variant.id)" : '')
    [ordered]@{
        label   = "$($season.Title) $($season.Icons['shell'].Value)"
        uiTheme = $season.Data.appearance -eq 'light' ? 'vs' : 'vs-dark'
        path    = "./themes/$slug.json"
    }
})

($manifest | ConvertTo-Json -Depth 10 -EscapeHandling Default) + "`n"
