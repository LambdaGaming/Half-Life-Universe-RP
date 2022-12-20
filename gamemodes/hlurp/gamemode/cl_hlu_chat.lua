function HLU_Notify( text, type, len )
	notification.AddLegacy( text, type, len )
	surface.PlaySound( "buttons/lightswitch2.wav" )
end
net.Receive( "HLU_Notify", function()
	local text = net.ReadString()
	local type = net.ReadInt( 32 )
	local len = net.ReadInt( 32 )
	HLU_Notify( text, type, len )
end )

function HLU_ChatNotify( ply, header, headercolor, text, speaker )
	local spkr = speaker:IsPlayer() and speaker or ply
	chat.AddText( headercolor, "["..header.."] ", team.GetColor( spkr:Team() ), spkr:Nick(), color_white, ": "..text )
	chat.PlaySound()
end
net.Receive( "HLU_ChatNotify", function()
	local ply = net.ReadEntity()
	local header = net.ReadString()
	local headercolor = net.ReadColor()
	local text = net.ReadString()
	local speaker = net.ReadEntity()
	if !ply:IsPlayer() then return end
	HLU_ChatNotify( ply, header, headercolor, text, speaker )
end )

function HLU_ChatNotifySystem( header, headercolor, text )
	chat.AddText( headercolor, "["..header.."]", color_white, ": "..text )
end
net.Receive( "HLU_ChatNotifySystem", function()
	local header = net.ReadString()
	local headercolor = net.ReadColor()
	local text = net.ReadString()
	HLU_ChatNotifySystem( header, headercolor, text )
end )

hook.Add( "OnPlayerChat", "HLU_OnPlayerChat", function( ply, text, team, dead )
	if ply != LocalPlayer() then
		chat.PlaySound()
	end
end )
