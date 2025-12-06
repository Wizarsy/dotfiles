#!/usr/bin/env bash

hooks_symlink() {
  local SYMLINK_D="$YADM_HOOK_DATA/symlink.d"
  local -a cpto cpfrom stats
  
  if [[ ! -e "$YADM_HOOK_DIR/symlink" ]]; then
    return 0
  fi

  if [[ ! -d "$SYMLINK_D" ]]; then
    echo "Error: symlink directory '$SYMLINK_D' not found" >&2
    return 1
  fi

  while IFS= read -r symlink; do
    if [[ -d "$HOME/$symlink" ]]; then
      if [[ ! -d "$SYMLINK_D/$symlink" ]]; then
        mkdir -p "$SYMLINK_D/$symlink"
      fi
    cp -v -r --preserve=all --update=older --strip-trailing-slashes "$HOME/$symlink"/* "$SYMLINK_D/$symlink"
    cp -v -r --preserve=all --update=older --strip-trailing-slashes "$SYMLINK_D/$symlink"/* "$HOME/$symlink"
    touch --no-create "$HOME/$symlink"/* "$SYMLINK_D/$symlink"/*
    #   for file in "$HOME/$symlink"/*; do
    #     stats=$((stat --printf="%Y\n" "$HOME/$symlink/$file" "$SYMLINK_D/$symlink/$file"))
    #     if [[ "${stats[0]}" -gt "${stats[1]}" ]]; then
    #       cpfrom+=("$file")
    #     else
    #       cpto+=("$file")
    #     fi
    #   done
    fi
  done < "$YADM_HOOK_DIR/symlink"
}

      # cp -v -r --preserve=all --update=older --strip-trailing-slashes "$HOME/$symlink"/* "$SYMLINK_D/$symlink"
      # cp -v -r --preserve=all --update=older --strip-trailing-slashes "$SYMLINK_D/$symlink"/* "$HOME/$symlink"