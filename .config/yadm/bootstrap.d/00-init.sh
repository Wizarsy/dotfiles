#!/usr/bin/env bash

read -r _HOST < /etc/hostname
YADM_CLASSES=()
YADM_UPDATE_REMOTE=""

case $_HOST in
  X570-AORUS-PRO)
    YADM_CLASSES=(pacman dhcpcd ssd hdd zram btrfs xfs pacman docker nvidia gaming desktop wayland hyprland ufw openrc)
    YADM_UPDATE_REMOTE=1
    ;;
  VOSTRO-5320)
    YADM_CLASSES=(pacman wayland ufw hyprland pacman btrfs ssd zram docker mobile openrc)
    YADM_UPDATE_REMOTE=1
    ;;
  INSPIRON-N4010|LATITUDE-E6500)
    YADM_CLASSES=(pacman ssd btrfs xfs dhcpcd docker samba server zram mobile ufw openrc)
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

export SKIP_SYS_ALTS=1
yadm alt