<#
.SYNOPSIS
    Drafts a month's season.jsonc from its existing hand-written Oh My Posh theme.

.DESCRIPTION
    Lines the old theme up with templates/oh-my-posh.omp.json segment by segment (matched by type).
    Wherever the template has a [[token]], the old theme's value in the same place becomes a candidate
    for that role. Each role gets its most common candidate; the others are noted as comments, so every
    place the old theme was inconsistent shows up.

    The draft is a starting point, not a finished document. Palette entries are keyed by hex (c_d35400)
    and named TODO. Rename them, fill in the identity fields and resolve the notes, then run
    Generate-Themes.ps1. The generator refuses a season.jsonc that still contains TODO.

.EXAMPLE
    pwsh ./tools/Import-OmpTheme.ps1 -Month August
    pwsh ./tools/Import-OmpTheme.ps1 -Month December -Theme December/davids-NewYearTheme.omp.json -OutFile -
#>
#Requires -Version 7.4
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [ValidateSet('January', 'February', 'March', 'April', 'May', 'June',
                 'July', 'August', 'September', 'October', 'November', 'December')]
    [string]$Month,

    # Old theme to import. Defaults to <Month>/davids-<Month>.omp.json (any capitalisation).
    [string]$Theme,

    # Where to write the draft. Defaults to <Month>/season.jsonc; '-' prints it instead.
    [string]$OutFile,

    # Overwrite an existing season.jsonc.
    [switch]$Force
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
$TemplatePath = Join-Path $Root 'templates' 'oh-my-posh.omp.json'
$TokenPattern = '\[\[([a-z0-9_.-]+)(?:\|([^\]]*))?\]\]'

if (-not $Theme) {
    $Theme = Get-ChildItem (Join-Path $Root $Month) -Filter '*.omp.json' |
        Where-Object { $_.Name -ieq "davids-$Month.omp.json" } |
        Select-Object -First 1 -ExpandProperty FullName
    if (-not $Theme) { throw "No davids-$Month.omp.json in $Month/. Pass -Theme." }
}
elseif (-not [IO.Path]::IsPathRooted($Theme)) {
    $Theme = Join-Path $Root $Theme
}
if (-not $OutFile) { $OutFile = Join-Path $Root $Month 'season.jsonc' }
if ($OutFile -ne '-' -and (Test-Path $OutFile) -and -not $Force) {
    throw "$OutFile already exists. Use -Force to overwrite, or -OutFile - to print the draft."
}

$template = Get-Content -Raw $TemplatePath | ConvertFrom-Json -AsHashtable
$oldText = Get-Content -Raw $Theme
$old = $oldText | ConvertFrom-Json -AsHashtable

$candidates = [ordered]@{}                                   # token -> list of @{ Value; Where }
$textColors = [System.Collections.Generic.List[object]]::new() # foregrounds seen where the template uses [[on.*]]
$unmatched = [System.Collections.Generic.List[string]]::new()
$missing = [System.Collections.Generic.List[string]]::new()
$missingSegments = [System.Collections.Generic.List[string]]::new()

function Add-Candidate([string]$Token, [string]$Value, [string]$Where) {
    $Value = $Value.Trim()
    if ($Token -like 'color.*' -or $Token -like 'on.*') {
        if ($Value -notmatch '^#[0-9A-Fa-f]{6}$') {
            $unmatched.Add("${Where}: expected a #RRGGBB colour for [[$Token]], found '$Value'")
            return
        }
        $Value = $Value.ToUpper()
    }
    if ($Value.Contains([char]0xFFFD)) {
        $unmatched.Add("${Where}: broken emoji (U+FFFD) where [[$Token]] goes; pick a new icon")
    }
    if ($Token -like 'on.*') {
        $textColors.Add(@{ Value = $Value; Where = $Where })
        return
    }
    if (-not $candidates.Contains($Token)) { $candidates[$Token] = [System.Collections.Generic.List[object]]::new() }
    $candidates[$Token].Add(@{ Value = $Value; Where = $Where })
}

