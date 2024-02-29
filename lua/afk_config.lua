-- Configuration for the StormAFK System

StormAFK = {}

-- Duration in seconds before the AFK check is initiated.
StormAFK.AFKTimerDisplay = 420

-- Duration in seconds the player has to respond to the AFK check before being kicked.
StormAFK.AFKTimertoKick = 60

-- Questions and answers for the AFK check. Format: {"Question", "Answer"}
StormAFK.questions = {
    {"0 + 5", "5"},
    {"10 + 10", "20"},
    {"10 + 5", "15"},
    {"4 + 4", "8"},
    {"2 + 2", "4"},
    {"5 + 5", "10"},
    {"1 + 1", "2"},
    {"5 - 5", "0"},
    {"5 + 4", "9"},
    {"3 + 2", "5"},
}

-- UI Settings
-- Color of the banner of the AFK check frame.
StormAFK.bannerColor = Color(140, 0, 0, 255)

-- Player Broadcast Settings
-- Color of the tag name displayed in the broadcast message.
StormAFK.afkTagColor = Color(255, 0, 0, 255)
-- Text of the tag name displayed in the broadcast message.
StormAFK.afkTagName = "AFK"
-- Color of the broadcast message text.
StormAFK.afkMessageColor = Color(255, 255, 255)

-- Message displayed to the player when kicked for failing the AFK check.
StormAFK.kickMessage = "Failed to answer the AFK Question!"

-- Function to reward the player for completing the AFK check.
StormAFK.reward = function(ply)
    -- Example: Add points to the player's account using a point shop system.
    ply:PS2_AddStandardPoints(50, "Completion of AFK Check")
    -- Broadcast a message to the player confirming the reward.
    ply:AFK_Broadcast("You've been awarded 50 points for completing the AFK check.", StormAFK.afkMessageColor)
end
