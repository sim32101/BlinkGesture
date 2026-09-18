#!/bin/bash

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
MODEL_PATH="$SCRIPT_DIR/shape_predictor_68_face_landmarks.dat"
MODEL_ARCHIVE="$MODEL_PATH.bz2"


# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python3 is not installed. Please install Python3."
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &>/dev/null; then
    echo "pip3 is not installed. Please install pip3."
    exit 1
fi

# Create a virtual environment if it doesn't exist
VENV_NAME="$SCRIPT_DIR/BlinkGestureVenV"
if [ ! -d "$VENV_NAME" ]; then
    python3 -m venv "$VENV_NAME"
    echo "Created virtual environment: $VENV_NAME."
else
    echo "Using existing virtual environment: $VENV_NAME."
fi

# Activate the virtual environment
source "$VENV_NAME/bin/activate"

# Check and install required Python packages
install_requirements() {
    if [ -f "$SCRIPT_DIR/requirements.txt" ]; then
        echo "Checking and installing required Python packages..."
        pip3 install -r "$SCRIPT_DIR/requirements.txt"
    else
        echo "requirements.txt not found."
        exit 1
    fi
}

# Install requirements if needed
install_requirements

# The landmark model is intentionally not stored in the repository because it
# is large. Fetch the model published by dlib once, then reuse the local copy.
if [ ! -s "$MODEL_PATH" ]; then
    if ! command -v curl &>/dev/null || ! command -v bzip2 &>/dev/null; then
        echo "curl and bzip2 are required to download the dlib landmark model."
        exit 1
    fi
    echo "Downloading dlib's 68-point face-landmark model (about 61 MB)..."
    curl --fail --location --retry 3 --output "$MODEL_ARCHIVE" \
        "https://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2" || exit 1
    bzip2 --decompress --keep --force "$MODEL_ARCHIVE" || exit 1
fi

# Run the Python script
python3 "$SCRIPT_DIR/main.py"

# Deactivate the virtual environment
deactivate

echo "app exit"
