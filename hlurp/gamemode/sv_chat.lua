util.AddNetworkString( "HLU_Notify" )
local meta = FindMetaTable( "Player" )
function meta:Notify( type, len, text )
	net.Start( "HLU_Notify" )
	net.WriteString( text )
	net.WriteUInt( type, 3 )
	net.WriteUInt( len, 6 )
	net.Send( self )
end

function BroadcastNotify( type, len, text )
	net.Start( "HLU_Notify" )
	net.WriteString( text )
	net.WriteUInt( type, 3 )
	net.WriteUInt( len, 6 )
	net.Broadcast()
end

util.AddNetworkString( "HLU_ChatNotify" )
function meta:ChatNotify( header, color, text, speaker )
	net.Start( "HLU_ChatNotify" )
	net.WriteString( header )
	net.WriteColor( color )
	net.WriteString( text )
	if speaker then
		net.WriteEntity( speaker )
	end
	net.Send( self )
end

function BroadcastChat( header, color, text, speaker )
	net.Start( "HLU_ChatNotify" )
	net.WriteString( header )
	net.WriteColor( color )
	net.WriteString( text )
	if speaker then
		net.WriteEntity( speaker )
	end
	net.Broadcast()
end

util.AddNetworkString( "HLU_ChatNotifySystem" )
function meta:SystemChat( header, color, text )
	net.Start( "HLU_ChatNotifySystem" )
	net.WriteString( header )
	net.WriteColor( color )
	net.WriteString( text )
	net.Send( self )
end

function BroadcastSystemChat( header, color, text )
	net.Start( "HLU_ChatNotifySystem" )
	net.WriteString( header )
	net.WriteColor( color )
	net.WriteString( text )
	net.Broadcast()
end

local function GetSameCategory( ply, listener )
	local job = GetJobList()
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
		BroadcastChat( "OOC", color_red, text )
		return ""
	end,
	["//"] = function( ply, text )
		BroadcastChat( "OOC", color_red, text )
		return ""
	end,
	["/advert"] = function( ply, text )
		BroadcastChat( "Announcement", color_red, text )
		return ""
	end,
	["/drop"] = function( ply )
		ply:DropWeapon()
		return ""
	end,
	["/job"] = function( ply, text )
		ply:SetNWString( "RPJob", text )
		ply:Notify( 0, 6, "Successfully applied custom job title." )
		return ""
	end,
	["/name"] = function( ply, text )
		ply:SetNWString( "RPName", text )
		ply:SetPData( "RPName", text )
		ply:Notify( 0, 6, "Successfully applied RP name." )
		return ""
	end,
	["!addons"] = function( ply )
		ply:SendLua( [[gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=587127431" )]] )
		return ""
	end,
	["!help"] = function( ply )
		ply:SendLua( [[gui.OpenURL( "https://lambdagaming.github.io/hlurp/main.html" )]] )
		return ""
	end,
	["!discord"] = function( ply )
		ply:ChatPrint( "https://discord.gg/9RGdUS2" )
		return ""
	end,
	["!fireoff"] = function( ply )
		if !ply:IsSuperAdmin() then
			ply:Notify( 1, 6, "Only superadmins can use this command." )
			return ""
		end
		RunConsoleCommand( "vfire_remove_all" )
		BroadcastNotify( 0, 6, ply:Nick().." turned off all fires." )
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
				v:ChatNotify( "Yell", ply:GetJobColor(), msg, false, ply )
			end
		end
		return ""
	elseif split[1]:lower() == "/w" then
		for k,v in ipairs( ents.FindInSphere( ply:GetPos(), 100 ) ) do
			if v:IsPlayer() then
				local msg = string.Right( string.len( text ) - 3 )
				v:ChatNotify( "Whisper", ply:GetJobColor(), msg, false, ply )
			end
		end
		return ""
	end
end )

hook.Add( "PlayerSay", "DetectChatCommand", function( ply, text )
	local split = string.Split( text, " " )
	if chatcommands[split[1]:lower()] then
		local trimmedtext = string.gsub( text, split[1], "" )
		return chatcommands[split[1]:lower()]( ply, trimmedtext )
	end
end )
