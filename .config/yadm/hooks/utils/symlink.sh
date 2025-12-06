#!/usr/bin/env bash

hooks_symlink() {
  local SYMLINK_D="$YADM_HOOK_DATA/symlink.d"
  local -a cpto cpfrom
  
  if [[ ! -e "$YADM_HOOK_DIR/symlink" ]]; then
    return 0
  fi

  if [[ ! -d "$SYMLINK_D" ]]; then
    echo "Error: symlink directory '$SYMLINK_D' not found" >&2
    return 1
  fi

  while IFS= read -r symlink; do
    if [[ -d "$HOME/$symlink" && ! -d "$SYMLINK_D/$symlink" ]]; then
      mkdir -p "$SYMLINK_D/$symlink"
    cp -v -r --update=older --strip-trailing-slashes --remove-destination "$HOME/$symlink"/* "$SYMLINK_D/$symlink"
    cp -v -r --update=older --strip-trailing-slashes --remove-destination "$SYMLINK_D/$symlink"/* "$HOME/$symlink"

    #   for file in "$HOME/$symlink"/*; do
    #     if [[ -e "$SYMLINK_D/$file" && $(stat --print="%Y" "$SYMLINK_D/$file") -gt $(stat --print="%Y" "$HOME/$symlink/$file") ]]; then
    #       cp 
    #       cpfrom+=("$file")
    #     else
    #       cpto+=("$file")
    #     fi
    #   done
    fi
  done < "$YADM_HOOK_DIR/symlink"
}

# cp -v -r --update=older .config/wezterm/* .local/share/yadm/symlink.d/.config/wezterm
# cp -v -r --update=older .local/share/yadm/symlink.d/.config/wezterm/* .config/wezterm
