-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action
-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Kanagawa (Gogh)'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 13.7
config.window_background_opacity = 0.85
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.keys = {
  -- set spawnTab to modifier Alt
  { key = "t", mods = "ALT", action = act { SpawnTab = "CurrentPaneDomain" } },
  -- set closeTab to modifier Alt
  { key = "w", mods = "ALT", action = act { CloseCurrentTab = { confirm = true } } },
}

for i = 1, 8 do
  -- CTRL+ALT + number to activate that tab
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end


-- and finally, return the configuration to wezterm
return config
