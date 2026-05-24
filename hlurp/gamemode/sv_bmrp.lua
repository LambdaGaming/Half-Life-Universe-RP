if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

--Functions for spawning and respawning NPCs in Xen
local XenSpawn, XenRespawn
XenRespawn = function()
	for k,v in pairs( ents.FindByClass( "monster_*" ) ) do
		if v.IsXenNPC then return end
	end
	timer.Simple( 600, function()
		XenSpawn()
	end )
end

XenSpawn = function()
	if game.GetMap() == "gm_atomic" then return end

	local monsters = {
		"npc_vj_hlr1_alienslave",
		"npc_vj_hlr1_aliengrunt",
		"npc_vj_hlr1_aliencontroller",
		"npc_vj_hlr1_bullsquid",
		"npc_vj_hlr1_houndeye"
	}

	local NPCPosTable = {
		Vector( -14609, -14482, -14952 ),
		Vector( -14309, -14713, -15006 ),
		Vector( -13876, -14545, -14941 ),
		Vector( -14381, -14138, -14950 ),
		Vector( -14321, -14431, -15017 )
	}

	for k,v in ipairs( NPCPosTable ) do
		local e = ents.Create( table.Random( monsters ) )
		e:SetPos( v )
		e:Spawn()
		e:EmitSound( "debris/beamstart7.wav" )
		e:CallOnRemove( "XenRespawn", function() XenRespawn() end )
		e.IsXenNPC = true
	end
end
hook.Add( "InitPostEntity", "SpawnXenNPCs", function() XenSpawn() end )

--Show ID chat command
util.AddNetworkString( "SendID" )
local function MiscCommands( ply, text )
	if text == "/showid" then --Show the player's name and job to nearby players
		for k,v in pairs( player.GetHumans() ) do
			if v == ply or v:GetPos():DistToSqr( ply:GetPos() ) <= 10000 then
				net.Start( "SendID" )
				net.WriteEntity( ply )
				net.Send( v )
			end
		end
		return ""
	end
end
hook.Add( "PlayerSay", "BMRP_MiscCommands", MiscCommands )

local function MapMods()
	if game.GetMap() == "rp_bmrf" then
		--Remove Xen objects that trigger NPCs and cause other problems
		for k,v in ipairs( ents.FindByClass( "xen_plantlight" ) ) do
			v:Remove()
		end

		--Remove announcements that constantly repeat
		local indexes = { 3345, 3346, 3347, 3348 }
		for k,v in pairs( indexes ) do
			local e = ents.GetMapCreatedEntity( v )
			e:Remove()
		end
	end
end
hook.Add( "InitPostEntity", "BMRPMapMods", MapMods )

--Remotely toggle the facility alarm
function ToggleAlarm( force )
	local index = {
		["rp_bmrf"] = 3364
	}
	local ent = ents.GetMapCreatedEntity( index[game.GetMap()] )
	ent:Fire( force and "PressIn" or "Press" )
end

--Vehicle spawn function
local function BMRPVehicleSpawn()
	local spawnpos
	local allowedmaps = {
		["gm_atomic"] = true,
		["rp_bmrf"] = true
	}

	if allowedmaps[game.GetMap()] then
		local vehicles = {
			{ "models/black_mesa_vehicles/crownvic.mdl", "scripts/vehicles/bm_crownvic.txt" },
			{ "models/black_mesa_vehicles/hummer.mdl", "scripts/vehicles/bm_hummer.txt" },
			{ "models/black_mesa_vehicles/jeep01.mdl", "scripts/vehicles/bm_jeep01.txt" },
			{ "models/black_mesa_vehicles/utility_truck.mdl", "scripts/vehicles/bm_utilitytruck.txt" },
			{ "models/black_mesa_vehicles/M35.mdl", "scripts/vehicles/bm_m35.txt" }
		}

		if game.GetMap() == "gm_atomic" then
			spawnpos = {
				{ Vector( -10676, 7944, -12294 ), angle_zero },
				{ Vector( -5513, 1928, -12240 ), angle_zero },
				{ Vector( 4352, 2820, -12260 ), angle_zero },
				{ Vector( 937, -2617, -12216 ), angle_zero },
				{ Vector( -8851, -2524, -12258 ), angle_zero },
				{ Vector( -11590, -9063, -11137 ), angle_zero },
				{ Vector( -2264, -7373, -12548 ), angle_zero },
				{ Vector( 9171, -9176, -12262 ), angle_zero }
			}
		elseif game.GetMap() == "rp_bmrf" then
			spawnpos = {
				{ Vector( 4289, -1954, 704 ), Angle( 0, -90, 0 ) },
				{ Vector( 2173, -5337, 192 ), Angle( 0, 180, 0 ) },
				{ Vector( -7263, -2217, 704 ), Angle( 0, 180, 0 ) }
			}
		end

		for k,v in pairs( spawnpos ) do
			local randveh = table.Random( vehicles )
			local car = ents.Create( "prop_vehicle_jeep" )
			car:SetModel( randveh[1] )
			car:SetKeyValue( "vehiclescript", randveh[2] )
			car:SetPos( v[1] )
			car:SetAngles( v[2] )
			car:Spawn()
			car:Activate()
			timer.Simple( 1, function()
				GAuto.SetFuel( car, math.random( 10, 100 ) )
			end )
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_VehicleSpawn", BMRPVehicleSpawn )

