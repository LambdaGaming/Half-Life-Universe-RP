
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Item NPC"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Item NPC"

local valley = "rp_ineu_valley2_v1a"
local map = game.GetMap()

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "NPCType" )
end

ItemNPC = {} --Initializes the item table, don't touch
ItemNPCType = {} --Initializes the type table, don't touch

ItemNPCType[1] = {
	Name = "HECU Weapon Crate",
	Model = "models/props/fifties/wep_crate.mdl",
	MenuColor = ColorAlpha( color_orange, 30 ),
	MenuTextColor = color_white,
	ButtonColor = color_white,
	ButtonTextColor = color_black,
	Allowed = {}
}

ItemNPCType[2] = {
	Name = "Combine Vehicle Shop",
	Model = "models/combine_soldier_prisonguard.mdl",
	MenuColor = Color( 230, 93, 80, 200 ),
	MenuTextColor = color_white,
	ButtonColor = Color( 49, 53, 61, 255 ),
	ButtonTextColor = color_white,
	Allowed = {}
}

ItemNPCType[3] = {
	Name = "Rebel Item Shop",
	Model = "models/humans/group03/male_04.mdl",
	MenuColor = Color( 1, 22, 0, 200 ),
	MenuTextColor = color_white,
	ButtonColor = color_black,
	ButtonTextColor = color_white,
	Allowed = {}
}

ItemNPCType[4] = {
	Name = "Black Mesa Item Shop",
	Model = "models/props/halflifeoneprops1/crate00.mdl",
	MenuColor = ColorAlpha( color_orange, 30 ),
	MenuTextColor = color_white,
	ButtonColor = color_black,
	ButtonTextColor = color_white,
	Allowed = {}
}

ItemNPCType[5] = {
	Name = "Combine Weapon Dispenser",
	Model = "models/props_combine/combine_interface001.mdl",
	MenuColor = ColorAlpha( color_theme, 220 ),
	MenuTextColor = color_white,
	ButtonColor = color_black,
	ButtonTextColor = color_white,
	Allowed = {}
}

-----HECU WEAPON CRATE ITEMS-----
ItemNPC["weapon_9mmar"] = {
	Name = "9mm SMG",
	Description = "Standard issue HECU SMG.",
	Model = "models/weapons/half-life/w_9mmar.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_9mmar" )
	end
}

ItemNPC["weapon_eagle"] = {
	Name = "Desert Eagle",
	Description = "Standard issue HECU sidearm.",
	Model = "models/weapons/opfor/w_desert_eagle.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_eagle" )
	end
}

ItemNPC["weapon_shotgun_hl"] = {
	Name = "Shotgun",
	Description = "Standard issue HECU shotgun.",
	Model = "models/weapons/half-life/w_shotgun.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_shotgun_hl" )
	end
}

ItemNPC["weapon_handgrenade"] = {
	Name = "Frag Grenade",
	Description = "Standard issue HECU grenade.",
	Model = "models/weapons/half-life/w_grenade.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_handgrenade" )
	end
}

ItemNPC["weapon_sniperrifle"] = {
	Name = "Sniper Rifle",
	Description = "Special issue HECU sniper rifle.",
	Model = "models/weapons/opfor/w_m40a1.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_sniperrifle" )
	end
}

ItemNPC["weapon_satchel"] = {
	Name = "Satchel Charge",
	Description = "Special issue HECU explosive.",
	Model = "models/weapons/half-life/w_satchel.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_satchel" )
	end
}

ItemNPC["weapon_m249"] = {
	Name = "M249",
	Description = "Standard issue HECU LMG.",
	Model = "models/opfor/items/w_saw.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_m249" )
	end
}

