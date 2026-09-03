local path = os.getenv("PATH")
local home = os.getenv("HOME")

hl.on("hyprland.start", function()
  local display_controller = io.popen("lspci -kd ::03xx", "r")
  if display_controller then
    local driver = string.match(display_controller:read("a"), "Kernel driver in use: (%w+)")
    display_controller:close()
    if driver == "nvidia" then
      hl.env("NVD_BACKEND", "direct")
      hl.env("GBM_BACKEND", "nvidia-drm")
      hl.env("CUDA_DISABLE_PERF_BOOST", "1")
      hl.env("LIBVA_DRIVER_NAME", "nvidia")
      hl.env("VDPAU_DRIVER", "nvidia")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
      hl.env("__EGL_VENDOR_LIBRARY_FILENAMES", "/usr/share/glvnd/egl_vendor.d/10_nvidia.json")
    elseif driver == "i915" or driver == "xe" or driver == "nouveau" or driver == "dxgkrnl" or driver == "amdgpu" then
      hl.env("VDPAU_DRIVER", "va_gl")
      hl.env("__GLX_VENDOR_LIBRARY_NAME", "mesa")
      hl.env("__EGL_VENDOR_LIBRARY_FILENAMES", "/usr/share/glvnd/egl_vendor.d/50_mesa.json")
      if driver == "i915" or driver == "xe" then
        hl.env("ANV_DEBUG", "video-decode,video-encode")
        if io.open("/usr/lib/dri/iHD_drv_video.so", "r") then
          hl.env("LIBVA_DRIVER_NAME", "iHD")
        else
          hl.env("LIBVA_DRIVER_NAME", "i965")
        end
      elseif driver == "nouveau" then
        hl.env("LIBVA_DRIVER_NAME", "nouveau")
      elseif driver == "dxgkrnl" then
        hl.env("GALLIUM_DRIVER", "d3d12")
        hl.env("LIBVA_DRIVER_NAME", "d3d12")
      elseif driver == "amdgpu" then
        hl.env("RADV_PERFTEST", "video_decode,video_encode")
        hl.env("LIBVA_DRIVER_NAME", "radeonsi")
      end
    end
  end

  hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
  hl.env("XDG_SESSION_DESKTOP", "Hyprland")
  hl.env("XDG_SESSION_TYPE", "wayland")
  hl.env("DESKTOP_SESSION", "gnome")

  hl.env("XDG_CONFIG_HOME", home .. "/.config")
  hl.env("XDG_CACHE_HOME", home .. "/.cache")
  hl.env("XDG_DATA_HOME", home .. "/.local/share")
  hl.env("XDG_STATE_HOME", home .. "/.local/state")

  hl.env("XCURSOR_PATH",
    home .. "/.icons:" .. home .. "/.local/share/icons:" .. (os.getenv("XCURSOR_PATH") or "/usr/share/icons"))

  hl.env("GDK_BACKEND", "wayland")
  hl.env("GDK_SCALE", "1")
  hl.env("GTK_USE_PORTAL", "1")

  hl.env("QT_QPA_PLATAFORM", "wayland;xcb")
  hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")
  hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
  hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
  -- hl.env("QT_SCALE_FACTOR_ROUNDING_POLICY", "RoundPreferFloor")

  hl.env("ELM_DISPLAY", "wl")
  hl.env("ELM_SCALE", "1")

  hl.env("MOZ_ENABLE_WAYLAND", "1")
  hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")

  hl.env("SDL_VIDEODRIVER", "wayland,x11")

  hl.env("CLUTTER_BACKEND", "wayland")

  hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

  hl.env("ELECTRON_FORCE_WINDOW_MENU_BAR", "1")
  hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

  hl.env("PATH", home .. "/.bin:" .. home .. "/.local/.bin:/opt:" .. path)
  path = os.getenv("PATH")

  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("hyprlauncher -d")

  hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface font-hinting 'full'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface font-rga-order 'rgb'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface text-scaling-factor 1.0")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface toolbar-icons-size 'small'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface toolbar-style 'icons'")
  hl.exec_cmd("gsettings set org.gnome.desktop.sounds input-feedback-sounds true")
  hl.exec_cmd("gsettings set org.gnome.desktop.sounds event-sounds true")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

  hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name " ..
    "'" .. os.getenv("FONT") .. " " .. os.getenv("FONTSIZE") .. "'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface document-font-name " ..
    "'" .. os.getenv("DOCFONT") .. " " .. os.getenv("DOCFONTSIZE") .. "'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name " ..
    "'" .. os.getenv("MONOFONT") .. " " .. os.getenv("MONOFONTSIZE") .. "'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme" .. os.getenv("ICONTHEME"))
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme" .. os.getenv("XCURSOR_THEME"))
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size" .. os.getenv("XCURSOR_SIZE"))
  -- hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme $gtkTheme")
  -- hl.exec_cmd("dbus-update-activation-environment --all")
end)

hl.on("monitor.added", function(m)
  local monitors = hl.get_monitors()
  hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = monitors[1].name })
end)

hl.on("window.open_early", function(w)
  if w ~= nil then
-- if w.initial_class == "rpcs3" then
-- if string.match(w.initial_title, "%[%w+%]") then
--   hl.dispatch(hl.dsp.window.set_prop({ prop = "content", value = "game" }))
-- end
-- end
  end
end)

hl.on("window.open", function(w)
  if w ~= nil then
    if w.tags[1] == "close*" then
      hl.dispatch(hl.dsp.window.close())
    end
  end
end)

