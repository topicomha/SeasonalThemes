<#
.SYNOPSIS
    Prints the path of today's Oh My Posh theme: the current month, its date variant if one covers
    today (e.g. New Year's Eve), in light or dark to match the system (or the time of day).

.DESCRIPTION
    Use it in a shell profile so the prompt follows the calendar and the system's appearance:

        # PowerShell ($PROFILE)
        oh-my-posh init pwsh --config (& ~/code/SeasonalThemes/Get-SeasonalTheme.ps1) | Invoke-Expression

        # zsh / bash (~/.zshrc, ~/.bashrc)
        eval "$(oh-my-posh init zsh --config "$(pwsh -NoProfile -File ~/code/SeasonalThemes/Get-SeasonalTheme.ps1)")"

    The theme is picked when the shell starts; open a new shell to pick up a change.

    -Mode system reads the OS setting: Windows' "apps use light theme", macOS dark mode, or GNOME's
    colour scheme. Anywhere it can't tell, it falls back to the time of day (-LightFrom / -DarkFrom).

.EXAMPLE
    ./Get-SeasonalTheme.ps1                       # today, following the system
    ./Get-SeasonalTheme.ps1 -Mode time -DarkFrom 18:30
    ./Get-SeasonalTheme.ps1 -Date 2027-12-31 -Mode light
#>
#Requires -Version 7.4
[CmdletBinding()]
param(
    [ValidateSet('system', 'time', 'light', 'dark')]
    [string]$Mode = 'system',

    [ValidatePattern('^([01][0-9]|2[0-3]):[0-5][0-9]$')]
    [string]$LightFrom = '07:00',

    [ValidatePattern('^([01][0-9]|2[0-3]):[0-5][0-9]$')]
    [string]$DarkFrom = '19:00',

    [datetime]$Date = (Get-Date)
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function Get-TimeMode {
    $now = $Date.ToString('HH:mm')
    $isLight = if ($LightFrom -le $DarkFrom) { $LightFrom -le $now -and $now -lt $DarkFrom }
               else { $now -ge $LightFrom -or $now -lt $DarkFrom }
    $isLight ? 'light' : 'dark'
}

# 'light', 'dark', or $null when the OS setting can't be read.
function Get-SystemMode {
    try {
        if ($IsWindows) {
            $value = Get-ItemPropertyValue 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' 'AppsUseLightTheme'
            return $value -eq 0 ? 'dark' : 'light'
        }
        if ($IsMacOS) {
            $style = & defaults read -g AppleInterfaceStyle 2>$null
            return $style -eq 'Dark' ? 'dark' : 'light'
        }
        if (Get-Command gsettings -ErrorAction SilentlyContinue) {
            $scheme = & gsettings get org.gnome.desktop.interface color-scheme 2>$null
            if ($scheme -match 'dark') { return 'dark' }
            if ($scheme -match 'light|default') { return 'light' }
        }
    }
    catch { }
    $null
}

$monthName = $Date.ToString('MMMM', [cultureinfo]::InvariantCulture)
$seasonPath = Join-Path $PSScriptRoot $monthName 'season.jsonc'
if (-not (Test-Path $seasonPath)) { throw "No theme for $monthName yet ($seasonPath)." }
$season = Get-Content -Raw $seasonPath | ConvertFrom-Json -AsHashtable

$monthDay = $Date.ToString('MM-dd')
$variant = @($season['variants'] ?? @()) | Where-Object { $_.from -le $monthDay -and $monthDay -le $_.to } | Select-Object -First 1

$wanted = switch ($Mode) {
    'system' { (Get-SystemMode) ?? (Get-TimeMode) }
    'time' { Get-TimeMode }
    default { $Mode }
}

# Use the wanted mode only if this month (or its variant) defines it.
$modes = @($season.appearance) + @(($season['modes'] ?? @{}).Keys) + @(($variant ? ($variant['modes'] ?? @{}) : @{}).Keys)
$mode = $wanted -in $modes ? $wanted : $season.appearance

# Must match the oh-my-posh target's output name in Generate-Themes.ps1: the base mode has no suffix.
$name = "davids-$monthName" + ($variant ? "-$($variant.id)" : '') + ($mode -eq $season.appearance ? '' : "-$mode") + '.omp.json'
Join-Path $PSScriptRoot $monthName $name
