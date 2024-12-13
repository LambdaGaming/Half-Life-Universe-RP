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
	local carpos = {
		Vector( 3783, -8076, -1526 ),
		Vector( 1817, -9502, -1540 ),
		Vector( 1817, -9502, -1540 ),
		Vector( -6483, 1438, -2808 ),
		Vector( -4564, 5197, -2477 ),
		Vector( 3340, 8278, -2900 ),
		Vector( 12140, 12355, -865 ),
		Vector( 13474, 8589, -749 )
	}

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
	local position = {
		// TODO: Revamp item system
	}
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
	local randcombine = {
		Vector( -1812, -1755, 6668 ),
		Vector( -1704, -3274, 6828 ),
		Vector( -2368, -4408, 6932 ),
		Vector( -2169, -3054, 6828 ),
		Vector( -132, -3197, 6880 )
	}
	local randrebel = {
		Vector( 11983, 8030, -1641 ),
		Vector( 10981, 8908, -771 )
		Vector( 12920, 7009, -1641 ),
		Vector( 12266, 8510, -1641 ),
		Vector( 12381, 7563, -1641 )
	}
	if combine[ply:Team()] then
		ply:SetPos( table.Random( randcombine ) )
	elseif rebels[ply:Team()] then
		ply:SetPos( table.Random( randrebel ) )
	end
end
hook.Add( "PlayerSpawn", "CombineSpawn", CombineSpawn )
