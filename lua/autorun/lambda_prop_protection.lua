
AddCSLuaFile()

local physblacklist = { --Entities that can't be physgunned by anyone but superadmins
	["rp_vendingmachine"] = true,
	["mgs_rock_hl2"] = true,
	["mgs_iron_rock"] = true,
	["swm_wood"] = true,
	["swm_wood_red"] = true,
	["npc_shop"] = true,
	["cancel_button_combine"] = true,
	["sattelite_control"] = true,
	["rp_vendingmachine_bm_drink1"] = true,
	["rp_vendingmachine_bm_drink2"] = true,
	["rp_vendingmachine_bm_food1"] = true,
	["rp_vendingmachine_c17_food1"] = true,
	["cancel_button"] = true,
	["c17_codes"] = true,
	["swm_wood_xen"] = true,
	["hecu_shop"] = true,
	["mgs_crystal"] = true,
	["nuke_key"] = true,
	["outland_item_spawner"] = true,
	["cancel_button_rebel"] = true,
	["rocket_launch_button"] = true,
	["gb5_proj_icbm_big"] = true,
	["trash_compactor"] = true,
	["xen_podium"] = true
}

local randomblock = { --Entities unblocked for admins, nobody else
	["aw2_dropship"] = true,
	["aw2_dropship2"] = true,
	["aw2_gunship"] = true,
	["aw2_hunterchopper"] = true,
	["aw2_hunterchopper2"] = true,
	["aw2_manhack"] = true,
	["gw_hunter"] = true,
	["gw_strider"] = true
}

local defaultblock = { --Blocked for all players including superadmins
	["prop_door"] = true,
	["prop_door_rotating"] = true,
	["func_detail"] = true,
	["prop_dynamic_ornament"] = true,
	["prop_dymanic_override"] = true,
	["prop_dynamic"] = true,
	["prop_static"] = true,
	["func_door"] = true,
	["func_door_rotating"] = true,
	["func_ladder"] = true,
	["func_monitor"] = true,
	["func_wall"] = true,
	["func_brush"] = true,
	["door"] = true,
	["func_reflective_glass"] = true,
	["func_button"] = true,
	["func_recharge"] = true,
	["func_healthcharger"] = true,
	["func_breakable"] = true,
	["func_tracktrain"] = true,
	["func_movelinear"] = true
}

local function PlayerPickup( ply, ent )
	if ent:IsWorld() then return false end
	if physblacklist[ent:GetClass():lower()] and !ply:IsSuperAdmin() then --Prevents players who arent superadmin from physgunning blacklisted entities
		return false
	end
	if defaultblock[ent:GetClass():lower()] then --Prevents all players from physgunning blacklisted entities
		return false
	end
	if string.find( ent:GetClass():lower(), "npc_" ) and !ply:IsSuperAdmin() then --Only superadmins can pick up NPCs
		return false
	end
	if !ply:IsAdmin() and ent:GetClass() == "prop_vehicle_jeep" or ent:GetClass() == "prop_vehicle_zapc" or randomblock[ent:GetClass()] then --Only admins can pick up vehicles
		return false
	end
	if !ply:IsSuperAdmin() and ent:GetClass() == "sammyservers_textscreen" and ent:GetIsPersisted() then
		return false
	end
end
hook.Add( "PhysgunPickup", "disallow_pickup", PlayerPickup)
