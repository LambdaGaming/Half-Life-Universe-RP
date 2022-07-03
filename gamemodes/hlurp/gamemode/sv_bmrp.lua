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
			RunConsoleCommand( "vox", commands[split[2]] )
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

	local NPCPosTable
	if game.GetMap() == "rp_sectorc_beta" then
		NPCPosTable = {
			Vector( -4312, -10572, 15 ),
			Vector( -4314, -9693, 45 ),
			Vector( -3841, -10562, 30 ),
			Vector( -6203, -11538, 115 ),
			Vector( -4343, -7738, -730 ),
			Vector( -6508, -12717, 115 ),
			Vector( -5484, -9237, -2845 ),
			Vector( -5736, -6869, -975 ),
			Vector( -8775, -7680, -2950 ),
			Vector( -7995, -7833, -2945 ),
			Vector( -10049, -6705, -2660 ),
			Vector( -10490, -7925, -2660 )
		}
	elseif game.GetMap() == "rp_blackmesa_complex_fixed" then
		NPCPosTable = {
			Vector( 8747, -2843, 1425 ),
			Vector( 7985, -3491, 1425 ),
			Vector( 9017, -3441, 1425 ),
			Vector( 9415, -4233, 1055 ),
			Vector( 9579, -4030, 1250 ),
			Vector( 8802, -3951, 1055 ),
			Vector( 9122, -3115, 1090 ),
			Vector( 8276, -3073, 1055 )
		}
	elseif game.GetMap() == "rp_blackmesa_laboratory" then
		NPCPosTable = {
			Vector( -4480, -39, -350 ),
			Vector( -4278, 1331, -350 ),
			Vector( -4015, 1916, -350 ),
			Vector( -4564, 1512, -350 ),
			Vector( -5243, 1906, -350 ),
			Vector( -4567, 2252, -350 )
		}
	elseif game.GetMap() == "rp_bmrf" then
		NPCPosTable = {
			Vector( -14609, -14482, -14952 ),
			Vector( -14309, -14713, -15006 ),
			Vector( -13876, -14545, -14941 ),
			Vector( -14381, -14138, -14950 ),
			Vector( -14321, -14431, -15017 )
		}
	end

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
	if game.GetMap() == "rp_sectorc_beta" then
		local models = {
			["models/hair.mdl"] = true,
			["models/fungus.mdl"] = true,
			["models/fungus(small).mdl"] = true
		}
		for k,v in ipairs( ents.GetAll() ) do
			if models[v:GetModel()] then
				v:Remove()
			end
		end
	elseif game.GetMap() == "rp_bmrf" then
		for k,v in pairs( ents.FindByClass( "xen_plantlight" ) ) do
			v:Remove()
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_HairLoss", HairLoss )

function ToggleAlarm( forceon )
	local alarmindex = {
		["rp_sectorc_beta"] = 1990,
		["rp_blackmesa_laboratory"] = 712,
		["rp_blackmesa_complex_fixed"] = 1104,
		["rp_bmrf"] = 1153
	}
	local ent = ents.GetByIndex( alarmindex[game.GetMap()] )
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
		["rp_sectorc_beta"] = true,
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

		if game.GetMap() == "rp_sectorc_beta" then
			spawnpos = {
				{ Vector( -8857, -870, 570 ), Angle( 0, 180, 0 ) },
				{ Vector( -8996, -866, 570 ), Angle( 0, 180, 0 ) },
				{ Vector( -6250, -1590, 557 ), Angle( 0, 118, 0 ) }
			}
		elseif game.GetMap() == "gm_atomic" then
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
		else
			spawnpos = {
				{ Vector( 4289, -1954, 704 ), Angle( 0, -90, 0 ) },
				{ Vector( 2173, -5337, 192 ), Angle( 0, 180, 0 ) },
				{ Vector( -7263, -2217, 704 ), Angle( 0, 180, 0 ) }
			}
		end

		for k,v in ipairs( spawnpos ) do
			local randveh = table.Random( vehicles )
			local car = ents.Create( "prop_vehicle_jeep" )
			car:SetModel( randveh[1] )
			car:SetKeyValue( "vehiclescript", randveh[2] )
			car:SetPos( v[1] )
			car:SetAngles( v[2] )
			car:Spawn()
			car:Activate()
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_VehicleSpawn", BMRPVehicleSpawn )

--Forklift spawn function
local function BMRPForkliftSpawn()
	if game.GetMap() == "gm_atomic" then return end
	local ForkPos = {
		["rp_sectorc_beta"] = {
			{ Vector( 3179, -1326, -377 ), Angle( 0, 180, 0 ) },
			{ Vector( 3385, -1326, -377 ), Angle( 0, 180, 0 ) },
			{ Vector( 3616, -1326, -377 ), Angle( 0, 180, 0 ) }
		},
		["rp_blackmesa_laboratory"] = {
			{ Vector( -381, -5922, -349 ), angle_zero },
			{ Vector( -240, -5924, -349 ), angle_zero },
			{ Vector( -65, -5925, -349 ), angle_zero }
		},
		["rp_blackmesa_complex_fixed"] = {
			{ Vector( -1854, 727, 288 ), angle_zero },
			{ Vector( -1143, -931, 432 ), angle_zero },
			{ Vector( -930, 1226, 288 ), angle_zero }
		},
		["rp_bmrf"] = {
			{ Vector( -223, -2680, 96 ), Angle( 0, 90, 0 ) },
			{ Vector( -223, -2830, 96 ), Angle( 0, 90, 0 ) },
			{ Vector( -223, -2911, 96 ), Angle( 0, 90, 0 ) }
		}
	}

	for k,v in ipairs( ForkPos[game.GetMap()] ) do
		local car = ents.Create( "prop_vehicle_jeep" )
		car:SetModel( "models/sligwolf/forklift_truck/forklift_truck.mdl" )
		car:SetKeyValue( "vehiclescript", "scripts/vehicles/sligwolf/sw_forklift_truck.txt" )
		car:SetPos( v[1] )
		car:SetAngles( v[2] )
		car:Spawn()
		car:Activate()
	end
end
hook.Add( "InitPostEntity", "BMRP_ForkliftSpawn", BMRPForkliftSpawn )

--Budget management function
function ChangeBudget( amount )
	local budget = GetGlobalInt( "BMRP_Budget" )
	SetGlobalInt( "BMRP_Budget", budget + amount )
end

--Set players radio when spawning
local function SetSpawnRadio( ply )
	ply:ConCommand( "say /setr 42.0" )
end
hook.Add( "PlayerInitialSpawn", "BMRP_SetRadio", SetSpawnRadio )

hook.Add( "CanPlayerEnterVehicle", "BMRP_ForkliftRestriction", function( ply, veh )
	local script = veh:GetKeyValues()["VehicleScript"]
	if script and script == "scripts/vehicles/sligwolf/sw_forklift_truck.txt" then
		if ply:Team() == TEAM_SERVICE then
			return true
		else
			HLU_Notify( ply, "Only service officials are forklift certified!", 1, 6 )
			return false
		end
	end
end )
