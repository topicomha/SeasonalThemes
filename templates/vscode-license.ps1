# Copies the repository's LICENSE into vscode/, where the extension packager looks for it.
# Called once by Generate-Themes.ps1 (Scope 'all'), so the two copies can't drift apart.
param([object[]]$Seasons, [string]$Root)

Set-StrictMode -Version Latest

[IO.File]::ReadAllText((Join-Path $Root 'LICENSE'))
