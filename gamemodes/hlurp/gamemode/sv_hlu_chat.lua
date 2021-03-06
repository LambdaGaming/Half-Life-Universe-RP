
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

local function GetSameCategory( ply, listener )
	local job = HLU_JOB[GetGlobalInt( "CurrentGamemode" )]
	if job[ply:Team()].Category == job[listener:Team()].Category then
		return true
	end
	return false
end

local function CheckTeamPlayers( listener, ply, text )
	if listener == ply or ply:Team() == listener:Team() or GetSameCategory( ply, listener ) then
		return true
	end
	return false
end

local chatcommands = {
	["/ooc"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, text, true )
		return ""
	end,
	["//"] = function( ply, text )
		HLU_ChatNotify( ply, "OOC", color_red, text, true )
		return ""
	end,
	["/advert"] = function( ply, text )
		HLU_ChatNotify( ply, "Announcement", color_red, text, true )
		return ""
	end,
	["/drop"] = function( ply )
		DropWeapon( ply )
		return ""
	end
}

function GM:PlayerCanSeePlayersChat( text, teamOnly, listener, speaker )
    local dist = listener:GetPos():DistToSqr( speaker:GetPos() )
	if teamOnly then
		return CheckTeamPlayers( listener, speaker, text )
	end
    return dist <= 90000
end

local function DetectChatCommand( ply, text )
	local split = string.Split( text, " " )
	if chatcommands[split[1]] then
		local trimmedtext = string.gsub( text, split[1], "" )
		return chatcommands[split[1]]( ply, trimmedtext )
	end
end
hook.Add( "PlayerSay", "DetectChatCommand", DetectChatCommand )

local function ShortenVoiceRange( listener, talker ) --Using this along with sv_alltalk 2 since all voice chats emit sound at 0,0,0 on the map for some reason
	local dist = 562500
	local listenpos = listener:GetPos()
	local talkpos = talker:GetPos()
	if listenpos:DistToSqr( talkpos ) <= dist then return true end
	return false
end
hook.Add( "PlayerCanHearPlayersVoice", "ShortenVoiceRange", ShortenVoiceRange )
