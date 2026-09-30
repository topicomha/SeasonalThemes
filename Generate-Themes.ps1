<#
.SYNOPSIS
    Generates every program's theme files from each month's season.jsonc.

.DESCRIPTION
    <Month>/season.jsonc is the one document that defines a month: identity, a named palette,
    colour roles, icons, date variants and per-program extras. schema/season.schema.json is the
    spec for that document, and this script reads its required roles and x-fallback rules from it.

    Each target turns the resolved season into one file:

    - Template targets (templates/*.json) contain [[token]] placeholders:
        [[color.<group>.<role>]]   e.g. [[color.brand.primary]], [[color.terminal.red]]
        [[on.<group>.<role>]]      ui.text_light or ui.text_dark, whichever reads better on that colour
        [[style.<group>.<role>]]   font style, e.g. italic ('' when none)
        [[palette.<name>]]         a palette colour by name
        [[icon.<role>]]            e.g. [[icon.git]], [[icon.lang.node]], [[icon.os.linux]]
        [[meta.<field>]]           month, name, tagline, appearance, variant
        [[target.<key>|default]]   a per-program extra from season.jsonc "targets"
        [[choice.<key>|role]]      the colour role the month picks in targets.<program>.<key> (default: role)
        [[on-choice.<key>|role]]   the best text colour on that choice
    - Renderer targets (templates/*.ps1) get the resolved season and return the file's text.
      Use these when the output needs loops (documentation, images).

.EXAMPLE
    ./Generate-Themes.ps1                  # every month that has a season.jsonc
    ./Generate-Themes.ps1 -Month October
    ./Generate-Themes.ps1 -Check           # exit 1 if any generated file is out of date
    ./Generate-Themes.ps1 -Month May -Export   # resolved colours as JSON (used by tools/New-LightMode.ps1)
#>
#Requires -Version 7.4
[CmdletBinding()]
param(
    [ValidateSet('January', 'February', 'March', 'April', 'May', 'June',
                 'July', 'August', 'September', 'October', 'November', 'December')]
    [string[]]$Month,

    [switch]$Check,

    # Print every selected month's resolved colours (per variant and mode) as JSON instead of generating.
    [switch]$Export
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Months = 'January', 'February', 'March', 'April', 'May', 'June',
          'July', 'August', 'September', 'October', 'November', 'December'

$SchemaPath = Join-Path $PSScriptRoot 'schema' 'season.schema.json'

# One entry per generated file type. Add a row here when a new program gets a template.
#   Program: the key under season.jsonc "targets" that holds this program's extras and choices.
#   PerVariant: also generate one file per date variant (output names get -<variant id>).
#   PerMode: also generate one file per light/dark mode the month defines.
#   Owns: a glob of the files this target generates; with -Check, any match it no longer generates is an orphan.
#   Output: { param($month, $variantId, $mode, $isBaseMode) } -> path relative to the repository root.
$Targets = @(
    @{
        Name       = 'oh-my-posh'
        Program    = 'oh-my-posh'
        Template   = 'templates/oh-my-posh.omp.json'
        Owns       = '*/davids-*.omp.json'
        PerVariant = $true
        Check      = { param($Season, $Text) Test-OmpContrast $Season $Text }
        PerMode    = $true
        # The base mode keeps the plain name (existing symlinks keep working); the other mode adds -light / -dark.
        Output     = { param($m, $v, $mode, $isBase) "$m/davids-$m$($v ? "-$v" : '')$($isBase ? '' : "-$mode").omp.json" }
    }
    @{
        Name       = 'palette-svg'
        Renderer   = 'templates/palette.svg.ps1'
        Owns       = '*/palette*.svg'
        PerVariant = $true
        PerMode    = $true
        Output     = { param($m, $v, $mode, $isBase) "$m/palette$($v ? "-$v" : '')$($isBase ? '' : "-$mode").svg" }
    }
    @{
        Name       = 'theme-definition'
        Renderer   = 'templates/theme-definition.md.ps1'
        Owns       = '*/theme-definition.md'
        PerVariant = $false
        Output     = { param($m) "$m/theme-definition.md" }
    }
    @{
        Name       = 'month-readme'
        Renderer   = 'templates/month-readme.md.ps1'
        # No Owns: '*/README.md' would also match the hand-written vscode/README.md.
        PerVariant = $false
        Output     = { param($m) "$m/README.md" }
    }
    @{
        Name       = 'vscode-theme'
        Program    = 'vscode'
        Template   = 'templates/vscode-color-theme.json'
        Owns       = 'vscode/themes/*.json'
        PerVariant = $true
        Check      = { param($Season, $Text) Test-VsCodeContrast $Season $Text }
        PerMode    = $true
        Output     = { param($m, $v, $mode) "vscode/themes/$($m.ToLower())$($v ? "-$v" : '')-$mode.json" }
    }
    @{
        Name       = 'vscode-preview'
        Program    = 'vscode'
        Renderer   = 'templates/vscode-preview.svg.ps1'
        Owns       = '*/vscode-preview*.svg'
        PerVariant = $true
        PerMode    = $true
        Output     = { param($m, $v, $mode) "$m/vscode-preview$($v ? "-$v" : '')-$mode.svg" }
    }
    # Scope 'all': rendered once from every month, not once per month.
    @{
        Name     = 'vscode-manifest'
        Scope    = 'all'
        Renderer = 'templates/vscode-package.json.ps1'
        Output   = 'vscode/package.json'
    }
    @{
        Name     = 'vscode-license'
        Scope    = 'all'
        Renderer = 'templates/vscode-license.ps1'
        Output   = 'vscode/LICENSE'
    }
)

