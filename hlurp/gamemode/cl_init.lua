include( "shared.lua" )
include( "cl_hlu_chat.lua" )
include( "sh_bmrp.lua" )
include( "cl_bmrp.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )
include( "sh_bmrp_events.lua" )

local themecolor = ColorAlpha( HLU_GAMEMODE[GetGlobalInt( "CurrentGamemode" )].Color, 40 )
surface.CreateFont( "JobCategory", {
	font = "Arial",
	size = 30,
	weight = 900
} )

surface.CreateFont( "JobTitle", {
	font = "Arial",
	size = 20,
	weight = 900
} )

surface.CreateFont( "QuestionMark", {
	font = "Arial",
	size = 50,
	weight = 900
} )

function GM:DrawDeathNotice()
	return false
end

--Luminance calculator
function IsDarkColor( color )
	return 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b < 255 / 3
end

scoreboard = scoreboard or {}
function scoreboard:show()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetSize( 800, 600 )
	mainframe:Center()
	mainframe:ShowCloseButton( false )
	mainframe:MakePopup()
	mainframe:SetDraggable( false )
	mainframe:SetTitle( "Lambda Gaming Half-Life Universe RP" )
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 2, 0, 0, w, h, themecolor )
	end

	local plylist = vgui.Create( "DListView", mainframe )
	plylist:Dock( FILL )
	plylist:AddColumn( "Name" ):SetWidth( 175 )
	plylist:AddColumn( "Job" ):SetWidth( 175 )
	plylist:AddColumn( "Health" ):SetWidth( 50 )
	plylist:AddColumn( "Kills" ):SetWidth( 50 )
	plylist:AddColumn( "Deaths" ):SetWidth( 50 )
	plylist:AddColumn( "Ping" ):SetWidth( 50 )
	plylist:SetDataHeight( 30 )
	plylist.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_transparent )
	end

	for k,v in ipairs( player.GetAll() ) do
		local row = plylist:AddLine( v:Nick(), v:GetJobName(), v:Health(), v:Frags(), v:Deaths(), v:Ping() )
		row:SetCursor( "hand" )
		for i=1,6 do
			if IsDarkColor( v:GetJobColor() ) then
				row.Columns[i]:SetTextColor( color_white )
			end
		end
		function row:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, v:GetJobColor() )
		end
		function row:OnSelect()
			gui.OpenURL( "https://steamcommunity.com/profiles/"..v:SteamID64() )
		end
	end
	function scoreboard:hide()
		mainframe:Close()
	end
end

function GM:ScoreboardShow()
	scoreboard:show()
end

function GM:ScoreboardHide()
	scoreboard:hide()
end

local function SelectPlayermodel( num, job )
	local ply = LocalPlayer()
	local main = vgui.Create( "DFrame" )
	main:SetTitle( "Choose a new playermodel:" )
	main:SetSize( 365, 240 )
	main:Center()
	main:MakePopup()
	main.Paint = function( self, w, h )
		surface.SetDrawColor( ColorAlpha( themecolor, 240 ) )
		surface.DrawRect( 0, 0, w, h )
	end
	main.OnClose = function()
		ply.MenuOpen = false
	end
	local scroll = vgui.Create( "DScrollPanel", main )
	scroll:Dock( FILL )
	local layout = vgui.Create( "DIconLayout", scroll )
	layout:Dock( FILL )
	layout:SetSpaceY( 5 )
	layout:SetSpaceX( 5 )
	for _,v in pairs( job.Models ) do
		local icon = layout:Add( "SpawnIcon" )
		icon:SetPos( 10, 30 )
		icon:SetModel( v )
		icon:SetToolTip( false )
		icon:SetSize( 60, 60 )
		icon.DoClick = function()
			net.Start( "SetPlayermodel" )
			net.WriteString( v )
			net.WriteInt( num, 8 )
			net.SendToServer()
			if ply:Team() == num then
				HLU_Notify( "Your playermodel has been updated.", 0, 6 )
			else
				HLU_Notify( ply, "This model will be used when you select this job.", 0, 6 )
			end
			main:Close()
		end
	end
	ply.MenuOpen = true
end

