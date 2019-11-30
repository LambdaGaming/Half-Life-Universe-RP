
local c17maps = {
	["rp_city17_build210"] = true,
	["rp_city17_district47"] = true,
	["rp_industrial17_v1"] = true,
	["rp_city24_v2"] = true
}
if SERVER and c17maps[game.GetMap()] then
	timer.Create( "City17Timer", 1800, 1, function()
		local endmessage = "The ceasefire has ended!"
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( "NOTICE: "..endmessage )
		end
		DarkRP.notifyAll( 0, 6, endmessage )
	end )

	hook.Add( "PlayerInitialSpawn", "City17CeasefireNotice", function( ply )
		if timer.Exists( "City17Timer" ) then
			timer.Simple( 10, function()
				local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
				ply:ChatPrint( "NOTICE: "..ceasefiremessage )
				DarkRP.notify( ply, 0, 6, ceasefiremessage )
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
			local industrial = "rp_industrial17_v1"
			if map == c17 then
				ply:SetPos( Vector( 4371, -270, 76 ) )
			elseif map == district then
				ply:SetPos( Vector( -179, -2592, 384 ) )
			elseif map == c24 then
				ply:SetPos( Vector( -626, 9549, -31 ) )
			elseif map == industrial then
				ply:SetPos( Vector( 2182, 3226, -543 ) )
			else
				DarkRP.notify( ply, 1, 6, "Something went wrong. The current map wasn't detected as valid." )
				return
			end
			DarkRP.notify( ply, 0, 15, "You are under Combine control until the resistance is able to free you." )
			timer.Simple( 0.3, function() DarkRP.notify( ply, 0, 15, "Visit the website for guidelines on how this job works if you are confused." ) end )
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

	if game.GetMap() == "rp_industrial17_v1" then
		hook.Add( "InitPostEntity", "C17Generator", function()
			local genpos = {
				Vector( 2925, -1120, -166 ),
				Vector( 3499, 1116, 3 ),
				Vector( 3165, 2524, -133 ),
				Vector( 909, 4636, -132 )
			}
			local e = ents.Create( "iron_generator" )
			e:SetPos( table.Random( genpos ) )
			e:Spawn()
		end )
	end
end