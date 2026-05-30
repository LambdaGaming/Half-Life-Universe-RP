local current = GetGlobalInt( "CurrentGamemode" )
local themecolor = ColorAlpha( HLU_GAMEMODE[current].Color, 40 )

local function DrawUtilityMenu()
	local ply = LocalPlayer()
	local main = vgui.Create( "DFrame" )
	main:SetTitle( "Utility Menu" )
	main:SetSize( ScrW() * 0.70, ScrH() * 0.85 )
	main:SetDraggable( false )
	main:Center()
	main:MakePopup()
	main.Paint = function( self, w, h )
		surface.SetDrawColor( ColorAlpha( themecolor, 200 ) )
		surface.DrawRect( 0, 0, w, h )
	end
	main.OnClose = function()
		ply.MenuOpen = false
	end

	local sheet = vgui.Create( "DPropertySheet", main )
	sheet:Dock( FILL )

	local htmlPanel = vgui.Create( "DPanel", sheet )
	htmlPanel:Dock( FILL )
	local html = vgui.Create( "DHTML", htmlPanel )
	html:Dock( FILL )
	local ctrl = vgui.Create( "DHTMLControls", htmlPanel )
	ctrl:Dock( TOP )
	ctrl:SetHTML( html )
	ctrl.AddressBar:SetText( "https://lambdagaming.github.io/hlurp/main.html" )
	html:OpenURL( "https://lambdagaming.github.io/hlurp/main.html" )
	sheet:AddSheet( "HLU RP Docs", htmlPanel )

	local plyTeam = ply:Team()
	if plyTeam == TEAM_ADMIN or plyTeam == TEAM_MARINEBOSS or plyTeam == TEAM_EARTHADMIN then
		local panel = vgui.Create( "DScrollPanel", sheet )
		panel:Dock( FILL )
		panel.Paint = function( self, w, h )
			surface.SetDrawColor( ColorAlpha( color_darkgray, 200 ) )
			surface.DrawRect( 0, 0, w, h )
		end

		local label = vgui.Create( "DLabel", panel )
		label:Dock( TOP )
		label:DockMargin( 0, 10, 0, 0 )
		label:SetFont( "JobCategory" )
		label:SetAutoStretchVertical( true )
		if current == 1 then
			label:SetText( "Black Mesa Announcement System" )
		else
			label:SetText( "Overwatch Announcements" )
		end

		local label = vgui.Create( "DLabel", panel )
		label:Dock( TOP )
		label:DockMargin( 0, 10, 0, 0 )
		label:SetFont( "TaskFont" )
		label:SetAutoStretchVertical( true )
		if current == 1 then
			label:SetText( "Press a button to insert a preset Vox announcement into the box, or type your own announcement. Press enter when you're ready to broadcast." )
		else
			label:SetText( "Press a button to play an Overwatch announcement." )
		end

		local entry
		if current == 1 then
			entry = vgui.Create( "DTextEntry", panel )
			entry:Dock( TOP )
			entry.OnEnter = function( self )
				net.Start( "PlayAnnouncement" )
				net.WriteString( self:GetValue() )
				net.SendToServer()
				self:SetText( "" )
				main:Close()
			end
		end

		local layout = vgui.Create( "DIconLayout", panel )
		layout:Dock( TOP )
		layout:SetSize( nil, 300 )
		layout:SetSpaceX( 5 )
		layout:SetSpaceY( 5 )
		layout:DockMargin( 0, 15, 0, 15 )

		if current == 1 then
			local btn = layout:Add( "DButton" )
			btn:SetSize( 110, 30 )
			btn:SetText( "Toggle Facility Alarm" )
			btn.DoClick = function()
				net.Start( "PlayAnnouncement" )
				net.SendToServer()
				surface.PlaySound( "buttons/button17.wav" )
			end
        end

		local tbl = plyTeam == TEAM_MARINEBOSS and ANNOUNCEMENTS_HECU or ANNOUNCEMENTS_ADMIN
		for k,v in pairs( tbl ) do
			local btn = layout:Add( "DButton" )
			btn:SetText( v[1] )
			btn.DoClick = function()
				if current == 1 then
					entry:SetText( v[2] )
				else
					net.Start( "PlayAnnouncement" )
					net.WriteString( v[2] )
					net.SendToServer()
					main:Close()
				end
			end
			local w, h = btn:GetTextSize()
			btn:SetSize( w + 10, 30 )
		end
		sheet:AddSheet( "Announcement System", panel )
	end
	ply.MenuOpen = true
end

