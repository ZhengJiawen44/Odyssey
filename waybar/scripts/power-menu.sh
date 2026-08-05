#!/bin/sh
# Wofi power menu for Sway

choice=$(printf '%s\n' \
  "Sleep" \
  "Restart" \
  "Power off" \
  "Log out" |
  wofi --dmenu --hide-search --prompt "Power" --width 280 --lines 4 \
    --style ~/.config/wofi/power-menu.css)

case "$choice" in
  "Sleep")
    systemctl suspend
    ;;
  "Restart")
    systemctl reboot
    ;;
  "Power off")
    systemctl poweroff
    ;;
  "Log out")
    swaymsg exit
    ;;
esac
