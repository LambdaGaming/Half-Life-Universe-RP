
if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

timer.Create( "City17Timer", 1800, 1, function()
	local endmessage = "The ceasefire has ended!"
	HLU_ChatNotifySystem( "City 17 RP", color_theme, endmessage )
	HLU_Notify( nil, endmessage, 0, 6, true )
end )

hook.Add( "PlayerInitialSpawn", "City17CeasefireNotice", function( ply )
	if timer.Exists( "City17Timer" ) then
		timer.Simple( 10, function()
			local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
			HLU_ChatNotifySystem( "City 17 RP", color_theme, ceasefiremessage )
			HLU_Notify( nil, ceasefiremessage, 0, 6, true )
		end )
	end
end )

hook.Add( "InitPostEntity", "C17InitJobRestrict", function()
	RestrictedJobs = {
		[TEAM_METROCOPMANHACK] = true,
		[TEAM_CREMATOR] = true,
		[TEAM_COMBINEELITE] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true
	}
end )

hook.Add( "playerCanChangeTeam", "City17RestrictUnits", function( ply, team )
	if RestrictedJobs[team] then
		return false, "This job must be unlocked via the Combine science locker."
	end
end )

hook.Add( "OnPlayerChangedTeam", "City17ScientistChange", function( ply, before, after )
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

			DarkRP.notify( ply, 1, 6, "Something went wrong. The current map wasn't detected as valid." )
			return
		end
		DarkRP.notify( ply, 0, 15, "You are under Combine control until the resistance is able to free you." )
		timer.Simple( 0.3, function() DarkRP.notify( ply, 0, 15, "Visit the website for guidelines on how this job works if you are confused." ) end )
	end
end )

hook.Add( "PlayerSay", "City17AdminCommands", function( ply, text )
	local allowedjobs = {
		[TEAM_EARTHADMIN] = true,
		[TEAM_COMBINEELITE] = true
	}

	local cmd = {
		{ "/person", "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav" },
		{ "/anticiv", "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav" },
		{ "/evadeciv", "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav" },
		{ "/civreport", "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav" },
		{ "/position", "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav" },
		{ "/failure", "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav" },
		{ "/capitalmal", "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav" },
		{ "/socifive", "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav" },
		{ "/violation", "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav" },
		{ "/unrest", "npc/overwatch/cityvoice/f_localunrest_spkr.wav" },
		{ "/evasion", "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav" },
		{ "/block", "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav" },
		{ "/socione", "npc/overwatch/cityvoice/f_sociolevel1_4_spkr.wav" },
		{ "/check", "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav" },
		{ "/miscount", "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav" },
		{ "/relocation", "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav" },
		{ "/exogen", "npc/overwatch/cityvoice/fprison_nonstandardexogen.wav" }
	}

	local function SendSound( player, sound )
		if IsValid( player ) then
			player:ConCommand( "play "..sound )
		end
	end

	for k,v in pairs( cmd ) do
		if text == v[1] then
			if !allowedjobs[ply:Team()] then
				DarkRP.notify( ply, 1, 6, "You do not have the right job to use these commands." )
				return ""
			end
			if ply:Team() == TEAM_COMBINEELITE and player.GetCount() > 5 then
				DarkRP.notify( ply, 1, 6, "There are too many players for you to take the Earth Admin's role." )
				return ""
			end
			SendSound( ply, v[2] )
			return ""
		end
	end
end )

if game.GetMap() == "rp_city17_build210" then
	hook.Add( "InitPostEntity", "C17Generator", function()
		local genpos = {
			Vector( 786, 6497, -463 ),
			Vector( 1959, -1108, -462 ),
			Vector( -1774, 6948, -463 ),
			Vector( 2865, -3104, 83 )
		}
		local e = ents.Create( "iron_generator" )
		e:SetPos( table.Random( genpos ) )
		e:Spawn()
	end )
end

if game.GetMap() == "rp_city17_district47" then
	hook.Add( "InitPostEntity", "C17Generator", function()
		local genpos = {
			Vector( 644, -793, -124 ),
			Vector( 214, -1580, 67 ),
			Vector( 916, -204, 134 ),
			Vector( 3713, -68, 69 )
		}
		local e = ents.Create( "iron_generator" )
		e:SetPos( table.Random( genpos ) )
		e:Spawn()
	end )
end

if game.GetMap() == "rp_city24_v2" then
		hook.Add( "InitPostEntity", "C17Generator", function()
		local genpos = {
			Vector( 6185, 5506, -311 ),
			Vector( 6986, 6516, -511 ),
			Vector( 5277, 3485, -305 ),
			Vector( 8008, 3820, -274 )
		}
		local e = ents.Create( "iron_generator" )
		e:SetPos( table.Random( genpos ) )
		e:Spawn()
	end )
end