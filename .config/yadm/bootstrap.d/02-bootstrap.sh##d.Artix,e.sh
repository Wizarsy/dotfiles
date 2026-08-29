#!/usr/bin/env bash

# shellcheck disable=SC2016

INSTALL="yay -S --noconfirm --needed --norebuild"
UPDATE="yay -Sy"
CLEAN="yay -Yc --noconfirm"
# read -r HOST < /etc/hostname

AURDEST="${HOME}/.cache/yay"
BUILDDIR="${HOME}/.cache/makepkg"
CARGO_HOME="${HOME}/.cache/cargo"
GOPATH="${HOME}/.cache/go"

export BUILDDIR CARGO_HOME GOPATH AURDEST

prepare-bootstrap() {
  local pkgs=(curl git base-devel mold axel)

  [[ -x "$(command -v sudo)" ]] || exit 1

  sudo -n pacman -Sy --noconfirm --needed "${pkgs[@]}"

  sudo -n pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
  sudo -n pacman-key --lsign-key F3B607488DB35A47

  curl https://auris.artixlinux.org/api/packages/auris/arch/repository.key -o /tmp/auris.key
  sudo -n pacman-key --add /tmp/auris.key
  sudo -n pacman-key --lsign-key 74E5750C4A3C00F037070EF2357B525A97500B9F

  sudo -n cp -v -r -L --preserve=mode,timestamps --reflink=never "${XDG_CONFIG_HOME:-$HOME/.config}/yadm/system_alt/etc/makepkg.conf.d/." /etc/makepkg.conf.d
  sudo -n cp -v -L --preserve=mode,timestamps --reflink=never "${XDG_CONFIG_HOME:-$HOME/.config}/yadm/system_alt/etc/makepkg.conf" /etc/makepkg.conf
  sudo -n cp -v -L --preserve=mode,timestamps --reflink=never "${XDG_CONFIG_HOME:-$HOME/.config}/yadm/system_alt/etc/pacman.conf" /etc/pacman.conf
  sudo -n /usr/bin/find "${XDG_CONFIG_HOME:-$HOME/.config}/yadm/system_alt/etc/pacman.d" -type l -exec bash -c 'file={}; dest="$(dirname "${file##*system_alt}")"; mkdir -p "$dest"; cp -v -L --preserve=mode,timestamps --reflink=never "$file" "${dest}/${file##*/}"' \;

  if [[ ! -x "$(command -v yay)" ]]; then
    sudo -n pacman -Sy --noconfirm --needed yay
    yay -Y --gendb
    yay -Y --devel --save
  fi

  $UPDATE
}

minimal-bootstrap() {
  local pkgs=(
    7zip bat btop htop dnsutils duf dust eza fastfetch fd fontconfig fzf jq less lm_sensors man-db
    neovim pacman-contrib pkgfile ripgrep-all speedtest-cli tcpdump tldr trash-d udisks2
    usbutils wezterm-nightly-bin witr-bin xdg-user-dirs yazi zoxide zsh mise traceroute
  )
  local deps_pkgs=(
    chafa ffmpeg imagemagick graphicsmagick pandoc poppler mediainfo
    python-gobject resvg tesseract-data nss-mdns
  )
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
  
  sudo -v
  command rm -rf "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
  git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-completions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-completions"
  git clone https://github.com/Pilaton/OhMyZsh-full-autoupdate.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/ohmyzsh-full-autoupdate"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting"
  git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fzf-tab"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
  
  ya pkg install
  ln -sf "${XDG_CONFIG_HOME:-$HOME/.config}/yazi/plugins/lsblk-mount.yazi" "${XDG_CONFIG_HOME:-$HOME/.config}/yazi/plugins/mount.yazi"
  sudo -n fc-cache -fv
  fc-cache -fv
  bat cache --build
  xdg-user-dirs-update
  mise i
}

pacman-bootstrap() {
  return
}

ssd-bootstrap() {
  return
}

hdd-bootstrap() {
  local pkgs=(hdparm)
  $INSTALL "${pkgs[@]}"
}

