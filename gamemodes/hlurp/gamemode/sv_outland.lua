
if GetGlobalInt( "CurrentGamemode" ) != 3 then return end

--Ceasefire timers
timer.Create( "OutlandTimer", 1800, 1, function()
	local endmessage = "The ceasefire has ended!"
	HLU_ChatNotifySystem( "Outland RP", color_green, endmessage )
	HLU_Notify( nil, endmessage, 0, 6, true )
end )

hook.Add( "PlayerInitialSpawn", "OutlandCeasefireNotice", function( ply )
	if timer.Exists( "OutlandTimer" ) then
		timer.Simple( 10, function()
			local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
			HLU_ChatNotifySystem( "Outland RP", color_green, ceasefiremessage, true, ply )
			HLU_Notify( ply, ceasefiremessage, 0, 6 )
		end )
	end
end )

--Vehicle and item spawners
local function SpawnVehicles()
	local carpos = {}
	if game.GetMap() == "rp_ineu_valley2_v1a" then
		carpos = {
			Vector( 4160, 6848, 512 ),
			Vector( 2684, 10425, 541 ),
			Vector( -1524, 13488, 256 ),
			Vector( -4842, 11112, 0 ),
			Vector( -13267, 11801, 0 ),
			Vector( -12493, 12003, 0 ),
			Vector( -5030, 3256, 0 ),
			Vector( -4155, 1150, 0 ),
			Vector( -2920, 605, -2 ),
			Vector( 2435, 204, 512 ),
			Vector( 7320, -3983, 17 ),
			Vector( -13013, 6372, 1024 )
		}
	else
		carpos = {
			Vector( -3010, -2426, -6445 ),
			Vector( 3278, -7007, -6406 ),
			Vector( 10177, -10680, -6600 ),
			Vector( 7392, 2424, -5674 ),
			Vector( 498, 5165, -5035 ),
			Vector( -389, 3430, -6399 ),
			Vector( -10541, 5820, -6399 ),
			Vector( -11264, 4806, -8683 ),
			Vector( -10009, -7392, -10284 )
		}
	end

	local vehicles = {
		{ "models/source_vehicles/car001a_hatchback_skin0.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car001a_hatchback_skin1.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car001b_hatchback/vehicle.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car001b_hatchback/vehicle_skin1.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car002a.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car002b/vehicle.mdl", "scripts/vehicles/hl2_hatchback.txt" },
		{ "models/source_vehicles/car003a.mdl", "scripts/vehicles/hl2_cars.txt" },
		{ "models/source_vehicles/car003b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
		{ "models/source_vehicles/car003b_rebel.mdl", "scripts/vehicles/hl2_cars.txt" },
		{ "models/source_vehicles/car004a.mdl", "scripts/vehicles/hl2_cars.txt" },
		{ "models/source_vehicles/car004b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
		{ "models/source_vehicles/car005a.mdl", "scripts/vehicles/hl2_cars.txt" },
		{ "models/source_vehicles/car005b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
		{ "models/source_vehicles/truck001c_01.mdl", "scripts/vehicles/truck001c_01.txt" },
		{ "models/source_vehicles/truck001c_02.mdl", "scripts/vehicles/truck001c_01.txt" },
		{ "models/source_vehicles/truck002a_cab.mdl", "scripts/vehicles/truck002a_cab.txt" },
		{ "models/source_vehicles/truck003a_01.mdl", "scripts/vehicles/truck003a_01.txt" },
		{ "models/source_vehicles/van001a_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001a_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001b_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001b_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/buggy.mdl", "scripts/vehicles/jeep_test.txt" }
	}
	
	for k,v in ipairs( carpos ) do
		local randveh = table.Random( vehicles )
		local car = ents.Create( "prop_vehicle_jeep" )
		car:SetModel( randveh[1] )
		car:SetKeyValue( "vehiclescript", randveh[2] )
		car:SetPos( v )
		car:Spawn()
		car:Activate()
	end
end

local function SpawnItems()
	local position = {}
	if game.GetMap() == "rp_ineu_valley2_v1a" then
		position = {
			Vector( 11904, 8654, 384 ),
			Vector( 11472, 9826, 384 ),
			Vector( 12744, 7863, 384 ),
			Vector( 14085, 563, -1483 ),
			Vector( 14319, 3859, -448 ),
			Vector( 15200, 6006, -448 ),
			Vector( 13377, 6642, -448 ),
			Vector( 14345, 7908, -435 ),
			Vector( 11692, 7969, -448 ),
			Vector( 13880, 3822, -448 )
		}
	else
		position = {
			Vector( -9144, -12037, -10471 ),
			Vector( -4462, -7715, -6373 ),
			Vector( -449, 4337, -6399 ),
			Vector( 1134, 2854, -6639 ),
			Vector( 1129, -14054, -7999 ),
			Vector( -14002, -6118, -7822 ),
			Vector( -361, 5257, -6631 ),
			Vector( 1737, 6007, -6743 )
		}
	end
	for k,v in ipairs( position ) do
		local e = ents.Create( "outland_item_spawner" )
		e:SetPos( v )
		e:Spawn()
		e:SetMoveType( MOVETYPE_NONE )
	end
end

hook.Add( "InitPostEntity", "OutlandItems", function()
	SpawnVehicles()
	SpawnItems()
end )


--Rebel codes chooser
--Run command if things go haywire:
--lua_run ents.FindByClass( [ENTCLASS] )[1].hascodes = true

local combinejobs = {
	[TEAM_COMBINESOLDIER] = true,
	[TEAM_COMBINEGUARD] = true,
	[TEAM_COMBINEELITE] = true
}

local outlandents = {
	"out_crate",
	"out_generator",
	"out_log"
}

hook.Add( "InitPostEntity", "OutlandPostEnt", function()
	for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
		v.hascodes = true
	end
end )

hook.Add( "PlayerDeath", "OutlandPlayerDeath", function( victim, inflictor, attacker )
	if victim.hascodes then
		victim.hascodes = nil
		for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
			v.hascodes = true
		end
		HLU_ChatNotifySystem( "Outland RP", color_green, victim:Nick().." has been killed and the portal codes are lost again!" )
	end
end )

hook.Add( "OnPlayerChangedTeam", "OutlandPlayerChange", function( ply, before, after )
	if ply.hascodes and combinejobs[after] then
		ply.hascodes = nil
		for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
			v.hascodes = true
		end
		HLU_ChatNotifySystem( "Outland RP", color_green, ply:Nick().." has changed jobs and the portal codes are lost again!" )
	end
end )

--Player spawn management
local function CombineSpawn( ply )
	local combine = {
		[TEAM_COMBINEELITE] = true,
		[TEAM_COMBINEGUARD] = true,
		[TEAM_COMBINEGUARDSHOTGUN] = true,
		[TEAM_COMBINESOLDIER] = true
	}
	local rebels = {
		[TEAM_RESISTANCELEADER] = true,
		[TEAM_REBEL] = true,
		[TEAM_REBELMEDIC] = true
	}
	local randcombine
	local randrebel
	if game.GetMap() == "rp_ineu_valley2_v1a" then
		randcombine = {
			Vector( 15205, -14367, 147 ),
			Vector( 15173, -14147, 183 ),
			Vector( 14918, -14182, 125 ),
			Vector( 14959, -14454, 101 )
		}
		randrebel = {
			Vector( -13301, 6816, 128 ),
			Vector( -13150, 6818, 128 ),
			Vector( -13150, 6716, 128 ),
			Vector( -13294, 6716, 128 )
		}
	else
		randcombine = {
			Vector( 858, -14100, -7999 ),
			Vector( 863, -13998, -7999 ),
			Vector( 953, -14000, -7999 ),
			Vector( 954, -14091, -7999 )
		}
		randrebel = {
			Vector( -4, 5008, -6399 ),
			Vector( 96, 4893, -6399 ),
			Vector( 409, 4993, -6399 ),
			Vector( 435, 5226, -6399 )
		}
	end
	if combine[ply:Team()] then
		ply:SetPos( table.Random( randcombine ) )
	end
	if rebels[ply:Team()] then
		ply:SetPos( table.Random( randrebel ) )
	end
end
hook.Add( "PlayerSpawn", "CombineSpawn", CombineSpawn )