local function SelectPlayermodel( num, job )
	local ply = LocalPlayer()
	local main = vgui.Create( "DFrame" )
	main:SetTitle( "Choose a new playermodel:" )
	main:SetSize( 365, 240 )
	main:Center()
	main:MakePopup()
	main.Paint = function( self, w, h )
		surface.SetDrawColor( ColorAlpha( themecolor, 200 ) )
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

	local btn = layout:Add( "DButton" )
	btn:SetSize( 60, 60 )
	btn:SetText( "Random" )
	btn.DoClick = function()
		net.Start( "SetPlayermodel" )
		net.WriteString( "" )
		net.WriteInt( num, 8 )
		net.SendToServer()
		if ply:Team() == num then
			ply:Notify( 0, 6, "Your playermodel has been updated." )
		else
			ply:Notify( 0, 6, "Playermodels for this job will be randomly chosen." )
		end
		main:Close()
	end

	for _,v in pairs( job.Models ) do
		local icon = layout:Add( "SpawnIcon" )
		icon:SetModel( v )
		icon:SetToolTip( false )
		icon:SetSize( 60, 60 )
		icon.DoClick = function()
			net.Start( "SetPlayermodel" )
			net.WriteString( v )
			net.WriteInt( num, 8 )
			net.SendToServer()
			if ply:Team() == num then
				ply:Notify( 0, 6, "Your playermodel has been updated." )
			else
				ply:Notify( 0, 6, "This model will be used when you select this job." )
			end
			main:Close()
		end
	end
	ply.MenuOpen = true
end

local function DrawJobMenu()
	local ply = LocalPlayer()
	local main = vgui.Create( "DFrame" )
	main:SetTitle( "Choose a Job:" )
	main:SetSize( 500, 500 )
	main:Center()
	main:MakePopup()
	main.Paint = function( self, w, h )
		surface.SetDrawColor( themecolor )
		surface.DrawRect( 0, 0, w, h )
	end
	main.OnClose = function()
		ply.MenuOpen = false
	end
	local mainscroll = vgui.Create( "DScrollPanel", main )
	mainscroll:Dock( FILL )
	for a,b in ipairs( HLU_JOB_CATEGORY[current] ) do
		local categorybutton = vgui.Create( "DButton", mainscroll )
		categorybutton:SetSize( nil, 30 ) --X is ignored since it's docked to the frame already
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
			draw.RoundedBoxEx( 8, 0, 0, w, h, b.Color, true, true )
		end
		for k,v in ipairs( GetJobList() ) do
			if v.Category != b.Name then --Puts jobs into their respective categories
				continue
			end
			local max
			if v.Max > 0 then
				max = v.Max
			else
				max = "∞"
			end
			local mainbuttons = vgui.Create( "DButton", mainscroll )
			mainbuttons:SetSize( nil, 50 )
			mainbuttons:SetText( v.Name..": "..team.NumPlayers( k ).."/"..max )
			mainbuttons:SetFont( "JobTitle" )
			mainbuttons:SetTextColor( color_white )
			mainbuttons:Dock( TOP )
			mainbuttons:DockMargin( 0, 0, 0, 5 )
			mainbuttons.Paint = function( self, w, h )
				draw.RoundedBoxEx( 8, 0, 0, w, h, v.Color, false, true, false, true )
			end
			mainbuttons.DoClick = function()
				if ply.JobSelectCooldown and ply.JobSelectCooldown > CurTime() then
					ply:Notify( 1, 6, "Please wait a few seconds before changing jobs." )
					return
				end
				if k == TEAM_MARINEBOSS or k == TEAM_MARINE then
					ply:Notify( 1, 8, "Under normal circumstances, players can only become HECU by interacting with the escape truck during the cascade." )
					return
				end
				net.Start( "HLU_ChangeJob" )
				net.WriteUInt( k, 8 )
				net.SendToServer()
				ply.JobSelectCooldown = CurTime() + 5
				main:Close()
			end
			
			local playermodel = vgui.Create( "SpawnIcon", mainbuttons )
			playermodel:SetSize( 50, 50 )
			playermodel:Dock( LEFT )
			playermodel:SetModel( v.Models[1] )
			playermodel.DoClick = function()
				if table.Count( v.Models ) <= 1 then
					ply:Notify( 1, 6, "Only one playermodel is available for this job." )
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
				local rpTypes = { "bmrp", "city17rp", "outandrp" }
				gui.OpenURL( "https://lambdagaming.github.io/hlurp/jobs_"..rpTypes[current]..".html#"..v.Link )
			end
		end
	end
	ply.MenuOpen = true
end

local function DrawBuyMenu()
	local ply = LocalPlayer()
	local main = vgui.Create( "DFrame" )
	main:SetTitle( "Select an item to purchase:" )
	main:SetSize( 500, 500 )
	main:Center()
	main:MakePopup()
	main.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, themecolor )
	end
	main.OnClose = function()
		ply.MenuOpen = false
	end

	local listframe = vgui.Create( "DScrollPanel", main )
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
			main:Close()
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
			main:Close()
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

hook.Add( "PlayerButtonDown", "MenuButtons", function( ply, button )
    if IsFirstTimePredicted() and !ply.MenuOpen then
		if button == KEY_F1 then
			DrawUtilityMenu()
		elseif button == KEY_F3 then
			DrawBuyMenu()
		elseif button == KEY_F4 then
			DrawJobMenu()
		elseif button == KEY_G then
			RunConsoleCommand( "tfa_vox_callout_panel" )
		end
	end
end )
