#!/bin/bash
DEVICE="prt0818:00-1da0:8004"
TOGGLE_FILE="/tmp/hypr_touch_toggle"

# Check current state and toggle
if [ ! -f "$TOGGLE_FILE" ] || grep -q "true" "$TOGGLE_FILE"; then
    # Disable via Lua evaluation
    hyprctl eval "hl.device({ name = '${DEVICE}', enabled = false })"
    echo "false" > "$TOGGLE_FILE"
    notify-send "Touchscreen" "Disabled" -t 2000
else
    # Enable via Lua evaluation
    hyprctl eval "hl.device({ name = '${DEVICE}', enabled = true })"
    echo "true" > "$TOGGLE_FILE"
    notify-send "Touchscreen" "Enabled" -t 2000
fi
