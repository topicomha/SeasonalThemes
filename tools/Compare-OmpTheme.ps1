<#
.SYNOPSIS
    Compares two Oh My Posh themes and prints a Markdown report for a PR description.

.DESCRIPTION
    Renders both themes with oh-my-posh (when it's installed) and lists every field that differs,
    segment by segment (segments are paired by type, in order). Either side can be a file path or a
    git revision and path, e.g. origin/main:August/davids-August.omp.json.

.EXAMPLE
    pwsh ./tools/Compare-OmpTheme.ps1 -Before origin/main:August/davids-August.omp.json -After August/davids-August.omp.json
#>
#Requires -Version 7.4
[CmdletBinding()]
param(
    [Parameter(Mandatory)][string]$Before,
    [Parameter(Mandatory)][string]$After,

    # Skip rendering even when oh-my-posh is installed.
    [switch]$NoRender
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path $PSScriptRoot -Parent
$temporary = [System.Collections.Generic.List[string]]::new()

function Read-Theme([string]$Spec) {
    $path = [IO.Path]::IsPathRooted($Spec) ? $Spec : (Join-Path $Root $Spec)
    # <revision>:<path>, where the revision may contain slashes (origin/main:June/...), but not a Windows path (C:\...).
    if (-not (Test-Path $path) -and $Spec -match '^[^:]+:.+' -and $Spec -notmatch '^[A-Za-z]:[\\/]') {
        # A git revision:path. Write it out so oh-my-posh can render it (it needs a .json extension).
        $text = (git -C $Root show $Spec) -join "`n"
        if ($LASTEXITCODE) { throw "git show $Spec failed." }
        $path = Join-Path ([IO.Path]::GetTempPath()) "compare-$([guid]::NewGuid().ToString('N')).omp.json"
        [IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
        $temporary.Add($path)
    }
    elseif (-not (Test-Path $path)) {
        throw "Can't find $Spec (not a file, and not a git revision:path)."
    }
    @{ Label = $Spec; Path = $path; Data = (Get-Content -Raw $path | ConvertFrom-Json -AsHashtable) }
}

# Flattens a segment into path -> value, e.g. 'properties.branch_icon' -> '🌰 '.
function Get-Leaves($Node, [string]$Prefix, [hashtable]$Into) {
    if ($Node -is [System.Collections.IDictionary]) {
        foreach ($key in $Node.Keys) { Get-Leaves $Node[$key] ($Prefix ? "$Prefix.$key" : $key) $Into }
    }
    elseif ($Node -is [System.Collections.IList]) {
        for ($i = 0; $i -lt $Node.Count; $i++) { Get-Leaves $Node[$i] "$Prefix[$i]" $Into }
    }
    else {
        $Into[$Prefix] = $Node
    }
}

function Get-Segments($Theme) {
    $list = [System.Collections.Generic.List[object]]::new()
    for ($b = 0; $b -lt $Theme.blocks.Count; $b++) {
        foreach ($segment in $Theme.blocks[$b].segments) { $list.Add(@{ Type = $segment.type; Block = $b; Data = $segment }) }
    }
    $list
}

# Hand-written and generated files differ in colour-code case (#f39c12 vs #F39C12); that's not a change.
function Get-Comparable($Value) {
    if ($null -eq $Value) { return "`0null" }
    [regex]::Replace([string]$Value, '#[0-9A-Fa-f]{6}\b', { param($m) $m.Value.ToUpper() })
}

function Format-Value($Value) {
    if ($null -eq $Value) { return '—' }
    $text = [string]$Value
    if ($text.Length -gt 90) { $text = $text.Substring(0, 87) + '...' }
    '`' + ($text -replace '\|', '\|' -replace '`', "'") + '`'
}

function Get-Render([string]$Path) {
    $out = foreach ($prompt in 'primary', 'right') {
        (oh-my-posh print $prompt --config $Path --shell pwsh --plain 2>&1) -join "`n"
    }
    ($out | Where-Object { $_.Trim() }) -join "`n"
}

try {
    $old = Read-Theme $Before
    $new = Read-Theme $After

    $report = [System.Collections.Generic.List[string]]::new()
    function Add([string]$Line = '') { $report.Add($Line) }

    if (-not $NoRender -and (Get-Command oh-my-posh -ErrorAction SilentlyContinue)) {
        Add '### Render'
        Add
        Add "**Before** (``$($old.Label)``)"
        Add '```text'
        Add (Get-Render $old.Path)
        Add '```'
        Add "**After** (``$($new.Label)``)"
        Add '```text'
        Add (Get-Render $new.Path)
        Add '```'
        Add
    }

    $oldSegments = Get-Segments $old.Data
    $newSegments = Get-Segments $new.Data
    $used = [System.Collections.Generic.HashSet[int]]::new()
    $rows = [System.Collections.Generic.List[string]]::new()
    $added = [System.Collections.Generic.List[string]]::new()
    $unchanged = 0

    foreach ($segment in $newSegments) {
        $index = -1
        for ($i = 0; $i -lt $oldSegments.Count; $i++) {
            if ($oldSegments[$i].Type -eq $segment.Type -and -not $used.Contains($i)) { $index = $i; break }
        }
        if ($index -lt 0) { $added.Add($segment.Type); continue }
        $null = $used.Add($index)

        $a = @{}; Get-Leaves $oldSegments[$index].Data '' $a
        $b = @{}; Get-Leaves $segment.Data '' $b
        $changes = 0
        foreach ($key in @($a.Keys) + @($b.Keys) | Select-Object -Unique | Sort-Object) {
            $x = $a[$key]; $y = $b[$key]
            if ((Get-Comparable $x) -cne (Get-Comparable $y)) {
                $rows.Add("| $($segment.Type) | ``$key`` | $(Format-Value $x) | $(Format-Value $y) |")
                $changes++
            }
        }
        if ($oldSegments[$index].Block -ne $segment.Block) {
            $rows.Add("| $($segment.Type) | *block* | $($oldSegments[$index].Block) | $($segment.Block) |")
            $changes++
        }
        if (-not $changes) { $unchanged++ }
    }
    $removed = @(for ($i = 0; $i -lt $oldSegments.Count; $i++) { if (-not $used.Contains($i)) { $oldSegments[$i].Type } })

    Add '### Segment changes'
    Add
    Add "$unchanged of $($newSegments.Count - $added.Count) matching segments unchanged."
    if ($added.Count) { Add "Added: $($added -join ', ')." }
    if ($removed) { Add "Removed: $($removed -join ', ')." }
    if ($old.Data.blocks.Count -ne $new.Data.blocks.Count) { Add "Blocks: $($old.Data.blocks.Count) → $($new.Data.blocks.Count)." }
    Add
    if ($rows.Count) {
        Add '| Segment | Field | Before | After |'
        Add '|---|---|---|---|'
        foreach ($row in $rows) { Add $row }
    }

    $report -join "`n"
}
catch {
    Write-Host "error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
finally {
    foreach ($file in $temporary) { Remove-Item -LiteralPath $file -ErrorAction SilentlyContinue }
}
