
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
	if RestrictedJobs and RestrictedJobs[newteam] then
		HLU_Notify( ply, "This job must be unlocked via the Combine science locker.", 1, 6 )
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

local function HLU_SpawnHook( ply )
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
end
hook.Add( "PlayerSpawn", "HLU_SpawnHook", HLU_SpawnHook )

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
			local model
			local phys = wep:GetPhysicsObject()
			if IsValid( phys ) then
				model = wep:GetModel()
			else
				model = "models/weapons/w_rif_m4a1.mdl"
			end
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
	local wep = ply:GetActiveWeapon()
	local DefaultWeps = {
		["weapon_physgun"] = true,
		["weapon_physcannon"] = true,
		["weapon_keys"] = true,
		["gmod_tool"] = true,
		["gmod_camera"] = true
	}
	if IsValid( wep ) and !DefaultWeps[wep:GetClass()] then
		local e = ents.Create( "hlu_dropped_weapon" )
		e:SetPos( ply:GetPos() + Vector( 0, 0, 30 ) )
		e:SetModel( wep:GetModel() )
		e:Spawn()
		e.DroppedClass = wep:GetClass()
	end
end
hook.Add( "DoPlayerDeath", "HLU_DropWeaponDeath", HLU_DropWeaponDeath )

local function HLU_SpawnNPCs()
	timer.Simple( 10, function()
		local map = game.GetMap()
		if map == "rp_sectorc_beta" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( -5095, -427, 608 ) )
			e:SetAngles( Angle( 0, 180, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local itemshopa = ents.Create( "npc_item" )
			itemshopa:SetPos( Vector( -13561, -585, -412 ) )
			itemshopa:SetAngles( angle_zero )
			itemshopa:Spawn()
			itemshopa:ApplyType( 4 )
			local itemshopb = ents.Create( "npc_item" )
			itemshopb:SetPos( Vector( 4072, -1618, -377 ) )
			itemshopb:SetAngles( Angle( 0, 180, 0 ) )
			itemshopb:Spawn()
			itemshopb:ApplyType( 4 )
			local itemshopc = ents.Create( "npc_item" )
			itemshopc:SetPos( Vector( -3088, -2126, -228 ) )
			itemshopc:SetAngles( Angle( 0, 90, 0 ) )
			itemshopc:Spawn()
			itemshopc:ApplyType( 4 )
			local itemshopd = ents.Create( "npc_item" )
			itemshopd:SetPos( Vector( -79, -5613, -252 ) )
			itemshopd:SetAngles( Angle( 0, 90, 0 ) )
			itemshopd:Spawn()
			itemshopd:ApplyType( 4 )
			local budget = ents.Create( "budget_npc" )
			budget:SetPos( Vector( -123, -3703, -252 ) )
			budget:SetAngles( angle_zero )
			budget:Spawn()
		end
		if map == "rp_blackmesa_laboratory" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( 10808, -4008, 922 ) )
			e:SetAngles( Angle( 0, 0, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local itemshopd = ents.Create( "npc_item" )
			itemshopd:SetPos( Vector( 833, -4633, 608 ) )
			itemshopd:SetAngles( Angle( 0, 180, 0 ) )
			itemshopd:Spawn()
			itemshopd:ApplyType( 4 )
			local budget = ents.Create( "budget_npc" )
			budget:SetPos( Vector( 2533, -58, -31 ) )
			budget:SetAngles( Angle( 0, 180, 0 ) )
			budget:Spawn()
		end
		if map == "rp_blackmesa_complex_fixed" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( -1251, 6766, 2160 ) )
			e:SetAngles( Angle( 0, 0, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local itemshop = ents.Create( "npc_item" )
			itemshop:SetPos( Vector( 363, 6829, 2160 ) )
			itemshop:SetAngles( Angle( 0, 90, 0 ) )
			itemshop:Spawn()
			itemshop:ApplyType( 4 )
			local itemshop2 = ents.Create( "npc_item" )
			itemshop2:SetPos( Vector( -2059, 780, 288 ) )
			itemshop2:SetAngles( angle_zero )
			itemshop2:Spawn()
			itemshop2:ApplyType( 4 )
			local budget = ents.Create( "budget_npc" )
			budget:SetPos( Vector( 952, 602, -31 ) )
			budget:SetAngles( Angle( 0, 90, 0 ) )
			budget:Spawn()
		end
		if map == "rp_bmrf" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( -1251, 6766, 2160 ) )
			e:SetAngles( Angle( 0, 0, 0 ) )
			e:Spawn()
			e:ApplyType( 1 )
			local itemshop = ents.Create( "npc_item" )
			itemshop:SetPos( Vector( 1083, -4278, -1439 ) )
			itemshop:SetAngles( Angle( 0, 90, 0 ) )
			itemshop:Spawn()
			itemshop:ApplyType( 4 )
			local itemshop2 = ents.Create( "npc_item" )
			itemshop2:SetPos( Vector( -1466, -2606, 352 ) )
			itemshop2:SetAngles( Angle( 0, 180, 0 ) )
			itemshop2:Spawn()
			itemshop2:ApplyType( 4 )
			local itemshop3 = ents.Create( "npc_item" )
			itemshop3:SetPos( Vector( -2088, 2965, -39 ) )
			itemshop3:SetAngles( Angle( 0, -90, 0 ) )
			itemshop3:Spawn()
			itemshop3:ApplyType( 4 )
			local budget = ents.Create( "budget_npc" )
			budget:SetPos( Vector( -404, 2374, -63 ) )
			budget:SetAngles( Angle( 0, 90, 0 ) )
			budget:Spawn()
		end
		if map == "rp_ineu_valley2_v1a" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( 9543, 14860, 1277 ) )
			e:SetAngles( Angle( 0, -90, 0 ) )
			e:Spawn()
			e:ApplyType( 2 )

			local e2 = ents.Create( "npc_item" )
			e2:SetPos( Vector( -11046, 6843, 1024 ) )
			e2:SetAngles( Angle( 0, 0, 0 ) )
			e2:Spawn()
			e2:ApplyType( 3 )
		end
		if map == "gm_boreas" then
			local e = ents.Create( "npc_item" )
			e:SetPos( Vector( 1694, -14736, -6575 ) )
			e:SetAngles( Angle( 0, -90, 0 ) )
			e:Spawn()
			e:ApplyType( 2 )

			local e2 = ents.Create( "npc_item" )
			e2:SetPos( Vector( -367, 370, -6303 ) )
			e2:SetAngles( Angle( 0, 67, 0 ) )
			e2:Spawn()
			e2:ApplyType( 3 )
		end
	end )
end
hook.Add( "InitPostEntity", "HLU_SpawnNPCs", HLU_SpawnNPCs )
