# Renders a mock VS Code window (title bar, activity bar, sidebar, tabs, code, terminal, status bar)
# in a month's VS Code theme, for reviewing themes without installing them. Called by Generate-Themes.ps1.
param($Season, [hashtable]$Files)

Set-StrictMode -Version Latest

# Build the real theme first so the preview always shows exactly what the extension ships.
# (Invoke-Template and $Targets come from Generate-Themes.ps1, which runs this renderer.)
$vscodeTarget = $Targets | Where-Object { $_.Name -eq 'vscode-theme' }
# Warnings are silenced here; the vscode-theme target has already reported them.
$theme = Invoke-Template $Season $vscodeTarget 3>$null | ConvertFrom-Json -AsHashtable
$c = $theme.colors

function X([string]$Text) { [System.Security.SecurityElement]::Escape($Text) }

# Syntax colour and font style per role, from the theme's own tokenColors.
$token = @{}
foreach ($rule in $theme.tokenColors) { $token[$rule.name] = $rule.settings }
function Span([string]$Text, [string]$Rule) {
    $s = $token[$Rule]
    $style = ''
    if ($s['fontStyle'] -match 'italic') { $style += ' font-style="italic"' }
    if ($s['fontStyle'] -match 'bold') { $style += ' font-weight="bold"' }
    "<tspan fill=`"$($s['foreground'] ?? $c['editor.foreground'])`"$style>$(X $Text)</tspan>"
}
function Plain([string]$Text) { "<tspan fill=`"$($c['editor.foreground'])`">$(X $Text)</tspan>" }
# Bracket-pair colours by nesting depth.
function Br([string]$Text, [int]$Depth) { "<tspan fill=`"$($c["editorBracketHighlight.foreground$((($Depth - 1) % 6) + 1)"])`">$(X $Text)</tspan>" }

$month = $Season.Month
$code = @(
    ,@((Span "// Seasonal greetings for $month" 'Comments'))
    ,@((Span 'import' 'Keywords'), (Plain ' '), (Br '{' 1), (Plain ' '), (Span 'Season' 'Types'), (Plain ' '), (Br '}' 1), (Plain ' '), (Span 'from' 'Keywords'), (Plain ' '), (Span '"./calendar"' 'Strings'), (Span ';' 'Punctuation'))
    ,@()
    ,@((Span 'interface' 'Keywords'), (Plain ' '), (Span 'Palette' 'Types'), (Plain ' '), (Br '{' 1), (Plain ' '), (Span 'primary' 'Properties'), (Span ':' 'Punctuation'), (Plain ' '), (Span 'string' 'Types'), (Span ';' 'Punctuation'), (Plain ' '), (Br '}' 1))
    ,@()
    ,@((Span 'export' 'Keywords'), (Plain ' '), (Span 'function' 'Keywords'), (Plain ' '), (Span 'greet' 'Functions'), (Br '(' 1), (Span 'month' 'Parameters'), (Span ':' 'Punctuation'), (Plain ' '), (Span 'Season' 'Types'), (Span ',' 'Punctuation'), (Plain ' '), (Span 'count' 'Parameters'), (Plain ' '), (Span '=' 'Operators'), (Plain ' '), (Span '3' 'Numbers'), (Br ')' 1), (Span ':' 'Punctuation'), (Plain ' '), (Span 'string' 'Types'), (Plain ' '), (Br '{' 1))
    ,@((Plain '  '), (Span 'const' 'Keywords'), (Plain ' '), (Span 'colors' 'Variables'), (Plain ' '), (Span '=' 'Operators'), (Plain ' '), (Br '{' 2), (Plain ' '), (Span 'primary' 'Properties'), (Span ':' 'Punctuation'), (Plain ' '), (Span "`"$($Season.Colors['brand.primary'].Hex.ToUpper())`"" 'Strings'), (Plain ' '), (Br '}' 2), (Span ';' 'Punctuation'))
    ,@((Plain '  '), (Span 'if' 'Keywords'), (Plain ' '), (Br '(' 2), (Span 'count' 'Variables'), (Plain ' '), (Span '>' 'Operators'), (Plain ' '), (Span '0' 'Numbers'), (Plain ' '), (Span '&&' 'Operators'), (Plain ' '), (Span 'month' 'Variables'), (Span '.' 'Punctuation'), (Span 'name' 'Properties'), (Br ')' 2), (Plain ' '), (Br '{' 2))
    ,@((Plain '    '), (Span 'return' 'Keywords'), (Plain ' '), (Span '`Happy ${' 'Strings'), (Span 'month' 'Variables'), (Span '.' 'Punctuation'), (Span 'name' 'Properties'), (Span '}!`' 'Strings'), (Span '.' 'Punctuation'), (Span 'repeat' 'Functions'), (Br '(' 3), (Span 'count' 'Variables'), (Br ')' 3), (Span ';' 'Punctuation'))
    ,@((Plain '  '), (Br '}' 2))
    ,@((Plain '  '), (Span 'return' 'Keywords'), (Plain ' '), (Span '/^[a-z]+$/' 'Regular expressions'), (Span '.' 'Punctuation'), (Span 'test' 'Functions'), (Br '(' 2), (Span 'month' 'Variables'), (Span '.' 'Punctuation'), (Span 'name' 'Properties'), (Br ')' 2), (Plain ' '), (Span '?' 'Operators'), (Plain ' '), (Span 'true' 'Constants'), (Plain ' '), (Span ':' 'Operators'), (Plain ' '), (Span 'null' 'Constants'), (Span ';' 'Punctuation'))
    ,@((Br '}' 1))
)
$activeLine = 7

$width = 960; $height = 600
$titleH = 30; $statusH = 24; $activityW = 48; $sideW = 210; $tabsH = 34; $panelH = 170
$bodyTop = $titleH; $bodyBottom = $height - $statusH
$editorLeft = $activityW + $sideW
$panelTop = $bodyBottom - $panelH
$lineH = 20
$mono = "ui-monospace, 'Cascadia Code', Consolas, 'DejaVu Sans Mono', monospace"
$sans = "system-ui, -apple-system, 'Segoe UI', sans-serif"

$svg = [System.Text.StringBuilder]::new()
function Out([string]$Line) { $null = $svg.AppendLine($Line) }

Out "<svg xmlns=`"http://www.w3.org/2000/svg`" width=`"$width`" height=`"$height`" viewBox=`"0 0 $width $height`" font-family=`"$sans`" font-size=`"12`">"
Out "  <rect width=`"$width`" height=`"$height`" fill=`"$($c['editor.background'])`"/>"

# Title bar, as VS Code draws it on Windows and Linux: menu on the left, the window title in the
# command-centre box, and minimise / maximise / close on the right.
$titleFg = $c['titleBar.activeForeground']
Out "  <rect width=`"$width`" height=`"$titleH`" fill=`"$($c['titleBar.activeBackground'])`"/>"
Out "  <text x=`"14`" y=`"19`" fill=`"$titleFg`" xml:space=`"preserve`">File    Edit    Selection    View    …</text>"
$boxW = 330
$boxX = ($width - $boxW) / 2
Out "  <rect x=`"$boxX`" y=`"5`" width=`"$boxW`" height=`"20`" rx=`"4`" fill=`"$($c['input.background'])`" stroke=`"$($c['titleBar.border'])`"/>"
Out "  <text x=`"$($width / 2)`" y=`"19`" text-anchor=`"middle`" font-size=`"11`" fill=`"$titleFg`">$(X "SeasonalThemes — $($Season.Title)")</text>"
$controlsX = $width - 3 * 46
Out "  <line x1=`"$($controlsX + 18)`" y1=`"15.5`" x2=`"$($controlsX + 28)`" y2=`"15.5`" stroke=`"$titleFg`"/>"
Out "  <rect x=`"$($controlsX + 46 + 18.5)`" y=`"10.5`" width=`"9`" height=`"9`" fill=`"none`" stroke=`"$titleFg`"/>"
Out "  <line x1=`"$($controlsX + 92 + 18)`" y1=`"10`" x2=`"$($controlsX + 92 + 28)`" y2=`"20`" stroke=`"$titleFg`"/>"
Out "  <line x1=`"$($controlsX + 92 + 28)`" y1=`"10`" x2=`"$($controlsX + 92 + 18)`" y2=`"20`" stroke=`"$titleFg`"/>"
Out "  <line x1=`"0`" y1=`"$titleH`" x2=`"$width`" y2=`"$titleH`" stroke=`"$($c['titleBar.border'])`"/>"

# Activity bar
Out "  <rect x=`"0`" y=`"$bodyTop`" width=`"$activityW`" height=`"$($bodyBottom - $bodyTop)`" fill=`"$($c['activityBar.background'])`"/>"
Out "  <rect x=`"0`" y=`"$($bodyTop + 10)`" width=`"2`" height=`"28`" fill=`"$($c['activityBar.activeBorder'])`"/>"
foreach ($i in 0..3) {
    $fill = $i -eq 0 ? $c['activityBar.foreground'] : $c['activityBar.inactiveForeground']
    Out "  <rect x=`"14`" y=`"$($bodyTop + 14 + $i * 44)`" width=`"20`" height=`"20`" rx=`"4`" fill=`"none`" stroke=`"$fill`" stroke-width=`"2`"/>"
}
Out "  <circle cx=`"34`" cy=`"$($bodyTop + 14 + 44 + 18)`" r=`"7`" fill=`"$($c['activityBarBadge.background'])`"/>"
Out "  <text x=`"34`" y=`"$($bodyTop + 14 + 44 + 22)`" text-anchor=`"middle`" font-size=`"9`" font-weight=`"bold`" fill=`"$($c['activityBarBadge.foreground'])`">3</text>"

# Sidebar
Out "  <rect x=`"$activityW`" y=`"$bodyTop`" width=`"$sideW`" height=`"$($bodyBottom - $bodyTop)`" fill=`"$($c['sideBar.background'])`"/>"
Out "  <line x1=`"$editorLeft`" y1=`"$bodyTop`" x2=`"$editorLeft`" y2=`"$bodyBottom`" stroke=`"$($c['sideBar.border'])`"/>"
Out "  <text x=`"$($activityW + 14)`" y=`"$($bodyTop + 22)`" font-size=`"11`" fill=`"$($c['sideBarTitle.foreground'])`">EXPLORER</text>"
Out "  <rect x=`"$activityW`" y=`"$($bodyTop + 32)`" width=`"$sideW`" height=`"22`" fill=`"$($c['sideBarSectionHeader.background'])`"/>"
Out "  <text x=`"$($activityW + 14)`" y=`"$($bodyTop + 47)`" font-size=`"11`" font-weight=`"bold`" fill=`"$($c['sideBarSectionHeader.foreground'])`">SEASONALTHEMES</text>"
$fileRows = @(
    @(('▾ ' + $month), $c['sideBar.foreground'], 0),
    @('greeting.ts', $c['list.activeSelectionForeground'], 1),
    @('season.jsonc', $c['gitDecoration.modifiedResourceForeground'], 1),
    @('palette.svg', $c['gitDecoration.untrackedResourceForeground'], 1),
    @('old-theme.json', $c['gitDecoration.deletedResourceForeground'], 1),
    @('theme-definition.md', $c['sideBar.foreground'], 1),
    @('.cache', $c['gitDecoration.ignoredResourceForeground'], 0)
)
for ($i = 0; $i -lt $fileRows.Count; $i++) {
    $y = $bodyTop + 60 + $i * 22
    if ($i -eq 1) { Out "  <rect x=`"$activityW`" y=`"$y`" width=`"$sideW`" height=`"22`" fill=`"$($c['list.activeSelectionBackground'])`"/>" }
    if ($i -eq 3) { Out "  <rect x=`"$activityW`" y=`"$y`" width=`"$sideW`" height=`"22`" fill=`"$($c['list.hoverBackground'])`"/>" }
    Out "  <text x=`"$($activityW + 16 + $fileRows[$i][2] * 14)`" y=`"$($y + 15)`" fill=`"$($fileRows[$i][1])`">$(X $fileRows[$i][0])</text>"
}
# Search box with placeholder, and a button
$searchY = $bodyTop + 60 + $fileRows.Count * 22 + 16
Out "  <rect x=`"$($activityW + 12)`" y=`"$searchY`" width=`"$($sideW - 24)`" height=`"24`" rx=`"3`" fill=`"$($c['input.background'])`" stroke=`"$($c['input.border'])`"/>"
Out "  <text x=`"$($activityW + 20)`" y=`"$($searchY + 16)`" fill=`"$($c['input.placeholderForeground'])`">Search files</text>"
Out "  <rect x=`"$($activityW + 12)`" y=`"$($searchY + 34)`" width=`"$($sideW - 24)`" height=`"26`" rx=`"3`" fill=`"$($c['button.background'])`"/>"
Out "  <text x=`"$($activityW + $sideW / 2)`" y=`"$($searchY + 51)`" text-anchor=`"middle`" fill=`"$($c['button.foreground'])`">Commit</text>"

# Tabs
Out "  <rect x=`"$editorLeft`" y=`"$bodyTop`" width=`"$($width - $editorLeft)`" height=`"$tabsH`" fill=`"$($c['editorGroupHeader.tabsBackground'])`"/>"
Out "  <rect x=`"$editorLeft`" y=`"$bodyTop`" width=`"140`" height=`"$tabsH`" fill=`"$($c['tab.activeBackground'])`"/>"
Out "  <rect x=`"$editorLeft`" y=`"$bodyTop`" width=`"140`" height=`"2`" fill=`"$($c['tab.activeBorderTop'])`"/>"
Out "  <text x=`"$($editorLeft + 16)`" y=`"$($bodyTop + 22)`" fill=`"$($c['tab.activeForeground'])`">greeting.ts</text>"
Out "  <rect x=`"$($editorLeft + 140)`" y=`"$bodyTop`" width=`"140`" height=`"$tabsH`" fill=`"$($c['tab.inactiveBackground'])`"/>"
Out "  <text x=`"$($editorLeft + 156)`" y=`"$($bodyTop + 22)`" fill=`"$($c['tab.inactiveForeground'])`">season.jsonc</text>"

# Editor
$codeTop = $bodyTop + $tabsH + 10
$gutterW = 44
Out "  <rect x=`"$editorLeft`" y=`"$($codeTop + ($activeLine - 1) * $lineH - 2)`" width=`"$($width - $editorLeft)`" height=`"$lineH`" fill=`"$($c['editor.lineHighlightBackground'])`"/>"
for ($i = 0; $i -lt $code.Count; $i++) {
    $y = $codeTop + $i * $lineH + 12
    $numberFill = ($i + 1) -eq $activeLine ? $c['editorLineNumber.activeForeground'] : $c['editorLineNumber.foreground']
    Out "  <text x=`"$($editorLeft + $gutterW - 10)`" y=`"$y`" text-anchor=`"end`" font-family=`"$mono`" fill=`"$numberFill`">$($i + 1)</text>"
    if ($code[$i].Count) {
        Out "  <text x=`"$($editorLeft + $gutterW + 6)`" y=`"$y`" font-family=`"$mono`" xml:space=`"preserve`">$($code[$i] -join '')</text>"
    }
}
# Cursor and a selection on the active line
$charW = 7.22
$selX = $editorLeft + $gutterW + 6 + 8 * $charW
Out "  <rect x=`"$selX`" y=`"$($codeTop + ($activeLine - 1) * $lineH - 1)`" width=`"$([math]::Round(6 * $charW, 1))`" height=`"$($lineH - 2)`" fill=`"$($c['editor.selectionBackground'])`"/>"
Out "  <rect x=`"$($selX + 6 * $charW)`" y=`"$($codeTop + ($activeLine - 1) * $lineH - 1)`" width=`"2`" height=`"$($lineH - 2)`" fill=`"$($c['editorCursor.foreground'])`"/>"

# Terminal panel
Out "  <rect x=`"$editorLeft`" y=`"$panelTop`" width=`"$($width - $editorLeft)`" height=`"$panelH`" fill=`"$($c['terminal.background'])`"/>"
Out "  <line x1=`"$editorLeft`" y1=`"$panelTop`" x2=`"$width`" y2=`"$panelTop`" stroke=`"$($c['panel.border'])`"/>"
Out "  <text x=`"$($editorLeft + 16)`" y=`"$($panelTop + 20)`" font-size=`"11`" fill=`"$($c['panelTitle.activeForeground'])`">TERMINAL</text>"
Out "  <rect x=`"$($editorLeft + 14)`" y=`"$($panelTop + 26)`" width=`"60`" height=`"1.5`" fill=`"$($c['panelTitle.activeBorder'])`"/>"
Out "  <text x=`"$($editorLeft + 96)`" y=`"$($panelTop + 20)`" font-size=`"11`" fill=`"$($c['panelTitle.inactiveForeground'])`">PROBLEMS</text>"
function Ansi([string]$Text, [string]$Key) { "<tspan fill=`"$($c["terminal.$Key"])`">$(X $Text)</tspan>" }
$termLines = @(
    ((Ansi '$ ' 'ansiGreen') + (Ansi 'npm test' 'foreground')),
    ((Ansi '  PASS ' 'ansiGreen') + (Ansi 'greeting.test.ts ' 'foreground') + (Ansi '(12 ms)' 'ansiBrightBlack')),
    ((Ansi '  FAIL ' 'ansiRed') + (Ansi 'calendar.test.ts' 'foreground')),
    ((Ansi '  warn ' 'ansiYellow') + (Ansi 'deprecated ' 'foreground') + (Ansi 'month.days' 'ansiCyan') + (Ansi ' → ' 'ansiBrightBlack') + (Ansi 'season.length' 'ansiMagenta')),
    ((Ansi '  info ' 'ansiBlue') + (Ansi "Tests: 1 failed, 11 passed" 'foreground'))
)
for ($i = 0; $i -lt $termLines.Count; $i++) {
    Out "  <text x=`"$($editorLeft + 16)`" y=`"$($panelTop + 48 + $i * 18)`" font-family=`"$mono`" xml:space=`"preserve`">$($termLines[$i])</text>"
}
# The 16 ANSI colours
$ansi = 'Black', 'Red', 'Green', 'Yellow', 'Blue', 'Magenta', 'Cyan', 'White'
for ($i = 0; $i -lt 16; $i++) {
    $key = ($i -lt 8 ? 'ansi' : 'ansiBright') + $ansi[$i % 8]
    Out "  <rect x=`"$($editorLeft + 16 + $i * 26)`" y=`"$($panelTop + $panelH - 26)`" width=`"22`" height=`"16`" rx=`"3`" fill=`"$($c["terminal.$key"])`"/>"
}

# Status bar
Out "  <rect x=`"0`" y=`"$bodyBottom`" width=`"$width`" height=`"$statusH`" fill=`"$($c['statusBar.background'])`"/>"
Out "  <rect x=`"0`" y=`"$bodyBottom`" width=`"70`" height=`"$statusH`" fill=`"$($c['statusBarItem.remoteBackground'])`"/>"
Out "  <text x=`"35`" y=`"$($bodyBottom + 16)`" text-anchor=`"middle`" fill=`"$($c['statusBarItem.remoteForeground'])`">&gt;&lt; WSL</text>"
Out "  <text x=`"84`" y=`"$($bodyBottom + 16)`" fill=`"$($c['statusBar.foreground'])`">main*   0 errors   1 warning</text>"
Out "  <text x=`"$($width - 12)`" y=`"$($bodyBottom + 16)`" text-anchor=`"end`" fill=`"$($c['statusBar.foreground'])`">Ln $activeLine, Col 15   UTF-8   TypeScript</text>"

Out '</svg>'
$svg.ToString()
