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
		Max = 10
	},
	["crafting_table_rebel"] = {
		Name = "Rebel Crafting Table",
		Description = "Allows players to craft turrets and science locker keys.",
		Allowed = function( ply )
			local allowed = {
				[TEAM_REBEL] = true,
				[TEAM_REBELMEDIC] = true,
				[TEAM_RESISTANCELEADER] = true,
				[TEAM_REFUGEE] = true
			}
			return allowed[ply:Team()]
		end
	},
	["item_healthcharger"] = {
		Name = "Mounted Healing Unit",
		Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
		Max = 5,
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
		Max = 5,
		Allowed = function( ply ) return ply:Team() == TEAM_REBELMEDIC or ply:Team() == TEAM_COMBINEGUARD end
	},
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
