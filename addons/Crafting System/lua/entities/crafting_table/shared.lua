
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crafting Table"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Crafting Table"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "TableType" ) --Access and write to using ent:GetTableType() and ent:SetTableType()
end

--[[
	Types:
	1 - Rebel
	2 - Biochemist
	3 - Weapons Engineer
	4 - Combine
]]

CraftingTable = {}

--Template Item
--[[
	CraftingTable["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name
	Description = "Requires 1 ball.", --Description of the item
	Materials = { --Entities that are required to craft this item, make sure you leave the entity names WITHOUT quotes!
		iron = 2,
		wood = 1
	},
	Type = 1, --Lets you set the type of the item to match up with the data table above so you can have one table entity for multiple sets of items, keep this at 1 if you only want to use 1 set of items for all players
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--On top of configuring your item here, don't forget to add the entity name to the list of allowed ents in craft_config.lua! Failure to do so will result in errors!

--Rebel crafting items

CraftingTable["weapon_pistol"] = {
	Name = "Civil Protection Pistol",
	Description = "Requires 2 iron and 1 wrench.",
	Materials = {
		ironbar = 2,
		wrench = 1
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_pistol" )
		end
}

CraftingTable["weapon_crowbar"] = {
	Name = "Crowbar",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_crowbar" )
		end
}

CraftingTable["weapon_smg1"] = {
	Name = "Combine SMG",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_smg1" )
		end
}

CraftingTable["weapon_crossbow"] = {
	Name = "Makeshift Crossbow",
	Description = "Requires 6 iron and 3 wrenches.",
	Materials = {
		ironbar = 6,
		wrench = 3
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_crossbow" )
		end
}

CraftingTable["wrench"] = {
	Name = "Wrench",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "wrench" )
		end
}

CraftingTable["weapon_bp_sniper"] = {
	Name = "Combine Sniper Rifle",
	Description = "Requires 5 iron and 4 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 4
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_bp_sniper" )
		end
}

CraftingTable["item_ammo_pistol"] = {
	Name = "Pistol Ammo",
	Description = "Requires 1 iron.",
	Materials = {
		ironbar = 1
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_pistol" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_smg1"] = {
	Name = "SMG Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_smg1" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_box_buckshot"] = {
	Name = "Shotgun Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_box_buckshot" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_crossbow"] = {
	Name = "Crossbow Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_crossbow" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["item_ammo_ar2"] = {
	Name = "AR2 Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "item_ammo_ar2" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["bp_sniper_ammo"] = {
	Name = "Sniper Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "bp_sniper_ammo" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["lockpick"] = {
	Name = "Lockpick",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "lockpick" )
		end
}

CraftingTable["weapon_shotgun"] = {
	Name = "Shotgun",
	Description = "Requires 3 iron and 2 wrenches.",
	Materials = {
		ironbar = 3,
		wrench = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_shotgun" )
		end
}

CraftingTable["weapon_rpg"] = {
	Name = "RPG",
	Description = "Requires 6 iron and 4 wrenches.",
	Materials = {
		ironbar = 6,
		wrench = 4
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_rpg" )
		end
}

CraftingTable["rebel_teleporter"] = {
	Name = "Resistance Teleporter",
	Description = "Requires 10 iron and 5 wrenches.",
	Materials = {
		ironbar = 10,
		wrench = 5
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "rebel_teleporter" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["two_way_teleporter"] = {
	Name = "Two-Way Teleporter",
	Description = "Requires 5 iron and 2 wrenches. (2 need to be crafted for them to work.)",
	Materials = {
		ironbar = 5,
		wrench = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "two_way_teleporter" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["weapon_frag"] = {
	Name = "Frag Grenade",
	Description = "Requires 4 iron and 2 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_frag" )
		end
}

CraftingTable["weapon_grenadeplacer"] = {
	Name = "Tripwire Grenade",
	Description = "Requires 4 iron and 1 wrench.",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_grenadeplacer" )
		end
}

CraftingTable["bouncingmine"] = {
	Name = "Anti-Personnel Mine",
	Description = "Requires 6 iron and 4 wrenches.",
	Materials = {
		ironbar = 6,
		wrench = 4
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "bouncingmine" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["springgun"] = {
	Name = "Tripwire Spring Gun",
	Description = "Requires 6 iron and 4 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "springgun" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

CraftingTable["tripwireextender"] = {
	Name = "Tripwire Extender",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 1,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "tripwireextender" )
			e:SetPos( self:GetPos() + Vector( 0, 0, -5 ) )
			e:Spawn()
		end
}

if game.GetMap() == "rp_ineu_valley2_v1a" then
	CraftingTable["ent_jack_sleepinbag"] = {
		Name = "Sleeping Bag",
		Description = "Requires 2 iron and 5 wood.",
		Materials = {
			ironbar = 2,
			wood = 5
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_sleepinbag" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_terminal"] = {
		Name = "Sentry Terminal",
		Description = "Requires 4 iron and 3 wrenches.",
		Materials = {
			ironbar = 4,
			wrench = 3
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_terminal" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_9mm"] = {
		Name = "9mm Sentry Ammo",
		Description = "Requires 3 iron.",
		Materials = {
			ironbar = 3
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_9mm" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_22"] = {
		Name = ".22 LR Sentry Ammo",
		Description = "Requires 2 iron.",
		Materials = {
			ironbar = 2
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_22" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_556"] = {
		Name = "5.56 Sentry Ammo",
		Description = "Requires 4 iron and 1 wrench.",
		Materials = {
			ironbar = 4,
			wrench = 1
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_556" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretammobox_762"] = {
		Name = "7.62 Sentry Ammo",
		Description = "Requires 4 iron and 3 wrenches.",
		Materials = {
			ironbar = 4,
			wrench = 3
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretammobox_762" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretbattery"] = {
		Name = "Sentry Battery",
		Description = "Requires 2 iron and 2 wrenches.",
		Materials = {
			ironbar = 2,
			wrench = 2
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretbattery" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}

	CraftingTable["ent_jack_turretrepairkit"] = {
		Name = "Sentry Repair Kit",
		Description = "Requires 4 iron and 4 wrenches.",
		Materials = {
			ironbar = 4,
			wrench = 4
		},
		Type = 1,
		SpawnFunction =
			function( ply, self )
				local e = ents.Create( "ent_jack_turretrepairkit" )
				e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
				e:Spawn()
			end
	}
end

--Combine crafting items

CraftingTable["ent_jack_turret_plinker"] = {
	Name = ".22 LR Sentry",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_plinker")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_pistol"] = {
	Name = "9mm Pistol Sentry",
	Description = "Requires 2 iron and 3 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 3
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_pistol")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_rifle"] = {
	Name = "5.56 Rifle Sentry",
	Description = "Requires 3 iron and 4 wrenches.",
	Materials = {
		ironbar = 3,
		wrench = 4
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_rifle")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_smg"] = {
	Name = "9mm SMG Sentry",
	Description = "Requires 2 iron and 4 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 4
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_smg")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_turret_sniper"] = {
	Name = "7.62 Sniper Sentry",
	Description = "Requires 5 iron and 5 wrenches.",
	Materials = {
		ironbar = 5,
		wrench = 5
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create("ent_jack_turret_sniper")
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity("Owenur",ply)
			spawn.TargetingGroup={1,3,6}
			spawn:Spawn()
			spawn:Activate()
		end
}

CraftingTable["ent_jack_terminal"] = {
	Name = "Sentry Terminal",
	Description = "Requires 4 iron and 3 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 3
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_terminal" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_9mm"] = {
	Name = "9mm Sentry Ammo",
	Description = "Requires 3 iron.",
	Materials = {
		ironbar = 3
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_9mm" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_22"] = {
	Name = ".22 LR Sentry Ammo",
	Description = "Requires 2 iron.",
	Materials = {
		ironbar = 2
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_22" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_556"] = {
	Name = "5.56 Sentry Ammo",
	Description = "Requires 4 iron and 1 wrench.",
	Materials = {
		ironbar = 4,
		wrench = 1
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_556" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretammobox_762"] = {
	Name = "7.62 Sentry Ammo",
	Description = "Requires 4 iron and 3 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 3
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretammobox_762" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretbattery"] = {
	Name = "Sentry Battery",
	Description = "Requires 2 iron and 2 wrenches.",
	Materials = {
		ironbar = 2,
		wrench = 2
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretbattery" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}

CraftingTable["ent_jack_turretrepairkit"] = {
	Name = "Sentry Repair Kit",
	Description = "Requires 4 iron and 4 wrenches.",
	Materials = {
		ironbar = 4,
		wrench = 4
	},
	Type = 4,
	SpawnFunction =
		function( ply, self )
			local e = ents.Create( "ent_jack_turretrepairkit" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 15 ) )
			e:Spawn()
		end
}