# Emoji-like text elements: skips ASCII, box drawing, powerline / Nerd Font private-use glyphs.
function Get-Emoji([string]$Text) {
    $elements = [System.Globalization.StringInfo]::GetTextElementEnumerator($Text)
    while ($elements.MoveNext()) {
        $element = [string]$elements.GetTextElement()
        $cp = [char]::ConvertToUtf32($element, 0)
        $isBoxDrawing = $cp -ge 0x2500 -and $cp -le 0x259F
        $isPrivateUse = ($cp -ge 0xE000 -and $cp -le 0xF8FF) -or $cp -ge 0xF0000
        if ($cp -ge 0x2190 -and -not $isBoxDrawing -and -not $isPrivateUse) { $element }
    }
}

function Get-Tokens($Node) {
    if ($Node -is [System.Collections.IDictionary]) { foreach ($v in $Node.Values) { Get-Tokens $v } }
    elseif ($Node -is [System.Collections.IList]) { foreach ($v in $Node) { Get-Tokens $v } }
    elseif ($Node -is [string]) { foreach ($m in [regex]::Matches($Node, $TokenPattern)) { $m.Groups[1].Value } }
}

function Add-Missing($TemplateNode, [string]$Where) {
    foreach ($token in Get-Tokens $TemplateNode) {
        if ($token -notlike 'target.*') { $missing.Add("[[${token}]] ($Where)") }
    }
}

function Compare-String([string]$Template, $Old, [string]$Where) {
    $tokens = @([regex]::Matches($Template, $TokenPattern))
    if ($Old -isnot [string]) {
        $unmatched.Add("${Where}: template has '$Template', old theme has no text here")
        return
    }

    # Turn the template string into a regex: literal text stays literal, each token captures.
    $pattern = '^'
    $last = 0
    for ($i = 0; $i -lt $tokens.Count; $i++) {
        $pattern += [regex]::Escape($Template.Substring($last, $tokens[$i].Index - $last)) + "(?<t$i>.*?)"
        $last = $tokens[$i].Index + $tokens[$i].Length
    }
    $pattern += [regex]::Escape($Template.Substring($last)) + '$'

    $match = [regex]::Match($Old, $pattern, 'Singleline')
    if ($match.Success) {
        for ($i = 0; $i -lt $tokens.Count; $i++) {
            $token = $tokens[$i].Groups[1].Value
            $value = $match.Groups["t$i"].Value
            if ($token -like 'target.*') {
                $default = $tokens[$i].Groups[2].Value
                if ($value -ne $default) { Add-Candidate $token $value $Where }
            }
            else {
                Add-Candidate $token $value $Where
            }
        }
        return
    }

    # The surrounding text differs. If every token is an icon and the old text has exactly one
    # emoji, that emoji is the icon (e.g. an old status template of just "👻  ").
    $iconTokens = @($tokens | Where-Object { $_.Groups[1].Value -like 'icon.*' })
    $emoji = @(Get-Emoji $Old)
    if ($iconTokens.Count -eq $tokens.Count -and $emoji.Count -eq 1) {
        foreach ($t in $iconTokens) { Add-Candidate $t.Groups[1].Value $emoji[0] "$Where (loose match)" }
        return
    }
    $unmatched.Add("${Where}: couldn't line up with the template; old value: $Old")
}

