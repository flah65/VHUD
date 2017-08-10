-----------------------------------------------------------------
--  > VALERY'S HUD http://steamcommunity.com/id/valeryrich/
-----------------------------------------------------------------
if SERVER then
	AddCSLuaFile("vhud/sh_vhudcfg.lua")
	AddCSLuaFile("vhud/client/cl_vhud.lua")

	resource.AddFile("materials/vgui/gun.png")
	resource.AddFile("materials/vgui/cop.png")
	resource.AddFile("materials/vgui/logo.png")
	return
end

include("vhud/sh_vhudcfg.lua")

if CLIENT then 
    include("vhud/client/cl_vhud.lua")
end
-----------------------------------------------------------------