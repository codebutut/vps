import time
import sys
import random
from datetime import datetime

# Configuration
INTERVAL = 20  # Seconds between activities
MODE = "log"   # Options: "log", "scroll_ansi"

def get_timestamp():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def log_mode():
    """
    Simulates a running process by printing 'fake' system logs.
    This forces the terminal to scroll down, keeping the session active
    through data transfer.
    """
    messages = [
        "Heartbeat signal sent... OK",
        "Checking session stability... STABLE",
        "Refreshing connection buffers... DONE",
        "Allocating virtual memory block... SUCCESS",
        "Garbage collection cycle... COMPLETED",
        "Syncing with remote host... SYNCHRONIZED"
    ]
    
    msg = random.choice(messages)
    # The \n at the end forces a new line (scrolling)
    print(f"[{get_timestamp()}] [SYSTEM] {msg}")
    
    # We flush stdout to ensure the output is sent immediately 
    # and not held in Python's buffer.
    sys.stdout.flush()

def ansi_scroll_mode():
    """
    Uses ANSI escape codes to force the terminal viewport to scroll 
    without necessarily printing new lines of text.
    \033[S = Scroll Up
    \033[T = Scroll Down
    """
    print(f"[{get_timestamp()}] Activity Tick...", end='')
    sys.stdout.flush()
    
    # Simulate rapid scrolling
    for _ in range(5):
        sys.stdout.write("\033[S") # Scroll up
        sys.stdout.flush()
        time.sleep(0.1)
        sys.stdout.write("\033[T") # Scroll down
        sys.stdout.flush()
        time.sleep(0.1)
    
    print(" Done.")

def run_keeper():
    print(f"--- Headless Keep-Alive Started ({MODE} mode) ---")
    print(f"Interval: {INTERVAL} seconds")
    print("Press Ctrl+C to stop.")
    
    try:
        while True:
            if MODE == "scroll_ansi":
                ansi_scroll_mode()
            else:
                log_mode()
                
            time.sleep(INTERVAL)
            
    except KeyboardInterrupt:
        print("\n\n--- Session Ended by User ---")

if __name__ == "__main__":
    run_keeper()