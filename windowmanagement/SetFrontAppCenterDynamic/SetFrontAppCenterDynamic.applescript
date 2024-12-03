-- Function to get the current screen dimensions
on getScreenDimensions()
    tell application "Finder"
        set screenBounds to bounds of window of desktop
        -- screenBounds is in the form {0, 0, screenWidth, screenHeight}
        return screenBounds
    end tell
end getScreenDimensions

-- Function to adjust the front application's window to 75% width and 69% height, centered
on resizeAndMoveWindow()
    tell application "System Events"
        -- Get the frontmost application
        set frontApp to name of first application process whose frontmost is true
    end tell
    
    -- Get screen dimensions
    set screenBounds to getScreenDimensions()
    set {screenX, screenY, screenWidth, screenHeight} to screenBounds
    
    -- Calculate window dimensions for 75% width and 80% height
    set newWidth to screenWidth * 0.75
    set newHeight to screenHeight * 0.80
    
    -- Calculate the top-left corner to center the window
    set newX to (screenWidth - newWidth) / 2
    set newY to (screenHeight - newHeight) / 2
    
    -- Set the new bounds
    set newBounds to {newX, newY, newX + newWidth, newY + newHeight}
    
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
