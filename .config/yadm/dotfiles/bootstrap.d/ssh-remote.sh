#!/usr/bin/env bash

if [[ $(dotfiles remote get-url origin) =~ ^https ]]; then
  echo "Updating the yadm repo origin URL"
  dotfiles remote set-url origin "git@github.com:Wizarsy/dotfiles.git"
fi
