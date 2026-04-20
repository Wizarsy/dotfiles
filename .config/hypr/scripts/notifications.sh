#!/usr/bin/env bash

amount="$(jq -r '.notifications | length' $HOME/.local/state/astal/notifd/notifications.json)"

case $amount in
  0)
    echo "<span foreground='#$textAlpha' size='32pt'>󰂚</span> <span foreground='#$accentAlpha' size='16pt'>$amount</span>"
    ;;
  *)
    echo "<span size='32pt'>󱅫</span> <span size='16pt'>$amount</span>"
    ;;
esac