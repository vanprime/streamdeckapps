property callWindowPatterns : {¬
    "APE", ¬
    "Calls", ¬
    "Daily", ¬
    "Weekly", ¬
    "Show", ¬
    "Review", ¬
    "Refinement", ¬
    "Stand Up", ¬
    "Meeting", ¬
    "Call", ¬
    "conversation", ¬
    "General", ¬
    "| Meeting", ¬
    "| Call" ¬
}

-- Function to return the patterns
on getPatterns()
    return callWindowPatterns
end getPatterns

-- Enable debug logging
property debugMode : true

on logDebug(message)
    if debugMode then
        log message
    end if
end logDebug