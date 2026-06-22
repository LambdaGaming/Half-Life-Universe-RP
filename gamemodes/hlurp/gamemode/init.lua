AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_chat.lua" )
AddCSLuaFile( "cl_bmrp.lua" )
AddCSLuaFile( "cl_menus.lua" )
AddCSLuaFile( "sh_jobs.lua" )
AddCSLuaFile( "sh_bmrp.lua" )
AddCSLuaFile( "sh_bmrp_events.lua" )
AddCSLuaFile( "sh_c17.lua" )
AddCSLuaFile( "sh_outland.lua" )
AddCSLuaFile( "modules/sh_crafting_items.lua" )
AddCSLuaFile( "modules/sh_npc_items.lua" )
AddCSLuaFile( "modules/sh_door_config.lua" )

include( "shared.lua" )
include( "sh_jobs.lua" )
include( "sh_bmrp.lua" )
include( "sh_bmrp_events.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )
include( "sv_chat.lua" )
include( "sv_bmrp.lua" )
include( "sv_c17.lua" )
include( "sv_outland.lua" )
include( "sv_c17_events.lua" )
include( "sv_utils.lua" )
include( "modules/sh_crafting_items.lua" )
include( "modules/sh_npc_items.lua" )
include( "modules/sh_door_config.lua" )
include( "modules/sv_persist.lua" )

local mode = GetGlobalInt( "CurrentGamemode" )
RunConsoleCommand( "sv_alltalk", "0" )
if mode == 1 then
	RunConsoleCommand( "vfire_spread_delay", "5" )
	RunConsoleCommand( "vfire_decay_rate", "0" )
	RunConsoleCommand( "vfire_spread_boost", "10" )
else
	RunConsoleCommand( "vfire_spread_delay", "60" )
	RunConsoleCommand( "vfire_decay_rate", "10" )
	RunConsoleCommand( "vfire_spread_boost", "0" )
end

function GM:PlayerSpawnNPC( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnSENT( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnSWEP( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerGiveSWEP( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerSpawnVehicle( ply )
	return ply:IsSuperAdmin()
end

function GM:PlayerNoClip( ply, on )
	return ply:IsSuperAdmin() or !on
end

function GM:ShowHelp() end
function GM:ShowTeam() end

function GM:PlayerLoadout( ply )
	local PlyTeam = ply:Team()
    local DefaultWeps = {
        "weapon_physgun",
        "weapon_physcannon",
        "weapon_keys",
        "gmod_tool",
        "gmod_camera",
		"pocket"
    }
    for k,v in pairs( DefaultWeps ) do
        ply:Give( v )
    end
    for k,v in pairs( GetJobInfo( PlyTeam ).Weapons ) do
		ply:Give( v )
    end
	return true
end

function GM:PlayerSetHandsModel( ply, ent )
	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if info then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end
end

function GM:PlayerInitialSpawn( ply )
	ply:ChangeTeam( 1, false, true )
	if GetJobInfo( ply:Team() ).IsCop then
		ply:SetWalkSpeed( 200 )
		ply:SetRunSpeed( 270 )
	else
		ply:SetWalkSpeed( 180 )
		ply:SetRunSpeed( 250 )
	end
	ply:SetJumpPower( 170 )
	ply:ChatPrint( "Welcome, "..ply:Nick().."! We're currently playing on the "..HLU_GAMEMODE[mode].Name.." gamemode." )

	local rpname = ply:GetPData( "RPName" )
	if rpname then
		ply:SetNWString( "RPName", rpname )
	end
end

--Job change handler
util.AddNetworkString( "HLU_ChangeJob" )
net.Receive( "HLU_ChangeJob", function( len, ply )
	local new = net.ReadUInt( 8 )
	ply:ChangeTeam( new )
end )

--Player spawn handler
hook.Add( "PlayerSpawn", "HLU_SpawnHook", function( ply )
	timer.Simple( 0, function()
		local jobtable = GetJobInfo( ply:Team() )
		local model = ply:GetNWString( "SetPlayermodel_"..ply:Team() )
		if model == "" then
			ply:SetModel( table.Random( jobtable.Models ) )
		else
			ply:SetModel( model )
		end
		if jobtable.IsCop then
			ply:SetWalkSpeed( 200 )
			ply:SetRunSpeed( 270 )
		else
			ply:SetWalkSpeed( 180 )
			ply:SetRunSpeed( 250 )
		end
		ply:SetJumpPower( 170 )
		if jobtable.SpawnFunction then
			jobtable.SpawnFunction( ply )
		end
		ply.IsZombie = false
	end )
end )

--Drop current weapon on death
hook.Add( "DoPlayerDeath", "HLU_DropWeaponDeath", function( ply, attacker, dmg )
	local wep = ply:GetActiveWeapon()
	if !IsValid( wep ) or DROP_BLACKLIST[wep:GetClass()] then return end
	local model = wep:GetWeaponWorldModel() or "models/weapons/w_rif_m4a1.mdl"
	local e = ents.Create( "hlu_dropped_weapon" )
	e:SetPos( ply:GetPos() + Vector( 0, 0, 30 ) )
	e:SetModel( model )
	e:Spawn()
	e.DroppedClass = wep:GetClass()
	wep:Remove()
end )

--Spawn interactive NPCs
hook.Add( "InitPostEntity", "HLU_SpawnNPCs", function()
	timer.Simple( 10, function()
		local map = game.GetMap()
		if map == "rp_bmrf" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( 5614, -53, -45 ) )
			e:SetAngles( Angle( 0, -90, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local budget = ents.Create( "budget_npc" )
			budget:SetPos( Vector( -404, 2374, -63 ) )
			budget:SetAngles( Angle( 0, 90, 0 ) )
			budget:Spawn()
		elseif map == "gm_atomic" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( -8407, -1818, -12639 ) )
			e:SetAngles( Angle( 0, 90, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local e2 = ents.Create( "npc_item" )
			e2:SetPos( Vector( 4046, 3826, -12271 ) )
			e2:SetAngles( Angle( 0, -90, 0 ) )
			e2:Spawn()
			e2:ApplyType( 1 )
		elseif map == "rp_mezs" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( -1631, -2762, 6829 ) )
			e:SetAngles( Angle( 0, 180, 0 ) )
			e:Spawn()
			e:ApplyType( 2 )
		end
	end )
end )

--Playermodel change handler
util.AddNetworkString( "SetPlayermodel" )
net.Receive( "SetPlayermodel", function( len, ply )
	local model = net.ReadString()
	local job = net.ReadInt( 8 )
	ply:SetNWString( "SetPlayermodel_"..job, model )
	if ply:Team() == job then
		if model == "" then
			local tbl = GetJobInfo( job )
			ply:SetModel( table.Random( tbl.Models ) )
			return
		end
		ply:SetModel( model )
	end
end )

--F3 menu item purchase handler
util.AddNetworkString( "BuyItemFromMenu" )
net.Receive( "BuyItemFromMenu", function( len, ply )
	local key = net.ReadString()
	local tr = ply:GetEyeTrace()
	local total = 0
	local item = BuyMenuItems[key]
	if ply.BuyCooldown and ply.BuyCooldown > CurTime() then
		ply:Notify( 1, 6, "Please wait before purchasing another item." )
		return
	end
	for k,v in ipairs( ents.FindByClass( key ) ) do
		if IsValid( v ) and v:CPPIGetOwner() == ply then
			total = total + 1
		end
	end
	if item.Max and total >= item.Max then
		ply:Notify( 1, 6, "Purchase failed. Maximum amount of this entity has been reached." )
		return
	end
	if item.SpawnCheck and item.SpawnCheck( ply ) == false then return end
	if !item.SpawnFunction then
		local e = ents.Create( key )
		e:SetPos( tr.HitPos + tr.HitNormal )
		e:Spawn()
		e:CPPISetOwner( ply )
	else
		local e = item.SpawnFunction( ply, tr )
		e:CPPISetOwner( ply )
	end
	if item.Price then
		ply:RemoveFunds( item.Price )
	end
	ply:Notify( 0, 6, "You have purchased a "..item.Name )
	ply.BuyCooldown = CurTime() + 10
end )

--Vox/Overwatch announcement handler
local cooldown = 0
util.AddNetworkString( "PlayAnnouncement" )
net.Receive( "PlayAnnouncement", function( len, ply )
	local msg = net.ReadString()
	if msg == "" then
		ToggleAlarm()
		return
	end
	if cooldown > CurTime() then
		ply:Notify( 1, 6, "Please wait before sending another announcement." )
		return
	end
	
	local tbl = ply:Team() == TEAM_MARINEBOSS and ANNOUNCEMENTS_HECU or ANNOUNCEMENTS_ADMIN
	if mode == 1 then
		RunConsoleCommand( "vox", msg )
	else
		BroadcastSound( msg )
	end
	cooldown = CurTime() + 10
end )

--Prevent players from picking up same weapon twice, and prevent zombified players from picking up any weapons
hook.Add( "PlayerCanPickupWeapon", "NoDoublePickup", function( ply, wep )
	if ply:HasWeapon( wep:GetClass() ) or ( ply.IsZombie and wep:GetClass() != "weapon_zombie" ) then
		return false
	end
end )

--Turn player into zombie when killed by a headcrab
hook.Add( "PlayerDeath", "ZombifyPlayer", function( ply, inflictor, attacker )
	local pos = ply:GetPos()
	local allowed = {
		npc_headcrab = true,
		npc_headcrab_fast = true,
		npc_headcrab_black = true,
		npc_vj_hlr1_headcrab = true
	}

	if allowed[attacker:GetClass()] and !ply.IsZombie then
		attacker:Remove()
		timer.Simple( 1, function()
			if !IsValid( ply ) then return end
			ply:Spawn()
			ply:SetPos( pos )
			ply:MakeZombie()
		end )
	end
end )

--Clear decals when players go in water
hook.Add( "OnEntityWaterLevelChanged", "WaterClearDecals", function( ent, old, new )
	if ent:IsPlayer() and new == 3 then
		ent:RemoveAllDecals()
	end
end )
