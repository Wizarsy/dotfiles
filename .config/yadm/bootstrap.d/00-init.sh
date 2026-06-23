#!/usr/bin/env bash

read -r _HOST < /etc/hostname
YADM_CLASSES=()
YADM_UPDATE_REMOTE=""

case $_HOST in
  X570-AORUS-PRO)
    YADM_CLASSES=(wayland hyprland openrc pacman nvidia gaming btrfs xfs ssd zram dev)
    YADM_UPDATE_REMOTE=1
    ;;
  VOSTRO-5320)
    YADM_CLASSES=(wayland hyprland openrc pacman btrfs ssd zram dev)
    YADM_UPDATE_REMOTE=1
    ;;
  *)
    ;;
esac

[ -z "$YADM_UPDATE_REMOTE" ] || yadm remote set-url origin "git@github.com:Wizarsy/dotfiles.git"; echo "Origin URL updated"

echo "Configuring git"
yadm gitconfig pull.rebase false

yadm config --unset-all local.class
yadm config --add local.class minimal

for class in "${YADM_CLASSES[@]}"; do
  yadm config --add local.class "${class}"
done

# while read -ren 1 opt; do
#   case $opt in
#     0) yadm config --add local.class server;;
#     1) yadm config --add local.class dev;;
#     2)
#       yadm config --add local.class wayland
#       yadm config --add local.class hyprland
#       yadm config --add local.class DE;;
#     q) break;;
#     *) continue;;
#   esac
# done
