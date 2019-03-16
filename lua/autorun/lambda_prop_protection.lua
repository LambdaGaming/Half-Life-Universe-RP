
AddCSLuaFile()

local physblacklist = { --Entities that can't be physgunned by anyone but superadmins
	"rp_vendingmachine",
	"mgs_rock_hl2",
	"mgs_iron_rock",
	"swm_wood",
	"swm_wood_red",
	"npc_shop",
	"cancel_button_combine",
	"sattelite_control",
	"rp_vendingmachine_bm_drink1",
	"rp_vendingmachine_bm_drink2",
	"rp_vendingmachine_bm_food1",
	"rp_vendingmachine_c17_food1",
	"cancel_button",
	"c17_codes",
	"swm_wood_xen",
	"hecu_shop",
	"mgs_crystal",
	"nuke_key",
	"outland_item_spawner",
	"cancel_button_rebel",
	"rocket_launch_button",
	"gb5_proj_icbm_big",
	"trash_compactor",
	"xen_podium"
}

local randomblock = { --Entities unblocked for admins, nobody else
	"aw2_dropship",
	"aw2_dropship2",
	"aw2_gunship",
	"aw2_hunterchopper",
	"aw2_hunterchopper2",
	"aw2_manhack",
	"gw_hunter",
	"gw_strider"
}

local defaultblock = { --Blocked for all players including superadmins
	"prop_door",
	"prop_door_rotating",
	"func_detail",
	"prop_dynamic_ornament",
	"prop_dymanic_override",
	"prop_dynamic",
	"prop_static",
	"func_door",
	"func_door_rotating",
	"func_ladder",
	"func_monitor",
	"func_wall",
	"func_brush",
	"door",
	"func_reflective_glass",
	"func_button",
	"func_recharge",
	"func_healthcharger",
	"func_breakable"
}

local function PlayerPickup( ply, ent )
	if ent:IsWorld() then return false end
	if table.HasValue( physblacklist, ent:GetClass():lower() ) and !ply:IsSuperAdmin() then --Prevents players who arent superadmin from physgunning blacklisted entities
		return false
	end
	if table.HasValue( defaultblock, ent:GetClass():lower() ) then --Prevents all players from physgunning blacklisted entities
		return false
	end
	if string.find( ent:GetClass():lower(), "npc_" ) and !ply:IsSuperAdmin() then --Only superadmins can pick up NPCs
		return false
	end
	if !ply:IsAdmin() and ent:GetClass() == "prop_vehicle_jeep" or ent:GetClass() == "prop_vehicle_zapc" or table.HasValue( randomblock, ent:GetClass() ) then --Only admins can pick up vehicles
		return false
	end
	if !ply:IsSuperAdmin() and ent:GetClass() == "sammyservers_textscreen" and ent:GetIsPersisted() then
		return false
	end
end
hook.Add( "PhysgunPickup", "disallow_pickup", PlayerPickup)