function Compare-Node($Template, $Old, [string]$Where) {
    if ($Template -is [System.Collections.IDictionary]) {
        if ($Old -isnot [System.Collections.IDictionary]) { Add-Missing $Template $Where; return }
        foreach ($key in $Template.Keys) {
            if ($Old.Contains($key)) { Compare-Node $Template[$key] $Old[$key] "$Where.$key" }
            else { Add-Missing $Template[$key] "$Where.$key" }
        }
    }
    elseif ($Template -is [System.Collections.IList]) {
        for ($i = 0; $i -lt $Template.Count; $i++) {
            $oldItem = ($Old -is [System.Collections.IList] -and $i -lt $Old.Count) ? $Old[$i] : $null
            if ($null -eq $oldItem) { Add-Missing $Template[$i] "$Where[$i]" }
            else { Compare-Node $Template[$i] $oldItem "$Where[$i]" }
        }
    }
    elseif ($Template -is [string] -and $Template -match $TokenPattern) {
        Compare-String $Template $Old $Where
    }
}

# Pair segments by type, in order, across all blocks.
$oldSegments = @($old.blocks | ForEach-Object { $_.segments })
$used = [System.Collections.Generic.HashSet[int]]::new()
foreach ($block in $template.blocks) {
    foreach ($segment in $block.segments) {
        $index = -1
        for ($i = 0; $i -lt $oldSegments.Count; $i++) {
            if ($oldSegments[$i].type -eq $segment.type -and -not $used.Contains($i)) { $index = $i; break }
        }
        if ($index -lt 0) { $missingSegments.Add($segment.type); continue }
        $null = $used.Add($index)
        Compare-Node $segment $oldSegments[$index] $segment.type
    }
}
$extraSegments = @(for ($i = 0; $i -lt $oldSegments.Count; $i++) { if (-not $used.Contains($i)) { $oldSegments[$i].type } })

#region Choose a value per role

function Get-Choice($List) {
    $groups = @($List | Group-Object { $_.Value } | Sort-Object Count -Descending -Stable)
    @{
        Value  = $groups[0].Name
        Others = @($groups | Select-Object -Skip 1 | ForEach-Object { "$($_.Name) ($(($_.Group.Where | ForEach-Object { $_ -replace ' \(loose match\)$', '' }) -join ', '))" })
    }
}

function Get-Luminance([string]$Hex) {
    $channels = 1, 3, 5 | ForEach-Object {
        $c = [Convert]::ToInt32($Hex.Substring($_, 2), 16) / 255
        if ($c -le 0.03928) { $c / 12.92 } else { [math]::Pow(($c + 0.055) / 1.055, 2.4) }
    }
    0.2126 * $channels[0] + 0.7152 * $channels[1] + 0.0722 * $channels[2]
}

$colorRoles = [ordered]@{}   # 'brand.primary' -> @{ Value; Others }
$iconRoles = [ordered]@{}
$langIcons = [ordered]@{}
$osIcons = [ordered]@{}
$targetExtras = [ordered]@{}

foreach ($token in $candidates.Keys) {
    $choice = Get-Choice $candidates[$token]
    $kind, $rest = $token -split '\.', 2
    switch ($kind) {
        'color' { $colorRoles[$rest] = $choice }
        'icon' {
            $group, $name = $rest -split '\.', 2
            if ($name -and $group -eq 'lang') { $langIcons[$name] = $choice }
            elseif ($name -and $group -eq 'os') { $osIcons[$name] = $choice }
            else { $iconRoles[$rest] = $choice }
        }
        'target' { $targetExtras[$rest] = $choice }
    }
}

# The two text colours: the lightest and darkest foregrounds used on brand backgrounds.
$texts = @($textColors | Group-Object { $_.Value } | ForEach-Object { $_.Name } | Sort-Object { Get-Luminance $_ })
if ($texts.Count) {
    $colorRoles['ui.text_light'] = @{ Value = $texts[-1]; Others = @() }
    $colorRoles['ui.text_dark'] = @{ Value = ($texts.Count -gt 1 ? $texts[0] : 'todo'); Others = @() }
}
foreach ($required in 'brand.primary', 'brand.secondary', 'brand.accent', 'ui.text_light', 'ui.text_dark', 'status.error') {
    if (-not $colorRoles.Contains($required)) { $colorRoles[$required] = @{ Value = 'todo'; Others = @() } }
}
foreach ($required in 'shell', 'path', 'git', 'exec_time', 'clock', 'status_ok') {
    if (-not $iconRoles.Contains($required)) { $iconRoles[$required] = @{ Value = 'TODO'; Others = @() } }
}

