# BlinkGesture
## Blink twice to send Keyboard Shortcuts / Double blink Gesture

This program detects double blinks and triggers customizable keyboard shortcuts. 
It uses the Eye Aspect Ratio (EAR) to accurately detect closed eyes and thus Blinks. 

### Press 'Start' 'Show Plot and Frame' to view eye landmarks and an EAR plot. 
Press 'Stop' to close these windows.
Adjust the consecutive frames for more precise double blink detection.
Customize keyboard shortcuts and choose actions that suit your needs. Ex: alt+tab, ctrl+win+right arrow, or just space if you're too lazy to pause the video like me 

### The App NO LONGER! only recogonizes the **Default Camera** of your Device


## Installation and Running

### Downloading the Application
1. Go to the [GitHub releases page](https://github.com/allanhanan/BlinkGesture/releases).
2. Download the latest release zip file.
3. Extract the contents.

### Running the Application
1. Navigate to the extracted folder.
2. Double-click on `BlinkGesture.exe` to run the application.

On Linux, run `bash run_app.sh`. The first run downloads and extracts dlib's
68-point landmark model (about 61 MB) from dlib.net; subsequent runs reuse it.
The model's dataset license excludes commercial use.
Camera detection on Linux uses OpenCV directly; `v4l2-ctl` / `v4l-utils` is not
required.

### Fedora KDE Plasma (Wayland)
Wayland blocks the X11 input simulation used by `pyautogui`. On Wayland the app
uses `ydotool`, which sends the configured shortcut through a virtual keyboard.
Install and start its daemon once:

```bash
sudo dnf install ydotool
sudo systemctl enable --now ydotool
```

The GUI shows `Tastatur-Backend: ydotool` when Wayland was detected. Supported
shortcut examples include `alt+tab`, `ctrl+win+right`, `space`, and `f1` through
`f12`. If sending a shortcut fails, the status line contains the exact error.
The X11-only tray icon is disabled on Wayland; closing the main window exits the
application cleanly instead of minimizing it to the tray.

Fedora's ydotool service can expose its socket in different locations depending
on the package version. The application detects the standard Fedora and user
socket locations automatically.

### Additional Configuration
- You can customize the settings, including EAR Threshold and consecutive frames, directly from the GUI.
- The settings are saved automatically, so you don't need to reconfigure them every time you run the application.
