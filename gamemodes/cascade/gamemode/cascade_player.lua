
local scientist = TEAM_SCIENTIST.ID
local admin = TEAM_ADMIN.ID
local visitor = TEAM_VISITOR.ID
local medic = TEAM_MEDIC.ID
local marine = TEAM_MARINE.ID
local security = TEAM_SECURITY.ID
local vort = TEAM_VORT.ID
local zombie = TEAM_ZOMBIE.ID

function ChangeTeam( ply, team, respawn )
	ply:StripWeapons()
	ply:SetTeam( team.ID )
	ply:SetModel( table.Random( team.Playermodel ) )
	hook.Run( "PlayerLoadout", ply )
	if respawn then
		ply:Spawn()
	end
end

function GM:PlayerLoadout( ply )
	ply:Give( "weapon_keys" )
	if ply:Team() == medic then
		ply:Give( "weapon_medkit" )
	elseif ply:Team() == scientist then
		ply:Give( "gmod_tool" )
		ply:Give( "weapon_physgun" )
		ply:Give( "weapon_physcannon" )
	elseif ply:Team() == marine then
		local randwep = {
			"weapon_shotgun_hl",
			"weapon_9mmar",
			"weapon_sniperrifle",
			"weapon_m249"
		}
		ply:Give( table.Random( randwep ) )
		ply:Give( "weapon_ram" )
	elseif ply:Team() == security then
		local randwep = {
			"weapon_eagle",
			"weapon_9mmhandgun",
			"weapon_357_hl"
		}
		ply:Give( table.Random( randwep ) )
		ply:Give( "weapon_ram" )
	elseif ply:Team() == zombie then
		ply:Give( "weapon_weapons_zombie" )
	elseif ply:Team() == vort then
		ply:Give( "swep_vortigaunt_beam" )
	end
	return true
end

function GM:PlayerShouldTakeDamage( ply, attacker )
	if attacker:IsPlayer() and ply:Team() == attacker:Team() then
		return false --Disables friendly fire
	end
	return true
end

function GM:PlayerSelectSpawn( ply ) --Even though this is the default code in sandbox, this function still needs declared here or the new spawns wont work for some reason
	local spawns = ents.FindByClass( "info_player_start" )
	local random_entry = math.random( #spawns )
	return spawns[ random_entry ]
end

function GM:PlayerSpawn( ply )
	ply:SetWalkSpeed( 180 )
	ply:SetRunSpeed( 240 )
	ply:AllowFlashlight( true )
end

function GM:PlayerInitialSpawn( ply )
	timer.Simple( 5, function()
		ChangeTeam( ply, TEAM_VISITOR, false )
		ply:ChatPrint("Welcome to BMRP:Cascade! If you are new here, ask an admin to give you a rundown of this gamemode.")
	end )
end

function GM:CanPlayerSuicide( ply )
	return false
end

function GM:DoPlayerDeath( ply, attacker, dmg )
	if !GetGlobalBool( "PreRound" ) and !GetGlobalBool( "MainRound" ) then
		timer.Simple( 1, function() --Respawns the player back at the waiting room if they die before the round starts, doesn't change their job
			ply:Spawn()
			ply:ChatPrint( "Wow. The round didn't even start yet and you still managed to die." )
		end )
		return
	end
	if attacker:IsNPC() then
		if attacker:GetClass() == "npc_headcrab" or attacker:GetClass() == "npc_headcrab_black" or attacker:GetClass() == "npc_headcrab_fast" then
			timer.Simple( 1, function()
				ply:SetPos( table.Random( MONSTER_POS ) ) --Currently spawns players at an NPC spawn, needs changed so the player spawns at their death position
				ply:ChangeTeam( TEAM_ZOMBIE, false )
				ply:ChatPrint( "You have been killed by a headcrab and are now a zombie." )
				ply:ChatPrint( "You are a zombie. Your objective is to kill all living organisms." )
			end )
			return
		end
	--[[ elseif attacker:IsPlayer() and attacker:Team() == zombie then --Function that allows zombie players to convert other players to zombies, disabled for now
		timer.Simple( 1, function()
			ply:Spawn()
			ply:ChangeTeam( TEAM_ZOMBIE, false )
			ply:ChatPrint( "You have been killed by zombie player and have also been converted to a zombie." )
			ply:ChatPrint( "You are a zombie. Your objective is to kill all living organisms." )
		end ) ]]
	end
	if GetGlobalBool( "PreRound" ) or GetGlobalBool( "MainRound" ) then
		timer.Simple( 1, function() --Sets the player's team to visitor and places them in the waiting room until the HECU timer cycles
			ply:Spawn()
			ChangeTeam( ply, TEAM_VISITOR, false )
			ply:ChatPrint( "You have died. You will respawn as HECU once the timer ends." )
		end )
		return
	end
end