hl.on("window.title", function(w)
  if w ~= nil then
--    if w.title == "Minecraft Launcher" then
--      hl.dispatch(hl.dsp.window.move({ workspace = "emptynm" }))
--    end
  end
end)

hl.workspace_rule({
  workspace = "9",
  monitor = hl.get_config("cursor.default_monitor") or hl.get_monitors()[1].name,
  no_rounding = true,
  decorate = false,
  persistent = true,
  default_name =
  "gaming"
})

hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})
hl.window_rule({
  name             = "fix-xwayland-video-bridge",
  match            = {
    class = "^xwaylandvideobridge$"
  },
  no_initial_focus = true,
  no_focus         = true,
  no_anim          = true,
  no_blur          = true,
  max_size         = { 1, 1 },
  opacity          = "0.0"
})

hl.window_rule({ match = { initial_title = [[\s*]] }, size = { "(monitor_w * 0.5)", "(monitor_h * 0.5)" }, center = true, float = true })

hl.window_rule({ match = { initial_class = "^(kvantummanager|qt[5-6]ct|nwg-look|filechooser|minecraft-launcher)$" }, float = true })
hl.window_rule({ match = { initial_class = "org.qbittorrent.qBittorrent", initial_title = "negative:^qBittorrent.*" }, float = true })

hl.window_rule({ match = { title = "^([Mm]inecraft [0-9].*)$" }, content = "game" })
hl.window_rule({ match = { class = "^(steam_app.*|hl2_linux)$" }, content = "game" })
hl.window_rule({ match = { xdg_tag = "^(proton-game)$" }, content = "game" })

hl.window_rule({ match = { initial_class = "rpcs3", initial_title = [[(.+ \|)*.+\[\w+\]?]] }, content = "game" })
hl.window_rule({ match = { initial_class = "steam_app.*", initial_title = [[\s*]] }, content = "none", tag = "close", no_follow_mouse = true })
-- hl.window_rule({ match = { initial_class = "steam_app.*", float = true }, content = "none" })
hl.window_rule({ match = { initial_title = "^(Steam|EA|Ubisoft Connect)$" }, content = "none" })
hl.window_rule({ match = { initial_title = "^(EADesktop)$" }, content = "none" })
hl.window_rule({ match = { initial_class = "steam", initial_title = "negative:Steam" }, float = true })
hl.window_rule({
  name = "games_rule",
  match = { content = 3 },
  dim_around = false,
  decorate = false,
  no_anim = true,
  no_shadow = true,
  no_dim = true,
  no_blur = true,
  render_unfocused = true,
  immediate = true,
  tag = "game"
})
hl.window_rule({ match = { class = "^(dyinglightgame_x64_rwdi.exe|hl2_linux)$" }, immediate = false })
hl.window_rule({ match = { content = 3 }, workspace = "name:gaming" })

hl.config({
  general = {
    border_size = 2,
    gaps_in = 8,
    gaps_out = 10,
    layout = "dwindle",
    resize_on_border = true,
    extend_border_grab_area = 10,
    allow_tearing = true,
    snap = {
      enabled = true,
      window_gap = 20,
      monitor_gap = 20,
      respect_gaps = true
    }
  },
  decoration = {
    rounding = 15,
    rounding_power = 2.0,
    dim_modal = false,
    shadow = {
      enabled = false
    },
  },
  input = {
    numlock_by_default = true,
    force_no_accel = true,
    follow_mouse = 1,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.5,
      drag_lock = 1
    }
  },
  misc = {
    vrr = 3,
    render_unfocused_fps = 30
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  scrolling = {
    fullscreen_on_one_column = true,
  },
  binds = {
    allow_workspace_cycles = true,
    drag_threshold = 10
  },
  xwayland = {
    enabled = true,
    force_zero_scaling = true,
    use_nearest_neighbor = true,
  },
  opengl = {
    nvidia_anti_flicker = true
  },
  render = {
    direct_scanout = 2,
  },
  cursor = {
    no_hardware_cursors = 2
  },
  ecosystem = {
    enforce_permissions = true
  }
})

hl.permission({ binary = ".*", type = "screencopy", mode = "ask" })
hl.permission({ binary = "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/hyprpm", type = "plugin", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/teamspeak", type = "screencopy", mode = "allow" })
hl.permission({ binary = "/usr/(bin|local/bin)/discord", type = "screencopy", mode = "allow" })

-- hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
-- hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
-- hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
-- hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
-- hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
-- hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
-- hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
-- hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
-- hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
-- hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
-- hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
-- hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
-- hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
-- hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
-- hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
-- hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
-- hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

local mod         = "SUPER"
local terminal    = "wezterm -e --always-new-process"
local fileManager = "wezterm -e --always-new-process -- yazi"
local menu        = "hyprlauncher"

-- hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mod .. " + Escape", hl.dsp.exec_cmd("hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mod .. " + SHIFT + Escape", hl.dsp.exit())
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(fileManager, { float = true }))
hl.bind(mod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mod .. " + Z", hl.dsp.window.float({ action = "toggle" }))

-- hl.bind(mod .. " + P", hl.dsp.window.pseudo())
-- hl.bind(mod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "r+1" }))

hl.bind(mod .. " + SHIFT + left", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind(mod .. "+ M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- hl.gesture({
--   fingers = 3,
--   direction = "horizontal",
--   action = "workspace"
-- })
