#!/usr/bin/env bash

echo "Update origin URL? y/n"
while read -ren 1 opt; do
  case $opt in
    y|Y) yadm remote set-url origin "git@github.com:Wizarsy/dotfiles.git"; echo "Origin URL updated";;
    n|N|*) break;;
  esac
done

echo "Configuring git"
yadm gitconfig pull.rebase false

echo -e "
Choose a profile:
  0: server
  1: dev
  2: hyprland
  q: finish"

yadm config --unset-all local.class
yadm config --add local.class minimal

while read -ren 1 opt; do
  case $opt in
    0) yadm config --add local.class server;;
    1) yadm config --add local.class dev;;
    2)
      yadm config --add local.class wayland
      yadm config --add local.class hyprland
      yadm config --add local.class DE;;
    q) break;;
    *) continue;;
  esac
done

case $(readlink -f /sbin/init) in
  *systemd*) yadm config --add local.class systemd;;
  *openrc*) yadm config --add local.class openrc;;
  *);;
esac

! command find /sys/class/power_supply/BAT* -quit &> /dev/null || yadm config --add local.class mobile

yadm alt
