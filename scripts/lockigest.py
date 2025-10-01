#!/usr/bin/env python3
import os
import sys
import subprocess
import time
import threading
from pynput import mouse, keyboard

# Configuration
LOCK_CMD = os.path.expanduser("~/.config/scripts/lock")
MOUSE_THRESHOLD = 50

def do_lock():
    print("[*] Trigger detected -> locking...")
    try:
        if os.path.exists(LOCK_CMD) and os.access(LOCK_CMD, os.X_OK):
            subprocess.Popen([LOCK_CMD])
        else:
            subprocess.Popen(["xdg-screensaver", "lock"])
    except:
        subprocess.Popen(["xdotool", "key", "--clearmodifiers", "Ctrl+Alt+l"])
    sys.exit(0)

# Mouse movement tracking
last_x, last_y = 0, 0
mouse_moved = False

def on_move(x, y):
    global last_x, last_y, mouse_moved
    dx = abs(x - last_x)
    dy = abs(y - last_y)
    if dx >= MOUSE_THRESHOLD or dy >= MOUSE_THRESHOLD:
        mouse_moved = True
        do_lock()
    last_x, last_y = x, y

def on_click(x, y, button, pressed):
    if pressed:
        print(f"[*] Mouse clicked at ({x},{y})")
        do_lock()

def on_press(key):
    print(f"[*] Key pressed: {key}")
    do_lock()

def start_mouse_listener():
    with mouse.Listener(on_move=on_move, on_click=on_click) as listener:
        listener.join()

def start_keyboard_listener():
    with keyboard.Listener(on_press=on_press) as listener:
        listener.join()

if __name__ == "__main__":
    print("[*] Starting input monitoring...")
    
    # Start mouse listener in a thread
    mouse_thread = threading.Thread(target=start_mouse_listener, daemon=True)
    mouse_thread.start()
    
    # Start keyboard listener
    start_keyboard_listener()
