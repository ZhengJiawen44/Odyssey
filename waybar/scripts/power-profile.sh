#!/bin/sh
current=$(powerprofilesctl get 2>/dev/null)
choice=$(
  printf '%s\n' performance balanced power-saver |
  while read -r p; do
    if [ "$p" = "$current" ]; then
      printf '> %s\n' "$p"
    else
      printf '   %s\n' "$p"
    fi
  done |
  wofi --dmenu --prompt "Power profile" --width 280 --lines 3
)
[ -z "$choice" ] && exit 0
profile=${choice#* }
powerprofilesctl set "$profile"
notify-send -t 1500 "Power profile" "$profile"
