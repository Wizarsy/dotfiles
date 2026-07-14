hl.env("ICONTHEME", "Papirus-Dark")
hl.env("FONT", "NotoSans Nerd Font Propo Regular")
hl.env("FONTSIZE", "12")
hl.env("DOCFONT", "NotoSerif Nerd Font Propo Regular")
hl.env("DOCFONTSIZE", "12")
hl.env("MONOFONT", "CaskaydiaMono Nerd Font Mono Regular")
hl.env("MONOFONTSIZE", "14")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-mocha-dark-cursors")
hl.env("HYPRCURSOR_SIZE", os.getenv("XCURSOR_SIZE"))
hl.env("HYPRCURSOR_THEME", os.getenv("XCURSOR_THEME"))

-- hl.env("QT_SCALE_FACTOR_ROUNDING_POLICY", "RoundPreferFloor")

hl.env("DXVK_CONFIG_FILE", "/home/wizarsy/.config/dxvk.conf")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_LOG_MAX_ANISO", "4")
hl.env("__GL_THREADED_OPTIMIZATIONS", "1")
hl.env("__GL_SHADER_DISK_CACHE", "1")
hl.env("__GL_SHADER_DISK_CACHE_SKIP_CLEANUP", "1")
hl.env("__GL_SHADER_DISK_CACHE_SIZE", "6000000000")
hl.env("CUDA_DISABLE_PERF_BOOST", "1")

-- hl.env("", "")
-- hl.env("SSH_AUTH_SOCK", "")
hl.env("EDITOR", "nvim")
hl.env("GOPATH", "/tmp/go")
hl.env("CARGO_HOME", "/tmp/cargo")

hl.monitor({ output = "desc:Samsung Electric Company Odyssey G5 HX5Y200481", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "desc:Samsung Electric Company C24FG7x HTHM400319", mode = "preferred", position = "auto-right", scale = 1 })
hl.monitor({ output = "Unknown-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = "desc:Samsung Electric Company Odyssey G5 HX5Y200481", default = true })
hl.workspace_rule({ workspace = "2", monitor = "desc:Samsung Electric Company C24FG7x HTHM400319", default = true })

local color_scheme = {
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
  }
}

hl.config({
  general = {
    col = {
      active_border = "rgb(565f89)",
      inactive_border = color_scheme.background,
    }
  },
  input = {
    kb_model = "",
    kb_layout = "us",
    kb_variant = "intl",
  },
  cursor = {
    default_monitor = "desc:Samsung Electric Company Odyssey G5 HX5Y200481"
  }
})

require("config")

hl.on("hyprland.start", function()
  hl.exec_cmd("openrc -U graphical")
end)

