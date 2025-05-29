AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_hlu_chat.lua" )
AddCSLuaFile( "sh_bmrp.lua" )
AddCSLuaFile( "cl_bmrp.lua" )
AddCSLuaFile( "sh_c17.lua" )
AddCSLuaFile( "sh_outland.lua" )
AddCSLuaFile( "sh_bmrp_events.lua" )

include( "shared.lua" )
include( "sv_hlu_chat.lua" )
include( "sv_bmrp.lua" )
include( "sh_bmrp.lua" )
include( "sv_c17.lua" )
include( "sh_c17.lua" )
include( "sh_outland.lua" )
include( "sv_outland.lua" )
include( "sh_bmrp_events.lua" )
include( "sv_c17_events.lua" )

RunConsoleCommand( "sv_alltalk", "0" )
if GetGlobalInt( "CurrentGamemode" ) == 1 then
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
	if !on then
		return true
	end
	return ply:IsSuperAdmin()
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
    for k,v in pairs( HLU_JOB[GetGlobalInt( "CurrentGamemode" )][PlyTeam].Weapons ) do
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

local meta = FindMetaTable( "Player" )
function meta:MakeZombie()
	self:StripWeapons()
	self.IsZombie = true
	HLU_Notify( self, "You have been zombified!", 0, 6 )
	timer.Simple( 1, function()
		self:EmitSound( "npc/zombie/zombie_voice_idle"..math.random( 1, 14 )..".wav" )
		self:Give( "weapon_weapons_zombie" )
	end )
end

function ChangeTeam( ply, newteam, respawn, silent )
	local gm = GetGlobalInt( "CurrentGamemode" )
	local oldteam = HLU_JOB[gm][ply:Team()]
	local tbl = HLU_JOB[gm][newteam]
	local model = ply:GetNWString( "SetPlayermodel_"..newteam )
	if !HLU_JOB[gm] or !HLU_JOB[gm][newteam] then
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
	if ply:GetNWBool( "GMAN_BF" ) then
		HLU_Notify( ply, "Exit your Gman state before changing jobs.", 1, 6 )
		return
	end
	if hook.Run( "HLU_CanChangeJobs", ply, newteam, oldteam ) == false then return end

	ply:SetNWString( "RPJob", false )
	ply:StripWeapons()
	ply:StripAmmo()
	ply:SetTeam( newteam )
	if model == "" then
		ply:SetModel( table.Random( tbl.Models ) )
	else
		ply:SetModel( model )
	end
	if tbl.Bodygroups then
		for _,v in pairs( tbl.Bodygroups ) do
			ply:SetBodygroup( v[1], v[2] )
		end
	end
	if !silent then
		HLU_Notify( nil, ply:Nick().." has changed their job to "..tbl.Name..".", 0, 6, true )
	end
	if tbl.SpawnFunction then
		tbl.SpawnFunction( ply )
	end
	hook.Run( "PlayerLoadout", ply )
	if respawn or ( gm == 3 and oldteam and oldteam.Category != tbl.Category ) then
		ply:Spawn()
	end
	ply.JModFriends = {}
	for k,v in ipairs( player.GetAll() ) do
		if v:GetJobCategory() == ply:GetJobCategory() then
			table.insert( ply.JModFriends, v )
		end
	end
	hook.Run( "HLU_OnChangeJob", ply, newteam, oldteam )
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
		ply:SetRunSpeed( 270 )
	else
		ply:SetWalkSpeed( 180 )
		ply:SetRunSpeed( 250 )
	end
	ply:SetJumpPower( 170 )
	ply:ChatPrint( "Welcome, "..ply:Nick().."! We're currently playing on the "..HLU_GAMEMODE[GetGlobalInt( "CurrentGamemode" )].Name.." gamemode." )

	local rpname = ply:GetPData( "RPName" )
	if rpname then
		ply:SetNWString( "RPName", rpname )
	end
end

