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
    YADM_CLASSES=(wayland hyprland openrc pacman btrfs ssd zram dev mobile)
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
