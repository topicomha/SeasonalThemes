# SeasonalThemes

## Goal

Theme the programs I use so they change with the month, built around each month's season and holidays (January = winter, February = Valentine's, March = St. Patrick's, October = Halloween...). A month should look **the same everywhere**: one palette, one set of icons and one feel, used in every program.

The core idea: **each month is defined by one detailed document. Refine the document, regenerate, and every program picks up the change.**

| Target | Status |
|---|---|
| Oh My Posh prompt | Done: all 12 months and New Year's Eve, in light and dark. |
| Month pages + images | Generated alongside each month: `README.md` (the summary GitHub shows when you open the folder), `theme-definition.md` (full detail), `palette.svg` and the VS Code previews. |
| VS Code colour theme | Done: one extension (`vscode/`) with 26 themes, following the month and the system's light/dark setting. It replaced the fall-only [Fall-VSCode-Theme](https://github.com/topicomha/Fall-VSCode-Theme), which is archived. |
| Terminal colours / other CLI tools | Possible later. The document already defines the 16 standard terminal colours and the syntax colours. |
| Wallpaper sync across OSes | An idea only. Out of scope for now. |

## How this project is developed

This project is developed with AI. Claude Code makes the changes, working from this file; David reviews and merges them. In practice:

- **Every change is a branch and a pull request.** `main` is protected, so there's no other way in. A PR description says what changed and why, shows before/after (previews, `tools/Compare-OmpTheme.ps1`), and lists the decisions that are David's to review.
- **Ask before deciding something that's David's call:**
  - a month's look (palette or icons)
  - replacing existing work
  - anything outward-facing, such as publishing or deleting.

  Look through all branches and tags for David's own existing work before designing something new. The original June and July were found on an unmerged branch only after new ones had been made.
- **Verify, don't assume.**
  - Run `pwsh ./Generate-Themes.ps1 -Check` on every commit.
  - Render the previews and look at them.
  - Report warnings and failures as they are.
- **Keep this file current.** When a convention, a target or the workflow changes, update CLAUDE.md in the same PR, so the next session starts from the truth.
- **Commits carry a `Co-Authored-By: Claude` trailer**, so the history shows which changes were AI-written.

## The month document: `<Month>/season.jsonc`

This is the **only file you edit** to change a month. It is JSONC (comments allowed) and follows `schema/season.schema.json`, so VS Code gives autocomplete, flags typos as you type and shows colour swatches. `October/season.jsonc` is the complete reference example.

Sections:

1. **Identity**: `month`, `name`, `tagline`, `description`, `mood`, `keywords`, `holidays`, `links`, `ideas`, `appearance` (dark or light).
2. **`palette`**: the month's named colours (`"pumpkin": { "hex": "#D35400", "name": "Pumpkin orange" }`). This is the only place hex codes should live.
3. **`colors`**: roles, each pointing at a palette name (or `{ "color": ..., "style": "italic" }`):
   - `brand`: signature colours: primary, secondary, accent, tertiary, accent_alt, highlight, deep, text_accent
   - `ui`: text_light and text_dark, background, foreground, surface, border, muted, selection, cursor...
   - `status`: error, success, warning, info
   - `syntax`: comment, keyword, string, number, function, type, variable...
   - `terminal`: the 16 standard terminal colours plus background, foreground, cursor and selection
