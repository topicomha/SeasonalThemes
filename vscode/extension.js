// Switches to the current month's Seasonal theme (or a date variant such as New Year's Eve).
// It only switches when a Seasonal theme is already active, so it never overrides another theme
// the user picked. The schedule is generated into package.json by Generate-Themes.ps1.
const vscode = require('vscode');
const { seasonalSchedule } = require('./package.json');

const CHECK_EVERY_MS = 60 * 60 * 1000; // hourly, so the theme changes soon after midnight

/** The theme label for a date: a variant whose MM-DD range covers it, else the month's own theme. */
function themeFor(date) {
  const month = date.getMonth() + 1;
  const monthDay = `${String(month).padStart(2, '0')}-${String(date.getDate()).padStart(2, '0')}`;
  const entries = seasonalSchedule.filter((entry) => entry.month === month);
  const variant = entries.find((entry) => entry.from && entry.from <= monthDay && monthDay <= entry.to);
  const base = entries.find((entry) => !entry.from);
  return (variant || base || {}).label;
}

async function switchTheme({ force }) {
  const config = vscode.workspace.getConfiguration();
  const current = config.get('workbench.colorTheme');
  const isSeasonal = seasonalSchedule.some((entry) => entry.label === current);
  if (!force && (!isSeasonal || !config.get('seasonalThemes.autoSwitch'))) return;

  const wanted = themeFor(new Date());
  if (wanted && wanted !== current) {
    await config.update('workbench.colorTheme', wanted, vscode.ConfigurationTarget.Global);
  }
}

function activate(context) {
  switchTheme({ force: false });
  const timer = setInterval(() => switchTheme({ force: false }), CHECK_EVERY_MS);
  context.subscriptions.push({ dispose: () => clearInterval(timer) });
  context.subscriptions.push(
    vscode.commands.registerCommand('seasonalThemes.useCurrentMonth', () => switchTheme({ force: true }))
  );
}

function deactivate() {}

module.exports = { activate, deactivate, themeFor };
