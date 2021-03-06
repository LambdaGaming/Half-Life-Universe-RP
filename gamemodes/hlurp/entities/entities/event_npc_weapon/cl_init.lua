include('shared.lua')

local function Menu()
	local ent = net.ReadEntity()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Corporal Shepard" )
	Frame:SetSize( 300, 300 )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( color_orange, 30 ) )
	end
	
	local richtext = vgui.Create( "RichText", Frame )
	richtext:Dock( FILL )
	richtext:AppendText( "The weapon I want has been printed to chat." )
	richtext:CenterHorizontal()
	
	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "I'll get that weapon to you." )
	Button:SetTextColor( color_black )
	Button:SetPos( 100, 100 )
	Button:SetSize( 150, 30 )
	Button:CenterHorizontal()
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_white )
	end
	Button.DoClick = function()
		Frame:Remove()
		net.Start("WepAccept")
		net.SendToServer()
	end
	
	local Button2 = vgui.Create( "DButton", Frame )
	Button2:SetText( "Sorry, not right now." )
	Button2:SetTextColor( color_black )
	Button2:SetPos( 100, 150 )
	Button2:SetSize( 150, 30 )
	Button2:CenterHorizontal()
	Button2.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_white )
	end
	Button2.DoClick = function()
		Frame:Remove()
		net.Start("WepDeny")
		net.WriteEntity( ent )
		net.SendToServer()
	end
end
net.Receive( "WepMenu", Menu )

function ENT:Draw()
    self:DrawModel()
end