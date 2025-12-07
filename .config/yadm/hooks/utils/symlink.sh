#!/usr/bin/env bash

hooks_symlink() {
  shopt -s nullglob
  local SYMLINK_D="$YADM_HOOK_DATA/symlink.d"
  local -a home_array symlink_array entries_array
  entries_array=("${SYMLINK_D##*/}")
  if [[ ! -e "$YADM_HOOK_DIR/symlink" ]]; then
    return 0
  fi

  if [[ ! -d "$SYMLINK_D" ]]; then
    echo "Error: symlink directory '$SYMLINK_D' not found" >&2
    return 1
  fi

  while IFS= read -r symlink; do
    entries_array+=("${symlink}")
    if [[ -d "$HOME/$symlink" ]]; then
      if [[ ! -d "$SYMLINK_D/$symlink" ]]; then
        mkdir -p "$SYMLINK_D/$symlink"
      fi
      home_array=("$HOME/$symlink"/*)
      symlink_array=("$SYMLINK_D/$symlink"/*)
    else
      home_array=("$HOME/$symlink")
      symlink_array=("$SYMLINK_D/$symlink")
    fi
    # echo "${home_array[@]}" "${symlink_array[@]}"
    cp -v -r --preserve=all --update=older --strip-trailing-slashes "${home_array[@]}" "$SYMLINK_D/$symlink"
    cp -v -r --preserve=all --update=older --strip-trailing-slashes "${symlink_array[@]}" "$HOME/$symlink"
    if [[ "$(</proc/version)" =~ [Mm]icrosoft ]]; then
      touch -c -m -d "$(date +'%F %T %z')" "${home_array[@]}" "${symlink_array[@]}"
    fi
  done < "$YADM_HOOK_DIR/symlink"
  shopt -u nullglob
  # echo "${entries_array[1]}" "$SYMLINK_D"
  find "$SYMLINK_D" $(printf "! -wholename '%s/**/*' " "${entries_array[@]}")
}

    # fi
    #   for file in "$HOME/$symlink"/*; do
    #     stats=$((stat --printf="%Y\n" "$HOME/$symlink/$file" "$SYMLINK_D/$symlink/$file"))
    #     if [[ "${stats[0]}" -gt "${stats[1]}" ]]; then
    #       cpfrom+=("$file")
    #     else
    #       cpto+=("$file")
    #     fi
    #   done