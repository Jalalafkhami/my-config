#!/bin/bash

SESSION=${1}
USER="jalal.afkhami"
host=$2
controller=$3

SERVERS_FILE="$HOME/.config/auto/${host}"
CONTROLLERS_FILE="$HOME/.config/auto/${controller}"

# ========== Check files ==========
if [[ ! -f $SERVERS_FILE ]]; then
    echo "❌ File not found: $SERVERS_FILE"
    exit 1
fi

if [[ ! -f $CONTROLLERS_FILE ]]; then
    echo "❌ File not found: $CONTROLLERS_FILE"
    exit 1
fi

mapfile -t SERVERS < "$SERVERS_FILE"
mapfile -t CONTROLLERS < "$CONTROLLERS_FILE"

if [[ ${#SERVERS[@]} -eq 0 ]]; then
    echo "❌ No servers found in $SERVERS_FILE"
    exit 1
fi

if [[ ${#CONTROLLERS[@]} -eq 0 ]]; then
    echo "❌ No controllers found in $CONTROLLERS_FILE"
    exit 1
fi

echo "📊 Found ${#SERVERS[@]} servers and ${#CONTROLLERS[@]} controllers"

# ========== Create tmux session ==========
tmux new-session -d -s "$SESSION" -n "servers"

# ========== Window 0: Servers ==========
# First server in pane 0
tmux send-keys -t "$SESSION:0.0" "ssh $USER@${SERVERS[0]}" C-m

# Create remaining server panes dynamically
for ((i=1; i<${#SERVERS[@]}; i++)); do
    if [[ $i -eq 1 ]]; then
        # Split horizontally for second server
        tmux split-window -h -t "$SESSION:0.0"
    else
        # Split vertically for remaining servers
        tmux split-window -v -t "$SESSION:0"
    fi
    tmux send-keys -t "$SESSION:0" "ssh $USER@${SERVERS[$i]}" C-m
done

# Arrange servers layout
tmux select-layout -t "$SESSION:0" tiled

# ========== Window 1: Controllers ==========
tmux new-window -t "$SESSION:1" -n "controllers"

# First controller in pane 0
tmux send-keys -t "$SESSION:1.0" "ssh $USER@${CONTROLLERS[0]}" C-m

# Create remaining controller panes dynamically
for ((i=1; i<${#CONTROLLERS[@]}; i++)); do
    if [[ $i -eq 1 ]]; then
        # Split horizontally for second controller
        tmux split-window -h -t "$SESSION:1.0"
    else
        # Split vertically for remaining controllers
        tmux split-window -v -t "$SESSION:1"
    fi
    tmux send-keys -t "$SESSION:1" "ssh $USER@${CONTROLLERS[$i]}" C-m
done

# Arrange controllers layout
if [[ ${#CONTROLLERS[@]} -le 2 ]]; then
    tmux select-layout -t "$SESSION:1" even-horizontal
else
    tmux select-layout -t "$SESSION:1" tiled
fi

# ========== Attach to session ==========
tmux attach -t "$SESSION:0"
