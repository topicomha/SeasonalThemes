<#
.SYNOPSIS
    Drafts a light mode (modes.light) for a dark month, and writes it into the month's season.jsonc.

.DESCRIPTION
    Keeps the month's identity (its brand colours, icons and prompt segments stay the same) and derives
    everything drawn on the window background from the month's dark colours:

    - page, panels, current line and borders: light tints of the month's primary colour
    - text: the month's dark text colour, darkened until it's at least 10:1 on the page
    - code, terminal, status and accent colours: the same hues as dark mode, darkened until they read on
      the light page (4.5:1 for code and terminal text, 3:1 for status icons and the prompt connector)

    New colours are added to the palette under modes.light, marked "Proposed", so the draft can be
    reviewed and tuned like any other part of the document. Regenerate afterwards and check the light
    previews (<Month>/vscode-preview-light.svg).

.EXAMPLE
    pwsh ./tools/New-LightMode.ps1 -Month October
    pwsh ./tools/New-LightMode.ps1 -Month December -Variant new-years-eve
    pwsh ./tools/New-LightMode.ps1 -Month May -OutFile -      # print the block instead of writing it
    pwsh ./tools/New-LightMode.ps1 -Month December -Tint brand.secondary   # evergreen page, not red
#>
#Requires -Version 7.4
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('January', 'February', 'March', 'April', 'May', 'June',
                 'July', 'August', 'September', 'October', 'November', 'December')]
    [string]$Month,

    # Draft the light mode of this variant (its modes.light) instead of the month's.
    [string]$Variant,

    # '-' prints the drafted block instead of inserting it into season.jsonc.
    [string]$OutFile,

    # The colour role the page and panels are tinted from (default: the month's primary colour).
    [string]$Tint = 'brand.primary'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
$SeasonPath = Join-Path $Root $Month 'season.jsonc'

#region Colour maths

# Plain loops, not pipelines: these run thousands of times while darkening, and pipelines are slow.
function ConvertFrom-Hex([string]$Hex) {
    [double[]]@([Convert]::ToInt32($Hex.Substring(1, 2), 16), [Convert]::ToInt32($Hex.Substring(3, 2), 16), [Convert]::ToInt32($Hex.Substring(5, 2), 16))
}
function ConvertTo-Hex([double[]]$Rgb) {
    $clamp = { param($v) [int][math]::Round([math]::Min(255, [math]::Max(0, $v))) }
    '#{0:X2}{1:X2}{2:X2}' -f (& $clamp $Rgb[0]), (& $clamp $Rgb[1]), (& $clamp $Rgb[2])
}

# $Weight of $B mixed into $A (0 = all A, 1 = all B).
function Get-Mix([string]$A, [string]$B, [double]$Weight) {
    $x = ConvertFrom-Hex $A; $y = ConvertFrom-Hex $B
    ConvertTo-Hex @(($x[0] + ($y[0] - $x[0]) * $Weight), ($x[1] + ($y[1] - $x[1]) * $Weight), ($x[2] + ($y[2] - $x[2]) * $Weight))
}

function Get-Luminance([string]$Hex) {
    $rgb = ConvertFrom-Hex $Hex
    $c = [double[]]::new(3)
    for ($i = 0; $i -lt 3; $i++) {
        $v = $rgb[$i] / 255
        $c[$i] = $v -le 0.03928 ? $v / 12.92 : [math]::Pow(($v + 0.055) / 1.055, 2.4)
    }
    0.2126 * $c[0] + 0.7152 * $c[1] + 0.0722 * $c[2]
}

function Get-Contrast([string]$A, [string]$B) {
    $la = Get-Luminance $A; $lb = Get-Luminance $B
    ([math]::Max($la, $lb) + 0.05) / ([math]::Min($la, $lb) + 0.05)
}

function ConvertTo-Hsl([string]$Hex) {
    $rgb = ConvertFrom-Hex $Hex
    $r = $rgb[0] / 255; $g = $rgb[1] / 255; $b = $rgb[2] / 255
    $max = [math]::Max($r, [math]::Max($g, $b)); $min = [math]::Min($r, [math]::Min($g, $b))
    $l = ($max + $min) / 2
    if ($max -eq $min) { return @(0.0, 0.0, $l) }
    $d = $max - $min
    $s = $l -gt 0.5 ? $d / (2 - $max - $min) : $d / ($max + $min)
    $h = if ($max -eq $r) { ($g - $b) / $d + ($g -lt $b ? 6 : 0) } elseif ($max -eq $g) { ($b - $r) / $d + 2 } else { ($r - $g) / $d + 4 }
    @(($h / 6), $s, $l)   # parentheses matter: a comma binds tighter than '/'
}

