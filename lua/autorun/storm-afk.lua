if SERVER then
	AddCSLuaFile("vgui/storm_vgui.lua")
	AddCSLuaFile("afk_config.lua")
	include("afk_config.lua")

    --afkmenu
	include("sv_afkmenu.lua")
	AddCSLuaFile("cl_afkmenu.lua")
else
	include("vgui/storm_vgui.lua")
	include("afk_config.lua")

	--afkmenu 
	include("cl_afkmenu.lua")
end