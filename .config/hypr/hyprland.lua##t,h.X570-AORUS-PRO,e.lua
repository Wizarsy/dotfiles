local lact_profile = "Default"
local home = os.getenv("HOME")
local user = os.getenv("USER")

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

hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-mocha-dark-cursors")
hl.env("HYPRCURSOR_SIZE", os.getenv("XCURSOR_SIZE"))
hl.env("HYPRCURSOR_THEME", os.getenv("XCURSOR_THEME"))

hl.on("hyprland.start", function()
  local uid = io.popen("id -u " .. user, "r")
  if uid then
    local xdg_runtime_dir = (os.getenv("XDG_RUNTIME_DIR") or ("/run/user/" .. uid:read("l")))
    uid:close()
    hl.env("DBUS_SESSION_BUS_ADDRESS", "unix:path=" .. xdg_runtime_dir .. "/bus")
    local ssh_sock = io.popen("command find " .. xdg_runtime_dir .. " -maxdepth 1 -name 'ssh-agent.*' -print0 -quit")
    if ssh_sock then
      hl.env("SSH_AUTH_SOCK", ssh_sock:read("a"))
      ssh_sock:close()
    end
  end

  hl.env("ICONTHEME", "Papirus-Dark")
  hl.env("FONT", "NotoSans Nerd Font Propo Regular")
  hl.env("FONTSIZE", "12")
  hl.env("DOCFONT", "NotoSerif Nerd Font Propo Regular")
  hl.env("DOCFONTSIZE", "12")
  hl.env("MONOFONT", "CaskaydiaMono Nerd Font Mono Regular")
  hl.env("MONOFONTSIZE", "14")
  hl.env("DXVK_CONFIG_FILE", home .. "/.config/dxvk.conf")
  hl.env("__GL_VRR_ALLOWED", "1")
  hl.env("__GL_GSYNC_ALLOWED", "1")
  hl.env("__GL_LOG_MAX_ANISO", "4")
  hl.env("__GL_THREADED_OPTIMIZATIONS", "1")
  hl.env("__GL_SHADER_DISK_CACHE", "1")
  hl.env("__GL_SHADER_DISK_CACHE_SKIP_CLEANUP", "1")
  hl.env("__GL_SHADER_DISK_CACHE_SIZE", "6000000000")

  hl.env("EDITOR", "nvim")
  hl.env("GOPATH", "/tmp/go")
  hl.env("CARGO_HOME", "/tmp/cargo")

  hl.exec_cmd("openrc -U graphical")
  if io.popen("command -v lact", "r") then
    hl.exec_cmd("lact cli profile set Default")
  end
end)

-- hl.on("window.open", function(w)
--   if w ~= nil then
--     if w.content_type == "game" then
--       if lact_profile == "Default" then
--         if io.popen("command -v lact", "r") then
--           hl.exec_cmd("lact cli profile set Performance")
--           lact_profile = "Performance"
--         end
--       end
--     end
--   end
-- end)

hl.on("window.fullscreen", function(w)
  if w ~= nil then
    if w.content_type == "game" and w.fullscreen == 2 and lact_profile == "Default" then
      if io.popen("command -v lact", "r") then
        hl.exec_cmd("lact cli profile set Performance")
        lact_profile = "Performance"
      end
    end
  end
end)

-- hl.on("window.close", function(w)
--   if w ~= nil then
--   end
-- end)

hl.on("window.destroy", function(w)
  if w ~= nil then
    if hl.get_window([[tag:game\*]]) == nil then
      if lact_profile == "Performance" then
        if io.popen("command -v lact", "r") then
          hl.exec_cmd("lact cli profile set Default")
          lact_profile = "Default"
        end
      end
    end
  end
end)

hl.monitor({ output = "desc:Samsung Electric Company Odyssey G5 HX5Y200481", mode = "preferred", position = "0x0", scale = 1 })
hl.monitor({ output = "desc:Samsung Electric Company C24FG7x HTHM400319", mode = "preferred", position = "auto-right", scale = 1 })
hl.monitor({ output = "Unknown-1", disabled = true })

hl.workspace_rule({ workspace = "1", monitor = "desc:Samsung Electric Company Odyssey G5 HX5Y200481", default = true })
hl.workspace_rule({ workspace = "2", monitor = "desc:Samsung Electric Company C24FG7x HTHM400319", default = true })

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
  },
  quirks = {
    skip_non_kms_dmabuf_formats = true
  }
})

require("config")
