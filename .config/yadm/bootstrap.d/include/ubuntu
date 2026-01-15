INSTALLC="sudo -v nala install -y"
SYNCC="sudo -v nala update"
UPC="sudo -v nala uprgrade -y"
CLEANC="sudo -v nala autopurge -y"
pkgs=(zsh jq fastfetch bat btop fd-find eza zoxide fzf ripgrep graphicsmagick pandoc poppler-utils tesseract-ocr du-dust openssh-client cron ffmpeg imagemagick nvim)
ppas=(ppa:zhangsongcui3371/fastfetch)

init() {
  sudo -v || exit 1
  sudo -v apt update
  sudo -v apt install -y curl git man-db build-essential ca-certificates
  curl https://gitlab.com/volian/volian-archive/-/raw/main/install-nala.sh | bash
  if [[ $? != 0 ]]; then
    sudo -v apt install -t nala nala
  fi
  
  for ppa in "${ppas[@]}"; do
    sudo -v add-apt-repository "$ppa"
  done

  "$SYNCC"
  "$UPC"
  "$CLEANC"
}

yazi() {
  "$INSTALLC" 7zip chafa poppler-utils resvg yazi
  ya pkg add yazi-rs/plugins:chmod
  ya pkg add yazi-rs/plugins:git
  ya pkg add yazi-rs/plugins:mount
  ya pkg add AnirudhG07/plugins-yazi:copy-file-contents
}

docker() {
  sudo -v install -m 0755 -d /etc/apt/keyrings
  sudo -v curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo -v chmod a+r /etc/apt/keyrings/docker.asc

sudo -v tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF

  "$SYNCC"
  "$INSTALLC" docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
  DIR=/opt; curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
  sudo -v systemctl enable docker
}