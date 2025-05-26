MineableEntity["iron_rock"] = {
	Name = "Iron Rock",
	Models = { "models/props/cs_militia/militiarock05.mdl" },
	Tools = { ["weapon_hl2pickaxe"] = 15, ["weapon_crowbar"] = 8 },
	Drops = { ["ucs_iron"] = 100 }
}

MineableEntity["rubble"] = {
	Name = "Rubble",
	Models = { "models/props_debris/concrete_debris128pile001a.mdl" },
	Tools = { ["weapon_hl2pickaxe"] = 15, ["weapon_crowbar"] = 8 },
	Drops = { ["ucs_iron"] = 100 },
	MaxSpawn = 4
}

MineableEntity["crystal"] = {
	Name = "Xen Crystal",
	Models = { "models/decay/props/orange_crystal.mdl" },
	Tools = { ["weapon_hl2pickaxe"] = 15, ["weapon_crowbar"] = 8 },
	Drops = { ["xen_iron"] = 100, ["crystal_pure"] = 5, ["crystal_harvested"] = 40 },
	MaxSpawn = 5,
	TextOffset = Vector( 0, 0, 50 )
}

MineableEntity["xen_tree"] = {
	Name = "Xen Tree",
	Models = { "models/decay/props/alien_tree.mdl" },
	Tools = { ["weapon_hl2pickaxe"] = 15, ["weapon_crowbar"] = 8 },
	Drops = { ["organic_matter"] = 100, ["organic_matter_rare"] = 10 },
	MaxSpawn = 1,
	TextOffset = Vector( 50, 0, 20 )
}

MineableEntity["tree"] = {
	Name = "Tree",
	Models = { "models/props/CS_militia/tree_large_militia.mdl" },
	Tools = { ["weapon_hl2pickaxe"] = 15, ["weapon_crowbar"] = 8 },
	Drops = { ["ucs_wood"] = 100 },
	TextOffset = Vector( 40, 0, -650 )
}

CraftingTable["rebel"] = {
	Name = "Rebel Crafting Table",
	Model = "models/props_wasteland/controlroom_desk001b.mdl",
	AllowAutomation = true
}

CraftingTable["bio"] = {
	Name = "Biochemist Crafting Table",
	Model = "models/props_phx/construct/windows/window_angle360.mdl",
	CraftSound = "debris/beamstart7.wav"
}

CraftingTable["wep"] = {
	Name = "Weapon Specialist Crafting Table",
	Model = "models/props_wasteland/controlroom_desk001b.mdl"
}

CraftingTable["combine"] = {
	Name = "Combine Crafting Table",
	Model = "models/props_wasteland/controlroom_desk001b.mdl",
	Material = "phoenix_storms/FuturisticTrackRamp_1-2"
}

CraftingIngredient["ucs_iron"] = {
	Name = "Iron",
	Category = "Ingredients",
	Types = { ["rebel"] = true, ["combine"] = true }
}

CraftingIngredient["ucs_wood"] = {
	Name = "Wood",
	Category = "Ingredients",
	Types = { ["rebel"] = true }
}

CraftingIngredient["locker_key"] = {
	Name = "Science Locker Key",
	Category = "Advanced Ingredients",
	Types = { ["rebel"] = true }
}

CraftingIngredient["xen_iron"] = {
	Name = "Xen Iron",
	Category = "Ingredients",
	Types = { ["bio"] = true, ["wep"] = true }
}

CraftingIngredient["xen_iron_refined"] = {
	Name = "Refined Xen Iron",
	Category = "Ingredients",
	Types = { ["bio"] = true, ["wep"] = true }
}

CraftingIngredient["organic_matter"] = {
	Name = "Organic Matter",
	Category = "Ingredients",
	Types = { ["bio"] = true, ["wep"] = true }
}

CraftingIngredient["organic_matter_rare"] = {
	Name = "Rare Organic Matter",
	Category = "Ingredients",
	Types = { ["wep"] = true }
}

CraftingIngredient["crystal_harvested"] = {
	Name = "Harvested Crystal",
	Category = "Ingredients",
	Types = { ["bio"] = true, ["wep"] = true }
}

CraftingIngredient["crystal_fragment"] = {
	Name = "Crystal Fragment",
	Category = "Ingredients",
	Types = { ["wep"] = true }
}

CraftingRecipe["weapon_pistol"] = {
	Name = "Civil Protection Pistol",
	Description = "Requires 3 iron and 75 or less Combine loyalty.",
	Category = "Pistols & SMGs",
	Loyalty = 75,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 3 }
}