function ConvertFrom-Hsl([double]$H, [double]$S, [double]$L) {
    if ($S -eq 0) { return ConvertTo-Hex @(($L * 255), ($L * 255), ($L * 255)) }
    $q = $L -lt 0.5 ? $L * (1 + $S) : $L + $S - $L * $S
    $p = 2 * $L - $q
    $channel = {
        param($t)
        if ($t -lt 0) { $t += 1 }; if ($t -gt 1) { $t -= 1 }
        if ($t -lt 1 / 6) { return $p + ($q - $p) * 6 * $t }
        if ($t -lt 1 / 2) { return $q }
        if ($t -lt 2 / 3) { return $p + ($q - $p) * (2 / 3 - $t) * 6 }
        $p
    }
    ConvertTo-Hex @(((& $channel ($H + 1 / 3)) * 255), ((& $channel $H) * 255), ((& $channel ($H - 1 / 3)) * 255))
}

# Same hue and saturation, darker, until it reaches $Target contrast on $Background.
function Get-Darkened([string]$Hex, [string]$Background, [double]$Target) {
    if ((Get-Contrast $Hex $Background) -ge $Target) { return $Hex.ToUpper() }
    $h, $s, $l = ConvertTo-Hsl $Hex
    # Contrast on a light background only grows as lightness drops, so binary-search the lightest shade that passes.
    $lo = 0.0; $hi = $l; $best = ConvertFrom-Hsl $h $s 0
    for ($i = 0; $i -lt 14; $i++) {
        $mid = ($lo + $hi) / 2
        $candidate = ConvertFrom-Hsl $h $s $mid
        if ((Get-Contrast $candidate $Background) -ge $Target) { $best = $candidate; $lo = $mid } else { $hi = $mid }
    }
    $best
}

# Mixed towards white until $Text reaches $Target contrast on it (for selection backgrounds).
function Get-Lightened([string]$Hex, [string]$Text, [double]$Target) {
    for ($w = 0.0; $w -le 1.0; $w += 0.02) {
        $candidate = Get-Mix $Hex '#FFFFFF' $w
        if ((Get-Contrast $Text $candidate) -ge $Target) { return $candidate }
    }
    '#FFFFFF'
}

#endregion

#region Read the month's resolved dark colours

$export = (& pwsh -NoProfile -File (Join-Path $Root 'Generate-Themes.ps1') -Month $Month -Export) -join "`n" | ConvertFrom-Json -AsHashtable
$entry = $export[$Month] | Where-Object { $_.isBaseMode -and $_.variant -eq ($Variant ? $Variant : $null) } | Select-Object -First 1
if (-not $entry) { throw "No $($Variant ? "variant '$Variant' of " : '')$Month found." }
if ($entry.mode -ne 'dark') { throw "$Month is already $($entry.mode); this drafts a light mode for a dark month." }

$dark = $entry.colors
function Hex([string]$Role) { $dark[$Role].hex.ToUpper() }

#endregion

#region Derive the light colours

$white = '#FFFFFF'
$primary = Hex 'brand.primary'
if (-not $dark.Contains($Tint)) { throw "-Tint $Tint isn't a colour role (e.g. brand.secondary)." }
$tintSource = Hex $Tint

$page = Get-Mix $tintSource $white 0.93
$panel = Get-Mix $tintSource $white 0.87
$line = Get-Mix $tintSource $white 0.89
$border = Get-Mix $tintSource $white 0.72
$ink = Get-Darkened (Get-Mix (Hex 'ui.text_dark') $tintSource 0.15) $page 10
$muted = Get-Darkened (Get-Mix $ink $page 0.5) $panel 4.5
$selection = Get-Lightened (Get-Mix (Hex 'ui.selection') $white 0.55) (Hex 'ui.text_dark') 4.5

# One readable "ink" per source colour, reused by every role derived from it, so the light palette stays
# small and a colour means the same thing everywhere. 4.5:1 on the (darker) panel also clears the page.
$inks = @{}
function Get-Ink([string]$Hex) {
    if (-not $script:inks.ContainsKey($Hex)) { $script:inks[$Hex] = Get-Darkened $Hex $panel 4.5 }
    $script:inks[$Hex]
}

# VS Code's accent: whichever colour the month picked (targets.vscode.accent), darkened to read on the panels.
$accentRole = ($entry.targets['vscode'] ?? @{})['accent'] ?? 'ui.accent'
$accent = Get-Ink (Hex $accentRole)

