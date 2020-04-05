include('shared.lua')

local function Menu()
	local Frame = vgui.Create( "DFrame" )
	Frame:SetTitle( "Budget Manager" )
	Frame:SetSize( 300, 350 )
	Frame:Center()
	Frame:MakePopup()
	Frame.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, ColorAlpha( color_orange, 30 ) )
	end
	
	local richtext = vgui.Create( "RichText", Frame )
	richtext:Dock( FILL )
	richtext:AppendText( "The budget isn't doing so good. Select an option below to fix it." )
	richtext:CenterHorizontal()
	
	local Button = vgui.Create( "DButton", Frame )
	Button:SetText( "Take out $5,000 loan." )
	Button:SetTextColor( color_black )
	Button:SetPos( 100, 100 )
	Button:SetSize( 150, 30 )
	Button:CenterHorizontal()
	Button.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_white )
	end
	Button.DoClick = function()
		Frame:Close()
		net.Start( "GiveLoan" )
		net.SendToServer()
	end
	
	local Button2 = vgui.Create( "DButton", Frame )
	Button2:SetText( "Sell Lab Equipment" )
	Button2:SetTextColor( color_black )
	Button2:SetPos( 100, 150 )
	Button2:SetSize( 150, 30 )
	Button2:CenterHorizontal()
	Button2.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_white )
	end
	Button2.DoClick = function()
		Frame:Close()
		net.Start( "SellEquipment" )
		net.SendToServer()
	end

	local Button3 = vgui.Create( "DButton", Frame )
	Button3:SetText( "Dismiss" )
	Button3:SetTextColor( color_black )
	Button3:SetPos( 100, 200 )
	Button3:SetSize( 150, 30 )
	Button3:CenterHorizontal()
	Button3.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, color_white )
	end
	Button3.DoClick = function()
		Frame:Close()
	end
end
net.Receive( "BudgetMenu", Menu )

function ENT:Draw()
    self:DrawModel()
end