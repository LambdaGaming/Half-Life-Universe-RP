include('shared.lua')

local function Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Government Man" )
	Frame:SetSize( 300, 300 )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
	end
	
	local richtext = vgui.Create( "RichText", Frame )
	richtext:Dock( FILL )
	richtext:AppendText( "You have violated numerous safety protocols and as a result had an employee death. You now have the following choices:" )
	richtext:CenterHorizontal()
	
	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "Resign as administrator." )
	Button:SetTextColor( color_white )
	Button:SetPos( 100, 100 )
	Button:SetSize( 150, 30 )
	Button:CenterHorizontal()
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) )
	end
	Button.DoClick = function()
		Frame:Remove()
		net.Start("ReviveFireAdmin")
		net.SendToServer()
	end
	
	local disabled = nil
	
	local Button2 = vgui.Create( "DButton", Frame )
	Button2:SetText( "Pay a fine of $5000." )
	Button2:SetTextColor( color_white )
	Button2:SetPos( 100, 150 )
	Button2:SetSize( 150, 30 )
	Button2:CenterHorizontal()
	if LocalPlayer().DarkRPVars.money < 5000 then
		Button2:SetDisabled( true )
		Button2:SetToolTip("You cannot afford this option!")
	end
	Button2.Paint = function( self, w, h )
		if LocalPlayer().DarkRPVars.money >= 5000 then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color( 128, 128, 128, 250 ) )
		end
	end
	Button2.DoClick = function()
		Frame:Remove()
		net.Start("ReviveRemoveCash")
		net.SendToServer()
	end
	
	local Button3 = vgui.Create( "DButton", Frame )
	Button3:SetText( "Call security on this man." )
	Button3:SetTextColor( color_white )
	Button3:SetPos( 100, 200 )
	Button3:SetSize( 150, 30 )
	Button3:CenterHorizontal()
	Button3.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) )
	end
	Button3.DoClick = function()
		Frame:Remove()
		net.Start("ReviveSecurity")
		net.SendToServer()
	end
end
usermessage.Hook( "ReviveGovMenu", Menu )

function ENT:Draw()
    self:DrawModel()
end