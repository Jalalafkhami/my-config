#!/bin/bash

choice=$(echo -e "SSH to storage nodes\nExit" | rofi -dmenu -p "Select action:")

if [[ "$choice" == "SSH to storage nodes" ]]; then
   ~/.config/auto/ssh_multi.sh
fi