# Minimum contrast before [[on.<role>]] warns: 3:1 is the WCAG floor for UI elements.
$MinContrast = 3.0

#region Schema-driven role tables

$Schema = Get-Content -Raw $SchemaPath | ConvertFrom-Json -AsHashtable

$ColorGroups = [ordered]@{}
$ColorRoles = [ordered]@{}
foreach ($group in $Schema.definitions.colors.properties.Keys) {
    $groupDef = $Schema.definitions.colors.properties[$group]
    $ColorGroups[$group] = $groupDef['description']
    foreach ($role in $groupDef.properties.Keys) {
        $def = $groupDef.properties[$role]
        $ColorRoles["$group.$role"] = @{
            Group       = $group
            Role        = $role
            Fallback    = $def['x-fallback']
            Description = $def['description']
        }
    }
}

$IconRoles = [ordered]@{}
$iconDefs = $Schema.definitions.icons.properties
foreach ($role in $iconDefs.Keys) {
    if ($role -in 'lang', 'os', 'pool') { continue }
    $IconRoles[$role] = @{
        Fallback    = $iconDefs[$role]['x-fallback']
        Default     = $iconDefs[$role]['x-default']
        Description = $iconDefs[$role]['description']
    }
}
$LangFallback = $iconDefs.lang['x-fallback']
$OsFallback = $iconDefs.os['x-fallback']

#endregion

#region Helpers

function Get-Luminance([string]$Hex) {
    $channels = 1, 3, 5 | ForEach-Object {
        $c = [Convert]::ToInt32($Hex.Substring($_, 2), 16) / 255
        if ($c -le 0.03928) { $c / 12.92 } else { [math]::Pow(($c + 0.055) / 1.055, 2.4) }
    }
    0.2126 * $channels[0] + 0.7152 * $channels[1] + 0.0722 * $channels[2]
}

function Get-ContrastRatio([string]$A, [string]$B) {
    $la = Get-Luminance $A
    $lb = Get-Luminance $B
    ([math]::Max($la, $lb) + 0.05) / ([math]::Min($la, $lb) + 0.05)
}

function Get-BestText([string]$Background, [string]$Light, [string]$Dark) {
    $lightRatio = Get-ContrastRatio $Background $Light
    $darkRatio = Get-ContrastRatio $Background $Dark
    if ($lightRatio -ge $darkRatio) { @{ Hex = $Light; Ratio = $lightRatio } }
    else { @{ Hex = $Dark; Ratio = $darkRatio } }
}

function Merge-Deep($Base, $Over) {
    $result = [ordered]@{}
    foreach ($key in $Base.Keys) { $result[$key] = $Base[$key] }
    foreach ($key in $Over.Keys) {
        if ($result[$key] -is [System.Collections.IDictionary] -and $Over[$key] -is [System.Collections.IDictionary]) {
            $result[$key] = Merge-Deep $result[$key] $Over[$key]
        }
        else {
            $result[$key] = $Over[$key]
        }
    }
    $result
}

