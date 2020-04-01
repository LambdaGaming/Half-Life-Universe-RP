
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
function HLU_ChatNotifySystem( header, headercolor, text, private, ply )
	net.Start( "HLU_ChatNotifySystem" )
	net.WriteString( header )
	net.WriteColor( headercolor )
	net.WriteString( text )
	if private and ply then
		net.Send( ply )
	else
		net.Broadcast()
	end
end

local function GetSameCategory( ply, v )
	local job = HLU_JOB[GetGlobalInt( "CurrentGamemode" )]
	if job[ply:Team()].Category == job[v:Team()].Category then
		return true
	end
	return false
end

local function CheckTeamPlayers( ply, text )
	for k,v in pairs( player.GetHumans() ) do
		if GetSameCategory( ply, v ) or ply:Team() == v:Team() or v == ply then
			return true
		end
	end
	return false
end

local chatcommands = {
	["/ooc"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, text, true )
		return false
	end,
	["//"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, text, true )
		return false
	end,
	["/advert"] = function( ply, text )
		HLU_ChatNotify( ply, "Announcement", color_red, text, true )
		return false
	end,
	["/drop"] = function()
		DropWeapon( ply )
		return false
	end
}

function GM:PlayerCanSeePlayersChat( text, teamOnly, listener, speaker )
    local dist = listener:GetPos():DistToSqr( speaker:GetPos() )
    local split = string.Split( text, " " )
	if teamOnly then
		return CheckTeamPlayers( speaker, text )
	end
	if chatcommands[split[1]] then
		local trimmedtext = string.gsub( text, split[1], "" )
		return chatcommands[split[1]]( speaker, trimmedtext )
	end
    return dist <= 90000
end

--[[ function GM:PlayerCanHearPlayersVoice( listener, talker ) --Only use as a last resort if sv_alltalk 2 doesn't work
	local dist = 250000
	local listenpos = listener:GetPos()
	local talkpos = talker:GetPos()
	if listenpos:DistToSqr( talkpos ) <= dist then return true end
	return false
end ]]
