#!/usr/bin/env bash

hooks_symlink() {
  shopt -s nullglob
  local SYMLINK_D="$YADM_HOOK_DATA/symlink.d"
  local -a home_d sym_d
  
  if [[ ! -e "$YADM_HOOK_DIR/symlink" ]]; then
    return 0
  fi

  if [[ ! -d "$SYMLINK_D" ]]; then
    echo "Error: symlink directory '$SYMLINK_D' not found" >&2
    return 1
  fi

  while IFS= read -r symlink; do
    home_d=("$HOME/$symlink"/*)
    sym_d=("$SYMLINK_D/$symlink"/*)
    if [[ -d "$HOME/$symlink" ]]; then
      if [[ ! -d "$SYMLINK_D/$symlink" ]]; then
        mkdir -p "$SYMLINK_D/$symlink"
      fi
    fi
    echo "${home_d[@]}" "${sym_d[@]}"
    # cp -v -r --preserve=all --update=older --strip-trailing-slashes "${home_d[@]}" "$SYMLINK_D/$symlink"
    # cp -v -r --preserve=all --update=older --strip-trailing-slashes "${sym_d[@]}" "$HOME/$symlink"
    # if [[ "$(</proc/version)" =~ [Mm]icrosoft ]]; then
    #   touch -c -m -d "$(date +'%F %T %z')" "${home_d[@]}" "${sym_d[@]}"
    # fi
    #   for file in "$HOME/$symlink"/*; do
    #     stats=$((stat --printf="%Y\n" "$HOME/$symlink/$file" "$SYMLINK_D/$symlink/$file"))
    #     if [[ "${stats[0]}" -gt "${stats[1]}" ]]; then
    #       cpfrom+=("$file")
    #     else
    #       cpto+=("$file")
    #     fi
    #   done
    # cp -v -r --preserve=all --update=older --strip-trailing-slashes "$HOME/$symlink" "$SYMLINK_D/$symlink"
    # cp -v -r --preserve=all --update=older --strip-trailing-slashes "$SYMLINK_D/$symlink" "$HOME/$symlink"
    # if [[ "$(</proc/version)" =~ [Mm]icrosoft ]]; then
    #   touch -c -m -d "$(date +'%F %T %z')" "$HOME/$symlink" "$SYMLINK_D/$symlink"
    # fi
  done < "$YADM_HOOK_DIR/symlink"
  shopt -u nullglob
}