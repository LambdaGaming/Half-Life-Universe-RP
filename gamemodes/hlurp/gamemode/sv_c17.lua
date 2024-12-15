if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

ResistanceStats = {}

--Restrictions for locked jobs
hook.Add( "InitPostEntity", "C17InitJobRestrict", function()
	RestrictedJobs = {
		[TEAM_METROCOPMANHACK] = true,
		[TEAM_CREMATOR] = true,
		[TEAM_COMBINEELITE] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true
	}
end )

--Overwatch announcement chat commands
local OverwatchCommands = {
	["person"] = "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav",
	["anticiv"] = "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav",
	["evadeciv"] = "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav",
	["civreport"] = "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav",
	["position"] = "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav",
	["failure"] = "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav",
	["capitalmal"] = "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav",
	["socifive"] = "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav",
	["violation"] = "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav",
	["unrest"] = "npc/overwatch/cityvoice/f_localunrest_spkr.wav",
	["evasion"] = "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav",
	["block"] = "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav",
	["socione"] = "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav",
	["check"] = "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav",
	["miscount"] = "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav",
	["relocation"] = "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav",
	["exogen"] = "npc/overwatch/cityvoice/fprison_nonstandardexogen.wav"
}

local function City17AdminCommands( ply, text )
	local allowedjobs = {
		[TEAM_EARTHADMIN] = true,
		[TEAM_COMBINEELITE] = true
	}

	if allowedjobs[ply:Team()] then
		if text == "/fatboy" then
			for k,v in ipairs( player.GetHumans() ) do
				v:ConCommand( "play admin/fat_boy.mp3" )
				cooldown = CurTime() + 10
			end
			return ""
		end
	
		local split = string.Split( text, " " )
		if split[1] == "!announce" then
			if ply:Team() == TEAM_COMBINEELITE and player.GetCount() > 5 then
				HLU_Notify( ply, "There are too many players for you to take the Earth Admin's role.", 1, 6 )
				return ""
			end
			if !split[2] or !OverwatchCommands[split[2]] then
				HLU_Notify( ply, "Please provide a valid argument. https://lambdagaming.github.io/hlurp/commands.html", 1, 6 )
				return ""
			end
			for k,v in ipairs( player.GetHumans() ) do
				v:ConCommand( "play "..OverwatchCommands[split[2]] )
			end
			cooldown = CurTime() + 10
			return ""
		end
	end
end
hook.Add( "PlayerSay", "City17AdminCommands", City17AdminCommands )

--Iron generator spawn function
local function C17Generator()
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
end
hook.Add( "InitPostEntity", "C17Generator", C17Generator )

--Player death management
local function C17PlayerDeath( ply, inflictor, attacker )
	local plyteam = ply:Team()
	if attacker:IsPlayer() and ply:GetJobCategory() == "Combine" and attacker:GetJobCategory() == "Citizens" then
		ResistanceStats[attacker:SteamID()].Killed = ResistanceStats[attacker:SteamID()].Killed + 1
	end
	if plyteam == TEAM_EARTHADMIN then
		ChangeTeam( ply, 1, false, true )
		HLU_Notify( nil, "The earth admin has been killed!", 0, 6, true )
	elseif plyteam == TEAM_GMANCITY then
		ChangeTeam( ply, 1, false, true )
		HLU_Notify( nil, "The government man was caught spying and has been killed!", 0, 6, true )
	elseif plyteam == TEAM_RESISTANCELEADER then
		ChangeTeam( ply, 1, false, true )
		HLU_Notify( nil, "A resistance leader has been killed!", 0, 6, true )
	end
end
hook.Add( "PlayerDeath", "C17PlayerDeath", C17PlayerDeath )

--Player spawn management
local function C17PlayerSpawn( ply )
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
			Vector( -812, 9107, -663 ),
			Vector( -812, 8999, -663 ),
			Vector( -922, 8998, -663 ),
			Vector( -923, 9079, -663 ),
			Vector( -1030, 9088, -663 ),
			Vector( -1029, 8994, -663 )
		}
	end
	if allowed[ply:Team()] then
		ply:SetPos( table.Random( randpos ) )
	end
	if !ResistanceStats[ply:SteamID()] then
		ResistanceStats[ply:SteamID()] = { Loyalty = 100, Killed = 0 }
	end
end
hook.Add( "PlayerSpawn", "C17PlayerSpawn", C17PlayerSpawn )

hook.Add( "HLU_CanChangeJobs", "C17JobCheck", function( ply, new, old )
	local resistanceJobs = { TEAM_RESISTANCELEADER, TEAM_COMBINEGUARD, TEAM_COMBINESOLDIER }
	if RestrictedJobs[new] then
		HLU_Notify( ply, "This job must be unlocked via the Combine science locker.", 1, 6 )
		return false
	elseif resistanceJobs[new] then
		local totalKilled = 0
		for k,v in pairs( ResistanceStats ) do
			totalKilled = totalKilled + v.Killed
		end
		if totalKilled < 5 then
			HLU_Notify( ply, "Wait for the resistance to build up more before choosing this job", 1, 6 )
			return false
		end
	end
end )
