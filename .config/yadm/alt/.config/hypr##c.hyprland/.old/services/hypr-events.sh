#!/usr/bin/env bash

declare -a handled_events

event_windowtitlev2() {
  local windowid="${1%,*}"
  local windowtitle="${1#*,}"
  [[ ! "${handled_events[*]}" =~ ${windowid} ]] || return
  case "${windowtitle}" in
    Extension:*)
      hyprctl -q --batch \
        "dispatch setfloating address:0x$windowid;" \
        "dispatch resizewindowpixel exact 20% 54%,address:0x$windowid;" \
        "dispatch centerwindow"
      handled_events+=("${windowid}")
    ;;
    *)
      return
    ;;
  esac
}

handle_closewindow() {
  # shellcheck disable=SC2206
  handled_events=(${handled_events[@]/$1/})
}


handle() {
  local event=${1%>>*}
  local payload=${1#*>>}
  case "${event}" in
    closewindow)
      handle_closewindow "$payload"
      echo "close window: ${payload%,*}"
    ;;
    windowtitlev2)
      event_windowtitlev2 "$payload"
      echo "handle window: ${payload%,*}"
    ;;
    *)
      echo "unhandled event: $event"
    ;;
  esac
}

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done