#!/usr/bin/env bash

declare -a _CLASSES

_CLASSES=("minimal" "server" "hyprland")

echo "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:Wizarsy/dotfiles.git"

echo "Configuring git"
yadm gitconfig pull.rebase false

echo "Choose a profile"
while read -ren 1 opt; do
  [[ "$opt" -eq 0 ]] && break
done