if GetGlobalInt( "CurrentGamemode" ) != 3 then return end

--Ceasefire timers
timer.Create( "OutlandTimer", 1800, 1, function()
	local endmessage = "The rocket is fully prepped and ready for launch!"
	HLU_ChatNotifySystem( "Outland RP", color_green, endmessage )
	HLU_Notify( nil, endmessage, 0, 6, true )
	local button = ents.FindByClass( "rocket_launch_button" )[1]
	button.light:SetKeyValue( "_light", "0 255 0 255" )
end )

timer.Create( "CombineVictory", 5400, 1, function()
	local msg = "The rebels failed to close the portal in time! The Combine invasion has started!"
	HLU_ChatNotifySystem( "Outland RP", color_green, msg )
	HLU_Notify( nil, msg, 0, 6, true )
	RunConsoleCommand( "blowout_enabled", "1" )
	RunConsoleCommand( "blowout_trigger_delayed", 300 )
	timer.Simple( 151, function()
		for k,v in ipairs( player.GetAll() ) do
			v:Kick( "\n--END OF SESSION--\nCombine victory ending chosen, server shutting down.\nThanks for playing!" )
		end
	end )
end )

--Vehicle and item spawners
local function SpawnVehicles()
	local carpos = {
		Vector( 3783, -8076, -1526 ),
		Vector( 1817, -9502, -1540 ),
		Vector( 3633, 767, -2471 ),
		Vector( -6483, 1438, -2808 ),
		Vector( -4564, 5197, -2477 ),
		Vector( 3340, 8278, -2800 ),
		Vector( 12140, 12355, -855 ),
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
		{ "models/source_vehicles/van001a_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001a_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001b_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/source_vehicles/van001b_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
		{ "models/buggy.mdl", "scripts/vehicles/jeep_test.txt" }
	}
	
	for k,v in pairs( carpos ) do
		local randveh = table.Random( vehicles )
		local car = ents.Create( "prop_vehicle_jeep" )
		car:SetModel( randveh[1] )
		car:SetKeyValue( "vehiclescript", randveh[2] )
		car:SetPos( v )
		car:Spawn()
		car:Activate()
		timer.Simple( 1, function()
			GAuto.SetFuel( car, math.random( 0, 75 ) )
			GAuto.TakeDamage( car, math.random( 10, 70 ) )
		end )
	end
end

hook.Add( "InitPostEntity", "OutlandItems", function()
	SpawnVehicles()
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
		Vector( 10981, 8908, -771 ),
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

--Cleanup abandoned combine vehicles
hook.Add( "PlayerEnteredVehicle", "OutlandVehicleEnter", function( ply, veh )
	if veh.aw2Ent or IsValid( veh:GetNWEntity( "GWEnt" ) ) then
		local p = veh:GetParent()
		timer.Remove( "CombineVehDespawn"..p:EntIndex() )
	end
end )

hook.Add( "PlayerLeaveVehicle", "OutlandVehicleLeave", function( ply, veh )
	if veh.aw2Ent or IsValid( veh:GetNWEntity( "GWEnt" ) ) then
		local p = veh:GetParent()
		timer.Create( "CombineVehDespawn"..p:EntIndex(), 300, 1, function()
			if IsValid( p ) then p:Dissolve() end
		end )
	end
end )

hook.Add( "OnEntityCreated", "OutlandEntityCreated", function( ent )
	timer.Simple( 1, function()
		if IsValid( ent ) and ent:GetClass() == "ent_jack_gmod_ezsentry" then
			ent.MaxDurability = 50
			ent.Durability = 50
		end
	end )
end )
