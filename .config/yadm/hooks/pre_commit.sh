#!/usr/bin/env bash

echo "Running Pre Commit script..."

if [[ "$(yadm config --get local.class)" == "wsl" ]]; then
  if ! diff "$HOME/.config/wezterm/wezterm.lua" "/mnt/c/Users/Filipe/.config/wezterm/wezterm.lua" &> /dev/null; then
    if [[ "$HOME/.config/wezterm/wezterm.lua" -nt "/mnt/c/Users/Filipe/.config/wezterm/wezterm.lua" ]]; then
      cp -f "$HOME/.config/wezterm/wezterm.lua" "/mnt/c/Users/Filipe/.config/wezterm/wezterm.lua"
    else
      cp -f "/mnt/c/Users/Filipe/.config/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
    fi
  fi
fi
