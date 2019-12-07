
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
	MenuColor = Color( 1, 22, 0, 200 ),
	MenuTextColor = color_white,
	ButtonColor = color_white,
	ButtonTextColor = color_black,
	Allowed = {}
}

ItemNPCType[2] = {
	Name = "Combine Vehicle NPC",
	Model = "models/combine_soldier_prisonguard.mdl",
	MenuColor = Color( 230, 93, 80, 200 ),
	MenuTextColor = color_white,
	ButtonColor = Color( 49, 53, 61, 255 ),
	ButtonTextColor = color_white,
	Allowed = {}
}

ItemNPCType[3] = {
	Name = "Turret NPC",
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
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_9mmar" )
		end
}

ItemNPC["weapon_eagle"] = {
	Name = "Desert Eagle",
	Description = "Standard issue HECU sidearm.",
	Model = "models/weapons/opfor/w_desert_eagle.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_eagle" )
		end
}

ItemNPC["weapon_shotgun_hl"] = {
	Name = "Shotgun",
	Description = "Standard issue HECU shotgun.",
	Model = "models/weapons/half-life/w_shotgun.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_shotgun_hl" )
		end
}

ItemNPC["weapon_handgrenade"] = {
	Name = "Frag Grenade",
	Description = "Standard issue HECU grenade.",
	Model = "models/weapons/half-life/w_grenade.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_handgrenade" )
		end
}

ItemNPC["weapon_sniperrifle"] = {
	Name = "Sniper Rifle",
	Description = "Special issue HECU sniper rifle.",
	Model = "models/weapons/opfor/w_m40a1.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_sniperrifle" )
		end
}

ItemNPC["weapon_satchel"] = {
	Name = "Satchel Charge",
	Description = "Special issue HECU explosive.",
	Model = "models/weapons/half-life/w_satchel.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_satchel" )
		end
}

ItemNPC["weapon_m249"] = {
	Name = "M249",
	Description = "Standard issue HECU LMG.",
	Model = "models/opfor/items/w_saw.mdl",
	Price = 0,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_m249" )
		end
}

-----COMBINE VEHICLE NPC ITEMS-----
ItemNPC["aw2_hunterchopper"] = {
	Name = "Hunter Chopper",
	Description = "Armed helicopter, seats one person.",
	Model = "models/Combine_Helicopter.mdl",
	Price = 1000,
	Type = 2,
	SpawnCheck =
		function( ply, self )
			if timer.Exists( "OutlandTimer" ) then
				DarkRP.notify( ply, 1, 6, "You cannot buy aerial units while the ceasefire is in effect!" )
				return false
			end
			if timer.Exists( "aerialCooldown" ) then
				DarkRP.notify( ply, 1, 6, "Please wait for the aerial unit cooldown to end before spawning another one." )
				return false
			end
			return true
		end,
	SpawnFunction =
		function( ply, self )
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
	Price = 800,
	Type = 2,
	SpawnCheck =
		function( ply, self )
			if timer.Exists( "OutlandTimer" ) then
				DarkRP.notify( ply, 1, 6, "You cannot buy aerial units while the ceasefire is in effect!" )
				return false
			end
			if timer.Exists( "aerialCooldown" ) then
				DarkRP.notify( ply, 1, 6, "Please wait for the aerial unit cooldown to end before spawning another one." )
				return false
			end
			return true
		end,
	SpawnFunction =
		function( ply, self )
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
	Price = 2000,
	Type = 2,
	SpawnCheck =
		function( ply, self )
			if timer.Exists( "OutlandTimer" ) then
				DarkRP.notify( ply, 1, 6, "You cannot buy aerial units while the ceasefire is in effect!" )
				return false
			end
			if timer.Exists( "aerialCooldown" ) then
				DarkRP.notify( ply, 1, 6, "Please wait for the aerial unit cooldown to end before spawning another one." )
				return false
			end
			return true
		end,
	SpawnFunction =
		function( ply, self )
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
	Price = 300,
	Type = 2,
	SpawnFunction =
		function( ply, self )
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
	SpawnFunction =
		function( ply, self )
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
	Price = 2000,
	Type = 2,
	SpawnFunction =
		function( ply, self )
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

ItemNPC["prop_vehicle_zapc"] = {
	Name = "APC",
	Description = "Ground unit, seats 3 people, armed with a pulse turret and rocket launcher.",
	Model = "models/combine_apc.mdl",
	Price = 1500,
	Type = 2,
	SpawnFunction =
		function( ply, self )
			if map == valley then
				local e = ents.Create( "prop_vehicle_zapc" )
				e:SetPos( Vector( 14450, -14100, 100 ) )
				e:Spawn()
			else
				local e = ents.Create( "prop_vehicle_zapc" )
				e:SetPos( Vector( 2749, -14444, -6632 ) )
				e:Spawn()
			end
		end
}

-----TURRET NPC ITEMS-----
ItemNPC["ent_jack_turret_plinker"] = {
	Name = "Plinker Sentry",
	Description = "Chambered in .22 LR, does minimal damage.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 0,
	Type = 3,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create( "ent_jack_turret_plinker" )
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity( "Owenur", ply )
			spawn.TargetingGroup = { 1, 3, 6 }
			spawn:Spawn()
			spawn:Activate()
		end
}

ItemNPC["ent_jack_turret_pistol"] = {
	Name = "Pistol Sentry",
	Description = "Chambered in 9mm , does a small amount of damage.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 400,
	Type = 3,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create( "ent_jack_turret_pistol" )
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity( "Owenur", ply )
			spawn.TargetingGroup = { 1, 3, 6 }
			spawn:Spawn()
			spawn:Activate()
		end
}

ItemNPC["ent_jack_turret_rifle"] = {
	Name = "Rifle Sentry",
	Description = "Chambered in 5.56, does high amounts of damage at short-med range.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 800,
	Type = 3,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create( "ent_jack_turret_rifle" )
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity( "Owenur", ply )
			spawn.TargetingGroup = { 1, 3, 6 }
			spawn:Spawn()
			spawn:Activate()
		end
}

ItemNPC["ent_jack_turret_smg"] = {
	Name = "SMG Sentry",
	Description = "Chambered in 9mm, same as pistol sentry but has a higher rate of fire.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 600,
	Type = 3,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create( "ent_jack_turret_smg" )
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity( "Owenur", ply )
			spawn.TargetingGroup = { 1, 3, 6 }
			spawn:Spawn()
			spawn:Activate()
		end
}

ItemNPC["ent_jack_turret_sniper"] = {
	Name = "Sniper Sentry",
	Description = "Chambered in 7.62, does high amounts of damage at long ranges.",
	Model = "models/Combine_turrets/Floor_turret.mdl",
	Price = 1000,
	Type = 3,
	SpawnFunction =
		function( ply, self )
			local spawn = ents.Create( "ent_jack_turret_sniper" )
			spawn:SetPos( ply:GetPos() + Vector( -30, 0, 10 ) )
			spawn:SetNetworkedEntity( "Owenur", ply )
			spawn.TargetingGroup = { 1, 3, 6 }
			spawn:Spawn()
			spawn:Activate()
		end
}