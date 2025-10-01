#!/usr/bin/env bash
# lock_on_input.sh - libinput version
set -u

# Configuration
LOCK_CMD="${HOME}/.config/scripts/lock"
MOUSE_THRESHOLD=50

CHILD_PIDS=()

cleanup() {
    for pid in "${CHILD_PIDS[@]:-}"; do
        kill "$pid" >/dev/null 2>&1 || true
    done
}
trap cleanup EXIT INT TERM

do_lock() {
    echo "[*] Trigger detected -> locking..."
    if [ -x "$LOCK_CMD" ]; then
        "$LOCK_CMD" &
    else
        xdg-screensaver lock &
    fi
    exit 0
}

# Check libinput
if ! command -v libinput-debug-events >/dev/null 2>&1; then
    echo "Error: libinput-debug-events not found. Install libinput-tools." >&2
    exit 1
fi

# Monitor all input events
libinput-debug-events | while read -r line; do
    if echo "$line" | grep -Eiq "(key|button).*press"; then
        do_lock
    fi
done &

CHILD_PIDS+=($!)

# Mouse movement monitor (xdotool)
eval "$(xdotool getmouselocation --shell 2>/dev/null || echo 'X=0;Y=0')"
LAST_X=$X
LAST_Y=$Y

(
    while :; do
        eval "$(xdotool getmouselocation --shell 2>/dev/null || echo 'X=0;Y=0')"
        DX=$(( X - LAST_X ))
        DY=$(( Y - LAST_Y ))
        [ $DX -lt 0 ] && DX=$(( -DX ))
        [ $DY -lt 0 ] && DY=$(( -DY ))

        if [ "$DX" -ge "$MOUSE_THRESHOLD" ] || [ "$DY" -ge "$MOUSE_THRESHOLD" ]; then
            do_lock
        fi

        LAST_X=$X
        LAST_Y=$Y
        sleep 0.05
    done
) &
CHILD_PIDS+=($!)

wait
