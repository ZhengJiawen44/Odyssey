#!/bin/sh
current=$(powerprofilesctl get 2>/dev/null)
choice=$(
  printf '%s\n' performance balanced power-saver |
  while read -r p; do
    if [ "$p" = "$current" ]; then
      printf '> %s\n' "$p"
    else
      printf '  %s\n' "$p"
    fi
  done |
  wofi --dmenu --hide-search --prompt "Power profile" --width 280 --lines 3 \
    --style ~/.config/wofi/power-menu.css
)
[ -z "$choice" ] && exit 0

# Strip marker/spaces so "  power-saver" / "> balanced" become a clean name
profile=$(printf '%s' "$choice" | sed 's/^[^A-Za-z0-9]*//')
[ -z "$profile" ] && exit 0

if powerprofilesctl set "$profile"; then
  notify-send -t 1500 "Power profile" "$profile"
else
  notify-send -t 2500 "Power profile" "Failed to set $profile"
fi
