
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_hlu_chat.lua" )
AddCSLuaFile( "sh_bmrp.lua" )
AddCSLuaFile( "cl_bmrp.lua" )
AddCSLuaFile( "sh_c17.lua" )
AddCSLuaFile( "sh_outland.lua" )

include( "shared.lua" )
include( "sv_hlu_chat.lua" )
include( "sv_bmrp.lua" )
include( "sh_bmrp.lua" )
include( "sv_c17.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )
include( "sv_outland.lua" )

RunConsoleCommand( "sv_alltalk", "2" )

function GM:PlayerSpawnNPC( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnSENT( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnSWEP( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnVehicle( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerNoClip( ply, on )
	if !on then
		return true
	end
	return ply:IsSuperAdmin()
end

function GM:PlayerLoadout( ply )
	local PlyTeam = ply:Team()
    local DefaultWeps = {
        "weapon_physgun",
        "weapon_physcannon",
        "weapon_keys",
        "gmod_tool",
        "gmod_camera"
    }
    for k,v in pairs( DefaultWeps ) do
        ply:Give( v )
    end
    for k,v in pairs( HLU_JOB[GetGlobalInt( "CurrentGamemode" )][PlyTeam].Weapons ) do
		ply:Give( v )
    end
	return true
end

function ChangeTeam( ply, newteam, respawn, silent )
    local tbl = HLU_JOB[GetGlobalInt( "CurrentGamemode" )][newteam]
	if !HLU_JOB[GetGlobalInt( "CurrentGamemode" )] or !HLU_JOB[GetGlobalInt( "CurrentGamemode" )][newteam] then
		HLU_Notify( ply, "Error changing jobs. Job does not exist.", 1, 6 )
		return
	end
	if newteam == ply:Team() then
		HLU_Notify( ply, "You are already playing as this job.", 1, 6 )
		return
	end
	if team.NumPlayers( newteam ) >= tbl.Max and tbl.Max > 0 then
		HLU_Notify( ply, "All slots are filled for this job.", 1, 6 )
		return
	end
	ply:StripWeapons()
	ply:SetTeam( newteam )
	ply:SetModel( table.Random( tbl.Models ) )
	if !silent then
		HLU_Notify( ply, "You have changed your job to "..tbl.Name..".", 0, 6 )
		HLU_Notify( nil, ply:Nick().." has changed their job to "..tbl.Name..".", 0, 6, true )
	end
	hook.Run( "PlayerLoadout", ply )
	if respawn then
		ply:Spawn()
	end
end

util.AddNetworkString( "HLU_ChangeJob" )
net.Receive( "HLU_ChangeJob", function( len, ply )
	local newteam = net.ReadInt( 32 )
	ChangeTeam( ply, newteam )
end )

function GM:PlayerInitialSpawn( ply )
	ChangeTeam( ply, 1, false, true )
	if HLU_JOB[GetGlobalInt( "CurrentGamemode" )][ply:Team()].IsCop then
		ply:SetWalkSpeed( 200 )
		ply:SetRunSpeed( 260 )
	else
		ply:SetWalkSpeed( 180 )
		ply:SetRunSpeed( 240 )
	end
	ply:SetJumpPower( 180 )
	ply:ChatPrint( "Welcome, "..ply:Nick().."! We're currently playing on the "..HLU_GAMEMODE[GetGlobalInt( "CurrentGamemode" )].Name.." gamemode." )
end

hook.Add( "PlayerSpawn", "HLU_SpawnHook", function( ply )
	timer.Simple( 0, function()
		ply:SetModel( table.Random( HLU_JOB[GetGlobalInt( "CurrentGamemode" )][ply:Team()].Models ) )
		if HLU_JOB[GetGlobalInt( "CurrentGamemode" )][ply:Team()].IsCop then
			ply:SetWalkSpeed( 200 )
			ply:SetRunSpeed( 260 )
		else
			ply:SetWalkSpeed( 180 )
			ply:SetRunSpeed( 240 )
		end
		ply:SetJumpPower( 180 )
	end )
end )

function DropWeapon( ply )
	if IsValid( ply ) then
		local wep = ply:GetActiveWeapon()
		local forward = ply:GetForward()
		local DefaultWeps = {
			["weapon_physgun"] = true,
			["weapon_physcannon"] = true,
			["weapon_keys"] = true,
			["gmod_tool"] = true,
			["gmod_camera"] = true
		}
		if IsValid( wep ) then
			if DefaultWeps[wep:GetClass()] then
				HLU_Notify( ply, "You can't drop this weapon.", 1, 6 )
				return
			end
			local e = ents.Create( "hlu_dropped_weapon" )
			e:SetPos( ply:GetPos() - Vector( forward.x, forward.y, -50 ) )
			e:SetModel( wep:GetModel() )
			e:Spawn()
			e.DroppedClass = wep:GetClass()
			wep:Remove()
		end
	end
end