--Fund management functions
local meta = FindMetaTable( "Player" )
function meta:GetFunds()
	return self:GetNWInt( "Funds" )
end
function meta:CanAfford( amount )
	return self:GetFunds() >= amount
end
function meta:AddFunds( amount )
	self:SetNWInt( "Funds", self:GetFunds() + amount )
end
function meta:RemoveFunds( amount )
	self:SetNWInt( "Funds", self:GetFunds() - amount )
end

--Set initial player values
local function BMRPPlayerInit( ply )
	ply:ConCommand( "say /setr 42.0" )
	ply:AddFunds( 1000 )
	net.Start( "UpdateTask" )
	net.WriteTable( BMRP_CURRENT_TASKS )
	net.Send( ply )
end
hook.Add( "PlayerInitialSpawn", "BMRPPlayerInit", BMRPPlayerInit )

hook.Add( "InitPostEntity", "InitialEventCooldown", function()
	SetGlobalBool( "EventCooldownActive", true )
	timer.Simple( 1800, function() SetGlobalBool( "EventCooldownActive", false ) end )
end )

local function Cascade() --Cascade activation function
	if game.GetMap() == "rp_bmrf" then
		local pos = {
			Vector( 2192, -4962, 192 ),
			Vector( -627, -4618, 352 ),
			Vector( -919, -3827, 352 ),
			Vector( 289, -3486, 352 ),
			Vector( -1846, -3840, -1440 ),
			Vector( -2359, -4140, -1120 ),
			Vector( -604, -3112, -1440 ),
			Vector( -3126, -4684, -1439 ),
			Vector( 1317, -3188, -1440 ),
			Vector( -1698, -2038, 352 ),
			Vector( -2721, -213, 704 ),
			Vector( -2585, -1489, 208 ),
			Vector( -908, -1419, 64 ),
			Vector( 619, 295, -64 ),
			Vector( 4579, -519, -64 ),
			Vector( 5908, -394, -63 ),
			Vector( -138, 2260, -64 ),
			Vector( -151, 2732, -63 ),
			Vector( -4793, 2062, -64 ),
			Vector( -5825, -155, -112 ),
			Vector( -1150, 1328, -1088 ),
			Vector( 6851, -5744, 352 ),
			Vector( -9242, -1768, -63 ),
			Vector( -10420, -1537, -64 ),
			Vector( -8774, -1859, 705 )
		}
	
		for k,v in pairs( pos ) do
			local e = ents.Create( "sent_vj_hlr_alientp" )
			e:SetPos( v )
			e:Spawn()
		end
	
		for k,v in ipairs( player.GetAll() ) do
			v:SendLua( [[util.ScreenShake( vector_origin, 50, 50, 8, 0 )]] )
			v:SendLua( [[surface.PlaySound( "ambient/atmosphere/terrain_rumble1.wav" )]] )
		end
	
		local e = ents.Create( "cascade_escape" )
		e:SetPos( Vector( -6901, -1738, 706 ) )
		e:Spawn()
		
		local rubblepos = {
			{ Vector( -910, -3855, 405 ), Angle( -45, 0, 0 ) },
			{ Vector( -9231, -2121, 766 ), Angle( 0, 0, -45 ) },
			{ Vector( -1821, -1398, 419 ), Angle( -90, 180, 180 ) }
		}
		for i=1,3 do
			local e = ents.Create( "rubble_block" )
			e:SetPos( rubblepos[i][1] )
			e:SetAngles( rubblepos[i][2] )
			e:Spawn()
		end
		ents.GetMapCreatedEntity( 3366 ):Fire( "Press" )
		ents.GetMapCreatedEntity( 3364 ):Fire( "Press" )
		ents.GetMapCreatedEntity( 3760 ):Fire( "Press" )
	end
	TramFailure( true )
	SetGlobalBool( "CascadeActive", true )
end
concommand.Add( "cascade", Cascade )

