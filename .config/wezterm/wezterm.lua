-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.colors = require('color')
config.font = wezterm.font('HackNerdFont', { weight = 'Regular' })
config.font_size = 13.5
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.keys = {
  -- set spawnTab to modifier Alt
  { key = "t", mods = "ALT", action = act { SpawnTab = "CurrentPaneDomain" } },
  -- set closeTab to modifier Alt
  { key = "w", mods = "ALT", action = act { CloseCurrentTab = { confirm = true } } },
  -- set activate pane right modifier Alt
  { key = "e", mods = "ALT", action = act { CloseCurrentPane = { confirm = true } } },
  -- set split vertical modifier Alt
  { key = "v", mods = "ALT", action = act { SplitVertical = { domain = "CurrentPaneDomain" } } },
  -- set split vertical modifier Alt
  { key = "b", mods = "ALT", action = act { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  -- set activate pane left modifier Alt
  { key = "h", mods = "ALT", action = act { ActivatePaneDirection = "Left" } },
  -- set activate pane down modifier Alt
  { key = "j", mods = "ALT", action = act { ActivatePaneDirection = "Down" } },
  -- set activate pane up modifier Alt
  { key = "k", mods = "ALT", action = act { ActivatePaneDirection = "Up" } },
  -- set activate pane right modifier Alt
  { key = "l", mods = "ALT", action = act { ActivatePaneDirection = "Right" } },
}

config.window_padding = {
  left = 5,
  right = 5,
  top = 5,
  bottom = 5,
}

for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

local function tab_title(tab_info)
  local title = tab_info.tab_title

  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cf, hover, max_width)
  local title = tab_title(tab)

  title = wezterm.truncate_left(title, max_width)
  local i = tab.tab_index + 1

  title = string.format(" %d %s ", i, title)

  return {
    { Text = title },
  }
end)

-- Vi navigation
local modal = wezterm.plugin.require("https://github.com/MLFlexer/modal.wezterm")
modal.apply_to_config(config)

-- -- and finally, return the configuration to wezterm
return config
