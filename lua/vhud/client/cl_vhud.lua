-----------------------------------------------------------------
--  > VALERY'S HUD http://steamcommunity.com/id/valeryrich/
-----------------------------------------------------------------
--  Resource
-----------------------------------------------------------------
if SERVER then
    include("vhud/sh_vhudcfg.lua")
	resource.AddFile("materials/vgui/gun.png")
	resource.AddFile("materials/vgui/cop.png")	
	resource.AddFile("materials/vgui/logo.png")		
	resource.AddFile("resource/fonts/RythmusRegular.ttf")
    return
end	
-----------------------------------------------------------------
--  Fonts
-----------------------------------------------------------------
surface.CreateFont( "CenterNumb", {
	font = "Rythmus Regular",	
	size = 22,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})
-----------------------------------------------------------------
surface.CreateFont( "CenterNumbLarge", {
	font = "Rythmus Regular",	
	size = 32,
	weight = 400,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	shadow = true
})
-----------------------------------------------------------------
surface.CreateFont( "CenterNumbLarge2", {
	font = "Rythmus Regular",	
	size = 48,
	weight = 100,
	blursize = 0,
	scanlines = 0,
	antialias = true,
})
-----------------------------------------------------------------
surface.CreateFont( "HeadText", {
	font = "Default",	
	size = 24,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	shadow = true
})
-----------------------------------------------------------------
--  Line & Outline and Blur
-----------------------------------------------------------------
local function formatNumber(n)
	if not n then return "" end
	if n >= 1e14 then return tostring(n) end
    n = tostring(n)
    local sep = sep or ","
    local dp = string.find(n, "%.") or #n+1
	for i=dp-4, 1, -3 do
		n = n:sub(1, i) .. sep .. n:sub(i+1)
    end
    return n
end
-----------------------------------------------------------------
local function drawLine( startPos, endPos, color )
	surface.SetDrawColor( color )
	surface.DrawLine( startPos[1], startPos[2], endPos[1], endPos[2] )
end
-----------------------------------------------------------------
local function drawRectOutline( x, y, w, h, color )
	surface.SetDrawColor( color )
	surface.DrawOutlinedRect( x, y, w, h )
