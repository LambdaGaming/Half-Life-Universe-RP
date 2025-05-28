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
function HLU_ChatNotify( ply, header, headercolor, text, broadcast, speaker )
	net.Start( "HLU_ChatNotify" )
	net.WriteEntity( ply )
	net.WriteString( header )
	net.WriteColor( headercolor )
	net.WriteString( text )
	if speaker then
		net.WriteEntity( speaker )
	end
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
	end,
	["/job"] = function( ply, text )
		ply:SetNWString( "RPJob", text )
		HLU_Notify( ply, "Successfully applied custom job title.", 0, 6 )
		return ""
	end,
	["/name"] = function( ply, text )
		ply:SetNWString( "RPName", text )
		ply:SetPData( "RPName", text )
		HLU_Notify( ply, "Successfully applied RP name.", 0, 6 )
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

function GM:PlayerCanHearPlayersVoice( listener, talker )
	local dist = listener:GetPos():DistToSqr( talker:GetPos() )
	if dist > 250000 then
		return false
	end
	return true, true
end

hook.Add( "PlayerSay", "RangedChatCommands", function( ply, text )
	local split = string.Split( text, " " )
	if split[1]:lower() == "/y" then
		for k,v in ipairs( ents.FindInSphere( ply:GetPos(), 500 ) ) do
			if v:IsPlayer() then
				local msg = string.Right( string.len( text ) - 3 )
				HLU_ChatNotify( v, "Yell", ply:GetJobColor(), msg, false, ply )
			end
		end
		return ""
	elseif split[1]:lower() == "/w" then
		for k,v in ipairs( ents.FindInSphere( ply:GetPos(), 100 ) ) do
			if v:IsPlayer() then
				local msg = string.Right( string.len( text ) - 3 )
				HLU_ChatNotify( v, "Whisper", ply:GetJobColor(), msg, false, ply )
			end
		end
		return ""
	end
end )

local function DetectChatCommand( ply, text )
	local split = string.Split( text, " " )
	if chatcommands[split[1]:lower()] then
		local trimmedtext = string.gsub( text, split[1], "" )
		return chatcommands[split[1]:lower()]( ply, trimmedtext )
	end
end
hook.Add( "PlayerSay", "DetectChatCommand", DetectChatCommand )
