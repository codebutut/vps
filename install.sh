#!/bin/bash
set -e

echo "----------------------------------------------------------------"
echo "Starting Codespace Desktop Environment Installation..."
echo "----------------------------------------------------------------"

# 1. Update and Install System Dependencies
# xfce4: The Desktop Environment
# xfce4-goodies: Terminal, settings managers, etc.
# xvfb: 'Fake' screen (X Virtual Framebuffer)
# x11vnc: VNC Server to broadcast the fake screen
echo "Installing XFCE4, Xvfb, and VNC tools..."
sudo apt update
sudo apt install -y xfce4 xfce4-goodies xvfb x11vnc net-tools python3-numpy dbus-x11 firefox

# 2. Install noVNC (The HTML5 VNC Client)
# We clone specifically to /opt/novnc to keep it organized
if [ ! -d "/opt/novnc" ]; then
    echo "Cloning noVNC..."
    sudo git clone https://github.com/novnc/noVNC /opt/novnc
    # Clone websockify (the bridge between browser and VNC)
    sudo git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify
else
    echo "noVNC already installed. Skipping..."
fi

# 3. Fix permissions
sudo chmod -R 755 /opt/novnc

echo "----------------------------------------------------------------"
echo "Installation Complete!"
echo "Run ./start.sh to launch your desktop."
echo "----------------------------------------------------------------"
