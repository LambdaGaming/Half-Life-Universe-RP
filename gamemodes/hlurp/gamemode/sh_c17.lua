if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

TEAM_CIVILIAN = 1
TEAM_RESISTANCELEADER = 2
TEAM_SCIENTIST = 3
TEAM_VORT = 4
TEAM_GMANCITY = 5
TEAM_EARTHADMIN = 6
TEAM_COMBINEELITE = 7
TEAM_CREMATOR = 8
TEAM_COMBINEGUARD = 9
TEAM_COMBINEGUARDSHOTGUN = 10
TEAM_COMBINESOLDIER = 11
TEAM_METROCOPMANHACK = 12
TEAM_METROCOP = 13

BuyMenuItems = {
	["mediaplayer_tv"] = {
		Name = "Media Player",
		Description = "Used to watch videos.",
		Max = 10
	},
	["smg1_shipment_small"] = {
		Name = "SMG (Small Box)",
		Description = "Automatic 9mm SMG with grenade launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SMG" )
			e.WepClass = "weapon_smg1"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["ar2_shipment_small"] = {
		Name = "AR2 (Small Box)",
		Description = "Automatic pulse rifle with energy ball launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "AR2" )
			e.WepClass = "weapon_ar2"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["shotgun_shipment_small"] = {
		Name = "Shotgun (Small Box)",
		Description = "12 gauge shotgun with double fire mode.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Shotgun" )
			e.WepClass = "weapon_shotgun"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["frag_shipment_small"] = {
		Name = "Frag Grenade (Small Box)",
		Description = "Standard frag grenade.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Frag Grenade" )
			e.WepClass = "weapon_frag"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["sniper_shipment_small"] = {
		Name = "Sniper Rifle (Small Box)",
		Description = "Sniper rifle with high accuracy and a 2x-4x scope.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Sniper Rifle" )
			e.WepClass = "weapon_bp_sniper"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["smg1_shipment_big"] = {
		Name = "SMG (Large Box)",
		Description = "Automatic 9mm SMG with grenade launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SMG" )
			e.WepClass = "weapon_smg1"
			return e
		end
	},
	["ar2_shipment_big"] = {
		Name = "AR2 (Large Box)",
		Description = "Automatic pulse rifle with energy ball launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "AR2" )
			e.WepClass = "weapon_ar2"
			return e
		end
	},
	["shotgun_shipment_big"] = {
		Name = "Shotgun (Large Box)",
		Description = "12 gauge shotgun with double fire mode.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Shotgun" )
			e.WepClass = "weapon_shotgun"
			return e
		end
	},
	["frag_shipment_big"] = {
		Name = "Frag Grenade (Large Box)",
		Description = "Standard frag grenade.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Frag Grenade" )
			e.WepClass = "weapon_frag"
			return e
		end
	},
	["sniper_shipment_big"] = {
		Name = "Sniper Rifle (Large Box)",
		Description = "Sniper rifle with high accuracy and a 2x-4x scope.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Sniper Rifle" )
			e.WepClass = "weapon_bp_sniper"
			return e
		end
	},
	["crafting_table_combine"] = {
		Name = "Combine Crafting Table",
		Description = "Allows players to craft turrets and science locker keys.",
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN or ply:Team() == TEAM_SCIENTIST end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( "combine" )
			e:Spawn()
			return e
		end
	},
	["crafting_table_rebel"] = {
		Name = "Rebel Crafting Table",
		Description = "Allows players to craft weapons, tools, traps, and ammo.",
		Allowed = function( ply ) return ply:Team() == TEAM_CIVILIAN or ply:Team() == TEAM_RESISTANCELEADER end,
		SpawnCheck = function( ply )
			if GetLoyalty( ply ) > 90 then
				HLU_Notify( ply, "You need to have no more than 90% loyalty to spawn the rebel crafting table.", 1, 6 )
				return false
			end
		end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetTableType( "rebel" )
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
		return ply:Team() == TEAM_SCIENTIST
	end,
	["wire_simple_explosive"] = function( ply, tool )
		return false
	end,
	["duplicator"] = function( ply, tool )
		return ply:Team() == TEAM_SCIENTIST
	end
}

local function RestrictTool( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply, tool )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_SCIENTIST
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
