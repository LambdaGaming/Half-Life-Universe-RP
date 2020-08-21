
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

surface.CreateFont( "JobDesc", {
	font = "Arial",
	size = 16
} )

function GM:DrawDeathNotice()
	return false
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
	mainframe:SetSize( ScrW() * 0.75, ScrH() * 0.75 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	mainframe.OnClose = function()
		ply.MenuOpen = false
	end
	local mainframescroll = vgui.Create( "DScrollPanel", mainframe )
	mainframescroll:Dock( FILL )
	for a,b in ipairs( HLU_JOB_CATEGORY[GetGlobalInt( "CurrentGamemode" )] ) do
		local categorybutton = vgui.Create( "DButton", mainframescroll )
		categorybutton:SetSize( nil, 50 ) --X is ignored since it's docked to the frame already
		categorybutton:SetText( b.Name )
		categorybutton:SetFont( "JobCategory" )
		categorybutton:SetTextColor( color_white )
		categorybutton:Dock( TOP )
		if a > 1 then
			categorybutton:DockMargin( 0, 60, 0, 5 )
		else
			categorybutton:DockMargin( 0, 0, 0, 5 )
		end
		categorybutton.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, b.Color )
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
			mainbuttons:SetSize( nil, 100 )
			mainbuttons:SetText( v.Name..": "..team.NumPlayers( k ).."/"..max )
			mainbuttons:SetTextInset( 0, -30 )
			mainbuttons:SetFont( "JobTitle" )
			mainbuttons:SetTextColor( color_white )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBox( 0, 0, 0, w, h, v.Color )
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
			local buttontext = vgui.Create( "DLabel", mainbuttons )
			local bwidth, bheight = mainbuttons:GetSize()
			buttontext:Dock( BOTTOM )
			buttontext:DockMargin( 200, 5, 200, 15 )
			buttontext:SetAutoStretchVertical( true )
			buttontext:SetText( "Description: "..v.Description )
			buttontext:SetTextColor( color_white )
			buttontext:SetFont( "JobDesc" )
			buttontext:SetWrap( true )

			local newwidth, newheight = buttontext:GetTextSize()
			if newheight > 7000 then
				mainbuttons:SetSize( bwidth, newheight * 0.015 )
			end
			
			if #v.Models > 1 then
				local playermodel = vgui.Create( "DButton", mainbuttons )
				playermodel:SetSize( 200, nil )
				playermodel:SetText( "Select Playermodel" )
				playermodel:SetFont( "JobTitle" )
				playermodel:SetTextColor( color_white )
				playermodel:Dock( RIGHT )
				playermodel.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, color_transparent )
				end
				playermodel.DoClick = function()
					mainframe:Close()
					SelectPlayermodel( k, v )
				end
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
		gui.OpenURL( "https://lambdagaming.github.io/hlurp/lambda_hlu_main.html" )
	end
end
hook.Add( "PlayerButtonDown", "HP_ChangeTeam", HLUButtons )
