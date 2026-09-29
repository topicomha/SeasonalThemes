# Renders the VS Code extension manifest: templates/vscode-package.json plus one theme entry per
# month and variant. Called once by Generate-Themes.ps1 with every month's resolved seasons.
param([object[]]$Seasons, [string]$Root)

Set-StrictMode -Version Latest

$manifest = Get-Content -Raw (Join-Path $Root 'templates' 'vscode-package.json') | ConvertFrom-Json -AsHashtable

$manifest.contributes.themes = @(foreach ($entry in $Seasons) {
    $season = $entry.Season
    # Must match the vscode-theme target's output path in Generate-Themes.ps1.
    $slug = $entry.Month.ToLower() + ($entry.Variant ? "-$($entry.Variant.id)" : '') + "-$($entry.Mode)"
    [ordered]@{
        label   = "$($season.Title) $($season.Icons['shell'].Value)"
        uiTheme = $entry.Mode -eq 'light' ? 'vs' : 'vs-dark'
        path    = "./themes/$slug.json"
    }
})

# Which theme belongs to which dates and mode, for extension.js's automatic switching.
$months = 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
$manifest.seasonalSchedule = @(for ($i = 0; $i -lt $Seasons.Count; $i++) {
    $entry = $Seasons[$i]
    $item = [ordered]@{
        month = [array]::IndexOf($months, $entry.Month) + 1
        mode  = $entry.Mode
        label = $manifest.contributes.themes[$i].label
    }
    if ($entry.Variant) {
        $item.from = $entry.Variant.from
        $item.to = $entry.Variant.to
    }
    $item
})

($manifest | ConvertTo-Json -Depth 10 -EscapeHandling Default) + "`n"
