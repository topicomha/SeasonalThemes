// Keeps VS Code on the current month's Seasonal theme (or a date variant such as New Year's Eve), in
// light or dark depending on seasonalThemes.mode:
//   system  follow the OS light/dark setting (VS Code's window.autoDetectColorScheme)
//   time    light between seasonalThemes.lightFrom and seasonalThemes.darkFrom, dark otherwise
//   light / dark  always that mode
// It only acts while a Seasonal theme is in use, so it never overrides another theme the user picked.
// The schedule (which theme covers which dates and mode) is generated into package.json by Generate-Themes.ps1.
const vscode = require('vscode');
const { seasonalSchedule } = require('./package.json');

const CHECK_EVERY_MS = 60 * 1000; // every minute: month changes at midnight, time mode at its switch times

const pad = (n) => String(n).padStart(2, '0');

/** The theme label for a date and mode: a variant whose MM-DD range covers the date, else the month's own. */
function themeFor(date, mode) {
  const month = date.getMonth() + 1;
  const monthDay = `${pad(month)}-${pad(date.getDate())}`;
  const inMonth = seasonalSchedule.filter((entry) => entry.month === month);
  const variant = inMonth.filter((entry) => entry.from && entry.from <= monthDay && monthDay <= entry.to);
  const candidates = variant.length ? variant : inMonth.filter((entry) => !entry.from);
  // A month without the requested mode falls back to whichever mode it has.
  const match = candidates.find((entry) => entry.mode === mode) || candidates[0];
  return match && match.label;
}

/** 'light' between lightFrom and darkFrom (local time, "HH:MM"), otherwise 'dark'. */
function modeForTime(date, lightFrom, darkFrom) {
  const now = `${pad(date.getHours())}:${pad(date.getMinutes())}`;
  const isLight = lightFrom <= darkFrom
    ? lightFrom <= now && now < darkFrom
    : now >= lightFrom || now < darkFrom; // e.g. light from 22:00 to 06:00
  return isLight ? 'light' : 'dark';
}

/** The settings to write for a date, given the extension's own settings. */
function settingsFor(date, { mode, lightFrom, darkFrom }) {
  const light = themeFor(date, 'light');
  const dark = themeFor(date, 'dark');
  if (mode === 'system') {
    return {
      'window.autoDetectColorScheme': true,
      'workbench.preferredLightColorTheme': light,
      'workbench.preferredDarkColorTheme': dark,
    };
  }
  const wanted = mode === 'time' ? modeForTime(date, lightFrom, darkFrom) : mode;
  return {
    'window.autoDetectColorScheme': false,
    'workbench.colorTheme': wanted === 'light' ? light : dark,
  };
}

async function update({ force }) {
  const config = vscode.workspace.getConfiguration();
  const ours = new Set(seasonalSchedule.map((entry) => entry.label));
  const inUse = ['workbench.colorTheme', 'workbench.preferredLightColorTheme', 'workbench.preferredDarkColorTheme']
    .some((key) => ours.has(config.get(key)));
  if (!force && (!inUse || !config.get('seasonalThemes.autoSwitch'))) return;

  const settings = settingsFor(new Date(), {
    mode: config.get('seasonalThemes.mode'),
    lightFrom: config.get('seasonalThemes.lightFrom'),
    darkFrom: config.get('seasonalThemes.darkFrom'),
  });
  for (const [key, value] of Object.entries(settings)) {
    if (value !== undefined && config.get(key) !== value) {
      await config.update(key, value, vscode.ConfigurationTarget.Global);
    }
  }
}

function activate(context) {
  update({ force: false });
  const timer = setInterval(() => update({ force: false }), CHECK_EVERY_MS);
  context.subscriptions.push({ dispose: () => clearInterval(timer) });
  context.subscriptions.push(
    vscode.commands.registerCommand('seasonalThemes.useCurrentMonth', () => update({ force: true })),
    vscode.workspace.onDidChangeConfiguration((event) => {
      if (event.affectsConfiguration('seasonalThemes')) update({ force: false });
    })
  );
}

function deactivate() {}

module.exports = { activate, deactivate, themeFor, modeForTime, settingsFor };