end
-----------------------------------------------------------------
local blur = Material( "pp/blurscreen" )
local function drawBlur( x, y, w, h, layers, density, alpha )
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )

	for i = 1, layers do
		blur:SetFloat( "$blur", ( i / layers ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		render.SetScissorRect( x, y, x + w, y + h, true )
			surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() )
		render.SetScissorRect( 0, 0, 0, 0, false )
	end
end
-----------------------------------------------------------------
hook.Add( "InitPostEntity", "vhud_portrait", function()
	local portrait = vgui.Create( "DModelPanel" )
	portrait:SetPos( 10, ScrH() - 80 )
	portrait:SetSize( 60, 70 )
	portrait:SetModel( LocalPlayer():GetModel() )
	portrait.Think = function()
		portrait:SetModel( LocalPlayer():GetModel() )
	end
	portrait.LayoutEntity = function()
		return false
	end
	portrait:SetFOV( 40 )
	portrait:SetCamPos( Vector( 25, -15, 62 ) )
	portrait:SetLookAt( Vector( 0, 0, 62 ) )
	portrait.Entity:SetEyeTarget( Vector( 200, 200, 100 ) )
end )
-----------------------------------------------------------------
--  HUD
-----------------------------------------------------------------
hook.Add("HUDPaint","DrawMyHUD",function ()
    //Main
    drawBlur(5, ScrH() - 156, 402, 151, 2, 4, 255)
 	draw.RoundedBox(0, 5, ScrH() - 156, 402, 151,Color(0,0,0,130))
	drawRectOutline( 5, ScrH() - 156, 402, 151, Color(0,0,0,75))
	draw.RoundedBox( 0, 10, ScrH() - 83, 60, 73, Color( 0, 0, 0, 125 ) )	
	drawRectOutline( 10, ScrH() - 83, 60, 73, Color( 0, 0, 0, 75 ) )
	draw.RoundedBox( 0, 10, ScrH() - 151, 60, 57, Color( 0, 0, 0, 125 ) )	
	drawRectOutline( 10, ScrH() - 151, 60, 57, Color( 0, 0, 0, 75 ) )	
	//Health, Armor & Hunger
	draw.RoundedBox( 0, 72, ScrH() - 83, 330, 23, Color( 0, 0, 0, 125 ) )	
	drawRectOutline( 72, ScrH() - 83, 330, 23, Color( 0, 0, 0, 75 ) )	
	draw.RoundedBox( 0, 72, ScrH() - 58, 330, 23, Color( 0, 0, 0, 125 ) )	
	drawRectOutline( 72, ScrH() - 58, 330, 23, Color( 0, 0, 0, 75 ) )	
	draw.RoundedBox( 0, 72, ScrH() - 33, 330, 23, Color( 0, 0, 0, 125 ) )	
	drawRectOutline( 72, ScrH() - 33, 330, 23, Color( 0, 0, 0, 75 ) )	
    //Line & Payday & Wallet
	draw.RoundedBox( 0, 10, ScrH() - 90, 391, 3, Color( 151, 221, 255, 655 ) )
	drawRectOutline( 10, ScrH() - 90, 391, 3, Color( 0, 0, 0, 75 ) )	
	draw.RoundedBox( 0, 72, ScrH() - 151, 166, 57, Color( 0, 0, 0, 125 ) )		
	drawRectOutline( 72, ScrH() - 151, 166, 57, Color( 0, 0, 0, 75 ) )	
	draw.RoundedBox( 0, 240, ScrH() - 151, 162, 57, Color( 0, 0, 0, 125 ) )		
	drawRectOutline( 240, ScrH() - 151, 162, 57, Color( 0, 0, 0, 75 ) )		
    //Logo
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial(Material("materials/vgui/logo.png"))
	surface.DrawTexturedRect( ScrW() - 230, 5, 225, 32 )	
	
	local health = LocalPlayer():Health()	
	draw.SimpleText(VHUD_translate.health.. " %" ..health,"CenterNumb", 225, ScrH() - 71,Color(252, 96, 66, 255), 1, 1)		
	
	local armor = LocalPlayer():Armor()
	draw.SimpleText(VHUD_translate.armor.. " %" ..armor,"CenterNumb", 225, ScrH() - 46,Color(44, 130, 201, 255), 1, 1)		
	
	local hunger = formatNumber(LocalPlayer():getDarkRPVar( "Energy" ))
	draw.SimpleText(VHUD_translate.hunger.. " %" ..hunger,"CenterNumb", 225, ScrH() - 22,Color(60, 179, 113, 255), 1, 1)		
	
    local salary = formatNumber(LocalPlayer():getDarkRPVar("salary"))
	draw.SimpleText(VHUD_translate.salary,"HeadText", 155, ScrH() - 135,Color(255, 255, 255, 255), 1, 1)
	draw.SimpleText("$" ..salary,"HeadText", 155, ScrH() - 110,Color(255, 255, 255), 1, 1)	

	local money = formatNumber(LocalPlayer():getDarkRPVar( "money" ))
	draw.SimpleText(VHUD_translate.money,"HeadText", 320, ScrH() - 135,Color(255, 255, 255, 255), 1, 1)
	draw.SimpleText("$" ..money,"HeadText", 320, ScrH() - 110,Color(255, 255, 255), 1, 1)		

    local HSV = HSVToColor(math.abs(math.sin(CurTime() *0.5) *300), 1, 1)	
	
    if GetGlobalBool("DarkRP_LockDown") then
	draw.SimpleText(VHUD_translate.lockdown,"HeadText", 4 + 200, ScrH() - 170,HSV, 1, 1)
	end		
	
	local agenda = LocalPlayer():getAgendaTable()
	local agendaText = agendaText or DarkRP.textWrap( ( LocalPlayer():getDarkRPVar( "agenda" ) or "" ):gsub( "//", "\n" ):gsub( "\\n", "\n" ), "HeadText", 395 )
	local agendaText = DarkRP.textWrap((LocalPlayer():getDarkRPVar("agenda") or ""):gsub( "//", "\n" ):gsub( "\\n", "\n" ), "HeadText", 395 )	
	if agenda then
    drawBlur(5, 5, 420, 170, 2, 4, 255)	
	draw.RoundedBox(2, 5, 5, 420,170,Color(0,0,0,130))
	drawRectOutline(5, 5, 420, 170, Color( 0, 0, 0, 75 ) )	
	draw.DrawText(agenda.Title, "HeadText", 210, 20, Color(255,255,255,255), 1)				
	draw.RoundedBox(2, 10, 55, 410,115,Color(0,0,0,75))
	drawRectOutline(10, 55, 410, 115, Color( 0, 0, 0, 75 ) )	
	draw.DrawText(agendaText, "HeadText", 15, 60, Color(255,255,255,255))
	end

	local reason = LocalPlayer():getDarkRPVar("wantedReason")	
	if LocalPlayer():getDarkRPVar("wanted") then
	draw.SimpleText(VHUD_translate.wanted,"HeadText", 930, ScrH() - 1000,HSV, 1, 1)
	draw.SimpleText(VHUD_translate.reason.. " - " ..reason,"HeadText", 930, ScrH() - 970,Color(255,255,255), 1, 1)
	surface.SetDrawColor( 255, 0, 0, 255 )
	surface.SetMaterial(Material("materials/vgui/cop.png"))
	surface.DrawTexturedRect( 35,ScrH() - 122, 24, 24 )		
	else
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial(Material("materials/vgui/cop.png"))
	surface.DrawTexturedRect( 35,ScrH() - 122, 24, 24 )	
	end	
	
	if LocalPlayer():getDarkRPVar("HasGunlicense") then
	surface.SetDrawColor( 151, 221, 255, 655 )
	surface.SetMaterial(Material("materials/vgui/gun.png"))
	surface.DrawTexturedRect( 20,ScrH() - 147, 24, 24 )
	else	
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.SetMaterial(Material("materials/vgui/gun.png"))
	surface.DrawTexturedRect( 20,ScrH() - 147, 24, 24 )
	end
	
    local clip1_max = 0
	local ammo_max = 0
    local clip1 = 0
	if LocalPlayer():GetActiveWeapon():IsWeapon() then
	clip1 = LocalPlayer():GetActiveWeapon():Clip1()
	end
	if clip1 >= 1 then
	if clip1 > clip1_max or LocalPlayer():GetActiveWeapon() != weapon then
	clip1_max = clip1
	end
	clip1_max = 0
	end
	
	local ammo = 0
	if LocalPlayer():GetActiveWeapon():IsWeapon() then
	ammo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
	end
	if ammo >= 1 then
	if ammo > ammo_max or LocalPlayer():GetActiveWeapon() != weapon then
	ammo_max = ammo
	end
	drawBlur( ScrW() - 175, ScrH() - 50, 170, 45, 3, 6, 255 )	
	draw.RoundedBox( 0, ScrW() - 175, ScrH() - 50, 170, 45, Color( 0, 0, 0, 150 ) )	
	drawRectOutline( ScrW() - 175, ScrH() - 50, 170, 45, Color( 0, 0, 0, 75 ) )	
	surface.SetFont( "CenterNumbLarge2" )
	surface.SetTextColor(255,255,255,255)
	surface.SetTextPos(ScrW() - 125,ScrH() - 50)
	surface.DrawText(clip1.. "/" ..ammo)	
	else
	ammo_max = 0
	end
end)
-----------------------------------------------------------------
local hideHUDElements = {
        ["DarkRP_HUD"] = true,
		["CHudBattery"] = true,
		["CHudSuitPower"] = true,
		["DarkRP_HUD"] = true,
		["DarkRP_Hungermod"] = true,
	    ["CHudAmmo"] = true,
		["CHudHealth"] = true,
		["CHudSecondaryAmmo"] = true,
		["DarkRP_Agenda"] = true,
		["DarkRP_LocalPlayerHUD"] = true
}
hook.Add("HUDShouldDraw", "HideDefaultDarkRPHud", function(name)
        if hideHUDElements[name] then return false end
end)
-----------------------------------------------------------------
--  END
-----------------------------------------------------------------