# The most common language icon becomes the default; only the exceptions stay in "lang".
$language = $null
if ($langIcons.Count) {
    $language = @($langIcons.Values | Group-Object { $_.Value } | Sort-Object Count -Descending -Stable)[0].Name
    $iconRoles['language'] = @{ Value = $language; Others = @() }
}

#endregion

#region Palette

$paletteKey = { param($hex) 'c_' + $hex.Substring(1).ToLower() }
$palette = [ordered]@{}   # hex -> list of roles using it
foreach ($role in $colorRoles.Keys) {
    $hex = $colorRoles[$role].Value
    if ($hex -eq 'todo') { continue }
    if (-not $palette.Contains($hex)) { $palette[$hex] = [System.Collections.Generic.List[string]]::new() }
    $palette[$hex].Add($role)
}
# Colours hard-coded in the template itself (e.g. battery states) aren't the month's, so skip them.
$templateColors = @([regex]::Matches((Get-Content -Raw $TemplatePath), '#[0-9A-Fa-f]{6}\b') | ForEach-Object { $_.Value.ToUpper() })
$otherColors = @([regex]::Matches($oldText, '#[0-9A-Fa-f]{6}\b') | ForEach-Object { $_.Value.ToUpper() } |
    Select-Object -Unique | Where-Object { -not $palette.Contains($_) -and $_ -notin $templateColors })

#endregion

#region Write the draft

function ConvertTo-JsonString([string]$Text) { '"' + ($Text -replace '\\', '\\' -replace '"', '\"') + '"' }

$relativeTheme = [IO.Path]::GetRelativePath($Root, $Theme) -replace '\\', '/'
$lines = [System.Collections.Generic.List[string]]::new()
function Add([string]$Line = '') { $lines.Add($Line) }
function Add-Entry([string]$Indent, [string]$Key, [string]$Value, [bool]$Last, [string[]]$Others) {
    $line = "$Indent$(ConvertTo-JsonString $Key): $Value$($Last ? '' : ',')"
    if ($Others) { $line += "  // also: $($Others -join '; ')" }
    Add $line
}

