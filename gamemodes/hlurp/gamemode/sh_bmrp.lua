if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

TEAM_VISITOR = 1
TEAM_ADMIN = 2
TEAM_SURVEYBOSS = 3
TEAM_SURVEY = 4
TEAM_TECH = 5
TEAM_BIO = 6
TEAM_MEDIC = 7
TEAM_SERVICE = 8
TEAM_GMAN = 9
TEAM_MARINE = 10
TEAM_MARINEBOSS = 11
TEAM_WEPBOSS = 12
TEAM_SECURITYBOSS = 13
TEAM_SECURITY = 14

BuyMenuItems = {
	["sent_computerzanik"] = {
		Name = "Office Terminal",
		Description = "Standard user-level terminal for basic operations such as record keeping and messaging.",
		Price = 100,
		Max = 10
	},
	["sent_iodevice"] = {
		Name = "Terminal I/O Device",
		Description = "Device that allows you to link your office terminal to Wiremod devices.",
		Price = 50,
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["sent_computerzanik_root"] = {
		Name = "Root Terminal",
		Description = "Office terminal with root-level access. Don't forget to set a password!",
		Price = 300,
		Max = 1,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["sent_computer_projector"] = {
		Name = "Holographic Terminal",
		Description = "High-tech office terminal with a floating screen. Useful for fitting into small places.",
		Price = 200,
		Max = 3,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["sent_computer_tv"] = {
		Name = "TV Terminal",
		Description = "Office terminal with a TV screen. Provides a much higher resolution than the regular office terminal.",
		Price = 150,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["sent_pc_spk"] = {
		Name = "Terminal Speaker",
		Description = "Plays audio from terminals.",
		Price = 50,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["sent_disk"] = {
		Name = "Floppy Disk",
		Description = "Stores data from a terminal.",
		Price = 50,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["item_healthcharger"] = {
		Name = "Mounted Healing Unit",
		Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_healthkit"] = {
		Name = "Health Kit",
		Description = "Small, one-time-use health kit that heals up to 25 HP.",
		Price = 100,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_battery"] = {
		Name = "Armor Battery",
		Description = "Battery for HEV suits. Charges up to 25 AP.",
		Price = 125,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_suitcharger"] = {
		Name = "Mounted Armor Charging Unit",
		Description = "Charging unit for HEV suits. Charges up to 75 AP.",
		Price = 225,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["crafting_table_bio"] = {
		Name = "Biochemist Crafting Table",
		Description = "Allows the biochemist to summon Xen creatures.",
		Price = 500,
		Max = 2,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( "bio" )
			e:Spawn()
			local portal = ents.Create("env_sprite")
			portal:SetPos( e:GetPos() + Vector( 0, 0, 35 ) )
			portal:SetKeyValue("model", "sprites/exit1_anim.vmt")
			portal:SetKeyValue("rendermode", "5") 
			portal:SetKeyValue("rendercolor", "255 255 255") 
			portal:SetKeyValue("scale", "0.5") 
			portal:SetKeyValue("spawnflags", "1") 
			portal:SetParent(e)
			portal:Spawn()
			portal:Activate()
			return e
		end
	},
	["crafting_table_wep"] = {
		Name = "Weapon Specialist Crafting Table",
		Description = "Allows the weapon specialist to craft weapons, both normal and rare.",
		Price = 500,
		Max = 2,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( "wep" )
			e:Spawn()
			return e
		end
	},
	["lab_burner"] = {
		Name = "Bunsen Burner",
		Description = "Scientific tool commonly used to heat things in a controlled manner.",
		Price = 1000,
		Max = 5,
		Allowed = function( ply ) return ply:GetJobCategory() == "Science" end
	},
	["lab_laser"] = {
		Name = "High-Powered Laser Emitter",
		Description = "Contains a high-powered laser that can cut through just about anything.",
		Price = 1500,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end
	},
	["lab_generator"] = {
		Name = "Electric Generator",
		Description = "Gasoline engine that can produce large amounts of electricity.",
		Price = 1000,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["lab_reactor"] = {
		Name = "Nuclear Reactor",
		Description = "Produces extreme amounts of energy. Relatively safe by itself.",
		Price = 1500,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end
	},
	["lab_nitrogen"] = {
		Name = "Liquid Nitrogen Capsule",
		Description = "Used to rapidly freeze items.",
		Price = 1000,
		Max = 5,
		Allowed = function( ply ) return ply:GetJobCategory() == "Science" end
	},
	["lab_chemical"] = {
		Name = "Chemical Container",
		Description = "Contains an unknown and highly reactive chemical.",
		Price = 1000,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end
	},
	["radioactive_container"] = {
		Name = "Radioactive Container",
		Description = "Used to safely store up to 10 radioactive materials.",
		Price = 200,
		Max = 5,
		Allowed = function( ply )
			local allowed = { [TEAM_BIO] = true, [TEAM_SURVEYBOSS] = true, [TEAM_SURVEY] = true }
			return allowed[ply:Team()]
		end
	},
	["satchel_shipment"] = {
		Name = "Satchel Charge (Box)",
		Description = "Remotely detonated plastic explosive.",
		Price = 500,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Satchel Charge" )
			e.WepClass = "weapon_hlof_satchel_ch"
			return e
		end
	},
	["m16_shipment"] = {
		Name = "M16 (Box)",
		Description = "Automatic rifle with a grenade launcher attachment.",
		Price = 300,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "M16" )
			e.WepClass = "weapon_hlof_9mmar_ch"
			return e
		end
	},
	["shotgun_shipment"] = {
		Name = "SPAS-12 (Box)",
		Description = "Semi-automatic 12 gauge shotgun with folding stock.",
		Price = 800,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SPAS-12" )
			e.WepClass = "weapon_hlof_shotgun_ch"
			return e
		end
	},
	["deagle_shipment"] = {
		Name = "Desert Eagle (Box)",
		Description = "Powerful pistol with laser sight.",
		Price = 500,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Desert Eagle" )
			e.WepClass = "weapon_hlof_eagle_ch"
			return e
		end
	},
	["sniper_shipment"] = {
		Name = "M40A1 Sniper (Box)",
		Description = "Bolt-action rifle with long range scope.",
		Price = 800,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "M40A1 Sniper" )
			e.WepClass = "weapon_hlof_sniperrifle_ch"
			return e
		end
	},
	["vending_resupply"] = {
		Name = "Vending Machine Resupply",
		Description = "Touch with a vending machine to restock it.",
		Price = 100,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_SERVICE end,
	},
	["weapon_extinguisher"] = {
		Name = "Fire Extinguisher",
		Description = "Used to put out fires. Touch with a used extinguisher case to restock it.",
		Price = 100,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_SERVICE end,
	},
	["mediaplayer_tv"] = {
		Name = "Media Player",
		Description = "Used to watch videos.",
		Price = 100,
		Max = 10
	}
}

ANNOUNCEMENTS_ADMIN = {
	{ "Sector C Damage Control", "bizwarn bizwarn bizwarn _comma any damage control team to sector c immediately" },
	{ "Evacuate Sector D", "buzwarn buzwarn administration _comma personnel evacuate _comma sector d immediately" },
	{ "Sector C Report Status", "deeoo deeoo attention _comma any sector c science personnel please report status" },
	{ "Report Security Violation", "bloop attention _comma report _comma any security violation _comma to administration _comma _comma sub level one" },
	{ "Evacuate Sector C", "buzwarn attention _comma any sector c science personnel evacuate _comma area immediately" },
	{ "Security to Sector D", "deeoo deeoo attention security personnel _comma to sector d" },
	{ "Biohazard in Sector B & C", "bizwarn bizwarn bizwarn biohazard _comma warning in sector b and c" },
	{ "Inspection Team Report", "dadeda inspection _comma team to radioactive materials handling bay" },
	{ "Report to Sector C", "dadeda sector c science personnel report _comma to anomalous materials test lab" },
	{ "Men Down in Sector C", "deeoo deeoo security officer reports _comma men down in sector c medical help required" },
	{ "Sector C Check Elevator", "deeoo service team check elevator one sector c" },
	{ "Tram on Time", "bloop transportation _comma control reports _comma all systems on time" },
	{ "Anomalous Energy Detected", "bizwarn bizwarn bizwarn warning anomalous energy field detected _comma in administration _comma center" },
	{ "Explosions Detected", "bizwarn bizwarn bizwarn warning high energy detonation detected _comma in materials lab" },
	{ "Elevator Failure", "buzwarn warning sector c elevator failure _comma do not use" },
	{ "Biological Forms in Sector C", "bizwarn bizwarn warning unauthorized biological _comma forms detected _comma in sector c" }
}

ANNOUNCEMENTS_HECU = {
	{ "Under Military Command", "bizwarn bizwarn bizwarn attention _comma this announcement system _comma now under military _comma command" },
	{ "Shoot on Sight", "buzwarn buzwarn alert military personnel _comma you are authorized _comma to shoot the renegade on sight" },
	{ "Wanted for Questioning", "buzwarn buzwarn attention _comma all security personnel wanted for immediate questioning" },
	{ "Report Topside", "buzwarn buzwarn attention _comma all science personnel report topside _comma for immediate questioning" },
	{ "Use Extreme Force", "buzwarn buzwarn military personnel prosecute _comma delta alpha bravo _comma with extreme force" },
	{ "Backup Required", "buzwarn buzwarn search _comma and destroy force reports _comma back up required engaged _comma with extreme resistance" }
}

--Vox announcement backend
--Loosely based on this ancient addon: https://steamcommunity.com/sharedfiles/filedetails/?id=222457407
local nextBroadcast = 0
if SERVER then
	util.AddNetworkString( "VOXBroadcast" )
	concommand.Add( "vox", function( ply, cmd, args )
		if nextBroadcast >= CurTime() then return end
		local lines = table.concat( args, " " )
		if !IsValid( ply ) or ply:IsAdmin() or ply:Team() == TEAM_ADMIN then
			net.Start( "VOXBroadcast" )
			net.WriteString( lines )
			net.Broadcast()
		end
		nextBroadcast = CurTime() + 1
	end )
else
	net.Receive( "VOXBroadcast", function()
		local lines = net.ReadString()
		local lineTbl = string.Explode( " ", lines )
		local time = 0
		for k,v in ipairs( lineTbl ) do
			v = string.lower( v )
			local dir = "vox/"..v..".wav"
			if k != 1 then
				time = time + SoundDuration( dir ) + 0.1
			end
			timer.Simple( time, function()
				surface.PlaySound( dir )
			end )
		end
	end )
end

local blockedtools = {
	["wire_explosive"] = function( ply )
		return ply:Team() == TEAM_WEPBOSS
	end,
	["wire_turret"] = function( ply )
		return ply:Team() == TEAM_WEPBOSS
	end,
	["wire_detonator"] = function( ply )
		return ply:Team() == TEAM_WEPBOSS
	end,
	["wire_expression2"] = function( ply )
		return ply:GetJobCategory() == "Science"
	end,
	["wire_simple_explosive"] = function( ply )
		return ply:Team() == TEAM_WEPBOSS
	end,
	["duplicator"] = function( ply )
		return ply:GetJobCategory() == "Science"
	end
}

hook.Add( "CanTool", "RestrictTool", function( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_TECH
	end
end )