ItemNPC["bm_nuke"] = {
	Name = "Thermonuclear Device",
	Description = "For when the cascade event reaches it's peak.",
	Model = "models/opfor/props/nukecase.mdl",
	Price = 0,
	Type = 1,
	SpawnCheck = function( ply, self )
		if TEAM_MARINEBOSS and ply:Team() == TEAM_MARINEBOSS then
			return true
		end
		return false
	end,
	SpawnFunction = function( ply, self )
		local e = ents.Create( "bm_nuke" )
		e:SetPos( self:GetPos() + Vector( 0, 0, 30 ) )
		e:Spawn()
	end
}

-----COMBINE VEHICLE NPC ITEMS-----
ItemNPC["aw2_hunterchopper"] = {
	Name = "Hunter Chopper",
	Description = "Armed helicopter, seats one person.",
	Model = "models/Combine_Helicopter.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnCheck = function( ply, self )
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( ply, "You cannot buy aerial units while the ceasefire is in effect!", 1, 6 )
			return false
		end
		if timer.Exists( "aerialCooldown" ) then
			HLU_Notify( ply, "Please wait for the aerial unit cooldown to end before spawning another one.", 1, 6 )
			return false
		end
		return true
	end,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "aw2_hunterchopper" )
			e:SetPos( Vector( 8649, 15023, 1392 ) )
			e:Spawn()
		else
			local e = ents.Create( "aw2_hunterchopper" )
			e:SetPos( Vector( 1587, -15003, -6320 ) )
			e:Spawn()
		end
		timer.Create( "aerialCooldown", 1, 600, function() end )
	end
}

ItemNPC["aw2_dropship2"] = {
	Name = "Dropship",
	Description = "Troop transporter, seats two people in main vehicle.",
	Model = "models/Combine_dropship.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnCheck = function( ply, self )
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( ply, "You cannot buy aerial units while the ceasefire is in effect!", 1, 6 )
			return false
		end
		if timer.Exists( "aerialCooldown" ) then
			HLU_Notify( ply, "Please wait for the aerial unit cooldown to end before spawning another one.", 1, 6 )
			return false
		end
		return true
	end,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "aw2_dropship2" )
			e:SetPos( Vector( 7416, 14760, 1420 ) )
			e:Spawn()
		else
			local e = ents.Create( "aw2_dropship2" )
			e:SetPos( Vector( 1587, -15003, -6320 ) )
			e:Spawn()
		end
		timer.Create( "aerialCooldown", 1, 600, function() end )
	end
}

ItemNPC["aw2_gunship"] = {
	Name = "Gunship",
	Description = "Fast moving gunship, seats one person.",
	Model = "models/gunship.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnCheck = function( ply, self )
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( ply, "You cannot buy aerial units while the ceasefire is in effect!", 1, 6 )
			return false
		end
		if timer.Exists( "aerialCooldown" ) then
			HLU_Notify( ply, "Please wait for the aerial unit cooldown to end before spawning another one.", 1, 6 )
			return false
		end
		return true
	end,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "aw2_gunship" )
			e:SetPos( Vector( 7989, 15117, 1392 ) )
			e:Spawn()
		else
			local e = ents.Create( "aw2_gunship" )
			e:SetPos( Vector( 1587, -15003, -6320 ) )
			e:Spawn()
		end
		timer.Create( "aerialCooldown", 1, 600, function() end )
	end
}

ItemNPC["aw2_manhack"] = {
	Name = "Manhack",
	Description = "Small flying device armed with spinning blades.",
	Model = "models/manhack.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "aw2_manhack" )
			e:SetPos( Vector( 9468, 14501, 1389 ) )
			e:Spawn()
		else
			local e = ents.Create( "aw2_manhack" )
			e:SetPos( Vector( 1587, -15003, -6320 ) )
			e:Spawn()
		end
	end
}

ItemNPC["gw_hunter"] = {
	Name = "Hunter",
	Description = "Ground unit, fires explosive darts and has a powerful kick.",
	Model = "models/hunter.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "gw_hunter" )
			e:SetPos( Vector( 14672, -14462, 44 ) )
			e:Spawn()
		else
			local e = ents.Create( "gw_hunter" )
			e:SetPos( Vector( 2749, -14444, -6632 ) )
			e:Spawn()
		end
	end
}