Add '{'
Add '  "$schema": "../schema/season.schema.json",'
Add
Add "  // Drafted by tools/Import-OmpTheme.ps1 from $relativeTheme."
Add '  // Before generating: name every palette entry (and rename its c_ key), fill in each TODO,'
Add '  // resolve the notes below and the "also:" comments, then delete these notes.'
if ($unmatched.Count) {
    Add '  //'
    Add "  // Couldn't import (set by hand if needed):"
    foreach ($note in $unmatched) { Add "  //   $note" }
}
if ($missingSegments.Count) {
    Add '  //'
    Add "  // Segments the old theme doesn't have (their roles fall back unless set): $($missingSegments -join ', ')"
}
if ($missing.Count) {
    Add '  //'
    Add '  // Not in the old theme (these fall back unless set):'
    foreach ($note in $missing | Select-Object -Unique) { Add "  //   $note" }
}
if ($extraSegments) {
    Add '  //'
    Add "  // Old segments the template doesn't have (dropped): $($extraSegments -join ', ')"
}
if ($otherColors) {
    Add '  //'
    Add "  // Other colours in the old theme that no role took: $($otherColors -join ', ')"
}
Add
Add "  `"month`": `"$Month`","
Add '  "name": "TODO",'
Add '  "tagline": "TODO",'
Add '  "appearance": "dark",'
Add
Add '  "palette": {'
$hexes = @($palette.Keys)
for ($i = 0; $i -lt $hexes.Count; $i++) {
    $hex = $hexes[$i]
    $comma = $i -lt $hexes.Count - 1 ? ',' : ''
    Add "    $(ConvertTo-JsonString (& $paletteKey $hex)): { `"hex`": `"$hex`", `"name`": `"TODO`" }$comma  // $($palette[$hex] -join ', ')"
}
Add '  },'
Add
Add '  "colors": {'
$groups = @($colorRoles.Keys | ForEach-Object { ($_ -split '\.')[0] } | Select-Object -Unique)
$groupOrder = 'brand', 'ui', 'status', 'syntax', 'terminal'
$groups = @($groupOrder | Where-Object { $_ -in $groups })
for ($g = 0; $g -lt $groups.Count; $g++) {
    $group = $groups[$g]
    Add "    `"$group`": {"
    $roles = @($colorRoles.Keys | Where-Object { $_ -like "$group.*" })
    for ($r = 0; $r -lt $roles.Count; $r++) {
        $choice = $colorRoles[$roles[$r]]
        $value = $choice.Value -eq 'todo' ? '"todo"' : (ConvertTo-JsonString (& $paletteKey $choice.Value))
        Add-Entry '      ' ($roles[$r] -split '\.', 2)[1] $value ($r -eq $roles.Count - 1) $choice.Others
    }
    Add "    }$($g -lt $groups.Count - 1 ? ',' : '')"
}
Add '  },'
Add
Add '  "icons": {'
$sections = @()
foreach ($role in $iconRoles.Keys) {
    $sections += , @{ Kind = 'plain'; Key = $role; Choice = $iconRoles[$role] }
}
$langExceptions = [ordered]@{}
foreach ($name in $langIcons.Keys) { if ($langIcons[$name].Value -ne $language) { $langExceptions[$name] = $langIcons[$name] } }
if ($langExceptions.Count) { $sections += , @{ Kind = 'map'; Key = 'lang'; Map = $langExceptions } }
if ($osIcons.Count) { $sections += , @{ Kind = 'map'; Key = 'os'; Map = $osIcons } }
for ($s = 0; $s -lt $sections.Count; $s++) {
    $section = $sections[$s]
    $last = $s -eq $sections.Count - 1
    if ($section.Kind -eq 'plain') {
        Add-Entry '    ' $section.Key (ConvertTo-JsonString $section.Choice.Value) $last $section.Choice.Others
    }
    else {
        Add "    `"$($section.Key)`": {"
        $names = @($section.Map.Keys)
        for ($n = 0; $n -lt $names.Count; $n++) {
            $choice = $section.Map[$names[$n]]
            Add-Entry '      ' $names[$n] (ConvertTo-JsonString $choice.Value) ($n -eq $names.Count - 1) $choice.Others
        }
        Add "    }$($last ? '' : ',')"
    }
}
if ($targetExtras.Count) {
    Add '  },'
    Add
    Add '  "targets": {'
    Add '    "oh-my-posh": {'
    $keys = @($targetExtras.Keys)
    for ($k = 0; $k -lt $keys.Count; $k++) {
        $choice = $targetExtras[$keys[$k]]
        Add-Entry '      ' $keys[$k] (ConvertTo-JsonString $choice.Value) ($k -eq $keys.Count - 1) $choice.Others
    }
    Add '    }'
    Add '  }'
}
else {
    Add '  }'
}
Add '}'

$draft = ($lines -join "`n") + "`n"
$null = $draft | ConvertFrom-Json  # the draft must at least be valid JSONC

if ($OutFile -eq '-') {
    $draft
}
else {
    [IO.File]::WriteAllText($OutFile, $draft, [Text.UTF8Encoding]::new($false))
    Write-Host "Drafted $([IO.Path]::GetRelativePath($Root, $OutFile)) from $relativeTheme" -ForegroundColor Green
    Write-Host "  $($palette.Count) palette colours, $($unmatched.Count) things to set by hand, $($otherColors.Count) unused old colours."
}

#endregion
