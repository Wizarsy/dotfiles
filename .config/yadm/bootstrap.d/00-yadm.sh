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
      yadm config --add local.class hyprland
      yadm config --add local.class wl_DE
      yadm config --add local.class DE;;
    q) break;;
    *) continue;;
  esac
done

source /etc/os-release

case $ID in
  artix) read -d '\n' -ra alt_files <<<"$(command find -L ~/.config/yadm/system_alt/Artix -type f -not -path '*/.git/*')";;
  arch) read -d '\n' -ra alt_files <<<"$(command find -L ~/.config/yadm/system_alt/Arch -type f -not -path '*/.git/*')";;  
  *);;
esac

if [[ -n $alt_files ]]; then
  for file in "${alt_files[@]}"; do
    dest="$(dirname "${file##*"${ID^}"}")"
    [ -d "$dest" ] || mkdir -p "$dest"
    sudo -n cp -vsup "$(readlink -f "$file")" "${dest}/${file##*/}"
  done
fi