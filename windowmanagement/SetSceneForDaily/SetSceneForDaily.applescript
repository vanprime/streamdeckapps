-- Function to get the current screen dimensions
on getScreenDimensions()
    tell application "Finder"
        set screenBounds to bounds of window of desktop
        -- screenBounds is in the form {0, 0, screenWidth, screenHeight}
        return screenBounds
    end tell
end getScreenDimensions

-- Function to set bounds for a specific application
on setAppBounds(appName, bounds)
    tell application appName
        try
            activate -- Bring the application to the front
            set bounds of front window to bounds
        on error errMsg
            display dialog "Error setting window bounds for " & appName & ": " & errMsg
        end try
    end tell
end setAppBounds

-- Main function to position Google Meet and Google Chrome
on positionMeetAndChrome()
    -- Get screen dimensions
    set screenBounds to getScreenDimensions()
    set {screenX, screenY, screenWidth, screenHeight} to screenBounds
    
    -- Calculate bounds for Google Meet (left 35%)
    set meetWidth to screenWidth * 0.35
    set meetHeight to screenHeight
    set meetBounds to {screenX, screenY, screenX + meetWidth, screenHeight}
    
    -- Calculate bounds for Google Chrome (right 65%)
    set chromeWidth to screenWidth * 0.65
    set chromeX to screenWidth * 0.35 -- Start where Meet ends
    set chromeBounds to {chromeX, screenY, chromeX + chromeWidth, screenHeight}
    
    -- Position Google Meet
    setAppBounds("Google Meet", meetBounds)
    
    -- Position Google Chrome
    setAppBounds("Google Chrome", chromeBounds)
end positionMeetAndChrome

-- Execute the script
positionMeetAndChrome()
