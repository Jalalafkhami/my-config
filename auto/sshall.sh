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

if [[ ${#SERVERS[@]} -lt 5 ]]; then
    echo "❌ Need at least 5 servers in $SERVERS_FILE"
    exit 1
fi

if [[ ${#CONTROLLERS[@]} -lt 2 ]]; then
    echo "❌ Need at least 2 controllers in $CONTROLLERS_FILE"
    exit 1
fi

# ========== Create tmux session ==========
tmux new-session -d -s "$SESSION" -n "servers"

# -------- پنجره 0: servers.txt --------
# First ssh
tmux send-keys -t "$SESSION:0.0" "ssh $USER@${SERVERS[0]}" C-m

# Create 4 more panes with ssh
PANE1=$(tmux split-window -h -t "$SESSION:0.0" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:0.$PANE1" "ssh $USER@${SERVERS[1]}" C-m

PANE2=$(tmux split-window -v -t "$SESSION:0.0" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:0.$PANE2" "ssh $USER@${SERVERS[2]}" C-m

PANE3=$(tmux split-window -v -t "$SESSION:0.$PANE1" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:0.$PANE3" "ssh $USER@${SERVERS[3]}" C-m

PANE4=$(tmux split-window -v -t "$SESSION:0.$PANE2" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:0.$PANE4" "ssh $USER@${SERVERS[4]}" C-m

# Layout tidy
tmux select-layout -t "$SESSION:0" tiled

# -------- پنجره 1: controller.txt --------
tmux new-window -t "$SESSION:1" -n "controllers"

# First controller ssh
tmux send-keys -t "$SESSION:1.0" "ssh $USER@${CONTROLLERS[0]}" C-m

# Split for second controller
PANE1_CTRL=$(tmux split-window -h -t "$SESSION:1.0" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:1.$PANE1_CTRL" "ssh $USER@${CONTROLLERS[1]}" C-m

# Optional: arrange layout
tmux select-layout -t "$SESSION:1" even-horizontal

# ========== Attach to session ==========
tmux attach -t "$SESSION:0"

