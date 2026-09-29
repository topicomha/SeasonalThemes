# SeasonalThemes

## Goal

Theme the programs I use so they change with the month, built around each month's season and holidays (January = winter, February = Valentine's, March = St. Patrick's, October = Halloween...). A month should look **the same everywhere**: one palette, one set of icons and one feel, used in every program.

The core idea: **each month is defined by one detailed document. Refine the document, regenerate, and every program picks up the change.**

| Target | Status |
|---|---|
| Oh My Posh prompt | Active. The current focus is finishing all 12 months consistently. |
| Theme page + palette image | Generated alongside each month (`theme-definition.md`, `palette.svg`). |
| VS Code colour theme | Planned. A fall-only version exists in [topicomha/Fall-VSCode-Theme](https://github.com/topicomha/Fall-VSCode-Theme). The plan is **one extension with 12 colour themes**, switched each month through `workbench.colorTheme`. |
| Terminal colours / other CLI tools | Possible later. The document already defines the 16 standard terminal colours and the syntax colours. |
| Wallpaper sync across OSes | An idea only. Out of scope for now. |

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
| Template | `oh-my-posh.omp.json` | The target's file with `[[token]]` placeholders |
| Renderer | `theme-definition.md.ps1`, `palette.svg.ps1` | A script that receives the resolved season and returns the file's text. Use one when the output needs loops. |

Template tokens:
- `[[color.<group>.<role>]]`
- `[[on.<group>.<role>]]`: text_light or text_dark, whichever reads better on that colour
- `[[style.<group>.<role>]]`
- `[[palette.<name>]]`
- `[[icon.<role>]]`, `[[icon.lang.<x>]]`, `[[icon.os.<x>]]`
- `[[meta.month|name|tagline|appearance|variant]]`
- `[[target.<key>|default]]`

To add a program, add a template or renderer and a row in `$Targets`. Use `PerVariant = $true` if each variant needs its own file.

## Repository layout

```
<Month>/
  season.jsonc               THE month document (edit this)
  davids-<Month>.omp.json    generated Oh My Posh theme (+ davids-<Month>-<variant>.omp.json)
  theme-definition.md        generated readable page
  palette.svg                generated palette swatch sheet
schema/season.schema.json    the format of season.jsonc: roles, fallbacks, descriptions
templates/                   one template or renderer per target
Generate-Themes.ps1          season.jsonc + templates -> every generated file
tools/Import-OmpTheme.ps1    drafts a season.jsonc from an old hand-written theme
tools/Compare-OmpTheme.ps1   before/after render + field diff of two themes, as Markdown for a PR
.github/                     CI check and the PR template
Icons.md                     candidate emoji per month, plus emojipedia collections (move into each month's icons.pool)
prompt-sections.md           list of the Oh My Posh segment types available
ThemesDocumentation.md       old overview of all months (to be replaced)
ThemeGenerator.md            earlier generator design, replaced by Generate-Themes.ps1
test.omp.json, test-all.omp.json   scratch/debug themes (test-all labels each segment type)
scripts.ipynb                snippets that symlink themes into the Oh My Posh themes folder
```

## Oh My Posh notes

- The layout (`templates/oh-my-posh.omp.json`) is the v3 three-block layout:
  - left: shell, root, path, git, execution time
  - right: languages, cloud, os, battery, time
  - a new line with the `⌂──` connector and a status emoji.
- Unconverted months' hand-written theme files are **JSONC**. Oh My Posh accepts `//` comments; generated files are plain JSON.
- In the status segment, use `.Code`/`.Error`. There is no `.Status`, and using it shows "unable to create text based on template".
- Test what a theme looks like:
  - `oh-my-posh print primary --config <file> --shell pwsh` (and `print right`)
  - `oh-my-posh debug --config <file>` for template errors
- Install by symlinking the generated file into the Oh My Posh themes folder (`~/.oh-my-posh-themes/` on Linux, `%LOCALAPPDATA%\Programs\oh-my-posh\themes\` on Windows; see `scripts.ipynb`, whose paths are for my other machines).

## Converting a month (one PR each)

1. **Branch.** From an up-to-date `release-0.0.1`, run `git switch -c updating-<month>`.
2. **Draft.** Run `pwsh ./tools/Import-OmpTheme.ps1 -Month <Month>`. It lines the old theme up with the template and writes `<Month>/season.jsonc`. It gives each role its most common old value, notes every conflicting value as an `// also:` comment, and lists at the top what it couldn't import (broken emoji, templates that didn't line up, missing segments, unused colours).
3. **Finish the document.**
   - Give each palette entry a proper name and key: `c_d35400` becomes `"pumpkin": { "hex": "#D35400", "name": "Pumpkin orange" }`.
   - Resolve each `// also:` comment and each note, then delete them.
   - Fill in the identity fields. Take the story and ideas from the old `theme-definition.md` / `*-Theme-Info.md`, and add spare emoji from that month's line in `Icons.md`.

   The generator refuses the file while any `TODO` is left.
4. **Generate.** Run `pwsh ./Generate-Themes.ps1 -Month <Month>`. Then delete the files it replaces (e.g. `<Month>-Theme-Info.md`), and delete the old theme file with `git rm` if its name changed (e.g. `davids-november.omp.json`).
5. **Compare.** Run `pwsh ./tools/Compare-OmpTheme.ps1 -Before release-0.0.1:<Month>/<old file> -After <Month>/davids-<Month>.omp.json`. Expect text-colour changes, plus whatever the old theme was missing or had broken. Anything else that changed was probably mapped wrong.
6. **Commit** the straight conversion as `<Month>: convert to season.jsonc`. Put any design refinements in a *separate* commit after it.
7. **PR.** Push, then run `gh pr create --base release-0.0.1`. The PR template asks for the compare report, the decisions made, and the checklist. Add `Part of #11`.

## Git workflow

Hosted on **GitHub** (`topicomha/SeasonalThemes`). Use `gh` for PRs.

- **Integration branch:** `release-0.0.1`. Every change goes in through a PR, merged with a merge commit (not squash), so each PR's commits survive.
- **One branch and PR per unit of work:**
  - `updating-<month>` to convert or refine an existing month
  - `adding-<month>` for a new month
  - `adding-<thing>` / `updating-<thing>` for generator, schema or template work.
- **Small, logical commits:**
  - Every commit leaves `pwsh ./Generate-Themes.ps1 -Check` passing, so the source and its generated files are always committed together.
  - In a month PR, keep the *faithful conversion* commit (no visual change except best-contrast text) separate from any *design refinement* commit, so each can be reviewed on its own.
  - Schema or template changes that affect every month go in their own PR, with all months regenerated in the same commit.
- **Commit messages:** `<Area>: <imperative summary>`, e.g. `August: convert to season.jsonc`, `Generator: add palette renderer`, `Schema: add ui.link role`.
- **CI:** `.github/workflows/check-themes.yml` runs `-Check` on every PR.
- **PR description:** what changed, and for a month the before/after `oh-my-posh print primary` output plus anything deliberately changed.
- `vscode-extension-src` folders are local scratch space and must not be committed.

## Backlog

1. **Convert every month to `season.jsonc`**, tracked in issue #11. Only October is done. Still to do: Jan, Feb, Mar, Apr, May, Aug, Sep, Nov, Dec.
   - December: make New Year's Eve a variant. That replaces `davids-NewYearTheme.omp.json` with `davids-December-new-years-eve.omp.json`, so update the symlink.
   - August and September: converting them also fixes the broken `.Status` template and the old v2 layout.
   - November: converting it fixes the four broken `�` emoji and renames `davids-november` → `davids-November`.
2. **Create June and July.** `ThemesDocumentation.md` has draft palettes and icons for both.
3. **Replace `ThemesDocumentation.md`** with a generated index of all months, and fold `Icons.md` into each month's `icons.pool`.
4. **Refine October's proposed colours.** The terminal red, green, blue and cyan swatches are marked "Proposed" in the palette. `status.error` is currently the same as `brand.secondary`.
5. **Remove the empty submodule pointers**: `Fall/vscode-extension-src` and `November/vscode-extension-src` (no `.gitmodules`), and widen the `.gitignore` rule to `vscode-extension-src/`.
6. **VS Code target** (after Oh My Posh is done): bring the extension into this repo, add a `templates/vscode-color-theme.json` template (it can use the `ui`, `syntax` and `terminal` roles directly), and generate 12 themes into one extension.
