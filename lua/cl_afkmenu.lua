
local Storm = {}

local timetokick = StormAFK.AFKTimertoKick

local questions = StormAFK.questions


net.Receive("start_afkmenu", function()
	local question = net.ReadString()
	if afkFrameBool then return end
	Storm.AFKMenu(question)
end)

local afkFrame
local afkFrameBool = false
local afkTextEntryBool = false

local function actionPress(str)

	net.Start("afk_response")
		net.WriteString(str)
	net.SendToServer()

end

net.Receive("afk_complete", function()
	if afkFrameBool then
		if IsValid(afkFrame) then
			afkFrame:Close()
		end
		afkFrameBool = false
		gui.EnableScreenClicker( false )
		afkTextEntryBool = false
	end
end)

function Storm.AFKMenu(question)
	if afkFrameBool then return end
	
	local endTime = CurTime() + timetokick -- Calculate when the time will end.

	afkFrameBool = true
	
	afkFrame = vgui.Create("StormAFKFrame")
	afkFrame:SetPos(0,ScrH()/2-75)
	afkFrame:SetSize(270,150)
	afkFrame:SetFrameName("AFK (Hold C to interact)")
	afkFrame:SetKeyBoardInputEnabled( true )
	afkFrame:SetMouseInputEnabled( true )

	local Panel = vgui.Create("DPanel", afkFrame)
	Panel:SetPos(10, 35)
	Panel:SetSize(afkFrame:GetWide()-20, afkFrame:GetTall()-50)
	Panel.Paint = function()
		local w, h = Panel:GetWide(), Panel:GetTall()
		--draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		local timey = math.max(0, endTime - CurTime())
		local timeyround = math.Round(timey)
		Storm_AAText("You have "..timeyround.." seconds to answer the question", "storm.med", 0, 0, Color(255,255,255,255), TEXT_ALIGN_LEFT)
		Storm_AAText("right!", "storm.med", 0, 15, Color(255,255,255,255), TEXT_ALIGN_LEFT)
		Storm_AAText(question.." = ", "storm.title", 5,h/2-7,Color(255,255,255,255),TEXT_ALIGN_LEFT)
	end

	local lengthx, lenghty = surface.GetTextSize(question.." = ") 
	local TextEntry = vgui.Create("DTextEntry",afkFrame)
	TextEntry:SetPos(lengthx+25, afkFrame:GetTall()/2)
	TextEntry:SetSize(30,25)
	TextEntry:SetText("")
	TextEntry.OnEnter = function()
		local str = TextEntry:GetValue()
		actionPress( str )
	end
	TextEntry.OnGetFocus = function()
		gui.EnableScreenClicker(true)  -- Keep the mouse for UI interaction
		afkTextEntryBool = true
	end
	TextEntry.OnLoseFocus = function()
		if afkFrameBool then -- Example condition, adjust based on your needs
			gui.EnableScreenClicker(false) -- Return mouse control to the game
		end
	end

	local button = vgui.Create("AdminStormSaveButton", afkFrame)
	button:SetButtonText("Submit")
	button:SetPos(10,afkFrame:GetTall()-35)
	button:SetSize(afkFrame:GetWide()-20, 25)
	button.DoClick = function()
		local str = TextEntry:GetValue()
		actionPress( str )
	end
end

hook.Add("OnContextMenuOpen", "afkmenu_releasemouse",function()
	if afkFrameBool then
		afkFrame:MakePopup()
		afkFrame:SetMouseInputEnabled(true)
		afkFrame:SetKeyboardInputEnabled(true)

		gui.EnableScreenClicker(true)
	end
end)

hook.Add("OnContextMenuClose", "afkmenu_releasemouse",function()
	if afkFrameBool and not afkTextEntryBool then
		afkFrame:SetMouseInputEnabled(false)
		afkFrame:SetKeyboardInputEnabled(false)

		gui.EnableScreenClicker( false )
	end
end)

local afkTag = StormAFK.afkTag
local afkColor = StormAFK.afkTagColor
local afkMessageColor = StormAFK.afkMessageColor

local function afk_message(msg)
	local text = {}

	table.insert(text, Color(50, 50, 50, 255))
	table.insert(text, "[")
	table.insert(text, afkColor)
	table.insert(text, afkTag)
	table.insert(text, Color(50, 50, 50, 255))
	table.insert(text, "] ")
	table.insert(text, afkMessageColor)
	table.insert(text, msg)

	chat.AddText(unpack(text))
end

net.Receive("storm_chat_message", function()
	local msg = net.ReadString()
	afk_message(msg)
end)