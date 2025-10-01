#!/bin/bash

SESSION="controller-ssh"
USER="jalal.afkhami"
SERVER_FILE="$HOME/.config/auto/controller.txt"

# Check if file exists
if [[ ! -f $SERVER_FILE ]]; then
    echo "❌ File $SERVER_FILE not found."
    exit 1
fi

# Read servers into array
mapfile -t SERVERS < "$SERVER_FILE"

if [[ ${#SERVERS[@]} -lt 2 ]]; then
    echo "❌ Need exactly 2 servers in $SERVER_FILE"
    exit 1
fi

# Start session with first pane and connect
tmux new-session -d -s "$SESSION" -n "controllers"
tmux send-keys -t "$SESSION:0.0" "ssh $USER@${SERVERS[0]}" C-m

# Split and get new pane index
PANE1=$(tmux split-window -h -t "$SESSION:0.0" -P -F "#{pane_index}")
tmux send-keys -t "$SESSION:0.$PANE1" "ssh $USER@${SERVERS[1]}" C-m

# Optional: use even-horizontal layout
tmux select-layout -t "$SESSION:0" even-horizontal

# Attach to the session
tmux attach -t "$SESSION"

