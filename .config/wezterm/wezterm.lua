local wezterm = require("wezterm")
local config = wezterm.config_builder()
local gpus = wezterm.gui.enumerate_gpus()
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

config.default_workspace = "master"

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh.exe", "-NoProfileLoadTime", "-NoLogo" }
	config.window_decorations = "RESIZE" -- "RESIZE|INTEGRATED_BUTTONS"
	config.default_domain = "WSL:Arch"
	for _, gpu in ipairs(gpus) do
		if gpu.backend == "Dx12" and gpu.device_type == "DiscreteGpu" then
			config.webgpu_preferred_adapter = gpu
			config.front_end = "WebGpu"
			break
		end
	end
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	config.default_prog = { "/usr/bin/zsh" }
	config.window_decorations = "NONE"
	config.enable_wayland = true
	-- for _, gpu in ipairs(gpus) do
	--   if gpu.backend == "Vulkan" and gpu.device_type ~= "Cpu" then
	--     config.webgpu_preferred_adapter = gpu
	--     config.front_end = "WebGpu"
	--     break
	--   end
	-- end
end

config.colors = require("colors.TokyoNight")

config.initial_cols = 120
config.initial_rows = 24

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.animation_fps = 1
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.font_dirs = { "fonts" }
config.font = wezterm.font_with_fallback({ "Monocraft", "Symbols Nerd Font Mono" })
config.font_size = 12
config.line_height = 1.2
config.cell_width = 1.0

config.mux_enable_ssh_agent = false
config.window_close_confirmation = "NeverPrompt"

bar.apply_to_config(config)

return config