CraftingRecipe["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 2 iron and 75 or less Combine loyalty.",
	Category = "Tools",
	Loyalty = 75,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["weapon_hl2pipe"] = {
	Name = "Pipe",
	Description = "Requires 2 iron and 75 or less Combine loyalty.",
	Category = "Tools",
	Loyalty = 75,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["weapon_hl2pan"] = {
	Name = "Frying Pan",
	Description = "Requires 5 iron and 75 or less Combine loyalty.",
	Category = "Tools",
	Loyalty = 75,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 5 }
}

CraftingRecipe["weapon_smg1"] = {
	Name = "Combine SMG",
	Description = "Requires 4 iron and 50 or less Combine loyalty.",
	Category = "Pistols & SMGs",
	Loyalty = 50,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 4 }
}

CraftingRecipe["weapon_ar2"] = {
	Name = "AR2",
	Description = "Requires 7 iron and 25 or less Combine loyalty.",
	Category = "Long Guns",
	Loyalty = 25,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 7 }
}

CraftingRecipe["weapon_crossbow"] = {
	Name = "Makeshift Crossbow",
	Description = "Requires 10 iron and 15 or less Combine loyalty.",
	Category = "Long Guns",
	Loyalty = 15,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 10 }
}

CraftingRecipe["weapon_bp_sniper"] = {
	Name = "Combine Sniper Rifle",
	Description = "Requires 12 iron and 10 or less Combine loyalty.",
	Category = "Long Guns",
	Loyalty = 10,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 12 }
}

CraftingRecipe["item_ammo_pistol"] = {
	Name = "Pistol Ammo",
	Description = "Requires 1 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 1 }
}

CraftingRecipe["item_ammo_smg1"] = {
	Name = "SMG Ammo",
	Description = "Requires 2 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["item_box_buckshot"] = {
	Name = "Shotgun Ammo",
	Description = "Requires 2 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["item_ammo_crossbow"] = {
	Name = "Crossbow Ammo",
	Description = "Requires 3 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 3 }
}

CraftingRecipe["item_ammo_ar2"] = {
	Name = "AR2 Ammo",
	Description = "Requires 2 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["bp_sniper_ammo"] = {
	Name = "Sniper Ammo",
	Description = "Requires 3 iron.",
	Category = "Ammo",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 3 }
}

CraftingRecipe["lockpick"] = {
	Name = "Lockpick",
	Description = "Requires 2 iron and 85 or less Combine loyalty.",
	Category = "Tools",
	Loyalty = 85,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 6 iron and 40 or less Combine loyalty.",
	Category = "Long Guns",
	Loyalty = 40,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 6 }
}

CraftingRecipe["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 13 iron and 0 Combine loyalty.",
	Category = "Explosives",
	Loyalty = 0,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 13 }
}

CraftingRecipe["rebel_teleporter"] = {
	Name = "Resistance Teleporter",
	Description = "Requires 18 iron and 0 Combine loyalty.",
	Category = "Tools",
	Loyalty = 0,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 18 }
}

CraftingRecipe["two_way_teleporter"] = {
	Name = "Two-Way Teleporter",
	Description = "Requires 8 iron and 0 Combine loyalty. Two must be crafted to be usable.",
	Category = "Tools",
	Loyalty = 0,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 8 }
}

CraftingRecipe["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 9 iron and 35 or less Combine loyalty.",
	Category = "Explosives",
	Loyalty = 35,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 9 }
}

CraftingRecipe["weapon_grenadeplacer"] = {
	Name = "Tripwire Grenade",
	Description = "Requires 5 iron and 50 or less Combine loyalty.",
	Category = "Traps",
	Loyalty = 50,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 5 }
}

CraftingRecipe["bouncingmine"] = {
	Name = "Anti-Personnel Mine",
	Description = "Requires 13 iron and 50 or less Combine loyalty.",
	Category = "Traps",
	Loyalty = 50,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 13 }
}

CraftingRecipe["springgun"] = {
	Name = "Tripwire Spring Gun",
	Description = "Requires 9 iron and 50 or less Combine loyalty.",
	Category = "Pistols",
	Loyalty = 50,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 9 }
}

CraftingRecipe["tripwireextender"] = {
	Name = "Tripwire Extender",
	Description = "Requires 2 iron.",
	Category = "Traps",
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 2 }
}

CraftingRecipe["weapon_ram"] = {
	Name = "Combine Door Authorization",
	Description = "Requires 40 iron and 5 or less Combine loyalty.",
	Category = "Tools",
	Loyalty = 5,
	Types = { ["rebel"] = true },
	Materials = { ["ucs_iron"] = 40 }
}

