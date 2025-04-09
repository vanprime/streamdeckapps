-- Function to get the current screen dimensions
on getScreenDimensions()
    tell application "Finder"
        set screenBounds to bounds of window of desktop
        return screenBounds
    end tell
end getScreenDimensions

-- Function to check if window title matches any pattern
on matchesCallPattern(windowTitle, patterns)
    log "====== Pattern Matching ======"
    log "Window title: " & windowTitle
    
    repeat with pattern in patterns
        if windowTitle contains pattern as text then
            log "✓ Match found with pattern: " & (pattern as text)
            return true
        end if
    end repeat
    
    log "✗ No match found"
    return false
end matchesCallPattern

-- Function to move Teams call window to left side of screen
on moveTeamsCallWindow()
    log "=== Script Start ==="
    
    -- Load configuration from config.applescript
    set configPath to ((path to me as text) & "::config.applescript") as alias
    try
        set configScript to load script configPath
        set callWindowPatterns to configScript's getPatterns()
        log "Successfully loaded patterns from config"
    on error errMsg
        log "Failed to load config: " & errMsg
        -- Fallback patterns if config loading fails
        set callWindowPatterns to {"Calls", "Daily", "Stand Up", "Meeting", "Call", "conversation", "General", "| Meeting", "| Call"}
        log "Using fallback patterns"
    end try

    -- Check if Teams is running
    tell application "System Events"
        set teamsRunning to exists process "Microsoft Teams"
    end tell
    
    if not teamsRunning then
        log "ERROR: Teams is not running"
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
    set callWindowFound to false
    
    tell application "System Events"
        tell process "Microsoft Teams"
            set teamWindows to every window
            repeat with theWindow in teamWindows
                try
                    set winTitle to title of theWindow
                    -- Store the title for pattern matching outside the tell block
                    set windowMatches to my matchesCallPattern(winTitle, callWindowPatterns)
                    if windowMatches then
                        -- Found matching window, move it
                        set position of theWindow to {screenX, screenY}
                        set size of theWindow to {newWidth, newHeight}
                        set callWindowFound to true
                        log "✓ Window moved successfully"
                        exit repeat
                    end if
                on error errMsg
                    log "ERROR processing window: " & errMsg
                end try
            end repeat
        end tell
    end tell
    
    if not callWindowFound then
        log "✗ No matching window found"
        display dialog "No matching Teams window found"
    end if
    
    log "=== Script End ==="
end moveTeamsCallWindow

-- Execute the script
moveTeamsCallWindow()