--Spawn selection
local TeamSpawns = {
	["rp_bmrf"] = {
		Vector( -7783, -1857, -64 ), --Level 1 Facility Entrance
		Vector( 5282, -5531, 352 ), --Level 3 Dormitories
		Vector( 3384, -333, -64 ), --Area 3 Security
		Vector( -4301, 3371, -64 ), --Sector C Test Labs
		Vector( -947, 2752, -64 ), --Sector D Administration
		Vector( 940, 623, -64 ), --Sector E Biodome Complex
		Vector( -963, -3618, -1440 ), --Sector F Lambda Complex
		Vector( 4265, -550, 704 ) --HECU spawn during cascade, should always be last
	}
}
util.AddNetworkString( "SelectSpawnMenu" )
hook.Add( "PlayerSpawn", "TeamSpawns", function( ply )
	local map = game.GetMap()
	local category = ply:GetJobCategory()
	if category == "Military" then
		ply:SetPos( TeamSpawns[map][#TeamSpawns[map]] )
		return
	end
	net.Start( "SelectSpawnMenu" )
	net.Send( ply )
end )
net.Receive( "SelectSpawnMenu", function( len, ply )
	local index = net.ReadInt( 6 )
	local map = game.GetMap()
	ply:SetPos( TeamSpawns[map][index - 1] )
end )

--Start and stop AMS detection
local offset = Vector( 0, 0, -50 )
hook.Add( "AcceptInput", "AMSTrigger", function( ent, input, activator, caller, value )
	if ent:MapCreationID() == 5243 then
		if input == "Enable" then
			timer.Create( "AMSTrigger", 0.5, 0, function()
				if GetGlobalBool( "CascadeActive" ) then return end
				local find = ents.FindInSphere( ent:GetPos() + offset, 100 )
				for k,v in ipairs( find ) do
					local c = v:GetClass()
					if c == "crystal_pure" then
						City17Map = v:GetNWString( "CType" )
						local e = ents.Create( "env_explosion" )
						e:SetPos( v:GetPos() )
						e:Spawn()
						e:Fire( "Explode" )
						v:Remove()
						Cascade()
						break
					elseif c == "bm_nuke" then
						for k,v in ipairs( player.GetAll() ) do
							v:SendLua( [[surface.PlaySound( "ambient/explosions/explode_6.wav" )]] )
							v:ScreenFade( SCREENFADE.IN, color_white, 0.5, 10 )
						end
						timer.Simple( 5, function()
							RunConsoleCommand( "changelevel", "gm_atomic" )
						end )
						v:Remove()
						break
					end
				end
			end )
		elseif input == "Disable" then
			timer.Remove( "AMSTrigger" )
		end
	end
end )

local positions = {
	["rp_bmrf"] = {
		Vector( 1002, -4873, 224 ), -- Main enterance S.F
		Vector( -460, -4292, 352 ), -----------------------------------
		Vector( -173, -6046, 352 ), -- Vending machines outside tram S.F
		Vector( -566, -3710, 352 ), -- S.F Interior Hallway
		Vector( -1147, -3717, 352 ), -- S.F Fountain
		Vector( -1471, -2581, 352 ), -- S.F Labs
		Vector( -1793, -2400, 352 ),
		Vector( -986, -1188, 352 ),
		Vector( -425, -952, 352 ), -------------------------------------
		Vector( -2639, -1352, 496 ), -- S.F, S.E Stairwell
		Vector( -2064, -1327, 64 ), ------------------------------------
		Vector( -1712, -1507, 64 ), -- S.E Labs
		Vector( -1069, -1321, 64 ),
		Vector( 94, -1657, 64 ),
		Vector( -86, -1014, 64 ),
		Vector( 220, -604, 64 ), ---------------------------------------
		Vector( 14, 414, 0 ), -- S.E Tram
		Vector( 3319, -592, -64 ), -- A3 Tram
		Vector( 4295, -428, -64 ), -- A3
		Vector( 5395, -5341, 352 ), -- L3 Dorms Tram
		Vector( 5674, -5813, 352 ), -- L3D Main Area
		Vector( 6241, -5817, 352 ),
		Vector( 7710, -5472, 352 ), --------------------------------------
		Vector( 8850, -4831, 192 ), -- L3 Dorms
		Vector( 8618, -4811, 176 ), ---------------------------------------
		Vector( -929, 3215, -64 ), -- S.D Tram
		Vector( -957, 2522, -64 ), -----------------------------------------
		Vector( -4480, 2604, -64 ), -- S.C Main
		Vector( -4050, 2420, -64 ),
		Vector( -5705, -815, -112 ),
		Vector( -5000, -897, -112 ), ----------------------------------------
		Vector( -9155, -1780, 704 ), -- Surface LVL1
		Vector( -9350, -1826, -64 ), -- LVL1
		Vector( -7761, -2135, -64 )
	}
}

hook.Add( "InitPostEntity", "bTrashEnt", function() -- Thank you OP for tidying this up!
	timer.Create( "TrashSpawnLoop", 300, 0, function()
		local map = game.GetMap()
		local pos = table.Random( positions[map] )
		if #team.GetPlayers( TEAM_SERVICE ) == 0 then return end
		for k,v in ipairs( ents.FindInSphere( pos, 300 ) ) do
			--Make sure no players, NPCs, or trash_ents are nearby
			if v:IsPlayer() or v:IsNPC() or v:GetClass() == "spawnTrash" then
				return
			end
		end
		local e = ents.Create( "spawnTrash" ) --Initializes a new entity, but does not spawn it by itself
		e:SetPos( pos )
		e:Spawn()
	end )
end )
