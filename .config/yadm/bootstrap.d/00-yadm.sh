#!/usr/bin/env bash

echo "Updating the yadm repo origin URL"
yadm remote set-url origin "git@github.com:Wizarsy/dotfiles.git"

echo "Configuring git"
yadm gitconfig pull.rebase false
