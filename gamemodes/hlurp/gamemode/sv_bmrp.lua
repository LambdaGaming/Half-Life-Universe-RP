if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

--Vox chat commands for facility administrator and HECU captain
local cooldown
local BMRPCommandsAdmin = {
	["damage"] = "bizwarn bizwarn bizwarn _comma any damage control team to sector c immediately",
	["evacuate"] = "buzwarn buzwarn administration _comma personnel evacuate _comma sector d immediately",
	["report"] = "deeoo deeoo attention _comma any sector c science personnel please report status",
	["reportviolation"] = "bloop attention _comma report _comma any security violation _comma to administration _comma _comma sub level one",
	["scientistevacuate"] = "buzwarn attention _comma any sector c science personnel evacuate _comma area immediately",
	["security"] = "deeoo deeoo attention security personnel _comma to sector d",
	["biohazard"] = "bizwarn bizwarn bizwarn biohazard _comma warning in sector b and c",
	["inspection"] = "dadeda inspection _comma team to radioactive materials handling bay",
	["hallaccess"] = "bloop maintenance _comma area access granted",
	["reportams"] = "dadeda sector c science personnel report _comma to anomalous materials test lab",
	["mendown"] = "deeoo deeoo security officer reports _comma men down in sector c medical help required",
	["checkelevator"] = "deeoo service team check elevator one sector c",
	["tram"] = "bloop transportation _comma control reports _comma all systems on time",
	["energy"] = "bizwarn bizwarn bizwarn warning anomalous energy field detected _comma in administration _comma center",
	["detonations"] = "bizwarn bizwarn bizwarn warning high energy detonation detected _comma in materials lab",
	["elevator"] = "buzwarn warning sector c elevator failure _comma do not use",
	["aliens"] = "bizwarn bizwarn warning unauthorized biological _comma forms detected _comma in sector c"
}
local BMRPCommandsHECU = {
	["command"] = "bizwarn bizwarn bizwarn attention _comma this announcement system _comma now under military _comma command",
	["kos"] = "buzwarn buzwarn alert military personnel _comma you are authorized _comma to shoot the renegade on sight",
	["security"] = "buzwarn buzwarn attention _comma all security personnel wanted for immediate questioning",
	["science"] = "buzwarn buzwarn attention _comma all science personnel report topside _comma for immediate questioning",
	["force"] = "buzwarn buzwarn military personnel prosecute _comma delta alpha bravo _comma with extreme force",
	["backup"] = "buzwarn buzwarn search _comma and destroy force reports _comma back up required engaged _comma with extreme resistance"
}

local function CommandSound( ply, text )
	local commands
	if ply:Team() == TEAM_ADMIN or ply:Team() == TEAM_MARINEBOSS then
		if cooldown and cooldown > CurTime() then
			HLU_Notify( ply, "Please wait before using this command again.", 1, 6 )
			return ""
		end

		if ply:Team() == TEAM_ADMIN then
			commands = BMRPCommandsAdmin
		else
			commands = BMRPCommandsHECU
		end

		if text == "/fatboy" and ply:Team() == TEAM_ADMIN then
			for k,v in ipairs( player.GetHumans() ) do
				v:ConCommand( "play admin/fat_boy.ogg" )
				cooldown = CurTime() + 10
			end
			return ""
		end

		local split = string.Split( text, " " )
		if split[1] == "!announce" then
			if !split[2] or !commands[split[2]] then
				HLU_Notify( ply, "Please provide a valid argument. https://lambdagaming.github.io/hlurp/commands.html", 1, 6 )
				return ""
			end
			for k,v in ipairs( player.GetHumans() ) do
				v:ConCommand( "vox "..commands[split[2]] )
			end
			cooldown = CurTime() + 10
			return ""
		end
	end
end
hook.Add( "PlayerSay", "BMRPCommandSounds", CommandSound )

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
		"monster_alien_slv",
		"monster_agrunt",
		"monster_controller",
		"monster_bullsquid",
		"monster_hound_eye"
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

--Remove Xen objects that trigger NPCs and cause other problems
local function HairLoss()
	if game.GetMap() == "rp_bmrf" then
		for k,v in ipairs( ents.FindByClass( "xen_plantlight" ) ) do
			v:Remove()
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_HairLoss", HairLoss )

function ToggleAlarm( forceon )
	local alarmindex = {
		["rp_bmrf"] = 3364
	}
	local ent = ents.GetMapCreatedEntity( alarmindex[game.GetMap()] )
	ent:Fire( forceon and "PressIn" or "Press" )
end

--Alarm chat command for the facility admin to remotely activate the alarm system
local function AdminAlarm( ply, text )
	if text == "!alarm" and ply:Team() == TEAM_ADMIN then
		ToggleAlarm()
		return ""
	end
end
hook.Add( "PlayerSay", "BMRP_Alarm", AdminAlarm )

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
function meta:AddFunds( amount )
	self:SetNWInt( "Funds", self:GetNWInt( "Funds" ) + amount )
end
function meta:RemoveFunds( amount )
	self:SetNWInt( "Funds", self:GetNWInt( "Funds" ) - amount )
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
		
		local npcs = {
			"monster_alien_slv",
			"monster_agrunt",
			"monster_controller",
			"npc_headcrab",
			"monster_bullsquid",
			"monster_hound_eye",
			"monster_zombie_barney",
			"monster_zombie_scientist"
		}
	
		for k,v in pairs( pos ) do
			local e = ents.Create( table.Random( npcs ) )
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
		Entity( 1153 ):Fire( "Press" )
		Entity( 1155 ):Fire( "Press" )
	end
	TramFailure( true )
	SetGlobalBool( "CascadeActive", true )
end
concommand.Add( "cascade", Cascade )

local TeamSpawns = {
	["rp_bmrf"] = {
		["Administration"] = {
			Vector( 271, 2724, -64 ),
			Vector( 802, -3720, 400 )
		},
		["Science"] = {
			Vector( -4295, 2539, -63 ),
			Vector( -964, -3816, -1440 ),
			Vector( -1697, -992, 352 ),
			Vector( 730, 228, -64 ),
			Vector( -9260, -1520, -64 )
		},
		["Security"] = {
			Vector( 3789, -509, -64 ),
			Vector( 5194, 344, 0 )
		},
		["Military"] = {
			Vector( 3772, -1268, 701 ),
			Vector( 4418, -910, 704 )
		},
		["Utility"] = {
			Vector( 5572, -4657, 64 ),
			Vector( -6032, -102, -112 )
		}
	}
}
hook.Add( "PlayerSpawn", "TeamSpawns", function( ply )
	local map = game.GetMap()
	local category = ply:GetJobCategory()
	local spawns = TeamSpawns[map][category]
	if spawns then
		ply:SetPos( table.Random( spawns ) )
	end
end )
