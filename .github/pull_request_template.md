## What changed

<!-- Which month (or which generator/schema/template change), and why. Link the tracking issue: "Part of #N". -->

## Before / after

<!-- For a month, paste the output of:
     pwsh ./tools/Compare-OmpTheme.ps1 -Before origin/main:<Month>/<old theme file> -After <Month>/davids-<Month>.omp.json
     Then list the changes that were deliberate (best-contrast text, bug fixes, new icons...). -->

## Decisions to review

<!-- Anything you chose that the old theme didn't settle: conflicting values, proposed colours, new icons. -->

## Checklist

- [ ] `pwsh ./Generate-Themes.ps1 -Check` passes (CI runs it too)
- [ ] The straight conversion and any design changes are in separate commits
- [ ] Replaced files are deleted (old `*-Theme-Info.md`, renamed or folded-in theme files)
- [ ] If a theme file was renamed, the symlink to update is noted above
