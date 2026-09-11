#!/usr/bin/env bash

update_screens() {
    local count
    count=$(hyprctl monitors all | grep -c "HDMI-A")

    if [ "$count" -ge 1 ]; then
        # Docked: Create state file
        touch /tmp/hypr_docked
    else
        # Switched away: Remove state file
        rm -f /tmp/hypr_docked
    fi
    
    # Let Lua rebuild the layout natively based on the file
    sleep 0.2
    hyprctl reload
}

# Run once at startup
update_screens

if ! command -v socat &>/dev/null; then
    echo "socat not found. Run: sudo pacman -S socat" >&2
    exit 1
fi

# Listen for KVM hotplug events
socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    case "$line" in
        monitoradded*|monitorremoved*)
            update_screens
            ;;
    esac
done
