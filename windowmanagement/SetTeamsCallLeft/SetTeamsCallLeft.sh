#!/bin/bash

# Get the directory of the current script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Get the base directory name
BASE_NAME=$(basename "$SCRIPT_DIR")

# Find the matching .applescript file
SCRIPT_NAME=$(find "$SCRIPT_DIR" -maxdepth 1 -name "${BASE_NAME}.applescript" -print -quit)

# Check if an .applescript file was found
if [ -z "$SCRIPT_NAME" ]; then
    echo "Error: No .applescript file found in $SCRIPT_DIR"
    exit 1
fi

# Run the found .applescript file using osascript
osascript "$SCRIPT_NAME"