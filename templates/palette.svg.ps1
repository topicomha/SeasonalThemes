# Renders a month's palette as an SVG swatch sheet. Called by Generate-Themes.ps1.
param($Season, [hashtable]$Files)

Set-StrictMode -Version Latest

function ConvertTo-Xml([string]$Text) {
    [System.Security.SecurityElement]::Escape($Text)
}

$columns = 6
$swatchWidth = 168
$swatchHeight = 76
$gap = 8
$padding = 16
$titleHeight = 40

$entries = @($Season.Palette.GetEnumerator())
$rows = [math]::Max(1, [math]::Ceiling($entries.Count / $columns))
$width = 2 * $padding + $columns * $swatchWidth + ($columns - 1) * $gap
$height = 2 * $padding + $titleHeight + $rows * $swatchHeight + ($rows - 1) * $gap

$background = $Season.Colors['ui.background'].Hex
$foreground = $Season.Colors['ui.foreground'].Hex
$border = $Season.Colors['ui.muted'].Hex
$title = "$($Season.Month) · $($Season.Data.name)"
if ($Season.VariantName) { $title += " · $($Season.VariantName)" }

$svg = [System.Text.StringBuilder]::new()
$null = $svg.AppendLine("<svg xmlns=`"http://www.w3.org/2000/svg`" width=`"$width`" height=`"$height`" viewBox=`"0 0 $width $height`" font-family=`"system-ui, -apple-system, 'Segoe UI', sans-serif`">")
$null = $svg.AppendLine("  <rect width=`"$width`" height=`"$height`" rx=`"12`" fill=`"$background`"/>")
$null = $svg.AppendLine("  <text x=`"$padding`" y=`"$($padding + 22)`" font-size=`"18`" font-weight=`"600`" fill=`"$foreground`">$(ConvertTo-Xml $title)</text>")

for ($i = 0; $i -lt $entries.Count; $i++) {
    $key = $entries[$i].Key
    $swatch = $entries[$i].Value
    # Labels are plain black or white so they read on every swatch, whatever the month's text colours are.
    # (Get-BestText comes from Generate-Themes.ps1, which runs this renderer.)
    $label = (Get-BestText $swatch.Hex '#FFFFFF' '#000000').Hex
    $x = $padding + ($i % $columns) * ($swatchWidth + $gap)
    $y = $padding + $titleHeight + [math]::Floor($i / $columns) * ($swatchHeight + $gap)
    $null = $svg.AppendLine("  <g transform=`"translate($x $y)`">")
    $null = $svg.AppendLine("    <rect width=`"$swatchWidth`" height=`"$swatchHeight`" rx=`"8`" fill=`"$($swatch.Hex)`" stroke=`"$border`" stroke-opacity=`"0.4`"/>")
    $null = $svg.AppendLine("    <text x=`"10`" y=`"24`" font-size=`"13`" font-weight=`"600`" fill=`"$label`">$(ConvertTo-Xml $swatch.Name)</text>")
    $null = $svg.AppendLine("    <text x=`"10`" y=`"44`" font-size=`"11`" fill=`"$label`" fill-opacity=`"0.85`">$(ConvertTo-Xml $key)</text>")
    $null = $svg.AppendLine("    <text x=`"10`" y=`"62`" font-size=`"11`" font-family=`"ui-monospace, Consolas, monospace`" fill=`"$label`" fill-opacity=`"0.85`">$($swatch.Hex.ToUpper())</text>")
    $null = $svg.AppendLine("  </g>")
}

$null = $svg.AppendLine('</svg>')
$svg.ToString()
