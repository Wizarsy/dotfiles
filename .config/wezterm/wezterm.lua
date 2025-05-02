local wezterm = require("wezterm")
local config = {}

local default_font = "CaskaydiaMono Nerd Font Mono"
-- config.term = "wezterm"

config.color_scheme_dirs = { wezterm.config_dir .. "/themes" }
config.color_scheme = "tokyonight"
config.use_fancy_tab_bar = true
config.window_frame = {
	font_size = 12.0,
}

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.animation_fps = 1
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.initial_cols = 120
config.initial_rows = 24

config.font = wezterm.font(default_font)
config.font_size = 12.0
config.line_height = 1.2
config.font_rules = {
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font(default_font, {
			style = "Oblique",
		}),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font(default_font, {
			style = "Oblique",
		}),
	},
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font(default_font, {
			style = "Oblique",
			foreground = "#414868",
		}),
	},
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", {
			foreground = "#414868",
		}),
	},
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoProfileLoadTime", "-NoLogo" }
	config.default_domain = "WSL:Arch"
	config.mux_enable_ssh_agent = false
	config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "/usr/bin/zsh" }
	config.window_decorations = "NONE"
end

return config

