tell application "Google Chrome"
	activate -- Brings Chrome to the front
	set baseURL to "https://outlook.office.com/mail"
	set foundTab to false
	set tabIndex to 1
	
	-- Check the first window for a tab with the target URL
	if (count of windows) > 0 then
		set firstWindow to window 1
		repeat with t from 1 to the count of tabs of firstWindow
			if URL of tab t of firstWindow starts with baseURL then
				set foundTab to true
				set tabIndex to t
				exit repeat
			end if
		end repeat
		set active tab index of firstWindow to tabIndex
	end if
	
	-- If no tab was found with the URL, create a new one
	if not foundTab then
		tell firstWindow
			set newTab to make new tab with properties {URL:baseURL}
			set active tab index of firstWindow to (count of tabs)
		end tell
	end if
end tell
