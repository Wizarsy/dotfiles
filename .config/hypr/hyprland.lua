
hl.env("ICONTHEME", "Papirus-Dark")
hl.env("FONT", "NotoSans Nerd Font Propo Regular")
hl.env("FONTSIZE", "12")
hl.env("DOCFONT", "NotoSerif Nerd Font Propo Regular")
hl.env("DOCFONTSIZE", "12")
hl.env("MONOFONT", "CaskaydiaMono Nerd Font Mono Regular")
hl.env("MONOFONTSIZE", "14")

hl.monitor({ output = "DP-1", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-2", mode = "preferred", position = "auto-right", scale = 1 })
hl.monitor({ output = "Unknown-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = "DP-1", default = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-2", default = true })

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
    default_monitor = "DP-1"
  }
})

-- hl.device({
--   name = "ven_04f3:00-04f3:325f-touchpad",
--   sensitivity = 0.7,
--   scroll_method = "2fg"
-- })

-- hl.device({
--   name = "at-translated-set-2-keyboard",
--   kb_model = "abnt2",
--   kb_layout = "br",
--   kb_variant = ""
-- })

require("config")

hl.on("hyprland.start", function()
  hl.exec_cmd("openrc -U graphical")
end)
