local meta = FindMetaTable( "Player" )
function meta:Notify( type, len, text )
	notification.AddLegacy( text, type, len )
	surface.PlaySound( "buttons/lightswitch2.wav" )
end
net.Receive( "HLU_Notify", function()
	local ply = LocalPlayer()
	local text = net.ReadString()
	local type = net.ReadUInt( 3 )
	local len = net.ReadUInt( 6 )
	ply:Notify( type, len, text )
end )

function meta:ChatNotify( header, color, text, speaker )
	local spkr = speaker or self
	chat.AddText( color, "["..header.."] ", team.GetColor( spkr:Team() ), spkr:Nick(), color_white, ": "..text )
	chat.PlaySound()
end
net.Receive( "HLU_ChatNotify", function()
	local ply = LocalPlayer()
	local header = net.ReadString()
	local color = net.ReadColor()
	local text = net.ReadString()
	local speaker = net.ReadEntity()
	ply:ChatNotify( header, color, text, speaker )
end )

function meta:SystemChat( header, color, text )
	chat.AddText( color, "["..header.."]", color_white, ": "..text )
end
net.Receive( "HLU_ChatNotifySystem", function()
	local ply = LocalPlayer()
	local header = net.ReadString()
	local color = net.ReadColor()
	local text = net.ReadString()
	ply:SystemChat( header, color, text )
end )

hook.Add( "OnPlayerChat", "HLU_OnPlayerChat", function( ply, text, tm, dead )
	if ply != LocalPlayer() then
		chat.PlaySound()
	end
	local decorator = tm and "(Team) " or ""
	chat.AddText( team.GetColor( ply:Team() ), decorator, ply:Nick(), color_white, ": "..text )
	return true
end )
