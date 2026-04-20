#!/usr/bin/env bash

case "$(hyprctl -j getoption general:layout | jq  -r .str)" in
  dwindle)
    hyprctl dispatch pseudo
    ;;
  master)
    hyprctl dispatch layoutmsg swapwithmaster master
    ;;
esac