btrfs-bootstrap() {
  local pkgs=(btrbk)
  local deps_pkgs=(udisks2-btrfs)
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

xfs-bootstrap() {
  return
}

zram-bootstrap() {
  return
}

dhcpcd-bootstrap() {
  return
}

samba-bootstrap() {
  return
}

server-bootstrap() {
  return
}

dev-bootstrap() {
  return
}

docker-bootstrap() {
  local pkgs=(docker-compose lazydocker docker-credential-secretservice)
  local deps_pkgs=(docker-buildx)
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
  if [[ -n "$(yadm config --get local.class btrfs)" ]]; then
    sudo -n mkdir -p /var/lib/docker/volumes
    sudo -n chattr +C /var/lib/docker/volumes
  fi
}

desktop-bootstrap() {
  local pkgs=(
    gparted onlyoffice-bin obsidian spotify firefox visual-studio-code-bin noto-fonts noto-fonts-cjk
    noto-fonts-emoji noto-fonts-extra ttf-cascadia-mono-nerd ttf-nerd-fonts-symbols
    ttf-nerd-fonts-symbols-mono ttf-noto-nerd ttc-monocraft-no-ligatures
    papirus-icon-theme mpv qbittorrent obs-studio teamspeak discord kdiskmark qdiskinfo
  )
  local deps_pkgs=(
    xorg-xhost gvfs gst-plugins-good gst-libav
  )
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

wayland-bootstrap() {
  local pkgs=(xwaylandvideobridge)
  local deps_pkgs=(wl-clipboard)
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

hyprland-bootstrap() {
  local pkgs=(
    hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
    xdg-desktop-portal-termfilechooser-hunkyburrito-git hyprpolkitagent
    hyprlauncher hypridle hyprqt6engine hyprpaper
  )
  local deps_pkgs=(gnome-keyring)
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

mobile-bootstrap() {
  local pkgs=(brightnessctl)
  $INSTALL "${pkgs[@]}"
}

ufw-bootstrap() {
  local ip_json addr_info_len addr_local addr_prefix_len
  local deps_pkgs=(ufw-extras)
  
  sudo -n cp -v -r -L --preserve=mode,timestamps --update=older --reflink=never "${XDG_CONFIG_HOME:-$HOME/.config}/yadm/system_alt/etc/ufw/." /etc/ufw
  
  sudo -n ufw --force reset
  sudo -n ufw default reject incoming
  sudo -n ufw default allow outgoing
  ip_json="$(ip -json addr)"
  for ifname in $(echo "$ip_json" | jq -r '.[].ifname'); do
    [[ "$ifname" =~ lo|docker[0-9]+ ]] && continue
    addr_info_len="$(echo "$ip_json" | jq -r --arg "ifname" "${ifname}" '.[] | select(.ifname == $ARGS.named.ifname).addr_info | length')"
    if [[ "$addr_info_len" -gt 0 ]]; then
      for ((i = 0; i < "$addr_info_len"; i++ )); do
        addr_local="$(echo "$ip_json" | jq -r --arg ifname "${ifname}" --argjson index "$i" '.[] | select(.ifname == $ARGS.named.ifname).addr_info[$index].local')"
        addr_prefix_len="$(echo "$ip_json" | jq -r --arg ifname "${ifname}" --argjson index "$i" '.[] | select(.ifname == $ARGS.named.ifname).addr_info[$index].prefixlen')"
        if [[ "$ifname" =~ eth[0-9]+|en.+ ]]; then
          if [[ -n "$(yadm config --get local.class server)" ]]; then
            sudo -n ufw limit in on "${ifname}" from any to any app SSH
          fi
          if [[ -n "$(yadm config --get local.class samba)" ]]; then
            sudo -n ufw allow in on "${ifname}" from "${addr_local}/${addr_prefix_len}" to any app CIFS
            sudo -n ufw allow in on "${ifname}" from "${addr_local}/${addr_prefix_len}" to any app wsdd
            sudo -n ufw allow in on "${ifname}" from "${addr_local}/${addr_prefix_len}" to any app Bonjour
          fi
        fi
        if [[ "$ifname" =~ wlan[0-9]+|wl.+ ]]; then
          echo
        fi
      done
    fi
  done
  if [[ -n "$(yadm config --get local.class docker)" ]]; then
    echo
  fi
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

gaming-bootstrap() {
  local pkgs=(steam mangohud faugus-launcher minecraft-launcher protonplus)
  local deps_pkgs=(ntsync-autoload lib32-pipewire-v4l2 lib32-pipewire-jack lib32-mangohud)
  if [[ -n "$(yadm config --get local.class desktop)" ]]; then
    deps_pkgs+=(lib32-nvidia-utils lib32-opencl-nvidia)
  fi
  $INSTALL "${pkgs[@]}"
  $INSTALL --asdeps "${deps_pkgs[@]}"
}

openrc-bootstrap() {
  git clone https://github.com/Wizarsy/PKGBUILDs /tmp/PKGBUILDs
  makepkg --noconfirm --needed -sr -D /tmp/PKGBUILDs/ananicy-cpp-git
  makepkg --noconfirm --needed -sr -D /tmp/PKGBUILDs/bpftune-git
  yay -U --noconfirm --asdeps /tmp/PKGBUILDs/ananicy-cpp-git/*.zst
  yay -U --noconfirm --asdeps /tmp/PKGBUILDs/bpftune-git/*.zst

  local pkgs=(ananicy-cpp-openrc fwupd-openrc openssh-openrc power-profiles-daemon-openrc ufw-openrc scx_loader-openrc dbus-openrc ssh-agent-openrc)
  local sys_services=(fwupd power-profiles-daemon ufw scx_loader dbus ananicy-cpp)
  local user_services=(ssh-agent dbus)
  if [[ -n "$(yadm config --get local.class desktop)" ]]; then
    mkdir -p "${HOME}/.config/rc/runlevels/graphical"
    rc-update -U -s default graphical
    rc-update -U add pipewire graphical
    rc-update -U add pipewire-pulse graphical
    rc-update -U add wireplumber graphical
  fi
  if [[ -n "$(yadm config --get local.class hyprland)" ]]; then
    pkgs+=(greetd-openrc)
    sys_services+=(greetd)
  fi
  if [[ -n "$(yadm config --get local.class docker)" ]]; then
    pkgs+=(docker-openrc)
    sys_services+=(docker)
  fi
  if [[ -n "$(yadm config --get local.class desktop)" ]]; then
    pkgs+=(scx_loader-openrc lact-openrc)
    sys_services+=(lact)
  fi
  if [[ -n "$(yadm config --get local.class nvidia)" ]]; then
    pkgs+=(nvidia-utils-openrc)
    sys_services+=(nvidia-persistenced)
  fi
  if [[ -n "$(yadm config --get local.class samba)" ]]; then
    pkgs+=(samba-openrc wsdd-openrc)
    sys_services+=(smb wsdd)
  fi
  if [[ -n "$(yadm config --get local.class server)" ]]; then
    sys_services+=(sshd.eth)
    sudo -n ln -sf /etc/init.d/sshd /etc/init.d/sshd.eth
    echo 'rc_need="!net net.eth*"' > /etc/conf.d/sshd.eth
  fi
  $INSTALL "${pkgs[@]}"
  sudo -n rc-update --update
  for srvc in "${sys_services[@]}"; do
    sudo -n rc-update add "${srvc%-*}" default
  done
  for srvc in "${user_services[@]}"; do
    rc-update -U add "${srvc%-*}" default
  done
}

sudo -v
prepare-bootstrap

while read -r class; do
  sudo -v
  "${class}"-bootstrap
  wait
done <<< "$(yadm config --get-all local.class)"
[[ "${SHELL##*/}" != "zsh" ]] && chsh -s "$(which zsh)"
$CLEAN
command rm -rf "$BUILDDIR" "$CARGO_HOME" "$GOPATH" "$AURDEST"
unset BUILDDIR CARGO_HOME GOPATH AURDEST