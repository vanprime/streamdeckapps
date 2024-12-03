#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Find the first .applescript file in the script directory
SCRIPT_NAME=$(find "$SCRIPT_DIR" -maxdepth 1 -name "*.applescript" -print -quit)

# Check if an .applescript file was found
if [ -z "$SCRIPT_NAME" ]; then
    echo "Error: No .applescript file found in $SCRIPT_DIR"
    exit 1
fi

# Run the found .applescript file using osascript
osascript "$SCRIPT_NAME"
