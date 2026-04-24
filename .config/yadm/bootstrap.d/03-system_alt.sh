#!/usr/bin/env bash

case $(readlink -f /sbin/init) in
  *systemd*) yadm config --add local.class systemd;;
  *openrc*) yadm config --add local.class openrc;;
  *);;
esac

! command find /sys/class/power_supply/BAT* -quit &> /dev/null || yadm config --add local.class mobile
! command pacman -V &> /dev/null || yadm config --add local.class pacman

yadm alt