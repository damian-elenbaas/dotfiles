-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Kanagawa (Gogh)'
config.font = wezterm.font 'Hack Nerd Font Mono'
config.font_size = 13.7
config.window_background_opacity = 0.6

-- and finally, return the configuration to wezterm
return config
