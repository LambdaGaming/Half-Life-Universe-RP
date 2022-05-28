
if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

--Ceasefire timers
timer.Create( "City17Timer", 1800, 1, function()
	local endmessage = "The ceasefire has ended!"
	HLU_ChatNotifySystem( "City 17 RP", color_theme, endmessage )
	HLU_Notify( nil, endmessage, 0, 6, true )
end )

local function City17CeasefireNotice( ply )
	if timer.Exists( "City17Timer" ) then
		timer.Simple( 10, function() --Small timer since players tend to freeze for a few seconds after spawning in
			local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
			HLU_ChatNotifySystem( "City 17 RP", color_theme, ceasefiremessage, true, ply )
			HLU_Notify( ply, ceasefiremessage, 0, 6 )
		end )
	end
end
hook.Add( "PlayerInitialSpawn", "City17CeasefireNotice", City17CeasefireNotice )

--Restrictions for locked jobs
hook.Add( "InitPostEntity", "C17InitJobRestrict", function()
	RestrictedJobs = {
		[TEAM_METROCOPMANHACK] = true,
		[TEAM_CREMATOR] = true,
		[TEAM_COMBINEELITE] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true
	}
end )

--Scientist job management
local function City17ScientistChange( ply, before, after )
	if after == TEAM_SCIENTIST then
		local map = game.GetMap()
		local c17 = "rp_city17_build210"
		local district = "rp_city17_district47"
		local c24 = "rp_city24_v2"
		if map == c17 then
			ply:SetPos( Vector( 4371, -270, 76 ) )
		elseif map == district then
			ply:SetPos( Vector( -179, -2592, 384 ) )
		elseif map == c24 then
			ply:SetPos( Vector( -626, 9549, -31 ) )
		else
			HLU_Notify( ply, "Something went wrong. The current map wasn't detected as valid.", 1, 6 )
			return
		end
		HLU_Notify( ply, "You are under Combine control until the resistance is able to free you.", 0, 15 )
		timer.Simple( 0.3, function() HLU_Notify( ply, "Visit the website for guidelines on how this job works if you are confused.", 0, 15 ) end )
	elseif before == TEAM_SCIENTIST then
		ply:Spawn()
		HLU_Notify( ply, "You have been sent back to spawn to avoid being locked in the citadel since you were a scientist.", 0, 10 )
	end
end
hook.Add( "PlayerChangedTeam", "City17ScientistChange", City17ScientistChange )

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
			RunConsoleCommand( "play", OverwatchCommands[split[2]] )
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
	elseif map == "rp_city17_district47" then
		genpos = {
			Vector( 644, -793, -124 ),
			Vector( 214, -1580, 67 ),
			Vector( 916, -204, 134 ),
			Vector( 3713, -68, 69 )
		}
	else
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

--Rebel crafting table spawns
local function C17Crafting()
	local craftpos
	local map = game.GetMap()
	if map == "rp_city17_build210" then
		craftpos = {
			{ Vector( 1455, 3949, 92 ), Angle( 0, 171, 0 ) },
			{ Vector( 2881, -2660, 96 ), Angle( 0, -145, 0 ) },
			{ Vector( -949, -2725, 96 ), Angle( 0, 94, 0 ) },
			{ Vector( -923, 1825, 96 ), Angle( 0, 90, 0 ) },
			{ Vector( -1803, 6954, -449 ), Angle( 0, -90, 0 ) }
		}
	elseif map == "rp_city17_district47" then
		craftpos = {
			{ Vector( -587, 444, 400 ), Angle( 0, 180, 0 ) },
			{ Vector( -1872, -970, 400 ), Angle( 0, 180, 0 ) },
			{ Vector( 3859, 76, 80 ), angle_zero },
			{ Vector( 1186, 683, 345 ), angle_zero },
			{ Vector( -2968, -1306, 80 ), Angle( 0, 90, 0 ) }
		}
	else
		craftpos = {
			{ Vector( 6565, 9456, 536 ), angle_zero },
			{ Vector( 6885, 5955, -496 ), angle_zero },
			{ Vector( 7884, 2892, 24 ), Angle( 0, 180, 0 ) },
			{ Vector( 10039, 8811, 25 ), Angle( 2, -146, 0 ) },
			{ Vector( 4301, 11454, 536 ), Angle( 0, -90, 0 ) }
		}
	end
	for k,v in pairs( craftpos ) do
		local e = ents.Create( "crafting_table" )
		e:SetPos( v[1] )
		e:SetAngles( v[2] )
		e:Spawn()
	end
end
hook.Add( "InitPostEntity", "C17Crafting", C17Crafting )

--Player death management
local function PlayerDeathDemote( ply )
	local plyteam = ply:Team()
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
hook.Add( "PlayerDeath", "PlayerDeathDemote", PlayerDeathDemote )

--Player spawn management
local function CombineSpawn( ply )
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
	elseif map == "rp_city17_district47" then
		randpos = {
			Vector( -1192, -2266, 640 ),
			Vector( -1192, -2364, 640 ),
			Vector( -1103, -2364, 640 ),
			Vector( -1103, -2254, 640 ),
			Vector( -1005, -2255, 640 ),
			Vector( -1007, -2376, 640 )
		}
	else
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
end
hook.Add( "PlayerSpawn", "CombineSpawn", CombineSpawn )
