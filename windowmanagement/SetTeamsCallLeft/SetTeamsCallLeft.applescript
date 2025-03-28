-- Function to get the current screen dimensions
on getScreenDimensions()
    tell application "Finder"
        set screenBounds to bounds of window of desktop
        return screenBounds
    end tell
end getScreenDimensions

-- Function to move Teams call window to left side of screen
on moveTeamsCallWindow()
    -- Check if Teams is running
    tell application "System Events"
        set teamsRunning to exists process "Microsoft Teams"
    end tell
    
    if not teamsRunning then
        display dialog "Microsoft Teams is not running"
        return
    end if
    
    -- Get screen dimensions
    set screenBounds to getScreenDimensions()
    set {screenX, screenY, screenWidth, screenHeight} to screenBounds
    
    -- Calculate window bounds for left 35% of the screen
    set newWidth to screenWidth * 0.35
    set newHeight to screenHeight
    
    -- Find and move the Teams call window
    tell application "System Events"
        tell process "Microsoft Teams"
            set callWindowFound to false
            set teamWindows to every window
            set windowCount to count of teamWindows
            
            -- Approach 1: If there are exactly 2 windows, one is likely the call window
            if windowCount = 2 then
                repeat with i from 1 to windowCount
                    set currentWindow to item i of teamWindows
                    try
                        set winTitle to title of currentWindow
                        -- Check if it's NOT the main window
                        if winTitle does not contain "Microsoft Teams" and winTitle does not contain "Teams" then
                            -- This is likely the call window
                            set position of currentWindow to {screenX, screenY}
                            set size of currentWindow to {newWidth, newHeight}
                            set callWindowFound to true
                            exit repeat
                        end if
                    on error
                        -- Continue if we can't get the title
                    end try
                end repeat
            end if
            
            -- Approach 2: Check for call-related UI elements (if first approach failed)
            if not callWindowFound then
                repeat with theWindow in teamWindows
                    try
                        -- Look for UI elements typical in call windows like buttons
                        set uiElements to UI elements of theWindow
                        repeat with elem in uiElements
                            try
                                set elemDesc to description of elem
                                if elemDesc contains "microphone" or elemDesc contains "camera" or elemDesc contains "mute" then
                                    -- Found call controls, this is likely the call window
                                    set position of theWindow to {screenX, screenY}
                                    set size of theWindow to {newWidth, newHeight}
                                    set callWindowFound to true
                                    exit repeat
                                end if
                            on error
                                -- Continue checking other elements
                            end try
                        end repeat
                        if callWindowFound then exit repeat
                    on error
                        -- Skip windows we can't examine
                    end try
                end repeat
            end if
            
            -- Approach 3: Extended title checking (if first two approaches failed)
            if not callWindowFound then
                repeat with theWindow in teamWindows
                    try
                        set winTitle to title of theWindow
                        -- More comprehensive title checks
                        if winTitle contains "Meeting" or winTitle contains "Call" or winTitle contains "conversation" or winTitle contains "| " or (winTitle contains ":" and winTitle does not contain "Microsoft Teams") then
                            -- This is likely the call window
                            set position of theWindow to {screenX, screenY}
                            set size of theWindow to {newWidth, newHeight}
                            set callWindowFound to true
                            exit repeat
                        end if
                    on error
                        -- Skip windows without accessible titles
                    end try
                end repeat
            end if
            
            -- Fallback: If all else fails, try the frontmost window
            if not callWindowFound and windowCount > 0 then
                try
                    set frontWindow to item 1 of teamWindows
                    set position of frontWindow to {screenX, screenY}
                    set size of frontWindow to {newWidth, newHeight}
                    set callWindowFound to true
                on error errMsg
                    display dialog "Error positioning Teams window: " & errMsg
                end try
            end if
            
            if not callWindowFound then
                display dialog "No active Teams call window found"
            end if
        end tell
    end tell
end moveTeamsCallWindow

-- Execute the script
moveTeamsCallWindow()