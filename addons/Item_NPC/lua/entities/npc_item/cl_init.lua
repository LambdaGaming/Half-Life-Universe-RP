
include('shared.lua')

surface.CreateFont( "ItemNPCTitleFont", {
	font = "Arial",
	size = 22,
	antialias = true
} )

surface.CreateFont( "ItemNPCHeadFont", {
	font = "Roboto",
	size = 40,
	antialias = true
} )

function ENT:Draw()
	self:DrawModel()

	local pos = self:GetPos()
	pos.z = pos.z + 15

	local ang = self:GetAngles()

	surface.SetFont( "ItemNPCHeadFont" )

	local title = ItemNPCType[self:GetNPCType()].Name
	local tw = surface.GetTextSize( title )
	local textcolor = Color( 38, 41, 49, 255 )

	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), -90 )

	cam.Start3D2D( pos + ang:Right() * -30, ang, 0.2 )
		draw.WordBox( 2, -tw *0.5 + 5, -180, title, "ItemNPCHeadFont", textcolor, color_white )
	cam.End3D2D()
end

local function DrawItemMenu( ent ) --Panel that draws the main menu
	local type = ent:GetNPCType()
	local ply = LocalPlayer()
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( ItemNPCType[type].Name )
	mainframe:SetSize( 500, 800 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, ItemNPCType[type].MenuColor )
	end

	local listframe = vgui.Create( "DScrollPanel", mainframe )
	listframe:Dock( FILL )
	for k,v in pairs( ItemNPC ) do
		if v.Type != type then
			continue
		end
		local itembackground = vgui.Create( "DPanel", listframe )
		itembackground:SetPos( 0, 10 )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:DockMargin( 0, 0, 0, 10 )
		itembackground:Center()
		itembackground.Paint = function()
			draw.RoundedBox( 0, 0, 0, itembackground:GetWide(), itembackground:GetTall(), Color( ItemNPCType[type].MenuColor.r, ItemNPCType[type].MenuColor.g, ItemNPCType[type].MenuColor.b, 255 ) )
		end

		local mainbuttons = vgui.Create( "DButton", itembackground )
		mainbuttons:SetText( v.Name )
		mainbuttons:SetTextColor( ItemNPCType[type].ButtonTextColor )
		mainbuttons:SetFont( "ItemNPCTitleFont" )
		mainbuttons:Dock( TOP )
		mainbuttons.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, ItemNPCType[type].ButtonColor )
		end
		mainbuttons.DoClick = function()
			net.Start( "CreateItem" )
			net.WriteEntity( ent )
			net.WriteString( k )
			net.SendToServer()
			mainframe:Close()
		end

		if v.Model then
			local itemicon = vgui.Create( "SpawnIcon", itembackground )
			itemicon:SetPos( 10, 30 )
			itemicon:SetModel( v.Model )
			itemicon:SetToolTip( false )
			itemicon:SetSize( 60, 60 )
			itemicon.DoClick = function()
				mainframe:ToggleVisible()

				local modelpanel = vgui.Create( "DFrame" )
				modelpanel:SetTitle( v.Name )
				modelpanel:SetSize( 350, 350 )
				modelpanel:Center()
				modelpanel:MakePopup()
				modelpanel.OnClose = function()
					mainframe:ToggleVisible()
				end
				modelpanel.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, ItemNPCType[type].MenuColor )
				end

				local modelpanel2 = vgui.Create( "DAdjustableModelPanel", modelpanel )
				modelpanel2:SetPos( 0, 0 )
				modelpanel2:SetSize( 320, 320 )
				modelpanel2:SetLookAt( Vector( 0, 0, 10 ) )
				modelpanel2:SetCamPos( Vector( -10, 0, 0 ) )
				modelpanel2:SetModel( v.Model )
			end
		end

		local itemprice = vgui.Create( "DLabel", itembackground )
		itemprice:SetFont( "Trebuchet24" )
		itemprice:SetColor( ItemNPCType[type].MenuTextColor )
		if v.Price <= 0 then
			itemprice:SetText( "Price: Free" )
		else
			itemprice:SetText( "Price: "..DarkRP.formatMoney( v.Price ) )
		end
		itemprice:SizeToContents()

		local itemdesc = vgui.Create( "DLabel", itembackground )
		itemdesc:SetFont( "Trebuchet18" )
		itemdesc:SetColor( ItemNPCType[type].MenuTextColor )
		itemdesc:SetText( "Description: "..v.Description )
		itemdesc:SetWrap( true )

		if v.Model then
			itemprice:SetPos( 85, 30 )
			itemdesc:SetSize( 240, 100 )
			itemdesc:SetPos( 225, 0 )
		else
			itemprice:SetPos( 5, 30 )
			itemdesc:SetSize( 320, 110 )
			itemdesc:SetPos( 150, -8 )
		end
	end
end

net.Receive( "ItemNPCMenu", function( len, ply ) --Receiving the net message to open the menu
	local ent = net.ReadEntity()
	DrawItemMenu( ent )
end )
