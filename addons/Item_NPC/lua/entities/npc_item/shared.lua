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

-----HECU WEAPON CRATE ITEMS-----
ItemNPC["weapon_9mmar"] = {
	Name = "9mm SMG",
	Description = "Standard issue HECU SMG.",
	Model = "models/weapons/half-life/w_9mmar.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_9mmar" )
	end
}

ItemNPC["weapon_eagle"] = {
	Name = "Desert Eagle",
	Description = "Standard issue HECU sidearm.",
	Model = "models/weapons/opfor/w_desert_eagle.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_eagle" )
	end
}

ItemNPC["weapon_shotgun_hl"] = {
	Name = "Shotgun",
	Description = "Standard issue HECU shotgun.",
	Model = "models/weapons/half-life/w_shotgun.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_shotgun_hl" )
	end
}

ItemNPC["weapon_handgrenade"] = {
	Name = "Frag Grenade",
	Description = "Standard issue HECU grenade.",
	Model = "models/weapons/half-life/w_grenade.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_handgrenade" )
	end
}

ItemNPC["weapon_sniperrifle"] = {
	Name = "Sniper Rifle",
	Description = "Special issue HECU sniper rifle.",
	Model = "models/weapons/opfor/w_m40a1.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_sniperrifle" )
	end
}

ItemNPC["weapon_satchel"] = {
	Name = "Satchel Charge",
	Description = "Special issue HECU explosive.",
	Model = "models/weapons/half-life/w_satchel.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_satchel" )
	end
}

ItemNPC["weapon_m249"] = {
	Name = "M249",
	Description = "Standard issue HECU LMG.",
	Model = "models/opfor/items/w_saw.mdl",
	Type = 1,
	SpawnFunction = function( ply, self )
		ply:Give( "weapon_m249" )
	end
}

ItemNPC["bm_nuke"] = {
	Name = "Thermonuclear Device",
	Description = "For when the cascade event reaches it's peak.",
	Model = "models/opfor/props/nukecase.mdl",
	Type = 1,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_MARINEBOSS then
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
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezsentry" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod.Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["ent_jack_gmod_ezaidradio"] = {
	Name = "Aid Radio",
	Description = "Used to call for supply airdrops.",
	Model = "models/props_rooftop/satellitedish02.mdl",
	Type = 3,
	Max = 5,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezaidradio" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod.Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}

ItemNPC["ent_jack_gmod_ezfieldhospital"] = {
	Name = "Automated Field Hospital",
	Description = "Large device to heal severe injuries such as radiation poisoning.",
	Model = "models/mri-scanner/mri-scanner.mdl",
	Type = 3,
	Max = 1,
	SpawnCheck = function( ply, self )
		if ply:Team() == TEAM_REBELMEDIC then return true end
		HLU_Notify( ply, "Only rebel medics can purchase this item.", 1, 6 )
		return false
	end,
	SpawnFunction = function( ply, self )
		local spawn = ents.Create( "ent_jack_gmod_ezfieldhospital" )
		spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
		JMod.Owner( spawn, ply )
		spawn:Spawn()
		spawn:Activate()
	end
}
