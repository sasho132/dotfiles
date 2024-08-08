local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("MesloLGS Nerd Font", { weight = "Regular" })
config.enable_tab_bar = false
config.font_size = 20
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 10
config.initial_rows = 30
config.initial_cols = 110
config.send_composed_key_when_left_alt_is_pressed = true
config.window_close_confirmation = "NeverPrompt"
-- config.background = {
-- 	{
-- 		source = {
-- 			Color = "#1e1e2e",
-- 		},
-- 		width = "100%",
-- 		height = "100%",
-- 		opacity = 0.80,
-- 	},
-- }

return config
