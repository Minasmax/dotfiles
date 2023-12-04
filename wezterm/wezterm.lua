local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.font = wezterm.font("Hack Nerd Font")
config.font_size = 14.0
config.line_height = 1.25
config.color_scheme = "Tomorrow"
config.freetype_load_target = "Light"
config.enable_tab_bar = false
config.audible_bell = "Disabled"

return config