$roles = [ordered]@{}   # role -> @{ Hex; Source (palette key it was derived from); Label; Style }
function Set-Role([string]$Role, [string]$Hex, [string]$Label, [string]$Source) {
    $script:roles[$Role] = @{ Hex = $Hex.ToUpper(); Label = $Label; Source = $Source; Style = $dark[$Role]['style'] }
}

Set-Role 'brand.line' (Get-Ink (Hex 'brand.line')) '' $dark['brand.line'].ref
Set-Role 'ui.background' $page 'Light-mode page' ''
Set-Role 'ui.foreground' $ink 'Light-mode ink' ''
Set-Role 'ui.surface' $panel 'Light-mode panel' ''
Set-Role 'ui.line_highlight' $line 'Light-mode current line' ''
Set-Role 'ui.border' $border 'Light-mode border' ''
Set-Role 'ui.muted' $muted 'Light-mode muted text' ''
Set-Role 'ui.selection' $selection 'Light-mode selection' ''
Set-Role 'ui.cursor' (Get-Ink $primary) '' $dark['brand.primary'].ref
Set-Role 'ui.accent' $accent '' $dark[$accentRole].ref

foreach ($status in 'success', 'warning', 'error', 'info') {
    Set-Role "status.$status" (Get-Ink (Hex "status.$status")) '' $dark["status.$status"].ref
}

$darkInk = Hex 'ui.foreground'
$darkMuted = Hex 'ui.muted'
foreach ($role in @($dark.Keys | Where-Object { $_ -like 'syntax.*' })) {
    $hex = Hex $role
    if ($hex -eq $darkInk) { Set-Role $role $ink 'Light-mode ink' '' }
    elseif ($hex -eq $darkMuted) { Set-Role $role $muted 'Light-mode muted text' '' }
    else { Set-Role $role (Get-Ink $hex) '' $dark[$role].ref }
}

Set-Role 'terminal.background' $page 'Light-mode page' ''
Set-Role 'terminal.foreground' $ink 'Light-mode ink' ''
Set-Role 'terminal.cursor' $roles['ui.cursor'].Hex '' $dark['brand.primary'].ref
Set-Role 'terminal.selection' $selection 'Light-mode selection' ''
Set-Role 'terminal.black' $ink 'Light-mode ink' ''
Set-Role 'terminal.bright_black' $muted 'Light-mode muted text' ''
# On a light terminal "white" has to stay readable, so it's a mid grey (like GitHub's light theme).
Set-Role 'terminal.white' (Get-Darkened (Get-Mix $muted $page 0.2) $page 3.5) 'Light-mode terminal white' ''
Set-Role 'terminal.bright_white' (Get-Darkened (Get-Mix $muted $page 0.4) $page 3) 'Light-mode terminal bright white' ''
foreach ($hue in 'red', 'green', 'yellow', 'blue', 'magenta', 'cyan') {
    Set-Role "terminal.$hue" (Get-Ink (Hex "terminal.$hue")) '' $dark["terminal.$hue"].ref
    Set-Role "terminal.bright_$hue" (Get-Ink (Hex "terminal.bright_$hue")) '' $dark["terminal.bright_$hue"].ref
}

#endregion

#region Name the new colours

$existing = @{}   # hex -> palette key already in the month
foreach ($key in $entry.palette.Keys) { $existing[$entry.palette[$key].Hex.ToUpper()] ??= $key }

$newPalette = [ordered]@{}   # key -> @{ Hex; Name }
$keyFor = @{}                # hex -> key used in the light mode
foreach ($role in $roles.Keys) {
    $r = $roles[$role]
    if ($keyFor.ContainsKey($r.Hex)) { continue }
    if ($existing.ContainsKey($r.Hex)) { $keyFor[$r.Hex] = $existing[$r.Hex]; continue }

    if ($r.Label) {
        $key = 'light_' + (($r.Label -replace '^Light-mode ', '') -replace '[^a-z]+', '_').ToLower().Trim('_')
        $name = $r.Label
    }
    else {
        $source = $r.Source ? $r.Source : 'colour'
        $key = "${source}_ink"
        $sourceName = $entry.palette[$source] ? $entry.palette[$source].Name : $source
        $name = "$sourceName (light-mode ink)"
    }
    $n = 2
    $base = $key
    while ($newPalette.Contains($key) -or $entry.palette.Contains($key)) { $key = "$base$n"; $n++ }
    $newPalette[$key] = @{ Hex = $r.Hex; Name = $name }
    $keyFor[$r.Hex] = $key
}

#endregion

#region Write the block

function Q([string]$Text) { '"' + ($Text -replace '\\', '\\' -replace '"', '\"') + '"' }

