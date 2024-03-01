util.AddNetworkString("afk_failed")
util.AddNetworkString("start_afkmenu")
util.AddNetworkString("afk_complete")
util.AddNetworkString("storm_chat_message")
util.AddNetworkString("afk_response")

local meta = FindMetaTable("Player")

local time = StormAFK.AFKTimerDisplay
local kickMessage = StormAFK.kickMessage

local timetokick = StormAFK.AFKTimertoKick

local questTable = StormAFK.questions

local playerTimer = {}
local playerQuestion = {}

function meta:AFK_Broadcast(msg)
	net.Start("storm_chat_message")
		net.WriteString(msg)
	net.Send(self)
end

net.Receive("afk_response", function(len, ply)
	local ans = net.ReadString()
	if IsValid(ply) and timer.Exists(ply:SteamID().."_afkresponse") then
		local question = playerQuestion[ply:SteamID()]
		if ans == question[2] then
			timer.Remove(ply:SteamID().."_afkresponse")
			net.Start("afk_complete")
			net.Send(ply)
			question = nil

			playerTimer[ply:SteamID()] = CurTime()
			StormAFK.reward(ply)
		end
	end
end)

local function ShowAFKQuestion(ply)
	local question = table.Random(questTable)
	playerQuestion[ply:SteamID()] = question
	net.Start("start_afkmenu")
		net.WriteString(question[1])
	net.Send(ply)

	timer.Create(ply:SteamID().."_afkresponse", timetokick, 1, function()
		ply:Kick(kickMessage)
	end)
end

timer.Create("GlobalAFKCheck", 1, 0, function()
    local currentTime = CurTime()
    for steamID, lastActive in pairs(playerTimer) do
        if (currentTime - lastActive) >= time then
            local ply = player.GetBySteamID(steamID)
            if IsValid(ply) then
				if timer.Exists(ply:SteamID().."_afkresponse") then return end 
                ShowAFKQuestion(ply)
            end
        end
    end
end)

hook.Add("PlayerInitialSpawn", "start_timer", function(ply)
	if ULib then
		local plyPerm = ULib.ucl.query(ply, "storm afk immune", false)
		if plyPerm then return end
	end
	playerTimer[ply:SteamID()] = CurTime()
end)

hook.Add("PlayerDisconnected", "deleteafktimer", function(ply)
	playerTimer[ply:SteamID()] = nil
	timer.Remove(ply:SteamID().."_afkresponse")
end)