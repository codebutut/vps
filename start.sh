#!/bin/bash

# Configuration
export DISPLAY=:1
export RESOLUTION=1280x720
export COLORD=24

echo "--- Stopping any previous sessions ---"
pkill -f Xvfb
pkill -f x11vnc
pkill -f startxfce4
pkill -f novnc_proxy

echo "--- Starting Virtual Display (Xvfb) ---"
# Starts a fake screen in memory
nohup Xvfb :1 -screen 0 ${RESOLUTION}x${COLORD} > /dev/null 2>&1 &
sleep 2

echo "--- Starting Window Manager (XFCE) ---"
# Starts the desktop interface
nohup dbus-launch startxfce4 > /dev/null 2>&1 &
sleep 2

echo "--- Starting VNC Server ---"
# -nopw: No password required (Access is secured by GitHub Codespaces auth)
# -forever: Keeps running even if you refresh the browser
nohup x11vnc -display :1 -nopw -listen localhost -xkb -ncache 10 -ncache_cr -forever > /dev/null 2>&1 &
sleep 2

echo "--- Starting noVNC (Web Interface) ---"
# Proxies the VNC signal to the browser on port 6080
/opt/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080