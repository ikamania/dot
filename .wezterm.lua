-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.font_size = 14.0
config.color_scheme = 'Ashes (base16)'

-- and finally, return the configuration to wezterm
return config

