if GetGlobalInt( "CurrentGamemode" ) != 3 then return end

TEAM_REFUGEE = 1
TEAM_RESISTANCELEADER = 2
TEAM_REBEL = 3
TEAM_REBELMEDIC = 4
TEAM_COMBINEELITE = 5
TEAM_COMBINEGUARD = 6
TEAM_COMBINESOLDIER = 7
TEAM_COMBINEGUARDSHOTGUN = 8

BuyMenuItems = {
	["mediaplayer_tv"] = {
		Name = "Media Player",
		Description = "Used to watch videos.",
		Max = 2
	},
	["crafting_table"] = {
		Name = "Rebel Crafting Table",
		Description = "Allows players to craft weapons, tools, traps, and ammo.",
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( "rebel" )
			e:Spawn()
			return e
		end
	},
	["item_healthcharger"] = {
		Name = "Mounted Healing Unit",
		Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
		Max = 3,
		Allowed = function( ply ) return ply:Team() == TEAM_REBELMEDIC or ply:Team() == TEAM_COMBINEGUARD end
	},
	["item_healthkit"] = {
		Name = "Health Kit",
		Description = "Small, one-time-use health kit that heals up to 25 HP.",
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_REBELMEDIC or ply:Team() == TEAM_COMBINEGUARD end
	},
	["item_battery"] = {
		Name = "Armor Battery",
		Description = "Battery for HEV suits. Charges up to 25 AP.",
		Max = 10,
		Allowed = function( ply ) return ply:Team() == TEAM_REBELMEDIC or ply:Team() == TEAM_COMBINEGUARD end
	},
	["item_suitcharger"] = {
		Name = "Mounted Armor Charging Unit",
		Description = "Charging unit for HEV suits. Charges up to 75 AP.",
		Max = 3,
		Allowed = function( ply ) return ply:Team() == TEAM_REBELMEDIC or ply:Team() == TEAM_COMBINEGUARD end
	},
	["ent_jack_gmod_eztoolbox"] = {
		Name = "Tool Box",
		Description = "Contains tools used to build JMod weapons and machinery.",
		Max = 1,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end
	},
	["ent_jack_gmod_ezgroundscanner"] = {
		Name = "Resource Scanner",
		Description = "Scans the ground for JMod crafting resources.",
		Max = 2,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezgroundscanner" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	},
	["ent_jack_gmod_ezsentry"] = {
		Name = "Sentry",
		Description = "Automated sentry.",
		Max = 2,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezsentry" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	},
	["ent_jack_gmod_ezrtg"] = {
		Name = "Thermoelectric Generator",
		Description = "Simple but slow power generator.",
		Max = 1,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezrtg" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	},
	["ent_jack_gmod_ezfurnace"] = {
		Name = "Smelting Furnace",
		Description = "Furnace used for smelting mined ores.",
		Max = 1,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezfurnace" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	},
	["ent_jack_gmod_ezaugerdrill"] = {
		Name = "Auger Drill",
		Description = "Used to gather resources from the ground.",
		Max = 1,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezaugerdrill" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	},
	["ent_jack_gmod_ezworkbench"] = {
		Name = "Workbench",
		Description = "Used to craft various JMod items.",
		Max = 1,
		Allowed = function( ply ) return ply:GetJobCategory() == "Rebels" end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ent_jack_gmod_ezworkbench" )
			e:SetPos( tr.HitPos + tr.HitNormal * 60 )
			JMod.SetEZowner( e, ply )
			e.SpawnFull = true
			e:SetCreator( ply )
			e:Spawn()
			e:Activate()
			return e
		end
	}
}

local blockedtools = {
	["wire_explosive"] = function( ply, tool )
		return false
	end,
	["wire_turret"] = function( ply, tool )
		return false
	end,
	["wire_detonator"] = function( ply, tool )
		return false
	end,
	["wire_expression2"] = function( ply, tool )
		return false
	end,
	["wire_simple_explosive"] = function( ply, tool )
		return false
	end
}

local function RestrictTool( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply, tool )
	end
	if string.find( tool, "pcspawn_" ) then
		return false
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