if game.GetMap() == "rp_mezs" then
	CraftingRecipe["ent_jack_sleepinbag_rebel"] = {
		Name = "Sleeping Bag",
		Description = "Requires 2 iron and 4 wood.",
		Category = "Tools",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 2, ["ucs_wood"] = 4 }
	}

	CraftingRecipe["ent_jack_gmod_ezadvparts"] = {
		Name = "Advanced Parts Box",
		Description = "Requires 9 iron.",
		Category = "JMod",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 9 }
	}

	CraftingRecipe["ent_jack_gmod_ezadvtextiles"] = {
		Name = "Advanced Textiles Box",
		Description = "Requires 2 iron and 2 wood.",
		Category = "JMod",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 2, ["ucs_wood"] = 2 }
	}

	CraftingRecipe["ent_jack_gmod_ezmedsupplies"] = {
		Name = "Medical Supply Box",
		Description = "Requires 2 iron and 3 wood.",
		Category = "JMod",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 2, ["ucs_wood"] = 3 }
	}

	CraftingRecipe["ent_gauto_fuel"] = {
		Name = "Vehicle Fuel",
		Description = "Requires 6 iron.",
		Category = "Tools",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 6 }
	}

	CraftingRecipe["ent_gauto_repair"] = {
		Name = "Vehicle Repair Kit",
		Description = "Requires 8 iron.",
		Category = "Tools",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 8 }
	}

	CraftingRecipe["rocket_key"] = {
		Name = "Rocket Key",
		Description = "Requires 35 iron and 0 Combine loyalty.",
		Category = "Tools",
		Loyalty = 0,
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 35 }
	}
else
	CraftingRecipe["code_decrypter"] = {
		Name = "Detonation Code Decrypter",
		Description = "Requires 5 iron and a science locker key.",
		Category = "Tools",
		Types = { ["rebel"] = true },
		Materials = { ["ucs_iron"] = 5, ["locker_key"] = 1 }
	}
end

CraftingRecipe["npc_headcrab_black"] = {
	Name = "Poison Headcrab",
	Description = "Requires 2 organic matter.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 2 }
}

CraftingRecipe["npc_headcrab_fast"] = {
	Name = "Fast Headcrab",
	Description = "Requires 2 organic matter.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_aliengrunt"] = {
	Name = "Alien Grunt",
	Description = "Requires 3 organic matter and 2 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 3, ["xen_iron"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_aliencontroller"] = {
	Name = "Alien Controller",
	Description = "Requires 5 organic matter and 2 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 3, ["xen_iron"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_bullsquid"] = {
	Name = "Bullsquid",
	Description = "Requires 4 organic matter and 2 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 4, ["xen_iron"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_headcrab_baby"] = {
	Name = "Baby Headcrab",
	Description = "Requires 1 organic matter.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 1 }
}

CraftingRecipe["npc_vj_hlr1_houndeye"] = {
	Name = "Houndeye",
	Description = "Requires 3 organic matter and 2 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 3, ["xen_iron"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_snark"] = {
	Name = "Snark",
	Description = "Requires 1 organic matter and 2 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 1, ["xen_iron"] = 2 }
}

CraftingRecipe["npc_vj_hlr1_alienslave"] = {
	Name = "Vortigaunt",
	Description = "Requires 4 organic matter and 3 xen iron.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 4, ["xen_iron"] = 3 }
}

CraftingRecipe["weapon_hlof_barnacle"] = {
	Name = "Handheld Barnacle",
	Description = "Requires 3 organic matter and 1 harvested crystal.",
	Category = "Bioweapons",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 3, ["crystal_harvested"] = 1 }
}

CraftingRecipe["weapon_hlmmod_hornetgun"] = {
	Name = "Hivehand",
	Description = "Requires 2 organic matter and 1 harvested crystal.",
	Category = "Bioweapons",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 2, ["crystal_harvested"] = 1 }
}

CraftingRecipe["weapon_hlof_shockrifle"] = {
	Name = "Shock Rifle",
	Description = "Requires 2 organic matter, 3 xen iron, 1 rare organic matter, and 1 harvested crystal.",
	Category = "Bioweapons",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 2, ["xen_iron"] = 3, ["organic_matter_rare"] = 1, ["crystal_harvested"] = 1 }
}

CraftingRecipe["weapon_hlmmod_c_snark"] = {
	Name = "Snark",
	Description = "Requires 3 organic matter, 3 xen iron, and 1 harvested crystal.",
	Category = "Bioweapons",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 3, ["xen_iron"] = 3, ["crystal_harvested"] = 1 }
}

CraftingRecipe["weapon_hlof_sporelauncher_ch"] = {
	Name = "Spore Launcher",
	Description = "Requires 4 organic matter, 2 xen iron, 1 rare organic matter, and 1 harvested crystal.",
	Category = "Bioweapons",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 4, ["xen_iron"] = 2, ["organic_matter_rare"] = 1, ["crystal_harvested"] = 1 }
}

CraftingRecipe["zombie_serum"] = {
	Name = "Zombie Serum",
	Description = "Requires 4 organic matter and 1 rare organic matter.",
	Category = "Creatures",
	Types = { ["bio"] = true },
	Materials = { ["organic_matter"] = 4, ["organic_matter_rare"] = 1 }
}

