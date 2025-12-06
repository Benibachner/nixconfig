#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

MONITOR="eDP-1"

STATUS=$(hyprctl monitors | grep "$MONITOR")

# if echo "$STATUS" | grep -q "enabled"; then
if hyprctl monitors | grep "$MONITOR"; then
  echo disabling
  hyprctl keyword monitor "$MONITOR, disable"
else
  echo enabling
  hyprctl keyword monitor "$MONITOR, preferred, auto, 1.25"
fi
