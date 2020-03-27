
if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

--Vox chat commands for facility administrator and HECU captain
local cooldown
local Commands
local BMRPCommandsAdmin = {
	{ "/admindamage", "bizwarn bizwarn bizwarn _comma any damage control team to sector c immediately" },
	{ "/adminevacuate", "buzwarn buzwarn administration _comma personnel evacuate _comma sector d immediately" },
	{ "/adminreport", "deeoo deeoo attention _comma any sector c science personnel please report status" },
	{ "/reportviolation", "bloop attention _comma report _comma any security violation _comma to administration _comma _comma sub level one" },
	{ "/scientistevacuate", "buzwarn attention _comma any sector c science personnel evacuate _comma area immediately" },
	{ "/securityreport", "deeoo deeoo attention security personnel _comma to sector d" },
	{ "/biohazard", "bizwarn bizwarn bizwarn biohazard _comma warning in sector b and c" },
	{ "/servicereport", "dadeda inspection _comma team to radioactive materials handling bay" },
	{ "/hallaccess", "bloop maintenance _comma area access granted" },
	{ "/reportams", "dadeda sector c science personnel report _comma to anomalous materials test lab" },
	{ "/mendown", "deeoo deeoo security officer reports _comma men down in sector c medical help required" },
	{ "/checkelevator", "deeoo service team check elevator one sector c" },
	{ "/tramworking", "bloop transportation _comma control reports _comma all systems on time" },
	{ "/badenergy", "bizwarn bizwarn bizwarn warning anomalous energy field detected _comma in administration _comma center" },
	{ "/detonations", "bizwarn bizwarn bizwarn warning high energy detonation detected _comma in materials lab" },
	{ "/failelevator", "buzwarn warning sector c elevator failure _comma do not use" },
	{ "/aliens", "bizwarn bizwarn warning unauthorized biological _comma forms detected _comma in sector c" }
}
local BMRPCommandsHECU = {
	{ "/militaryvox", "bizwarn bizwarn bizwarn attention _comma this announcement system _comma now under military _comma command" },
	{ "/militarykos", "buzwarn buzwarn alert military personnel _comma you are authorized _comma to shoot the renegade on sight" },
	{ "/militarycallsecurity", "buzwarn buzwarn attention _comma all security personnel wanted for immediate questioning" },
	{ "/militarycallscience", "buzwarn buzwarn attention _comma all science personnel report topside _comma for immediate questioning" },
	{ "/militaryforce", "buzwarn buzwarn military personnel prosecute _comma delta alpha bravo _comma with extreme force" },
	{ "/militarybackup", "buzwarn buzwarn search _comma and destroy force reports _comma back up required engaged _comma with extreme resistance" }
}

local function CommandSound( ply, text )
	if ply:Team() == TEAM_ADMIN or ply:Team() == TEAM_MARINEBOSS then
		if cooldown and cooldown > CurTime() then
			DarkRP.notify( ply, 1, 6, "Please wait before using this command again." )
			return ""
		end
		if ply:Team() == TEAM_ADMIN then
			Commands = BMRPCommandsAdmin
		else
			Commands = BMRPCommandsHECU
		end
		if text == "/fatboy" and ply:Team() == TEAM_ADMIN then
			for k,v in pairs( player.GetAll() ) do
				v:ConCommand( "play admin/fat_boy.ogg" )
				cooldown = CurTime() + 5
			end
			return ""
		end
		for k,v in pairs( Commands ) do
			if text == v[1] then
				RunConsoleCommand( "vox", v[2] )
				cooldown = CurTime() + 5
				return ""
			end
		end
	end
end
hook.Add( "PlayerSay", "BMRPCommandSounds", CommandSound )

--Console command for spawning NPCs in Xen
local function XenSpawn()
	for k,v in pairs( ents.FindByClass( "npc_*" ) ) do
		if v.IsXenNPC then v:Remove() end
	end
	for k,v in pairs( ents.FindByClass( "monster_*" ) ) do
		if v.IsXenNPC then v:Remove() end
	end

	local monsters = {
		"monster_alien_slv",
		"monster_agrunt",
		"monster_controller",
		"npc_headcrab",
		"npc_bullsquid",
		"monster_hound_eye"
	}

	local NPCPosTable

	local sectorcpos = {
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

	local complexpos = {
		Vector( 8747, -2843, 1425 ),
		Vector( 7985, -3491, 1425 ),
		Vector( 9017, -3441, 1425 ),
		Vector( 9415, -4233, 1055 ),
		Vector( 9579, -4030, 1250 ),
		Vector( 8802, -3951, 1055 ),
		Vector( 9122, -3115, 1090 ),
		Vector( 8276, -3073, 1055 )
	}

	local laboratorypos = {
		Vector( -4480, -39, -350 ),
		Vector( -4278, 1331, -350 ),
		Vector( -4015, 1916, -350 ),
		Vector( -4564, 1512, -350 ),
		Vector( -5243, 1906, -350 ),
		Vector( -4567, 2252, -350 )
	}

	if game.GetMap() == "rp_sectorc_beta" then
		NPCPosTable = sectorcpos
	elseif game.GetMap() == "rp_blackmesa_complex_fixed" then
		NPCPosTable = complexpos
	elseif game.GetMap() == "rp_blackmesa_laboratory" then
		NPCPosTable = laboratorypos
	end

	for k,v in ipairs( NPCPosTable ) do
		local e = ents.Create( table.Random( monsters ) )
		e:SetPos( v )
		e:Spawn()
		e.IsXenNPC = true
	end
end
concommand.Add( "xenspawn", XenSpawn )
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

--Remove Xen objects that trigger NPCs on rp_sectorc_beta
local function HairLoss()
	if game.GetMap() == "rp_sectorc_beta" then
		local models = {
			["models/hair.mdl"] = true,
			["models/fungus.mdl"] = true,
			["models/fungus(small).mdl"] = true
		}
		for k,v in pairs( ents.GetAll() ) do
			if models[v:GetModel()] then
				v:Remove()
			end
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_HairLoss", HairLoss )

--Alarm chat command for the facility admin to remotely activate the alarm system
local alarmindex = {
	["rp_sectorc_beta"] = 1990,
	["rp_blackmesa_laboratory"] = 712,
	["rp_blackmesa_complex_fixed"] = 1104
}

local function AdminAlarm( ply, text )
	if text == "!alarm" and ply:Team() == TEAM_ADMIN then
		local ent = ents.GetByIndex( alarmindex[game.GetMap()] )
		ent:Fire( "Press" )
		return ""
	end
end
hook.Add( "PlayerSay", "BMRP_Alarm", AdminAlarm )

--Vehicle spawn function
local function BMRPVehicleSpawn()
	local spawnpos
	local allowedmaps = {
		["rp_sectorc_beta"] = true,
		["gm_atomic"] = true
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
				{ Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) }
			}
		else
			spawnpos = {
				{ Vector( 0, 0, 0 ), Angle( 0, 0, 0 ) }
			}
		end

		for k,v in ipairs( spawnpos ) do
			local randveh = table.Random( vehicles )
			local car = ents.Create( "prop_vehicle_jeep" )
			car:SetModel( randveh[1] )
			car:SetKeyValue( "vehiclescript", randveh[2] )
			car:SetPos( v )
			car:Spawn()
			car:Activate()
		end
	end
end
hook.Add( "InitPostEntity", "BMRP_VehicleSpawn", BMRPVehicleSpawn )

--Budget management function
function ChangeBudget( amount )
	local budget = GetGlobalInt( "BMRP_Budget" )
	SetGlobalInt( "BMRP_Budget", budget + amount )
end
