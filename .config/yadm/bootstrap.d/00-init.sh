#!/usr/bin/env bash

read -r HOST < /etc/hostname
YADM_CLASSES=()
YADM_UPDATE_REMOTE=""

case $HOST in
  X570-AORUS-PRO)
    YADM_CLASSES=(pacman ssd hdd btrfs xfs zram dhcpcd docker nvidia gaming desktop wayland hyprland ufw openrc)
    YADM_UPDATE_REMOTE=1
    ;;
  VOSTRO-5320)
    YADM_CLASSES=(pacman ssd hdd btrfs xfs zram networkmanager docker desktop wayland hyprland mobile ufw openrc)
    YADM_UPDATE_REMOTE=1
    ;;
  INSPIRON-N4010|LATITUDE-E6500)
    YADM_CLASSES=(pacman ssd btrfs xfs zram dhcpcd docker samba server mobile ufw openrc)
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