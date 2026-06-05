hl.window_rule({
  name  = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name  = "fix-xwayland-drags",
  match = {
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
  name  = "fix-xwayland-video-bridge",
  match = {
    class = "^xwaylandvideobridge$",
  },
  no_initial_focus = true,
  no_focus = true,
  no_anim = true,
  no_blur = true,
  max_size = { 1, 1 },
  opacity = "0.0"
})

hl.window_rule({
  name = "games",
  match = { content = 3 },
  no_shadow = true,
  no_dim = true,
  no_blur = true,
  render_unfocused = true,
  immediate = true
})