ItemNPC["gw_strider"] = {
	Name = "Strider",
	Description = "Ground unit, fires high-energy rounds and is eqipped with a high-powered cannon to destroy vehicles and buildings.",
	Model = "models/Combine_Strider.mdl",
	Price = 0,
	Type = 2,
	Max = 10,
	SpawnFunction = function( ply, self )
		if map == valley then
			local e = ents.Create( "gw_strider" )
			e:SetPos( Vector( 14450, -14100, 100 ) )
			e:Spawn()
		else
			local e = ents.Create( "gw_strider" )
			e:SetPos( Vector( 2749, -14444, -6632 ) )
			e:Spawn()
		end
	end
}

-----TURRET NPC ITEMS-----
ItemNPC["ent_jack_gmod_ezsentry"] = {
	Name = "Sentry",
	Description = "Automated turret that can be programmed to not shoot friendly players.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezsentry" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod_Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["ent_jack_gmod_ezworkbench"] = {
	Name = "Workbench",
	Description = "Used to craft armor and certain weapons.",
	Model = "models/mosi/fallout4/furniture/workstations/weaponworkbench01.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezworkbench" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod_Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["ent_jack_gmod_ezaidradio"] = {
	Name = "Aid Radio",
	Description = "Used to call for supply airdrops.",
	Model = "models/props_rooftop/satellitedish02.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezaidradio" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod_Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["ent_jack_gmod_ezfieldhospital"] = {
	Name = "Automated Field Hospital",
	Description = "Large device to heal severe injuries such as radiation poisoning.",
	Model = "models/mri-scanner/mri-scanner.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezfieldhospital" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod_Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["item_healthcharger_out"] = {
	Name = "Mounted Healing Unit",
	RealClass = "item_healthcharger",
	Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
	Model = "models/props_combine/health_charger001.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_REBELMEDIC then return true end
		HLU_Notify( ply, "Only rebel medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_healthcharger" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_healthkit_out"] = {
	Name = "Health Kit",
	RealClass = "item_healthkit",
	Description = "Small, one-time-use health kit that heals up to 25 HP.",
	Model = "models/Items/HealthKit.mdl",
	Price = 0,
	Type = 3,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_REBELMEDIC then return true end
		HLU_Notify( ply, "Only rebel medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_healthkit" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_battery_out"] = {
	Name = "Armor Battery",
	RealClass = "item_battery",
	Description = "Battery for HEV suits. Charges up to 25 AP.",
	Model = "models/Items/battery.mdl",
	Price = 0,
	Type = 3,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_REBELMEDIC then return true end
		HLU_Notify( ply, "Only rebel medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_battery" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_suitcharger_out"] = {
	Name = "Mounted Armor Charging Unit",
	RealClass = "item_suitcharger",
	Description = "Charging unit for HEV suits. Charges up to 75 AP.",
	Model = "models/props_combine/suit_charger001.mdl",
	Price = 0,
	Type = 3,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_REBELMEDIC then return true end
		HLU_Notify( ply, "Only rebel medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_suitcharger" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["crafting_tablerebel"] = {
	Name = "Rebel Crafting Table",
	RealClass = "crafting_table",
	Description = "Used to craft weapons to help the resistance defeat the Combine.",
	Model = "models/props_wasteland/controlroom_desk001b.mdl",
	Price = 0,
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "crafting_table" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

-----BLACK MESA ITEM SHOP ITEMS-----
ItemNPC["sent_computer"] = {
	Name = "Black Mesa Standard Office Terminal",
	Description = "Terminal-based computer that allows for private messaging and file transfer through virtual servers.",
	Model = "models/props_lab/monitor01a.mdl",
	Price = 50,
	Type = 4,
	Max = 20,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "sent_computer" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_healthcharger"] = {
	Name = "Mounted Healing Unit",
	Description = "Health unit that heals up to 75 HP. Recharges after 5 minutes when empty.",
	Model = "models/props_combine/health_charger001.mdl",
	Price = 100,
	Type = 4,
	Max = 5,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_MEDIC then return true end
		HLU_Notify( ply, "Only medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_healthcharger" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_healthkit"] = {
	Name = "Health Kit",
	Description = "Small, one-time-use health kit that heals up to 25 HP.",
	Model = "models/Items/HealthKit.mdl",
	Price = 50,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_MEDIC then return true end
		HLU_Notify( ply, "Only medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_healthkit" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_battery"] = {
	Name = "Armor Battery",
	Description = "Battery for HEV suits. Charges up to 25 AP.",
	Model = "models/Items/battery.mdl",
	Price = 75,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_MEDIC then return true end
		HLU_Notify( ply, "Only medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_battery" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_suitcharger"] = {
	Name = "Mounted Armor Charging Unit",
	Description = "Charging unit for HEV suits. Charges up to 75 AP.",
	Model = "models/props_combine/suit_charger001.mdl",
	Price = 125,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_MEDIC then return true end
		HLU_Notify( ply, "Only medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_suitcharger" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["crafting_table"] = {
	Name = "Biochemist Crafting Table",
	Description = "Allows the biochemist to summon Xen creatures.",
	Model = "models/props_phx/construct/windows/window_angle360.mdl",
	Price = 400,
	Type = 4,
	Max = 2,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_BIO then return true end
		HLU_Notify( ply, "Only biochemists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "crafting_table" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:SetTableType( 2 )
		spawn:Spawn()
		spawn:SetModel( "models/props_phx/construct/windows/window_angle360.mdl" )
		spawn.CraftSound = "debris/beamstart7.wav"
		local portal = ents.Create("env_sprite")
		portal:SetPos( spawn:GetPos() + Vector( 0, 0, 35 ) )
		portal:SetKeyValue("model", "sprites/exit1_anim.vmt")
		portal:SetKeyValue("rendermode", "5") 
		portal:SetKeyValue("rendercolor", "255 255 255") 
		portal:SetKeyValue("scale", "0.5") 
		portal:SetKeyValue("spawnflags", "1") 
		portal:SetParent(spawn)
		portal:Spawn()
		portal:Activate()
	end
}

ItemNPC["crafting_tablewep"] = {
	Name = "Weapons Engineer Crafting Table",
	RealClass = "crafting_table",
	Description = "Allows the weapons engineer to craft weapons, both normal and rare.",
	Model = "models/props_wasteland/controlroom_desk001b.mdl",
	Price = 400,
	Type = 4,
	Max = 2,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPMAKER then return true end
		HLU_Notify( ply, "Only weapons engineers can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "crafting_table" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:SetTableType( 3 )
		spawn:Spawn()
	end
}

ItemNPC["lab_burner"] = {
	Name = "Bunsen Burner",
	Description = "Common scientific tool, emits a small flame from a metal tube.",
	Model = "models/labware/burner.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_DEV then return true end
		HLU_Notify( ply, "Only research and development can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_burner" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["lab_laser"] = {
	Name = "High-Powered Laser Emitter",
	Description = "Contains a high-powered laser that can cut through just about anything.",
	Model = "models/props_lab/surgical_laser.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPMAKER then return true end
		HLU_Notify( ply, "Only weapons engineers can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_laser" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["lab_generator"] = {
	Name = "Electric Generator",
	Description = "Gasoline engine built to produce large amounts of electricity.",
	Model = "models/props/portedprops1/battery.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_DEV or ply:Team() == TEAM_TECH then return true end
		HLU_Notify( ply, "Only research and development and technicians can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_generator" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["lab_reactor"] = {
	Name = "Nuclear Reactor",
	Description = "Produces extreme amounts of energy. Relatively safe by itself.",
	Model = "models/props/hl16props/generator00.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_BIO then return true end
		HLU_Notify( ply, "Only biochemists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_reactor" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["lab_nitrogen"] = {
	Name = "Liquid Nitrogen Capsule",
	Description = "Contains liquid nitrogen, which is extremely cold in normal conditions.",
	Model = "models/props_lab/sterilizer.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_DEV then return true end
		HLU_Notify( ply, "Only research and development can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_nitrogen" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["lab_chemical"] = {
	Name = "Chemical Container",
	Description = "Contains an unknown and highly reactive chemical.",
	Model = "models/czeror/models/biohazard_container.mdl",
	Price = 200,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_BIO then return true end
		HLU_Notify( ply, "Only biochemists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "lab_chemical" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["container_ent"] = {
	Name = "Radioactive Material Barrel",
	Description = "Used to safely store radioactive materials.",
	Model = "models/props_c17/oildrum001.mdl",
	Price = 100,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_BIO then return true end
		HLU_Notify( ply, "Only biochemists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "container_ent" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["announcement_speaker"] = {
	Name = "Announcement Speaker",
	Description = "Used with the announcement SWEP to broadcast voice.",
	Model = "models/props_wasteland/speakercluster01a.mdl",
	Price = 50,
	Type = 4,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_ADMIN then return true end
		HLU_Notify( ply, "Only the facility administrator can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		ply:Give( "announcement_speaker" )
	end
}

ItemNPC["weapon_satchelbm"] = {
	Name = "Satchel Charge (Box)",
	RealClass = "hlu_shipment",
	Description = "Remotely detonated plastic explosive.",
	Model = "models/weapons/half-life/w_satchel.mdl",
	Price = 300,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPBOSS then return true end
		HLU_Notify( ply, "Only weapon specialists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Satchel Charge" )
		spawn.WepClass = "weapon_satchel"
	end
}

ItemNPC["weapon_9mmarbm"] = {
	Name = "9mm SMG (Box)",
	RealClass = "hlu_shipment",
	Description = "Automatic rifle chambered in 9mm with a grenade launcher attachment.",
	Model = "models/weapons/half-life/w_9mmar.mdl",
	Price = 300,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPBOSS then return true end
		HLU_Notify( ply, "Only weapon specialists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "9mm SMG" )
		spawn.WepClass = "weapon_9mmar"
	end
}

ItemNPC["weapon_shotgun_hlbm"] = {
	Name = "SPAS-12 (Box)",
	RealClass = "hlu_shipment",
	Description = "Semi-automatic 12 gauge shotgun with folding stock.",
	Model = "models/halflife/weapons/scigun.mdl",
	Price = 300,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPBOSS then return true end
		HLU_Notify( ply, "Only weapon specialists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "SPAS-12" )
		spawn.WepClass = "weapon_shotgun_hl"
	end
}

ItemNPC["weapon_eaglebm"] = {
	Name = "Desert Eagle (Box)",
	RealClass = "hlu_shipment",
	Description = "Powerful pistol with laser sight.",
	Model = "models/opfor/items/w_desert_eagle.mdl",
	Price = 300,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPBOSS then return true end
		HLU_Notify( ply, "Only weapon specialists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Desert Eagle" )
		spawn.WepClass = "weapon_eagle"
	end
}

ItemNPC["weapon_sniperriflecombine"] = {
	Name = "M40A1 Sniper (Box)",
	RealClass = "hlu_shipment",
	Description = "Bolt-action rifle with long range scope.",
	Model = "models/opfor/items/w_m40a1.mdl",
	Price = 300,
	Type = 4,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_WEPBOSS then return true end
		HLU_Notify( ply, "Only weapon specialists can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "M40A1 Sniper" )
		spawn.WepClass = "weapon_sniperrifle"
	end
}

ItemNPC["vending_resupply"] = {
	Name = "Vending Machine Resupply",
	Description = "Touch with a vending machine to restock it.",
	Model = "models/props/CS_militia/food_stack.mdl",
	Price = 50,
	Type = 4,
	Max = 5,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_SERVICE then return true end
		HLU_Notify( ply, "Only service officials can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "vending_resupply" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}


ItemNPC["mediaplayer_tv"] = {
	Name = "Media Player",
	RealClass = "mediaplayer_tv",
	Description = "Used to watch youtube.",
	Model = "models/gmod_tower/suitetv_large.mdl",
	Price = 50,
	Type = 4,
	Max = 10,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "mediaplayer_tv" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

--Combine weapon dispenser items
ItemNPC["item_battery"] = {
	Name = "Armor Battery",
	Description = "Battery for powered suits. Charges up to 25 AP.",
	Model = "models/Items/battery.mdl",
	Price = 0,
	Type = 5,
	Max = 10,
	SpawnCheck = function( ply, self )
		local allowed = {
			[TEAM_COMBINESOLIER] = true,
			[TEAM_COMBINEGUARD] = true,
			[TEAM_COMBINEGUARDSHOTGUN] = true,
			[TEAM_COMBINEELITE] = true
		}
		if allowed[ply:Team()] then return true end
		HLU_Notify( ply, "Only Overwatch soldiers, guards, and elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_battery" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["item_suitcharger"] = {
	Name = "Mounted Armor Charging Unit",
	Description = "Charging unit for powered suits. Charges up to 75 AP.",
	Model = "models/props_combine/suit_charger001.mdl",
	Price = 0,
	Type = 5,
	Max = 10,
	SpawnCheck = function( ply, self )
		local allowed = {
			[TEAM_COMBINESOLIER] = true,
			[TEAM_COMBINEGUARD] = true,
			[TEAM_COMBINEGUARDSHOTGUN] = true,
			[TEAM_COMBINEELITE] = true
		}
		if allowed[ply:Team()] then return true end
		HLU_Notify( ply, "Only overwatch soldiers, guards, and elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "item_suitcharger" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}

ItemNPC["weapon_smg1"] = {
	Name = "SMG (Small Box)",
	RealClass = "hlu_shipment",
	Description = "Automatic 9mm SMG with grenade launcher.",
	Model = "models/weapons/w_smg1.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_COMBINEELITE then return true end
		HLU_Notify( ply, "Only overwatch elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "SMG" )
		spawn.WepClass = "weapon_smg1"
		spawn:SetNWInt( "NumWeapons", 5 )
	end
}

ItemNPC["weapon_ar2"] = {
	Name = "AR2 (Small Box)",
	RealClass = "hlu_shipment",
	Description = "Automatic pulse rifle with energy ball launcher.",
	Model = "models/weapons/w_IRifle.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_COMBINEELITE then return true end
		HLU_Notify( ply, "Only overwatch elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "AR2" )
		spawn.WepClass = "weapon_ar2"
		spawn:SetNWInt( "NumWeapons", 5 )
	end
}

ItemNPC["weapon_shotgun"] = {
	Name = "Shotgun (Small Box)",
	RealClass = "hlu_shipment",
	Description = "12 gauge shotgun with double fire mode.",
	Model = "models/weapons/w_shotgun.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_COMBINEELITE then return true end
		HLU_Notify( ply, "Only overwatch elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Shotgun" )
		spawn.WepClass = "weapon_shotgun"
		spawn:SetNWInt( "NumWeapons", 5 )
	end
}

ItemNPC["weapon_frag"] = {
	Name = "Frag Grenade (Small Box)",
	RealClass = "hlu_shipment",
	Description = "Standard frag grenade.",
	Model = "models/weapons/w_grenade.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_COMBINEELITE then return true end
		HLU_Notify( ply, "Only overwatch elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Frag Grenade" )
		spawn.WepClass = "weapon_frag"
		spawn:SetNWInt( "NumWeapons", 5 )
	end
}

ItemNPC["weapon_bp_sniper"] = {
	Name = "Sniper Rifle (Small Box)",
	RealClass = "hlu_shipment",
	Description = "Sniper rifle with high accuracy and a 2-4x scope.",
	Model = "models/rtb_weapons/w_sniper.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_COMBINEELITE then return true end
		HLU_Notify( ply, "Only overwatch elites can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Sniper Rifle" )
		spawn.WepClass = "weapon_bp_sniper"
		spawn:SetNWInt( "NumWeapons", 5 )
	end
}

ItemNPC["weapon_smg1"] = {
	Name = "SMG (Large Box)",
	RealClass = "hlu_shipment",
	Description = "Automatic 9mm SMG with grenade launcher.",
	Model = "models/weapons/w_smg1.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "SMG" )
		spawn.WepClass = "weapon_smg1"
	end
}

ItemNPC["weapon_ar2"] = {
	Name = "AR2 (Large Box)",
	RealClass = "hlu_shipment",
	Description = "Automatic pulse rifle with energy ball launcher.",
	Model = "models/weapons/w_IRifle.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "AR2" )
		spawn.WepClass = "weapon_ar2"
	end
}

ItemNPC["weapon_shotgun"] = {
	Name = "Shotgun (Large Box)",
	RealClass = "hlu_shipment",
	Description = "12 gauge shotgun with double fire mode.",
	Model = "models/weapons/w_shotgun.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Shotgun" )
		spawn.WepClass = "weapon_shotgun"
	end
}

ItemNPC["weapon_frag"] = {
	Name = "Frag Grenade (Large Box)",
	RealClass = "hlu_shipment",
	Description = "Standard frag grenade.",
	Model = "models/weapons/w_grenade.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Frag Grenade" )
		spawn.WepClass = "weapon_frag"
	end
}

ItemNPC["weapon_bp_sniper"] = {
	Name = "Sniper Rifle (Large Box)",
	RealClass = "hlu_shipment",
	Description = "Sniper rifle with high accuracy and a 2-4x scope.",
	Model = "models/rtb_weapons/w_sniper.mdl",
	Price = 0,
	Type = 5,
	Max = 20,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "hlu_shipment" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetNWString( "WepName", "Sniper Rifle" )
		spawn.WepClass = "weapon_bp_sniper"
	end
}

ItemNPC["crafting_tablecombine"] = {
	Name = "Combine Crafting Table",
	RealClass = "crafting_table",
	Description = "Allows players to craft turrets and keys for the science locker.",
	Model = "models/props_wasteland/controlroom_desk001b.mdl",
	Price = 0,
	Type = 5,
	Max = 10,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "crafting_table" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
		spawn:SetTableType( 4 )
        spawn:SetMaterial( "phoenix_storms/FuturisticTrackRamp_1-2" )
	end
}

ItemNPC["announcement_speakercmd"] = {
	Name = "Announcement Speaker",
	RealClass = "announcement_speaker",
	Description = "Used with the announcement SWEP to broadcast voice.",
	Model = "models/props_wasteland/speakercluster01a.mdl",
	Price = 0,
	Type = 5,
	Max = 4,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_EARTHADMIN then return true end
		HLU_Notify( ply, "Only the earth admin can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		ply:Give( "announcement_speaker" )
	end
}

ItemNPC["mediaplayer_tvcmb"] = {
	Name = "Media Player",
	RealClass = "mediaplayer_tv",
	Description = "Used to watch youtube.",
	Model = "models/gmod_tower/suitetv_large.mdl",
	Price = 0,
	Type = 5,
	Max = 10,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "mediaplayer_tv" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 30 ) )
		spawn:Spawn()
	end
}
