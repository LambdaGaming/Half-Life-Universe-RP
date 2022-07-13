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
TEAM_WEPMAKER = 13
TEAM_SECURITYBOSS = 14
TEAM_SECURITY = 15

BuyMenuItems = {
	["sent_computer"] = {
		Name = "Office Terminal",
		Description = "Terminal-based computer that allows for private messaging and file transfer through virtual servers.",
		Price = 50,
		Max = 10
	},
	["sent_iodevice"] = {
		Name = "Terminal I/O Device",
		Description = "Device that allows you to link your office terminal to wiremod devices.",
		Price = 100,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["item_healthcharger"] = {
		Name = "Mounted Healing Unit",
		Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
		Price = 100,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_healthkit"] = {
		Name = "Health Kit",
		Description = "Small, one-time-use health kit that heals up to 25 HP.",
		Price = 50,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_battery"] = {
		Name = "Armor Battery",
		Description = "Battery for HEV suits. Charges up to 25 AP.",
		Price = 75,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["item_suitcharger"] = {
		Name = "Mounted Armor Charging Unit",
		Description = "Charging unit for HEV suits. Charges up to 75 AP.",
		Price = 125,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_MEDIC end
	},
	["crafting_table_bio"] = {
		Name = "Biochemist Crafting Table",
		Description = "Allows the biochemist to summon Xen creatures.",
		Price = 400,
		Max = 2,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "crafting_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( 2 )
			e:Spawn()
			e:SetModel( "models/props_phx/construct/windows/window_angle360.mdl" )
			e.CraftSound = "debris/beamstart7.wav"
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
		Name = "Weapons Engineer Crafting Table",
		Description = "Allows the weapons engineer to craft weapons, both normal and rare.",
		Price = 400,
		Max = 2,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPMAKER end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "crafting_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( 3 )
			e:Spawn()
			return e
		end
	},
	["lab_burner"] = {
		Name = "Bunsen Burner",
		Description = "Common scientific tool, emits a small flame from a metal tube.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:IsJobCategory( "Science" ) end
	},
	["lab_laser"] = {
		Name = "High-Powered Laser Emitter",
		Description = "Contains a high-powered laser that can cut through just about anything.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPMAKER end
	},
	["lab_generator"] = {
		Name = "Electric Generator",
		Description = "Gasoline engine built to produce large amounts of electricity.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_TECH end
	},
	["lab_reactor"] = {
		Name = "Nuclear Reactor",
		Description = "Produces extreme amounts of energy. Relatively safe by itself.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end
	},
	["lab_nitrogen"] = {
		Name = "Liquid Nitrogen Capsule",
		Description = "Contains liquid nitrogen, which is extremely cold in normal conditions.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:IsJobCategory( "Science" ) end
	},
	["lab_chemical"] = {
		Name = "Chemical Container",
		Description = "Contains an unknown and highly reactive chemical.",
		Price = 200,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end
	},
	["container_ent"] = {
		Name = "Radioactive Material Barrel",
		Description = "Used to safely store radioactive materials.",
		Price = 100,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_BIO end
	},
	["satchel_shipment"] = {
		Name = "Satchel Charge (Box)",
		Description = "Remotely detonated plastic explosive.",
		Price = 300,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Satchel Charge" )
			e.WepClass = "weapon_satchel"
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
			e.WepClass = "weapon_9mmar"
			return e
		end
	},
	["shotgun_shipment"] = {
		Name = "SPAS-12 (Box)",
		Description = "Semi-automatic 12 gauge shotgun with folding stock.",
		Price = 300,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SPAS-12" )
			e.WepClass = "weapon_shotgun_hl"
			return e
		end
	},
	["deagle_shipment"] = {
		Name = "Desert Eagle (Box)",
		Description = "Powerful pistol with laser sight.",
		Price = 300,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Desert Eagle" )
			e.WepClass = "weapon_eagle"
			return e
		end
	},
	["sniper_shipment"] = {
		Name = "M40A1 Sniper (Box)",
		Description = "Bolt-action rifle with long range scope.",
		Price = 300,
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_WEPBOSS end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "M40A1 Sniper" )
			e.WepClass = "weapon_sniperrifle"
			return e
		end
	},
	["vending_resupply"] = {
		Name = "Vending Machine Resupply",
		Description = "Touch with a vending machine to restock it.",
		Price = 50,
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_SERVICE end,
	},
	["mediaplayer_tv"] = {
		Name = "Media Player",
		Description = "Used to watch videos.",
		Price = 50,
		Max = 10
	}
}

local blockedtools = {
	["wire_explosive"] = function( ply )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_turret"] = function( ply )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_detonator"] = function( ply )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_expression2"] = function( ply )
		return ply:IsJobCategory( "Science" )
	end,
	["wire_simple_explosive"] = function( ply )
		return ply:Team() == TEAM_WEPMAKER
	end
}

local function RestrictTool( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_TECH
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
