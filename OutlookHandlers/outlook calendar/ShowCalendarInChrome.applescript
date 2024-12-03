tell application "Google Chrome"
    activate -- Brings Chrome to the front
    set baseURL to "https://outlook.office.com/calendar"
    set foundTab to false
    set tabIndex to 1

    -- Check the first window for a tab with the target URL
    if (count of windows) > 0 then
        set firstWindow to window 1
        repeat with t from 1 to the count of tabs of firstWindow
            if URL of tab t of firstWindow starts with baseURL then
                set foundTab to true
                set tabIndex to t
                set active tab index of firstWindow to tabIndex
                exit repeat
            end if
        end repeat
    end if
    
    -- If no tab was found with the URL, use the default tab in the new window
    if not foundTab then
        set newWindow to make new window
        tell tab 1 of newWindow
            set URL to baseURL & "/view/workweek"
        end tell
    end if
end tell
