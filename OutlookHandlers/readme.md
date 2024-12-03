# Outlook Web Access Helpers for macOS

## Problem statement
Outlook provides only a single app. Thus we have to either navigate inside that app or use the web versions and find the tabs in our never clean tab list.
For me, this creates a surprisingly large context switch and cognitive load which I'd prefer to avoid.

## Idea
Why not use scripts to manipulate chrome to behave like the GSuite PWA did?
With these applescripts you can create your own "apps" that can be placed in your dock to open the outlook calendar or mail.

## Creating Applications with Script Editor

### Step 1: Open Script Editor

1. Open `Script Editor` located in `/Applications/Utilities/`.
2. Select `File > New` to create a new document.

### Step 2: Enter the Script

1. Copy the AppleScript code from the provided `.applescript` files into the Script Editor.
2. Modify the script as needed for custom behavior.

### Step 3: Save as an Application

1. Once the script is ready, select `File > Save`.
2. In the dialog box, change the `File Format` to `Application`.
3. Choose a suitable location and save the file.

## Setting Custom Icons

1. Right-click on the saved application and select `Get Info`.
2. Drag and drop the `.png` file onto the small icon in the top left corner of the `Get Info` window.

## Usage

To use the applications, simply click on them in Finder. They will execute the AppleScript to manage your Outlook Web Access in Chrome as configured.

## Notes

- Ensure that Google Chrome is installed on your macOS.
- The scripts assume Chrome is the default browser for opening Outlook Web Access.
- the folders also contain bash scripts, if you want to run them from a stream deck or some hotkeys.