4. **`icons`**: role icons (shell, path, git, exec_time, clock, status_ok...), `lang.<segment>`, `os.<linux|macos|windows>`, and `pool` (spare emoji).
5. **`variants`**: date ranges that override parts of the month (e.g. New Year's Eve in late December). Each variant gets its own generated files.
6. **`targets`**: per-program extras that don't fit a shared role (e.g. `"oh-my-posh": { "time_format": ... }`).
7. **`modes`**: the month in its other appearance, usually `modes.light` for a dark month (a variant can have its own `modes` too). It's laid over the month like a variant, but only for that mode. It keeps the brand colours and icons, so the prompt segments look the same, and re-colours what's drawn on the window background: `ui`, `syntax`, `terminal`, `status`, `brand.line`, and `ui.accent` for VS Code's accent. Every program that supports it gets a file per mode.

**Required vs optional:** in the schema, any colour or icon role with an `x-fallback` is optional and takes the named role's value when left out. Roles without one are required. So a new month can start with about 6 colours and 6 icons and fill in detail over time. The generated `theme-definition.md` marks every inherited role, which shows what hasn't been decided yet.

To add or change a role for **every** month, edit the schema. The generator reads its role list and fallbacks from there.

## Generating

```bash
pwsh ./Generate-Themes.ps1                  # every month that has a season.jsonc
pwsh ./Generate-Themes.ps1 -Month October
pwsh ./Generate-Themes.ps1 -Check           # exit 1 if any generated file is out of date
```

- Requires PowerShell 7.4+ (`pwsh`), on Windows or Linux. No other dependencies.
- The script checks the document against the schema, resolves palette names and fallbacks, then writes every target.
- It stops with a plain message on:
  - a schema violation (unknown field, bad hex code...)
  - a missing required role
  - a role pointing at a palette name that doesn't exist
  - an unknown `[[token]]`
  - output that isn't valid JSON.

  It warns when text contrast on a background is below 3:1.
- Generated files are committed, so the existing symlinks keep working. **Never hand-edit a generated file.** Run `-Check` before committing.

### Targets (`templates/`, listed in `$Targets` in `Generate-Themes.ps1`)

| Kind | File | How it works |
|---|---|---|
| Template | `oh-my-posh.omp.json`, `vscode-color-theme.json` | The target's file with `[[token]]` placeholders |
| Renderer | `month-readme.md.ps1`, `theme-definition.md.ps1`, `palette.svg.ps1`, `vscode-preview.svg.ps1` | A script that receives the resolved season and returns the file's text. Use one when the output needs loops. |
| All-months renderer | `vscode-package.json.ps1` | `Scope = 'all'`: rendered once with every month's seasons (e.g. the extension manifest listing all themes) |

Template tokens:
- `[[color.<group>.<role>]]`
- `[[on.<group>.<role>]]`: text_light or text_dark, whichever reads better on that colour
- `[[style.<group>.<role>]]`
- `[[palette.<name>]]`
- `[[icon.<role>]]`, `[[icon.lang.<x>]]`, `[[icon.os.<x>]]`
- `[[meta.month|name|tagline|appearance|variant|title]]` (`title` is e.g. "Seasonal 10 · October — Halloween")
- `[[target.<key>|default]]`: a per-program extra from `targets.<program>`
- `[[choice.<key>|<role>]]` / `[[on-choice.<key>|<role>]]`: a colour role the month picks in `targets.<program>.<key>` (default `<role>`), and the best text on it

To add a program, add a template or renderer and a row in `$Targets`. Use `PerVariant = $true` if each variant needs its own file, and `Program = '<name>'` for the key it reads under `targets` in `season.jsonc`. An unknown program name under `targets` is an error. Run with `-Verbose` to see where a template or renderer failed.

## Repository layout

```
<Month>/
  season.jsonc                    THE month document (edit this)
  davids-<Month>.omp.json         generated Oh My Posh theme (+ -<variant>, and -light for light terminals)
  README.md                       generated summary: previews, signature colours, icons, how to use (GitHub shows it in the folder)
  theme-definition.md             generated full detail: every colour role, the light-mode changes, all files
  palette.svg                     generated palette swatch sheet (+ palette-light.svg)
  vscode-preview-dark.svg         generated mock VS Code windows in the month's themes (+ -light.svg)
vscode/                           the VS Code extension (Seasonal Themes)
  themes/<month>-<mode>.json      generated colour themes (+ <month>-<variant>-<mode>.json)
  package.json                    generated manifest (themes + the date/mode schedule extension.js reads)
  LICENSE                         generated copy of the repo's LICENSE (the packager wants one here)
  extension.js                    keeps VS Code on this month's theme, light or dark per seasonalThemes.mode
  README.md, CHANGELOG.md, icon.png, .vscodeignore
schema/season.schema.json         the format of season.jsonc: roles, fallbacks, descriptions
templates/                        one template or renderer per target
Generate-Themes.ps1               season.jsonc + templates -> every generated file
Get-SeasonalTheme.ps1             prints today's Oh My Posh theme path (month, variant, light/dark), for shell profiles
tools/New-LightMode.ps1           drafts a month's modes.light from its dark colours
tools/Compare-OmpTheme.ps1        before/after render + field diff of two themes, as Markdown for a PR
.github/                          CI, the release workflow, Dependabot and the PR template
README.md, LICENSE                for people using the themes (MIT)
```

## VS Code theme standard

Every month's theme comes from one template, `templates/vscode-color-theme.json`, so all months behave the same. Only their colours differ:

| Part of the window | Role |
|---|---|
| Editor, gutter, tabs (active), panels | `ui.background`, `ui.foreground`, `ui.line_highlight`, `ui.selection`, `ui.cursor` |
| Title bar, activity bar, sidebar, inactive tabs, widgets, inputs | `ui.surface`, `ui.border`, `ui.muted` |
| Status bar, buttons | **choice** `status_bar` (default `brand.primary`) |
| Badges, focus rings, active tab / panel borders, find matches, list highlights | **choice** `accent` (default `brand.accent`) |
| Debugging / no-folder status bar | `brand.highlight` / `brand.secondary` |
| Code | `syntax.*`, for both TextMate scopes and semantic tokens |
| Bracket pairs (1–6) | `syntax.number`, `type`, `function`, `keyword`, `string`, `terminal.cyan` |
| Terminal, git decorations, diff, errors / warnings | `terminal.*`, `syntax.invalid` |

**What makes a month unique:** its palette and roles, plus two choices in `season.jsonc`:

```jsonc
"targets": { "vscode": { "status_bar": "brand.secondary", "accent": "brand.line" } }
```

Pick the colours that say the month most clearly (e.g. September's apple-red status bar, July's Old Glory red). Variants can make their own choices (New Year's Eve uses champagne gold). Check every month's `vscode-preview.svg` side by side after a change. The generator checks 31 text/background pairs in each theme (status bar, tabs, badges, buttons, selections, widgets, terminal) and warns below 3:1.

**Light and dark:** every month has both, from `modes.light`. The extension's `seasonalThemes.mode` picks between them: `system` (default) follows the OS through VS Code's `window.autoDetectColorScheme` and preferred light/dark themes, `time` switches at `lightFrom` / `darkFrom`, and `light` / `dark` fix it. Light mode usually sets `targets.vscode.accent` to `ui.accent`, a darker shade of the month's accent that reads on light panels.

**Building:** `cd vscode && npx @vscode/vsce package` makes `seasonal-themes-<version>.vsix` (ignored by git). CI builds it on every PR and attaches it to the run. Bump `version` in `templates/vscode-package.json` and add a `vscode/CHANGELOG.md` entry for a release.

## Oh My Posh notes

- The layout (`templates/oh-my-posh.omp.json`) is the v3 three-block layout:
  - left: shell, root, path, git, execution time
  - right: languages, cloud, os, battery, time
  - a new line with the `⌂──` connector and a status emoji.
- Oh My Posh accepts JSONC (`//` comments), so strict JSON tools may reject hand-written themes; generated files are plain JSON.
- In the status segment, use `.Code`/`.Error`. There is no `.Status`, and using it shows "unable to create text based on template".
- Test what a theme looks like:
  - `oh-my-posh print primary --config <file> --shell pwsh` (and `print right`)
  - `oh-my-posh debug --config <file>` for template errors
- Install by symlinking a generated file into the Oh My Posh themes folder (`~/.oh-my-posh-themes/` on Linux, `%LOCALAPPDATA%\Programs\oh-my-posh\themes\` on Windows):
  - Linux: `ln -s <repo>/<Month>/davids-<Month>.omp.json ~/.oh-my-posh-themes/`
  - Windows: `New-Item -ItemType SymbolicLink -Path <themes>\davids-<Month>.omp.json -Target <repo>\<Month>\davids-<Month>.omp.json`
- Or let the profile pick today's theme, including the variant and light/dark:
  - PowerShell: `oh-my-posh init pwsh --config (& <repo>/Get-SeasonalTheme.ps1) | Invoke-Expression`
  - zsh / bash: `eval "$(oh-my-posh init zsh --config "$(pwsh -NoProfile -File <repo>/Get-SeasonalTheme.ps1)")"`

  `-Mode system` (the default) reads Windows' "apps use light theme", macOS dark mode or GNOME's colour scheme, and falls back to `-LightFrom` / `-DarkFrom` (07:00 / 19:00). The choice is made when the shell starts.
- Light-mode prompts (`davids-<Month>-light.omp.json`) keep every segment's colours and change only what's drawn on the terminal background: the `⌂──` connector and the status icon.

## Adding a light mode to a month

1. Run `pwsh ./tools/New-LightMode.ps1 -Month <Month>` (add `-Variant <id>` for a variant). It writes a `modes.light` block into the month's `season.jsonc`:
   - page, panels and borders are tints of the month's primary colour
   - text is the month's dark text colour
   - code, terminal and status colours keep their dark-mode hues, darkened until they read on the light page.

   If the primary gives the wrong feel, tint from another role with `-Tint <role>`. December uses `brand.secondary` (evergreen, not the pink a red tint gives), November uses its roast brown so it doesn't match October, and New Year's Eve uses `brand.accent` (champagne gold).
2. Run `pwsh ./Generate-Themes.ps1 -Month <Month>`, fix any warnings, and review `<Month>/vscode-preview-light.svg` next to the dark one.
3. Tune by hand. The drafted palette entries are marked "Proposed: light mode".

## Archive

Files that are no longer used are removed from `main`, but kept under `archive/*` tags so nothing is lost. Restore one with `git checkout <tag> -- <path>`.

| Tag | Holds |
|---|---|
| `archive/retired-tools-and-docs` | the original 2048 px `icon.png` (the extension uses a 256 px copy in `vscode/`), `docs/icons.md` (emoji collections per month and holiday), `docs/oh-my-posh-segments.md`, and `tools/Import-OmpTheme.ps1` (converted the hand-made themes to `season.jsonc`) |
| `archive/adding-better-documentation` | the original hand-made June and July (now converted in `main`), the old `*-Theme-Info.md` docs, and "clean" March/April themes |
| `archive/first-june-july-designs` | the first June and July designs, made from the old drafts before the originals were found |

The files replaced during the move to `season.jsonc` (`ThemesDocumentation.md`, `ThemeGenerator.md`, `scripts.ipynb`, the old hand-written themes) are in the history before `v0.2.0`.

## Git workflow

Hosted on **GitHub** (`topicomha/SeasonalThemes`). Use `gh` for PRs.

- **`main`** is the only long-lived branch, and it's protected:
  - changes go in only through a PR, and the `check` CI job must pass
  - no force-pushes and no deleting it.

  PRs are merged with a merge commit (squash and rebase merges are turned off), so each PR's commits survive. Merged branches are deleted automatically.
- **One branch and PR per unit of work:**
  - `updating-<month>` to change a month
  - `adding-<thing>` / `updating-<thing>` for new programs, and for generator, schema or template work.
- **Small, logical commits:**
  - Every commit leaves `pwsh ./Generate-Themes.ps1 -Check` passing, so the source and its generated files are always committed together.
  - Keep fixes separate from design changes, e.g. a readability fix in one commit and a new palette in another, so each can be reviewed on its own.
  - Schema or template changes that affect every month go in their own PR, with all months regenerated in the same commit.
- **Commit messages:** `<Area>: <imperative summary>`, e.g. `August: convert to season.jsonc`, `Generator: add palette renderer`, `Schema: add ui.link role`.
- **CI:** `.github/workflows/check-themes.yml` runs `-Check` and builds the `.vsix` on every PR and on every push to `main`. Dependabot keeps the Actions versions current.
- **PR description:** what changed, and for a month the before/after `oh-my-posh print primary` output plus anything deliberately changed.

## Releases

Releases are version tags on `main`, published by `.github/workflows/release.yml`:

1. In a PR, bump `version` in `templates/vscode-package.json` and regenerate. Add a `vscode/CHANGELOG.md` entry, then merge.
2. Tag the merge commit and push the tag: `git tag -a v0.3.0 -m "Seasonal Themes v0.3.0" && git push origin v0.3.0`.
3. The workflow checks that the tag matches the extension's version, builds `seasonal-themes-<tag>.vsix` and `oh-my-posh-themes-<tag>.zip`, and publishes them as a GitHub Release with generated notes. Edit the notes afterwards to summarise the release.

Versions follow semver: a new month, target or mode is a minor bump, and colour or icon fixes are a patch.

## Backlog

1. **More targets from the same documents:** terminal emulators (Windows Terminal, GNOME Terminal, iTerm2) straight from the `terminal` roles; `bat` / `delta` from `syntax`.
2. **Shared-layout ideas the conversions surfaced:**
   - execution-time thresholds (the old August and September themes)
   - path depth and branch-name length limits (old March)
   - per-role text colours (old April).
3. **Publish to the VS Code Marketplace** (needs a `topicomha` publisher account), or keep installing the `.vsix` from releases.
4. **Wallpaper sync across OSes** (an idea only).
