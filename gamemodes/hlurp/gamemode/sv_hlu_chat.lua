
util.AddNetworkString( "HLU_Notify" )
function HLU_Notify( ply, text, type, len, broadcast )
	net.Start( "HLU_Notify" )
	net.WriteString( text )
	net.WriteInt( type, 32 )
	net.WriteInt( len, 32 )
	if broadcast then
		net.Broadcast()
	else
		net.Send( ply )
	end
end

util.AddNetworkString( "HLU_ChatNotify" )
function HLU_ChatNotify( ply, header, headercolor, text, broadcast )
	net.Start( "HLU_ChatNotify" )
	net.WriteEntity( ply )
	net.WriteString( header )
	net.WriteColor( headercolor )
	net.WriteString( text )
	if broadcast then
		net.Broadcast()
	else
		net.Send( ply )
	end
end

util.AddNetworkString( "HLU_ChatNotifySystem" )
function HLU_ChatNotifySystem( header, headercolor, text )
	net.Start( "HLU_ChatNotify" )
	net.WriteString( header )
	net.WriteColor( headercolor )
	net.WriteString( text )
	net.Broadcast()
end

function CheckChatArea( ply, text )
	for k,v in pairs( player.GetHumans() ) do
		if v == ply or v:GetPos():DistToSqr( ply:GetPos() ) <= 10000 then
			return text
		end
	end
	return ""
end

--[[ function GM:PlayerSay( ply, text )
	local split = string.Split( text, " " )
	local trimmedtext = string.gsub( text, split[1], "" )
	if split[1] == "/ooc" or split[1] == "//" then
		
	end
	if split[1] == "/advert" then
		HLU_ChatNotify( ply, "Announcement", color_red, trimmedtext, true )
		return ""
	end
	CheckChatArea( ply, text )
	return ""
end ]]

local chatcommands = {
	["/ooc"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, trimmedtext, true )
		return ""
	end,
	["//"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, trimmedtext, true )
		return ""
	end,
	["/advert"] = function( ply, text )
		HLU_ChatNotify( ply, "Announcement", color_red, trimmedtext, true )
		return ""
	end,
	["/drop"] = function( ply, text )
		DropWeapon( ply )
		return ""
	end
}
hook.Add( "PlayerSay", "HLU_ChatOverride", function( ply, text )
	local split = string.Split( text, " " )
	if chatcommands[split[1]] then
		local trimmedtext = string.gsub( text, split[1], "" )
		return chatcommands[split[1]]( ply, trimmedtext )
	end
	return CheckChatArea( ply, text )
end )

--[[ function GM:PlayerCanHearPlayersVoice( listener, talker ) --Only use as a last resort if sv_alltalk 2 doesn't work
	local dist = 40000
	local listenpos = listener:GetPos()
	local talkpos = talker:GetPos()
	if listenpos:DistToSqr( talkpos ) <= dist then return true end
	return false
end ]]