local function HLU_SpawnHook( ply )
	local curmode = GetGlobalInt( "CurrentGamemode" )
	timer.Simple( 0, function()
		local jobtable = HLU_JOB[curmode][ply:Team()]
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
end
hook.Add( "PlayerSpawn", "HLU_SpawnHook", HLU_SpawnHook )

local DropBlacklist = {
	["weapon_physgun"] = true,
	["weapon_physcannon"] = true,
	["weapon_keys"] = true,
	["gmod_tool"] = true,
	["gmod_camera"] = true,
	["weapon_handcuffed"] = true,
	["swep_vortigaunt_beam"] = true,
	["pocket"] = true,
	["weapon_weapons_zombie"] = true,
	["swep_gmanbriefcase"] = true,
	["weapon_leash_police"] = true,
	["trash_wep"] = true,
	["broom"] = true,
	["weapon_portal_pair"] = true,
	["weapon_ram"] = true
}

function DropWeapon( ply )
	if IsValid( ply ) then
		local wep = ply:GetActiveWeapon()
		local forward = ply:GetForward()
		if IsValid( wep ) then
			if DropBlacklist[wep:GetClass()] then
				HLU_Notify( ply, "You can't drop this weapon.", 1, 6 )
				return
			end
			local model = wep:GetWeaponWorldModel() or "models/weapons/w_rif_m4a1.mdl"
			local e = ents.Create( "hlu_dropped_weapon" )
			e:SetPos( ply:GetPos() - Vector( forward.x, forward.y, -50 ) )
			e:SetModel( model )
			e:Spawn()
			e.DroppedClass = wep:GetClass()
			wep:Remove()
		end
	end
end

local function HLU_DropWeaponDeath( ply )
	if IsValid( ply ) then
		local wep = ply:GetActiveWeapon()
		if IsValid( wep ) then
			if DropBlacklist[wep:GetClass()] then return end
			local model = wep:GetWeaponWorldModel() or "models/weapons/w_rif_m4a1.mdl"
			local e = ents.Create( "hlu_dropped_weapon" )
			e:SetPos( ply:GetPos() + Vector( 0, 0, 30 ) )
			e:SetModel( model )
			e:Spawn()
			e.DroppedClass = wep:GetClass()
			wep:Remove()
		end
	end
end
hook.Add( "DoPlayerDeath", "HLU_DropWeaponDeath", HLU_DropWeaponDeath )

local function HLU_SpawnNPCs()
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
end
hook.Add( "InitPostEntity", "HLU_SpawnNPCs", HLU_SpawnNPCs )

util.AddNetworkString( "SetPlayermodel" )
net.Receive( "SetPlayermodel", function( len, ply )
	local model = net.ReadString()
	local job = net.ReadInt( 8 )
	ply:SetNWString( "SetPlayermodel_"..job, model )
	if ply:Team() == job then
		ply:SetModel( model )
	end
end )

util.AddNetworkString( "BuyItemFromMenu" )
net.Receive( "BuyItemFromMenu", function( len, ply )
	local key = net.ReadString()
	local tr = ply:GetEyeTrace()
	local total = 0
	local item = BuyMenuItems[key]
	if ply.BuyCooldown and ply.BuyCooldown > CurTime() then
		HLU_Notify( ply, "Please wait before purchasing another item.", 1, 6 )
		return
	end
	for k,v in ipairs( ents.FindByClass( key ) ) do
		if IsValid( v ) and v:CPPIGetOwner() == ply then
			total = total + 1
		end
	end
	if item.Max and total >= item.Max then
		HLU_Notify( ply, "Purchase failed. Maximum amount of this entity has been reached.", 1, 6 )
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
	HLU_Notify( ply, "You have purchased a "..item.Name, 0, 6 )
	ply.BuyCooldown = CurTime() + 10
end )

hook.Add( "PlayerCanPickupWeapon", "NoDoublePickup", function( ply, wep )
	if ply:HasWeapon( wep:GetClass() ) or ( ply.IsZombie and wep:GetClass() != "weapon_weapons_zombie" ) then
		return false
	end
end )

hook.Add( "PlayerDeath", "ZombifyPlayer", function( ply, inflictor, attacker )
	local pos = ply:GetPos()
	local allowed = {
		npc_headcrab = true,
		npc_headcrab_fast = true,
		npc_headcrab_black = true,
		npc_vj_hlr1_headcrab = true
	}
	if allowed[attacker:GetClass()] and !ply.IsZombie then
		timer.Simple( 1, function()
			if IsValid( ply ) then
				ply:Spawn()
				ply:SetPos( pos )
				ply:MakeZombie()
			end
		end )
	end
end )
