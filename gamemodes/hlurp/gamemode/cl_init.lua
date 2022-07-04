include( "shared.lua" )
include( "cl_hlu_chat.lua" )
include( "sh_bmrp.lua" )
include( "cl_bmrp.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )

local themecolor = ColorAlpha( HLU_GAMEMODE[GetGlobalInt( "CurrentGamemode" )].Color, 30 )
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
local function IsDarkColor( color )
	return 0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b < 255 / 3
end

scoreboard = scoreboard or {}
function scoreboard:show()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetSize( ScrW() * 0.70, ScrH() * 0.70 )
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
	plylist:AddColumn( "Name" )
	plylist:AddColumn( "Job" )
	plylist:AddColumn( "Health" )
	plylist:AddColumn( "Kills" )
	plylist:AddColumn( "Deaths" )
	plylist:SetDataHeight( 30 )
	plylist.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_transparent )
	end

	for k,v in ipairs( player.GetAll() ) do
		local row = plylist:AddLine( v:Nick(), v:GetJobName(), v:Health(), v:Frags(), v:Deaths() )
		for i=1,5 do
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
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( "Choose a Playermodel:" )
	mainframe:SetSize( ScrW() * 0.1, ScrH() * 0.5 )
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
	for k,v in pairs( job.Models ) do
		local itembackground = vgui.Create( "DPanel", listframe )
		itembackground:SetPos( 0, 10 )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:Center()
		itembackground.Paint = function()
			draw.RoundedBox( 0, 0, 0, itembackground:GetWide(), itembackground:GetTall(), color_transparent )
		end
		local itemicon = vgui.Create( "SpawnIcon", itembackground )
		itemicon:SetPos( 10, 30 )
		itemicon:SetModel( v )
		itemicon:SetToolTip( false )
		itemicon:SetSize( 60, 60 )
		itemicon.DoClick = function()
			net.Start( "SetPlayermodel" )
			net.WriteString( v )
			net.WriteInt( num, 32 )
			net.SendToServer()
			mainframe:Close()
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
				mainframe:Close()
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
					current = "outlandrp"
				end
				gui.OpenURL( "https://lambdagaming.github.io/hlurp/jobs_"..rptype..".html#"..v.Link )
			end
		end
	end
	ply.MenuOpen = true
end

local function HLUButtons( ply, button )
	local f4 = KEY_F4
	local f3 = KEY_F3
	if !IsFirstTimePredicted() then return end
	if button == f4 and !ply.MenuOpen then
		DrawJobMenu()
	end
	if button == f3 then
		gui.OpenURL( "https://lambdagaming.github.io/hlurp/main.html" )
	end
end
hook.Add( "PlayerButtonDown", "HP_ChangeTeam", HLUButtons )