function DrawJobMenu()
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose a Job:" )
	mainframe:SetSize( 500, 500 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		surface.SetDrawColor( themecolor )
		surface.DrawRect( 0, 0, w, h )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for a,b in ipairs( HLU_JOB_CATEGORY[GetGlobalInt( "CurrentGamemode" )] ) do
		local categorybutton = vgui.Create( "DButton", mainframescroll )
		categorybutton:SetSize( nil, 25 ) --X is ignored since it's docked to the frame already
		categorybutton:SetText( b.Name )
		categorybutton:SetFont( "JobCategory" )
		categorybutton:SetTextColor( color_white )
		categorybutton:Dock( TOP )
		if a > 1 then
			categorybutton:DockMargin( 0, 40, 0, 5 )
		else
			categorybutton:DockMargin( 0, 0, 0, 5 )
		end
		categorybutton.Paint = function( self, w, h )
			surface.SetDrawColor( b.Color )
			surface.DrawRect( 0, 0, w, h )
		end
		for k,v in ipairs( HLU_JOB[GetGlobalInt( "CurrentGamemode" )] ) do
			if v.Category != b.Name then --Puts jobs into their respective categories
				continue
			end
			local max
			if v.Max > 0 then
				max = v.Max
			else
				max = "∞"
			end
			local mainbuttons = vgui.Create( "DButton", mainframescroll )
			mainbuttons:SetSize( nil, 50 )
			mainbuttons:SetText( v.Name..": "..team.NumPlayers( k ).."/"..max )
			mainbuttons:SetFont( "JobTitle" )
			mainbuttons:SetTextColor( color_white )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBox( 8, 0, 0, w, h, v.Color )
			end
			mainbuttons.DoClick = function()
				if ply.JobSelectCooldown and ply.JobSelectCooldown > CurTime() then
					HLU_Notify( "Please wait a few seconds before changing jobs.", 1, 6 )
					return
				end
				if k == TEAM_MARINEBOSS or k == TEAM_MARINE then
					HLU_Notify( "Under normal circumstances, players can only become HECU by interacting with the escape truck during the cascade.", 1, 8 )
					return
				end
				net.Start( "HLU_ChangeJob" )
				net.WriteInt( k, 32 )
				net.SendToServer()
				ply.JobSelectCooldown = CurTime() + 5
				mainframe:Close()
			end
			
			local playermodel = vgui.Create( "SpawnIcon", mainbuttons )
			playermodel:SetSize( 50, 50 )
			playermodel:Dock( LEFT )
			playermodel:SetModel( v.Models[1] )
			playermodel.DoClick = function()
				if table.Count( v.Models ) <= 1 then
					HLU_Notify( "Only one playermodel is available for this job.", 1, 6 )
					return
				end
				SelectPlayermodel( k, v )
			end

			local info = vgui.Create( "DButton", mainbuttons )
			info:Dock( RIGHT )
			info:SetText( "?" )
			info:SetFont( "QuestionMark" )
			info.Paint = function()
				draw.RoundedBox( 0, 0, 0, info:GetWide(), info:GetTall(), color_transparent )
			end
			info.DoClick = function()
				local current = GetGlobalInt( "CurrentGamemode" )
				local rptype
				if current == 1 then
					rptype = "bmrp"
				elseif current == 2 then
					rptype = "city17rp"
				else
					rptype = "outlandrp"
				end
				gui.OpenURL( "https://lambdagaming.github.io/hlurp/jobs_"..rptype..".html#"..v.Link )
			end
		end
	end
	ply.MenuOpen = true
end

local function DrawBuyMenu()
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Select an item to purchase:" )
	mainframe:SetSize( 500, 500 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end

	local listframe = vgui.Create( "DScrollPanel", mainframe )
	listframe:Dock( FILL )
	for k,v in pairs( BuyMenuItems ) do
		if v.Allowed and !v.Allowed( ply ) then
			continue
		end
		local itembackground = vgui.Create( "DButton", listframe )
		itembackground:SetPos( 0, 10 )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:DockMargin( 0, 0, 0, 10 )
		itembackground:Center()
		itembackground:SetText( "" )
		itembackground.Paint = function( self, w, h )
			surface.SetDrawColor( Color( 45, 45, 45 ) )
			surface.DrawRect( 0, 0, w, h )
		end
		itembackground.DoClick = function()
			net.Start( "BuyItemFromMenu" )
			net.WriteString( k )
			net.SendToServer()
			mainframe:Close()
		end

		local mainbuttons = vgui.Create( "DButton", itembackground )
		mainbuttons:SetText( v.Name )
		mainbuttons:SetTextColor( color_white )
		mainbuttons:SetFont( "JobTitle" )
		mainbuttons:Dock( TOP )
		mainbuttons.Paint = function( self, w, h )
			surface.SetDrawColor( ColorAlpha( themecolor, 255 ) )
			surface.DrawRect( 0, 0, w, h )
		end
		mainbuttons.DoClick = function()
			net.Start( "BuyItemFromMenu" )
			net.WriteString( k )
			net.SendToServer()
			mainframe:Close()
		end

		local itemprice = vgui.Create( "DLabel", itembackground )
		itemprice:SetFont( "Trebuchet24" )
		itemprice:SetColor( color_white )
		itemprice:Dock( LEFT )
		if v.Price and v.Price > 0 then
			itemprice:SetText( "Price: "..v.Price )
		else
			itemprice:SetText( "Price: Free" )
		end
		itemprice:SizeToContents()

		local itemdesc = vgui.Create( "DLabel", itembackground )
		itemdesc:SetFont( "Trebuchet18" )
		itemdesc:SetColor( color_white )
		itemdesc:SetText( v.Description )
		itemdesc:Dock( RIGHT )
		itemdesc:SetWrap( true )
		itemprice:SetPos( 5, 30 )
		itemdesc:SetSize( 320, 110 )
	end
	ply.MenuOpen = true
end

local function HLUButtons( ply, button )
	if IsFirstTimePredicted() and !ply.MenuOpen then
		if button == KEY_F4 then
			DrawJobMenu()
		elseif button == KEY_F3 then
			DrawBuyMenu()
		elseif button == KEY_G then
			RunConsoleCommand( "tfa_vox_callout_panel" )
		end
	end
end
hook.Add( "PlayerButtonDown", "OpenJobBuyMenu", HLUButtons )

surface.CreateFont( "EntitySignFont", {
	font = "Roboto",
	size = 400,
	antialias = true
} )
local meta = FindMetaTable( "Entity" )
local offset = Vector( 0, 0, 80 )
function meta:DrawNPCText( text, override )
	local origin = self:GetPos()
	local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( origin ) >= 589824 then return end

	local pos = origin + ( override or offset )
	local ang = ( ply:EyePos() - pos ):Angle()
	ang.p = 0
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang:RotateAroundAxis( ang:Up(), 90 )
	ang:RotateAroundAxis( ang:Forward(), 180 )
	cam.Start3D2D( pos, ang, 0.035 )
		draw.SimpleText( text, "EntitySignFont", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	cam.End3D2D()
end

--Draw text on item NPCs
hook.Add( "ItemNPC_OnDraw", "ItemNPCDraw", function( npc )
	local type = npc:GetNPCType()
	local name = ItemNPCType[type].Name
	npc:DrawNPCText( name )
end )
