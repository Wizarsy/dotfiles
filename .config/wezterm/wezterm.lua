local wezterm = require("wezterm")
local config = wezterm.config_builder()
local gpus = wezterm.gui.enumerate_gpus()
local hostname = wezterm.hostname()
local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")

local default_font = "Monocraft"
local font_size = 12.0

-- local teste require("fonts")

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
  config.default_prog = { "pwsh.exe", "-NoProfileLoadTime", "-NoLogo" }
  -- config.color_scheme_dirs = { wezterm.config_dir .. "/colors" }
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
  for _, gpu in ipairs(gpus) do
    if gpu.backend == "Vulkan" and gpu.device_type == "DiscreteGpu" then
      config.webgpu_preferred_adapter = gpu
      config.front_end = "WebGpu"
      break
    end
  end
end

-- config.color_scheme = "tokyonight"
config.initial_cols = 120
config.initial_rows = 24

config.colors = {
  foreground = "#a9b1d6",
  background = "#1a1b26",
  cursor_bg = "#9aa5ce",
  cursor_border = "#1a1b26",
  cursor_fg = "#565f89",
  selection_bg = "#565f89",
  selection_fg = "#9aa5ce",
  ansi = {
    "#414868",
    "#f7768e",
    "#9ece6a",
    "#e0af68",
    "#7aa2f7",
    "#bb9af7",
    "#7dcfff",
    "#c0caf5",
  },
  brights = {
    "#414868",
    "#f7768e",
    "#73daca",
    "#e0af68",
    "#7aa2f7",
    "#bb9af7",
    "#7dcfff",
    "#c0caf5",
  }
}

bar.apply_to_config(config)

config.default_cursor_style = "BlinkingUnderline"
config.cursor_thickness = 2
config.animation_fps = 1
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.font_dirs = {"fonts"}
-- config.font_locator = "ConfigDirsOnly"
config.font = wezterm.font_with_fallback({default_font, "Symbols Nerd Font Mono"})
config.font_size = 12
config.line_height = 1.2
config.cell_width = 1.0
-- config.freetype_interpreter_version = 40
-- config.freetype_load_flags = "NO_HINTING|MONOCHROME"
-- config.freetype_load_target = 'Normal'
-- config.freetype_render_target = 'Normal'
-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.mux_enable_ssh_agent = false
config.window_close_confirmation = "NeverPrompt"



return config