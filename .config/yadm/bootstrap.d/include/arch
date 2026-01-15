INSTALLC="yay -S --noconfirm"
SYNCC="yay -Sy"
UPC="yay -Syu --noconfirm"
CLEANC="yay -Yc --noconfirm"
pkgs=(zsh jq fastfetch bat btop fd eza zoxide fzf ripgrep-all graphicsmagick pandoc poppler tesseract dust asdf-vm pkgfile openssh cronie ffmpeg imagemagick nvim wezterm)

init() {
  sudo -v || exit 1
  sudo -v pacman -Sy
  sudo -v pacman -S --noconfirm curl git man-db base-devel ca-certificates
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  makepkg -si -D /tmp/yay
  yay -Y --gendb
  yay -Y --devel --save

  "$UPC"
  "$CLEANC"
}

yazi() {
  "$INSTALLC" 7zip chafa resvg yazi
  ya pkg add yazi-rs/plugins:chmod
  ya pkg add yazi-rs/plugins:git
  ya pkg add yazi-rs/plugins:mount
  ya pkg add AnirudhG07/plugins-yazi:copy-file-contents
}

docker() {
  "$INSTALLC" docker docker-buildx docker-compose lazydocker
  sudo -v systemctl enable docker
}