CraftingRecipe["weapon_hlmmod_c_357"] = {
	Name = "357 Magnum",
	Description = "Requires 4 xen iron.",
	Category = "Normal Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron"] = 4 }
}

CraftingRecipe["weapon_hlmmod_c_crossbow"] = {
	Name = "Crossbow",
	Description = "Requires 4 xen iron and 1 refined xen iron.",
	Category = "Normal Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron"] = 4, ["xen_iron_refined"] = 1 }
}

CraftingRecipe["weapon_hlmmod_c_egon"] = {
	Name = "Gluon Gun",
	Description = "Requires 2 refined xen iron, 1 harvested crystal, and 1 crystal fragment.",
	Category = "Prototype Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron_refined"] = 2, ["crystal_harvested"] = 1, ["crystal_fragment"] = 1 }
}

CraftingRecipe["weapon_hlof_displacer_ch"] = {
	Name = "Displacer Cannon",
	Description = "Requires 3 refined xen iron, 2 harvested crystals, and 2 crystal fragments.",
	Category = "Prototype Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron_refined"] = 3, ["crystal_harvested"] = 2, ["crystal_fragment"] = 2 }
}

CraftingRecipe["weapon_hlmmod_c_gauss"] = {
	Name = "Tau Cannon",
	Description = "Requires 2 refined xen iron, 2 xen iron, 2 harvested crystals, and 3 crystal fragments.",
	Category = "Prototype Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron_refined"] = 2, ["xen_iron"] = 2, ["crystal_harvested"] = 2, ["crystal_fragment"] = 3 }
}

CraftingRecipe["weapon_hlof_knife_ch"] = {
	Name = "Combat Knife",
	Description = "Requires 2 xen iron.",
	Category = "Normal Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron"] = 2 }
}

CraftingRecipe["weapon_hlof_penguin_ch"] = {
	Name = "Penguin",
	Description = "Requires 2 organic matter, 1 rare organic matter, 2 xen iron, 1 refined xen iron, 1 harvested crystal, and 1 crystal fragment.",
	Category = "Unusual Weapons",
	Types = { ["wep"] = true },
	Materials = { ["organic_matter"] = 2, ["organic_matter_rare"] = 1, ["xen_iron"] = 2, ["xen_iron_refined"] = 1, ["crystal_harvested"] = 1, ["crystal_fragment"] = 1 }
}

CraftingRecipe["weapon_hlof_rpg_ch"] = {
	Name = "RPG",
	Description = "Requires 4 refined xen iron, 2 xen iron, and 1 harvested crystal.",
	Category = "Normal Weapons",
	Types = { ["wep"] = true },
	Materials = { ["xen_iron_refined"] = 4, ["xen_iron"] = 2, ["crystal_harvested"] = 1 }
}

CraftingRecipe["ent_jack_gmod_ezsentry"] = {
	Name = "Sentry",
	Description = "Requires 6 iron.",
	Category = "JMod",
	Types = { ["combine"] = true },
	Materials = { ["ucs_iron"] = 6 }
}

CraftingRecipe["locker_key"] = {
	Name = "Combine Science Locker Key",
	Description = "Requires 10 iron.",
	Category = "Tools",
	Types = { ["combine"] = true },
	Materials = { ["ucs_iron"] = 10 }
}

CraftingRecipe["ent_jack_gmod_ezammo"] = {
	Name = "Turret Ammo",
	Description = "Requires 4 iron.",
	Category = "JMod",
	Outland = true,
	Types = { ["rebel"] = true, ["combine"] = true },
	Materials = { ["ucs_iron"] = 4 }
}

CraftingRecipe["ent_jack_gmod_ezbattery"] = {
	Name = "Turret Battery",
	Description = "Requires 5 iron.",
	Category = "JMod",
	Outland = true,
	Types = { ["rebel"] = true, ["combine"] = true },
	Materials = { ["ucs_iron"] = 5 }
}

CraftingRecipe["ent_jack_gmod_ezbasicparts"] = {
	Name = "Basic Parts Box",
	Description = "Requires 6 iron.",
	Category = "JMod",
	Outland = true,
	Types = { ["rebel"] = true, ["combine"] = true },
	Materials = { ["ucs_iron"] = 6 }
}

hook.Add( "UCS_CanCraft", "HLUCraftModifiers", function( ent, ply, recipe )
	if recipe.Loyalty and GetLoyalty( ply ) > recipe.Loyalty then
		HLU_Notify( ply, "You need to have no more than "..recipe.Loyalty.."% loyalty to craft this item.", 1, 6 )
		return false
	elseif recipe.Outland and GetGlobalInt( "CurrentGamemode" ) == 2 and ply:GetJobCategory() != "Combine" then
		HLU_Notify( ply, "This item is only available in the outlands." )
		return false
	end
end )