function Assert-Schema([string]$Path, [string]$Text) {
    $errs = $null
    $valid = Test-Json -Json $Text -SchemaFile $SchemaPath -Options IgnoreComments, AllowTrailingCommas `
        -ErrorVariable errs -ErrorAction SilentlyContinue
    if ($valid) { return }

    $messages = @($errs | ForEach-Object {
        $_.Exception.Message -replace '^The JSON is not valid with the schema: ', '' `
                             -replace '^All values fail against the false schema at', 'Unknown field at' `
                             -replace '^The string value is not a match for the indicated regular expression at', 'Wrong format at'
    })
    # A value that can take several shapes (e.g. a colour is a name OR { color, style }) reports
    # one message per shape it didn't match. Drop those when a more specific message exists.
    $noise = '^Value is "\w+" but should be "\w+"|^Expected \d+ matching subschema'
    $useful = @($messages | Where-Object { $_ -notmatch $noise } | Select-Object -Unique)
    if (-not $useful) { $useful = @($messages | Select-Object -Unique) }
    throw "$Path doesn't match schema/season.schema.json:`n  " + ($useful -join "`n  ")
}

#endregion

#region Resolving a season

function Read-Season([string]$MonthName) {
    $path = Join-Path $PSScriptRoot $MonthName 'season.jsonc'
    $text = Get-Content -Raw -Path $path
    Assert-Schema $path $text
    $raw = $text | ConvertFrom-Json -AsHashtable
    if ($raw.month -ne $MonthName) {
        throw "$path says month '$($raw.month)' but lives in the $MonthName folder."
    }
    $programs = @($Targets | ForEach-Object { $_['Program'] } | Where-Object { $_ } | Select-Object -Unique)
    foreach ($source in @($raw) + @($raw['variants'] ?? @())) {
        foreach ($program in @($source['targets'] ? $source.targets.Keys : @())) {
            if ($program -notin $programs) {
                throw "$path has targets.$program, but no target reads it (known: $($programs -join ', '))."
            }
        }
    }

    $todos = @(Find-Todo $raw '')
    if ($todos) {
        throw "$path is still a draft; fill in: $($todos -join ', ')"
    }
    $raw
}

# A draft marks anything still undecided as TODO (or "todo" for colour roles); refuse to generate until it's filled in.
function Find-Todo($Node, [string]$Where) {
    if ($Node -is [System.Collections.IDictionary]) {
        foreach ($key in $Node.Keys) { Find-Todo $Node[$key] ($Where ? "$Where.$key" : $key) }
    }
    elseif ($Node -is [System.Collections.IList]) {
        for ($i = 0; $i -lt $Node.Count; $i++) { Find-Todo $Node[$i] "$Where[$i]" }
    }
    elseif ($Node -is [string] -and $Node -match '^\s*todo\b') {
        $Where
    }
}

function Resolve-Color($Ctx, [string]$Key) {
    if ($Ctx.Colors.Contains($Key)) { return $Ctx.Colors[$Key] }
    if ($Ctx.Stack.Contains($Key)) { throw "$($Ctx.Where): colour fallbacks loop: $($Ctx.Stack -join ' -> ') -> $Key" }

    $role = $ColorRoles[$Key]
    if (-not $role) { throw "schema/season.schema.json: x-fallback points at unknown colour role '$Key'." }
    $group =$Ctx.Data.colors ? $Ctx.Data.colors[$role.Group] : $null
    $value = $group ? $group[$role.Role] : $null

    if ($null -ne $value) {
        $ref, $style = if ($value -is [System.Collections.IDictionary]) { $value.color, $value['style'] } else { $value, $null }
        $hex = if ($ref -match '^#') { $ref }
               elseif ($Ctx.Palette.Contains($ref)) { $Ctx.Palette[$ref].Hex }
               else { throw "$($Ctx.Where): colour '$Key' points at '$ref', which isn't in the palette." }
        $resolved = @{ Hex = $hex; Ref = $ref; Style = $style; From = $null }
    }
    elseif ($role.Fallback) {
        $Ctx.Stack.Add($Key)
        $inherited = Resolve-Color $Ctx $role.Fallback
        $null = $Ctx.Stack.Remove($Key)
        $resolved = @{ Hex = $inherited.Hex; Ref = $inherited.Ref; Style = $inherited.Style; From = $role.Fallback }
    }
    else {
        throw "$($Ctx.Where) is missing required colour '$Key'."
    }

    $Ctx.Colors[$Key] = $resolved
    $resolved
}

function Resolve-Icon($Ctx, [string]$Role) {
    if ($Ctx.Icons.Contains($Role)) { return $Ctx.Icons[$Role] }
    $def = $IconRoles[$Role]
    $value = $Ctx.Data.icons[$Role]

    $resolved = if ($value) { @{ Value = $value; From = $null } }
                elseif ($def.Fallback) { @{ Value = (Resolve-Icon $Ctx $def.Fallback).Value; From = $def.Fallback } }
                elseif ($def.Default) { @{ Value = $def.Default; From = 'default' } }
                else { throw "$($Ctx.Where) is missing required icon '$Role'." }

    $Ctx.Icons[$Role] = $resolved
    $resolved
}

# The modes a month (or one of its variants) defines, e.g. @{ light = @{ colors = ... } }.
function Get-Modes($Raw, $Variant) {
    $modes = $Raw['modes'] ?? [ordered]@{}
    if ($Variant -and $Variant['modes']) { $modes = Merge-Deep $modes $Variant.modes }
    $modes
}

# Turns the raw document (plus an optional variant laid over it) into everything a target needs:
# every colour role resolved to a hex with its best text colour, and every icon resolved.
function Resolve-Season($Raw, $Variant, [string]$Mode) {
    $data = $Raw
    $where = $Raw.month
    if ($Variant) {
        $overrides = [ordered]@{}
        foreach ($key in $Variant.Keys) {
            if ($key -notin 'id', 'name', 'from', 'to', 'modes') { $overrides[$key] = $Variant[$key] }
        }
        $data = Merge-Deep $Raw $overrides
        $where = "$($Raw.month) variant '$($Variant.id)'"
    }

    # The other appearance: the month's (and variant's) modes.<mode> laid over everything else.
    $baseMode = $Raw.appearance
    if (-not $Mode) { $Mode = $baseMode }
    if ($Mode -ne $baseMode) {
        $modes = Get-Modes $Raw $Variant
        if (-not $modes.Contains($Mode)) { throw "$where has no modes.$Mode." }
        $data = Merge-Deep $data $modes[$Mode]
        $data.appearance = $Mode
        $where += " ($Mode)"
    }

    $palette = [ordered]@{}
    foreach ($name in $data.palette.Keys) {
        $entry = $data.palette[$name]
        $palette[$name] = if ($entry -is [string]) { @{ Hex = $entry; Name = $name; Note = $null } }
                          else { @{ Hex = $entry.hex; Name = $entry['name'] ?? $name; Note = $entry['note'] } }
    }

    $ctx = @{
        Where   = $where
        Data    = $data
        Palette = $palette
        Colors  = [ordered]@{}
        Icons   = [ordered]@{}
        Stack   = [System.Collections.Generic.List[string]]::new()
    }

    $colors = [ordered]@{}
    foreach ($key in $ColorRoles.Keys) { $colors[$key] = Resolve-Color $ctx $key }

    # Colours that are drawn as text must stay readable on the background they're drawn on.
    $readableOn = [ordered]@{ 'ui.foreground' = 'ui.background'; 'ui.muted' = 'ui.background' }
    foreach ($key in $colors.Keys) {
        if ($key -like 'syntax.*') { $readableOn[$key] = 'ui.background' }
        elseif ($key -like 'terminal.*' -and $key -notmatch '\.(background|cursor|selection|black|bright_black)$') { $readableOn[$key] = 'terminal.background' }
    }
    foreach ($key in $readableOn.Keys) {
        $ratio = Get-ContrastRatio $colors[$key].Hex $colors[$readableOn[$key]].Hex
        if ($ratio -lt $MinContrast) {
            Write-Warning ("{0}: {1} ({2}) is only {3:N1}:1 on {4} ({5})" -f $where, $key, $colors[$key].Hex, $ratio, $readableOn[$key], $colors[$readableOn[$key]].Hex)
        }
    }

    $light = $colors['ui.text_light'].Hex
    $dark = $colors['ui.text_dark'].Hex
    foreach ($entry in @($colors.Values) + @($palette.Values)) {
        $best = Get-BestText $entry.Hex $light $dark
        $entry.On = $best.Hex
        $entry.Contrast = $best.Ratio
    }

    $icons = [ordered]@{}
    foreach ($role in $IconRoles.Keys) { $icons[$role] = Resolve-Icon $ctx $role }

    # A display name that sorts by month in pickers, e.g. "Seasonal 10 · October — Halloween".
    $number = '{0:D2}' -f ([array]::IndexOf($Months, $Raw.month) + 1)
    $title = "Seasonal $number · $($Raw.month) — $($Variant ? $Variant.name : $Raw.name)"
    if ((Get-Modes $Raw $Variant).Count) { $title += ' · ' + (Get-Culture).TextInfo.ToTitleCase($Mode) }

    @{
        Month       = $Raw.month
        Title       = $title
        Mode        = $Mode
        IsBaseMode  = $Mode -eq $baseMode
        VariantId   = $Variant ? $Variant.id : $null
        VariantName = $Variant ? $Variant.name : $null
        Where       = $where
        Data        = $data
        Variants    = @($Raw['variants'] ?? @())
        Palette     = $palette
        Colors      = $colors
        Icons       = $icons
        Lang        = $data.icons['lang'] ?? @{}
        Os          = $data.icons['os'] ?? @{}
        Pool        = @($data.icons['pool'] ?? @())
        Roles       = @{ Groups = $ColorGroups; Colors = $ColorRoles; Icons = $IconRoles }
    }
}

function Resolve-Token($Season, [string]$TargetName, [string]$Token, $Default) {
    $kind, $rest = $Token -split '\.', 2
    $value = switch ($kind) {
        'color' { if ($Season.Colors.Contains($rest)) { $Season.Colors[$rest].Hex } }
        'style' { if ($Season.Colors.Contains($rest)) { $Season.Colors[$rest].Style ?? '' } }
        'on' {
            if ($Season.Colors.Contains($rest)) {
                $entry = $Season.Colors[$rest]
                if ($entry.Contrast -lt $MinContrast) {
                    Write-Warning ("{0}: best text contrast on {1} ({2}) is only {3:N1}:1" -f $Season.Where, $rest, $entry.Hex, $entry.Contrast)
                }
                $entry.On
            }
        }
        'palette' { if ($Season.Palette.Contains($rest)) { $Season.Palette[$rest].Hex } }
        'icon' {
            $group, $name = $rest -split '\.', 2
            if ($name -and $group -eq 'lang') { $Season.Lang[$name] ?? $Season.Icons[$LangFallback].Value }
            elseif ($name -and $group -eq 'os') { $Season.Os[$name] ?? $Season.Icons[$OsFallback].Value }
            elseif ($Season.Icons.Contains($rest)) { $Season.Icons[$rest].Value }
        }
        'meta' {
            switch ($rest) {
                'variant' { $Season.VariantName ?? '' }
                'title' { $Season.Title }
                { $_ -in 'month', 'name', 'tagline', 'appearance' } { $Season.Data[$rest] }
            }
        }
        'target' {
            $extras = $Season.Data['targets'] ? $Season.Data.targets[$TargetName] : $null
            $extras ? $extras[$rest] : $null
        }
        # A colour role the month picks for this program, e.g. [[choice.status_bar|brand.primary]]
        # uses targets.<program>.status_bar when set, else brand.primary. on-choice gives its text colour.
        { $_ -in 'choice', 'on-choice' } {
            $extras = $Season.Data['targets'] ? $Season.Data.targets[$TargetName] : $null
            $role = ($extras ? $extras[$rest] : $null) ?? $Default
            if (-not $Season.Colors.Contains($role)) {
                throw "$($Season.Where): targets.$TargetName.$rest is '$role', which isn't a colour role (e.g. brand.accent)."
            }
            $kind -eq 'choice' ? $Season.Colors[$role].Hex : $Season.Colors[$role].On
        }
    }
    if ($null -ne $value) { return [string]$value }
    if ($null -ne $Default) { return $Default }
    throw "$($Season.Where): unknown token [[$Token]] in the $TargetName template."
}

#endregion

#region Targets

$TokenPattern = '\[\[([a-z0-9_.-]+)(?:\|([^\]]*))?\]\]'

function Invoke-Template($Season, $Target) {
    $templatePath = Join-Path $PSScriptRoot $Target.Template
    $text = [IO.File]::ReadAllText($templatePath, $utf8)
    $isJson = $templatePath -match '\.json$'

    $values = @{}
    foreach ($match in [regex]::Matches($text, $TokenPattern)) {
        if ($values.ContainsKey($match.Value)) { continue }
        $default = $match.Groups[2].Success ? $match.Groups[2].Value : $null
        $value = Resolve-Token $Season $Target.Program $match.Groups[1].Value $default
        # JSON templates put tokens inside strings, so escape anything that would end or break one.
        if ($isJson) { $value = $value -replace '\\', '\\' -replace '"', '\"' }
        $values[$match.Value] = $value
    }
    $output = [regex]::Replace($text, $TokenPattern, { param($m) $values[$m.Value] })

    if ($isJson) { $null = $output | ConvertFrom-Json }  # fail loudly rather than write a broken theme
    $output
}

# Warns about prompt segments whose text is hard to read on their own background.
function Test-OmpContrast($Season, [string]$Text) {
    $theme = $Text | ConvertFrom-Json -AsHashtable
    foreach ($block in $theme.blocks) {
        foreach ($segment in $block.segments) {
            $fg = $segment['foreground']
            # Segments without a background are drawn straight on the terminal.
            $bg = $segment['background'] ?? $Season.Colors['terminal.background'].Hex
            if ($fg -notmatch '^#[0-9A-Fa-f]{6}$' -or $bg -notmatch '^#[0-9A-Fa-f]{6}$') { continue }
            $ratio = Get-ContrastRatio $fg $bg
            if ($ratio -lt $MinContrast) {
                Write-Warning ("{0}: Oh My Posh {1} segment text {2} is only {3:N1}:1 on {4}" -f $Season.Where, $segment.type, $fg, $ratio, $bg)
            }
        }
    }
}

# Text/background pairs in a VS Code theme that must stay readable.
$VsCodePairs = @(
    @('editor.foreground', 'editor.background'),
    @('editorLineNumber.foreground', 'editor.background'),
    @('editorLineNumber.activeForeground', 'editor.lineHighlightBackground'),
    @('titleBar.activeForeground', 'titleBar.activeBackground'),
    @('activityBar.foreground', 'activityBar.background'),
    @('activityBarBadge.foreground', 'activityBarBadge.background'),
    @('sideBar.foreground', 'sideBar.background'),
    @('sideBarSectionHeader.foreground', 'sideBarSectionHeader.background'),
    @('list.activeSelectionForeground', 'list.activeSelectionBackground'),
    @('list.inactiveSelectionForeground', 'list.inactiveSelectionBackground'),
    @('list.highlightForeground', 'sideBar.background'),
    @('tab.activeForeground', 'tab.activeBackground'),
    @('tab.inactiveForeground', 'tab.inactiveBackground'),
    @('breadcrumb.foreground', 'breadcrumb.background'),
    @('input.foreground', 'input.background'),
    @('input.placeholderForeground', 'input.background'),
    @('button.foreground', 'button.background'),
    @('button.secondaryForeground', 'button.secondaryBackground'),
    @('badge.foreground', 'badge.background'),
    @('panelTitle.activeForeground', 'panel.background'),
    @('statusBar.foreground', 'statusBar.background'),
    @('statusBar.debuggingForeground', 'statusBar.debuggingBackground'),
    @('statusBar.noFolderForeground', 'statusBar.noFolderBackground'),
    @('statusBarItem.remoteForeground', 'statusBarItem.remoteBackground'),
    @('editorSuggestWidget.foreground', 'editorSuggestWidget.background'),
    @('editorSuggestWidget.selectedForeground', 'editorSuggestWidget.selectedBackground'),
    @('editorSuggestWidget.highlightForeground', 'editorSuggestWidget.background'),
    @('quickInputList.focusForeground', 'quickInputList.focusBackground'),
    @('menu.selectionForeground', 'menu.selectionBackground'),
    @('notifications.foreground', 'notifications.background'),
    @('terminal.foreground', 'terminal.background')
)

function Test-VsCodeContrast($Season, [string]$Text) {
    $colors = ($Text | ConvertFrom-Json -AsHashtable).colors
    foreach ($pair in $VsCodePairs) {
        $fg = $colors[$pair[0]]
        $bg = $colors[$pair[1]]
        if ($fg -notmatch '^#[0-9A-Fa-f]{6}$' -or $bg -notmatch '^#[0-9A-Fa-f]{6}$') { continue }
        $ratio = Get-ContrastRatio $fg $bg
        if ($ratio -lt $MinContrast) {
            Write-Warning ("{0}: VS Code {1} {2} is only {3:N1}:1 on {4} {5}" -f $Season.Where, $pair[0], $fg, $ratio, $pair[1], $bg)
        }
    }
}

function Invoke-Renderer($Season, $Target, [hashtable]$Files) {
    & (Join-Path $PSScriptRoot $Target.Renderer) -Season $Season -Files $Files
}

#endregion

# Whether a target is generated for this month/variant/mode (PerVariant and PerMode opt in).
function Test-TargetEntry($Target, $Entry) {
    if ($Entry.Variant -and -not $Target['PerVariant']) { return $false }
    if (-not $Entry.IsBase -and -not $Target['PerMode']) { return $false }
    $true
}

function Get-OutputPath($Target, $Entry) {
    & $Target.Output $Entry.Month ($Entry.Variant ? $Entry.Variant.id : $null) $Entry.Mode $Entry.IsBase
}

# Writes a generated file, or in -Check mode records it as stale, unless it's already up to date.
function Save-Output([string]$Relative, [string]$Output) {
    $null = $script:produced.Add(($Relative -replace '\\', '/'))
    $outPath = Join-Path $PSScriptRoot $Relative
    $current = (Test-Path $outPath) ? [IO.File]::ReadAllText($outPath, $utf8) : $null
    if ($current -ceq $Output) {
        Write-Host "  up to date  $Relative"
    }
    elseif ($Check) {
        Write-Host "  STALE       $Relative" -ForegroundColor Yellow
        $script:stale += $Relative
    }
    else {
        $null = New-Item -ItemType Directory -Force -Path (Split-Path $outPath -Parent)
        [IO.File]::WriteAllText($outPath, $Output, $utf8)
        Write-Host "  generated   $Relative" -ForegroundColor Green
    }
}

# Every month's seasons (the month itself, then each variant), resolved once and reused.
$resolved = @{}
function Get-MonthSeasons([string]$MonthName) {
    if (-not $resolved.ContainsKey($MonthName)) {
        $raw = Read-Season $MonthName
        $list = @()
        foreach ($v in @($null) + @($raw['variants'] ?? @())) {
            # The base appearance first, then each other mode the month (or variant) defines.
            $modes = @($raw.appearance) + @((Get-Modes $raw $v).Keys | Where-Object { $_ -ne $raw.appearance })
            $bySeason = @{}
            foreach ($mode in $modes) {
                $season = Resolve-Season $raw $v $mode
                $bySeason[$mode] = $season
                $list += @{ Month = $MonthName; Variant = $v; Mode = $mode; IsBase = $season.IsBaseMode; Season = $season }
            }
            # Renderers of the base mode (e.g. the docs page) can show the other modes too.
            $bySeason[$raw.appearance].ModeSeasons = $bySeason
        }
        $resolved[$MonthName] = $list
    }
    $resolved[$MonthName]
}

# Problems in a season file are the normal failure here, so show just the message, not a stack trace.
try {
    $available = @($Months | Where-Object { Test-Path (Join-Path $PSScriptRoot $_ 'season.jsonc') })
    $selected = if ($Month) { $Month } else { $available }

    $utf8 = [Text.UTF8Encoding]::new($false)
    $stale = @()
    $produced = [System.Collections.Generic.HashSet[string]]::new()
    if ($Export) {
        $exported = [ordered]@{}
        foreach ($monthName in $selected) {
            $exported[$monthName] = @(foreach ($entry in Get-MonthSeasons $monthName) {
                $season = $entry.Season
                [ordered]@{
                    variant    = $entry.Variant ? $entry.Variant.id : $null
                    mode       = $entry.Mode
                    isBaseMode = $entry.IsBase
                    palette    = $season.Palette
                    colors     = & {
                        $map = [ordered]@{}
                        foreach ($role in $season.Colors.GetEnumerator()) { $map[$role.Key] = [ordered]@{ hex = $role.Value.Hex; ref = $role.Value.Ref; style = $role.Value.Style } }
                        $map
                    }
                    targets    = $season.Data['targets'] ?? @{}
                }
            })
        }
        $exported | ConvertTo-Json -Depth 8 -EscapeHandling Default
        exit 0
    }

    $monthTargets = @($Targets | Where-Object { $_['Scope'] -ne 'all' })
    $allTargets = @($Targets | Where-Object { $_['Scope'] -eq 'all' })

    foreach ($monthName in $selected) {
        $seasons = Get-MonthSeasons $monthName

        # Every generated file for this month, relative to the month folder, so generated docs can link to them.
        $monthDir = Join-Path $PSScriptRoot $monthName
        $files = @{}
        # Keys look like 'vscode-theme', 'vscode-theme:new-years-eve', 'vscode-theme@light', 'vscode-theme:new-years-eve@light'.
        foreach ($target in $monthTargets) {
            foreach ($entry in $seasons) {
                if (-not (Test-TargetEntry $target $entry)) { continue }
                $key = $target.Name + ($entry.Variant ? ":$($entry.Variant.id)" : '') + ($entry.IsBase ? '' : "@$($entry.Mode)")
                $full = Join-Path $PSScriptRoot (Get-OutputPath $target $entry)
                $files[$key] = [IO.Path]::GetRelativePath($monthDir, $full) -replace '\\', '/'
            }
        }

        foreach ($target in $monthTargets) {
            foreach ($entry in $seasons) {
                if (-not (Test-TargetEntry $target $entry)) { continue }

                $output = if ($target['Template']) { Invoke-Template $entry.Season $target }
                          else { Invoke-Renderer $entry.Season $target $files }
                if ($target['Check']) { & $target.Check $entry.Season $output }

                Save-Output (Get-OutputPath $target $entry) $output
            }
        }
    }

    # Targets that cover every month (e.g. the VS Code extension manifest) always see all of them.
    if ($allTargets) {
        $everything = @(foreach ($monthName in $available) { Get-MonthSeasons $monthName })
        foreach ($target in $allTargets) {
            $output = & (Join-Path $PSScriptRoot $target.Renderer) -Seasons $everything -Root $PSScriptRoot
            Save-Output $target.Output $output
        }
    }

    # Generated files that nothing generates any more (e.g. after a rename). Only meaningful for a full run.
    if (-not $Month) {
        foreach ($target in @($Targets | Where-Object { $_['Owns'] })) {
            $parent, $leaf = ($target.Owns -split '/', 2)
            $dirs = @(Resolve-Path -Path (Join-Path $PSScriptRoot $parent) -ErrorAction SilentlyContinue |
                Where-Object { Test-Path -LiteralPath $_ -PathType Container })
            $owned = foreach ($dir in $dirs) { Get-ChildItem -LiteralPath $dir -Filter $leaf -File }
            foreach ($file in $owned) {
                $relative = [IO.Path]::GetRelativePath($PSScriptRoot, $file.FullName) -replace '\\', '/'
                if (-not $produced.Contains($relative)) {
                    Write-Host "  ORPHAN      $relative (no longer generated; delete it)" -ForegroundColor Yellow
                    if ($Check) { $stale += $relative }
                }
            }
        }
    }
}
catch {
    Write-Host "error: $($_.Exception.Message)" -ForegroundColor Red
    Write-Verbose $_.ScriptStackTrace  # run with -Verbose to see where a template or renderer failed
    exit 1
}

if ($Check -and $stale) {
    Write-Host "$($stale.Count) file(s) out of date. Run ./Generate-Themes.ps1 to regenerate." -ForegroundColor Yellow
    exit 1
}
