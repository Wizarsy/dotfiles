#!/usr/bin/env bash

if [[ $(yadm remote get-url origin) =~ ^https ]]; then
  echo "Updating the yadm repo origin URL"
  yadm remote set-url origin "git@github.com:Wizarsy/dotfiles.git"
fi
