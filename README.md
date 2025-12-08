# VPS Desktop Environment


This project provides an accessible desktop environment, designed to be run in a `containerized environment` GitHub Codespaces.


## How It Works


The setup consists of several components working together:


- **`Desktop Environment (XFCE)`:** A lightweight and stable desktop interface.


- **`Virtual Display (Xvfb)`:** Creates a `"virtual"` screen in memory, so no physical monitor is needed.


- **`VNC Server (x11vnc)`:** Broadcasts the virtual screen's content.


- **`Web Client (noVNC)`:** A modern `HTML5` client that allows you to access the VNC session directly from your browser.


## Files


- **`devcontainer.json`:** Configures the development container. It automatically forwards port `6080` for the `web-based GUI` and runs the `install.sh` script upon creation.


- **`install.sh`:** A setup script that installs all the necessary software:


    - `xfce4` and `xfce4-goodies` for the desktop environment.


    - `xvfb` for the virtual display.


    - `x11vnc` for the VNC server.


    - `noVNC` for the web-based VNC client.


- **`start.sh`:** This script starts all the services in the correct order:


    1. It starts the virtual display (Xvfb).


    2. It launches the XFCE desktop environment.


    3. It starts the VNC server to share the desktop.


    4. It starts the noVNC proxy, making the desktop accessible on port `6080`.


- **`terminal_keep_live.py`:** A utility script to prevent the terminal from disconnecting due to inactivity. It periodically prints output to the console to keep the session alive.


## How to Use


1.  - **Launch the Environment:** Run `install.sh` script will run on its own.
    ```bash
    ./install.sh
    ```

    - **Start the Desktop:** Once the environment is ready, run the `start.sh` script:
    ```bash
    ./start.sh
    ```

2. **Access the GUI:** A port forwarding notification should appear for port `6080`. Open this port in your browser to access the desktop GUI.


3.  **Keep Terminal Alive (Optional):** If you need to keep a terminal session active for a long period, you can run the keep-alive script:
    ```bash
    python3 terminal_keep_live.py
    ```
