if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

function SetLoyalty( ply, num )
	local final = math.Clamp( num, 0, 100 )
	ply:SetNWInt( "Loyalty", final )
end

function GetLoyalty( ply )
	return ply:GetNWInt( "Loyalty" )
end

function AddKill( ply )
	ply:SetNWInt( "Killed", ply:GetNWInt( "Killed" ) + 1 )
end

function GetKilled( ply )
	return ply:GetNWInt( "Killed" )
end

--Restrictions for locked jobs
hook.Add( "InitPostEntity", "C17InitJobRestrict", function()
	RestrictedJobs = {
		[TEAM_METROCOPMANHACK] = true,
		[TEAM_CREMATOR] = true,
		[TEAM_COMBINEELITE] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true
	}
end )

--Iron generator spawn function
hook.Add( "InitPostEntity", "C17Generator", function()
	local genpos
	local map = game.GetMap()
	if map == "rp_city17_build210" then
		genpos = {
			Vector( 786, 6497, -463 ),
			Vector( 1959, -1108, -462 ),
			Vector( -1774, 6948, -463 ),
			Vector( 2865, -3104, 83 )
		}
	elseif map == "rp_city24_v4" then
		genpos = {
			Vector( 6185, 5506, -311 ),
			Vector( 6986, 6516, -511 ),
			Vector( 5277, 3485, -305 ),
			Vector( 8008, 3820, -274 )
		}
	end
	local e = ents.Create( "iron_generator" )
	e:SetPos( table.Random( genpos ) )
	e:Spawn()
end )

--Player death management
hook.Add( "PlayerDeath", "C17PlayerDeath", function( ply, inflictor, attacker )
	local plyteam = ply:Team()
	if attacker:IsPlayer() and ply:GetJobCategory() == "Combine" and attacker:GetJobCategory() == "Citizens" then
		AddKill( attacker )
		SetLoyalty( attacker, GetLoyalty( attacker ) - 15 )
	elseif ply:GetJobCategory() == "Citizens" then
		SetLoyalty( ply, GetLoyalty( ply ) + 10 )
	end

	local demoteJobs = { [TEAM_EARTHADMIN] = true, [TEAM_GMANCITY] = true, [TEAM_RESISTANCELEADER] = true, [TEAM_VORT] = true }
	if demoteJobs[plyteam] then
		ply:ChangeTeam( 1, false, true )
		HLU_Notify( nil, ply:Nick().." has been killed!", 0, 6, true )
		timer.Create( "JobCooldown"..plyteam..ply:SteamID(), 600, 1, function()
			if IsValid( ply ) then
				HLU_Notify( ply, "You can now play as the "..HLU_JOB[2][plyteam].Name.." job again.", 0, 6 )
			end
		end )
	end
end )

--Player spawn management
hook.Add( "PlayerSpawn", "C17PlayerSpawn", function( ply )
	local map = game.GetMap()
	local allowed = {
		[TEAM_COMBINEELITE] = true,
		[TEAM_CREMATOR] = true,
		[TEAM_COMBINEGUARD] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true,
		[TEAM_COMBINESOLDIER] = true,
		[TEAM_METROCOPMANHACK] = true,
		[TEAM_METROCOP] = true
	}
	local randpos
	if map == "rp_city17_build210" then
		randpos = {
			Vector( 4024, -1877, -179 ),
			Vector( 4132, -1877, -179 ),
			Vector( 4132, -2003, -179 ),
			Vector( 4024, -2003, -179 ),
			Vector( 4024, -2069, -179 ),
			Vector( 4164, -2068, -179 )
		}
	elseif map == "rp_city24_v4" then
		randpos = {
			Vector( 11826, 6758, 396 ),
			Vector( 12797, 7408, 456 ),
			Vector( 12787, 10481, 696 ),
			Vector( 11644, 7893, 396 ),
			Vector( 8935, 7139, 392 ),
			Vector( 9234, 8502, 384 )
		}
	end
	if allowed[ply:Team()] then
		ply:SetPos( table.Random( randpos ) )
	end
end )

hook.Add( "PlayerInitialSpawn", "C17InitialSpawn", function( ply )
	SetLoyalty( ply, 100 )
end )

hook.Add( "HLU_CanChangeJobs", "C17JobCheck", function( ply, new, old )
	local resistanceJobs = { [TEAM_RESISTANCELEADER] = true, [TEAM_COMBINEGUARD] = true, [TEAM_COMBINESOLDIER] = true }
	if RestrictedJobs[new] then
		HLU_Notify( ply, "This job must be unlocked via the Combine science locker.", 1, 6 )
		return false
	elseif resistanceJobs[new] then
		local totalKilled = 0
		for k,v in ipairs( player.GetAll() ) do
			totalKilled = totalKilled + GetKilled( v )
		end
		if totalKilled < 3 then
			HLU_Notify( ply, "Wait for the resistance to build up more before choosing this job", 1, 6 )
			return false
		end
	elseif new == TEAM_RESISTANCELEADER and GetLoyalty( ply ) > 25 then
		HLU_Notify( ply, "You need 25 loyalty or less to play as this job.", 1, 6 )
		return false
	elseif timer.Exists( "JobCooldown"..new..ply:SteamID() ) then
		HLU_Notify( ply, "Wait for the cooldown to end before choosing this job again.", 1, 6 )
		return false
	end
end )

hook.Add( "HLU_OnChangeJob", "C17ChangeJob", function( ply, new, old )
	if ply:GetJobCategory() != "Citizens" then
		SetLoyalty( ply, 100 )
	end
end )

hook.Add( "EntityTakeDamage", "C17TakeDamage", function( ent, dmg )
	if ent:IsPlayer() and dmg:GetAttacker():IsPlayer() and dmg:GetAttacker():GetActiveWeapon():GetClass() == "weapon_stunstick" and ent:GetJobCategory() == "Citizens" and dmg:GetAttacker():GetJobCategory() == "Combine" then
		SetLoyalty( ent, GetLoyalty( ent ) + 5 )
	end
end )

hook.Add( "OnHandcuffed", "C17Handcuffed", function( ply, cuffedply, handcuffs )
	SetLoyalty( cuffedply, GetLoyalty( cuffedply ) + 10 )
end )