function Get-Block([string]$Indent) {
    $i1 = $Indent + '  '; $i2 = $i1 + '  '; $i3 = $i2 + '  '; $i4 = $i3 + '  '
    $out = [System.Collections.Generic.List[string]]::new()
    $out.Add("$Indent`"modes`": {")
    $out.Add("$i1// Drafted by tools/New-LightMode.ps1 from the dark colours: tune freely.")
    $out.Add("$i1`"light`": {")
    $out.Add("$i2`"palette`": {")
    $keys = @($newPalette.Keys)
    for ($k = 0; $k -lt $keys.Count; $k++) {
        $p = $newPalette[$keys[$k]]
        $out.Add("$i3$(Q $keys[$k]): { `"hex`": `"$($p.Hex)`", `"name`": $(Q $p.Name), `"note`": `"Proposed: light mode`" }$($k -lt $keys.Count - 1 ? ',' : '')")
    }
    $out.Add("$i2},")
    $out.Add("$i2`"colors`": {")
    $groups = @($roles.Keys | ForEach-Object { ($_ -split '\.')[0] } | Select-Object -Unique)
    for ($g = 0; $g -lt $groups.Count; $g++) {
        $out.Add("$i3$(Q $groups[$g]): {")
        $inGroup = @($roles.Keys | Where-Object { $_ -like "$($groups[$g]).*" })
        for ($r = 0; $r -lt $inGroup.Count; $r++) {
            $role = $roles[$inGroup[$r]]
            $value = $role.Style ? "{ `"color`": $(Q $keyFor[$role.Hex]), `"style`": $(Q $role.Style) }" : (Q $keyFor[$role.Hex])
            $out.Add("$i4$(Q ($inGroup[$r] -split '\.', 2)[1]): $value$($r -lt $inGroup.Count - 1 ? ',' : '')")
        }
        $out.Add("$i3}$($g -lt $groups.Count - 1 ? ',' : '')")
    }
    $out.Add("$i2},")
    $out.Add("$i2`"targets`": {")
    $out.Add("$i3`"vscode`": { `"accent`": `"ui.accent`" }")
    $out.Add("$i2}")
    $out.Add("$i1}")
    $out.Add("$Indent}")
    $out -join "`n"
}

# Where an object's closing brace is, skipping strings and comments.
function Find-ObjectEnd([string]$Text, [int]$Start) {
    $depth = 1; $i = $Start
    while ($i -lt $Text.Length) {
        $ch = $Text[$i]
        if ($ch -eq '"') { $i++; while ($Text[$i] -ne '"') { if ($Text[$i] -eq '\') { $i++ }; $i++ } }
        elseif ($ch -eq '/' -and $Text[$i + 1] -eq '/') { while ($i -lt $Text.Length -and $Text[$i] -ne "`n") { $i++ } }
        elseif ($ch -eq '{') { $depth++ }
        elseif ($ch -eq '}') { $depth--; if ($depth -eq 0) { return $i } }
        $i++
    }
    throw 'Unbalanced braces in season.jsonc.'
}

$text = [IO.File]::ReadAllText($SeasonPath)
if ($Variant) {
    $match = [regex]::Match($text, '(?m)^(?<indent>[ \t]*)"id":\s*"' + [regex]::Escape($Variant) + '"')
    if (-not $match.Success) { throw "No variant '$Variant' in $SeasonPath." }
    $indent = $match.Groups['indent'].Value
    $end = Find-ObjectEnd $text $match.Index
    $object = $text.Substring($match.Index, $end - $match.Index)
    if ($object -match '"modes"\s*:') { throw "Variant '$Variant' already has modes; edit it by hand." }
    $block = Get-Block $indent
}
else {
    if (($export[$Month] | Where-Object { -not $_.isBaseMode -and -not $_.variant })) { throw "$Month already has a light mode; edit it by hand." }
    $end = $text.LastIndexOf('}')
    $indent = '  '
    $block = "  // ── Light mode ──────────────────────────────────────────────────────────`n" + (Get-Block $indent)
}

if ($OutFile -eq '-') { $block; return }

$before = $text.Substring(0, $end).TrimEnd()
$closingIndent = $Variant ? $indent.Substring(0, [math]::Max(0, $indent.Length - 2)) : ''
$updated = $before + ",`n`n" + $block + "`n" + $closingIndent + $text.Substring($end)
$null = $updated | ConvertFrom-Json   # still valid JSONC
[IO.File]::WriteAllText($SeasonPath, $updated, [Text.UTF8Encoding]::new($false))
Write-Host "Drafted a light mode for $Month$($Variant ? " ($Variant)" : '') in $([IO.Path]::GetRelativePath($Root, $SeasonPath)): $($newPalette.Count) new colours." -ForegroundColor Green

#endregion
