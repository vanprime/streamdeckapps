-- Function to get the current screen dimensions
on getScreenDimensions()
    tell application "Finder"
        set screenBounds to bounds of window of desktop
        -- screenBounds is in the form {0, 0, screenWidth, screenHeight}
        return screenBounds
    end tell
end getScreenDimensions

-- Function to adjust the front application's window to the left 32% of the screen
on resizeAndMoveWindow()
    tell application "System Events"
        -- Get the frontmost application
        set frontApp to name of first application process whose frontmost is true
    end tell
    
    -- Get screen dimensions
    set screenBounds to getScreenDimensions()
    set {screenX, screenY, screenWidth, screenHeight} to screenBounds
    
    -- Calculate window bounds for left 35% of the screen
    set newWidth to screenWidth * 0.35
    set newHeight to screenHeight -- Full height
    set newBounds to {screenX, screenY, screenX + newWidth, newHeight}
    
    -- Move and resize the frontmost window
    tell application frontApp
        try
            set bounds of front window to newBounds
        on error errMsg
            display dialog "Error setting window bounds for " & frontApp & ": " & errMsg
        end try
    end tell
end resizeAndMoveWindow

-- Execute the script
resizeAndMoveWindow()