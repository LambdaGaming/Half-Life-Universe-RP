local function ArialCheck( ply )
	if timer.Exists( "aerialCooldown" ) then
		ply:Notify( 1, 6, "Please wait for the cooldown to end before deploying another arial unit." )
		return false
	end
	return true
end

local function GroundCheck( ply )
	if timer.Exists( "groundCooldown" ) then
		ply:Notify( 1, 6, "Please wait for the cooldown to end before deploying another ground unit." )
		return false
	end
	return true
end

local function CeasefireCheck( ply )
	if timer.Exists( "CombineCooldown" ) then
		ply:Notify( 1, 6, "Non-transport vehicles are currently unavailable. Please check back later." )
		return false
	end
	return true
end

local function CalcCooldown( half )
	local num = player.GetCount()
	return half and num * 45 or num * 90
end

ItemNPCType = {
	{
		Name = "HECU Weapon Crate",
		Model = "models/props/fifties/wep_crate.mdl",
		MenuColor = ColorAlpha( color_orange, 30 ),
		MenuTextColor = color_white,
		CanUse = function( ply )
			if ply:GetJobCategory() == "Military" or GetGlobalBool( "CascadeActive" ) then
				return true
			end
			ply:Notify( 1, 6, "Only the HECU can use the weapon crate at this time." )
			return false
		end
	},
	{
		Name = "Vehicle Deployment Terminal",
		Model = "models/props_combine/combine_interface002.mdl",
		MenuColor = Color( 0, 30, 0 ),
		MenuTextColor = color_white,
		CanUse = function( ply )
			local allowed = { TEAM_COMBINESOLDIER, TEAM_COMBINEGUARD, TEAM_COMBINEELITE, TEAM_COMBINEGUARDSHOTGUN }
			if table.HasValue( allowed, ply:Team() ) then
				return true
			end
			ply:Notify( 1, 6, "Only the Combine can use this terminal." )
			return false
		end
	}
}

ItemNPC = {
	----HECU WEAPON CRATE ITEMS----
	{
		Name = "Thermonuclear Device",
		Description = "Nuclear bomb only to be used in extreme circumstances where destroying the facility is your only remaining option.",
		Model = "models/opfor/props/nukecase.mdl",
		Type = 1,
		CanBuy = function( ply, self )
			return ply:Team() == TEAM_MARINEBOSS, "Only the HECU Captain can use the nuke!"
		end,
		SpawnClass = "bm_nuke",
		SpawnOffset = Vector( 0, 0, 30 )
	},
	{
		Name = "M16",
		Description = "Standard issue HECU rifle with grenade launcher.",
		Model = "models/weapons/half-life/w_9mmar.mdl",
		Type = 1,
		Give = "weapon_hlof_9mmar_ch"
	},
	{
		Name = "Desert Eagle",
		Description = "Standard issue HECU sidearm.",
		Model = "models/weapons/opfor/w_desert_eagle.mdl",
		Type = 1,
		Give = "weapon_hlof_eagle_ch"
	},
	{
		Name = "SPAS-12",
		Description = "Standard issue HECU shotgun.",
		Model = "models/weapons/half-life/w_shotgun.mdl",
		Type = 1,
		Give = "weapon_hlof_shotgun_ch"
	},
	{
		Name = "Frag Grenade",
		Description = "Standard issue HECU explosive.",
		Model = "models/weapons/half-life/w_grenade.mdl",
		Type = 1,
		Give = "weapon_hlof_handgrenade_ch"
	},
	{
		Name = "Sniper Rifle",
		Description = "Special issue HECU rifle.",
		Model = "models/weapons/opfor/w_m40a1.mdl",
		Type = 1,
		Give = "weapon_hlof_sniperrifle_ch"
	},
	{
		Name = "Satchel Charge",
		Description = "Special issue HECU explosive.",
		Model = "models/weapons/half-life/w_satchel.mdl",
		Type = 1,
		Give = "weapon_hlof_satchel_ch"
	},
	{
		Name = "M249",
		Description = "Standard issue HECU machine gun.",
		Model = "models/opfor/items/w_saw.mdl",
		Type = 1,
		Give = "weapon_hlof_m249_ch"
	},

	----COMBINE VEHICLE NPC ITEMS----
	{
		Name = "Hunter Chopper",
		Description = "Helicopter equipped with a gun and bombs.",
		Model = "models/Combine_Helicopter.mdl",
		Type = 2,
		Max = 5,
		CanBuy = function( ply ) return ArialCheck( ply ) and CeasefireCheck( ply ) end,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "aw2_hunterchopper" )
			e:SetPos( Vector( 1691, -483, -1492 ) )
			e:Spawn()
			ply:SetPos( e:GetPos() + Vector( 0, 100, 0 ) )
			timer.Simple( 0.5, function() e:Use( ply ) end )
			timer.Create( "aerialCooldown", 1, CalcCooldown(), function() end )
		end
	},
	{
		Name = "Dropship",
		Description = "Troop transporter, seats one person in main vehicle and six in the pod.",
		Model = "models/Combine_dropship.mdl",
		Type = 2,
		Max = 3,
		CanBuy = ArialCheck,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "aw2_dropship" )
			e:SetPos( Vector( 1780, -163, -1504 ) )
			e:Spawn()
			ply:SetPos( e:GetPos() + Vector( 0, 100, 0 ) )
			timer.Simple( 0.5, function() e:Use( ply ) end )
			timer.Create( "aerialCooldown", 1, CalcCooldown(), function() end )
		end
	},
	{
		Name = "Gunship",
		Description = "Fast moving gunship equipped with a rapid-firing cannon.",
		Model = "models/gunship.mdl",
		Type = 2,
		Max = 5,
		CanBuy = function( ply ) return ArialCheck( ply ) and CeasefireCheck( ply ) end,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "aw2_gunship" )
			e:SetPos( Vector( 1772, 235, -1510 ) )
			e:Spawn()
			ply:SetPos( e:GetPos() + Vector( 0, 100, 0 ) )
			timer.Simple( 0.5, function() e:Use( ply ) end )
			timer.Create( "aerialCooldown", 1, CalcCooldown(), function() end )
		end
	},
	{
		Name = "Hunter",
		Description = "Three-legged ground unit that fires explosive darts and has a powerful kick.",
		Model = "models/hunter.mdl",
		Type = 2,
		Max = 5,
		CanBuy = function( ply ) return GroundCheck( ply ) and CeasefireCheck( ply ) end,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "gw_hunter" )
			e:SetPos( Vector( 4115, -1173, -2623 ) )
			e:Spawn()
			ply:SetPos( e:GetPos() + Vector( 0, 100, 0 ) )
			timer.Simple( 0.5, function() e:Use( ply ) end )
			timer.Create( "groundCooldown", 1, CalcCooldown( true ), function() end )
		end
	},
	{
		Name = "Strider",
		Description = "Three-legged ground unit that fires high-energy rounds, and is eqipped with a high-powered beam cannon.",
		Model = "models/Combine_Strider.mdl",
		Type = 2,
		Max = 5,
		CanBuy = function( ply ) return GroundCheck( ply ) and CeasefireCheck( ply ) end,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "gw_strider" )
			e:SetPos( Vector( 3285, -1204, -2324 ) )
			e:Spawn()
			ply:SetPos( e:GetPos() + Vector( 0, 100, 0 ) )
			timer.Simple( 0.5, function() e:Use( ply ) end )
			timer.Create( "groundCooldown", 1, CalcCooldown( true ), function() end )
		end
	},
	{
		Name = "Transport Truck",
		Description = "Four-wheeled ground vehicle used to transport prisoners and troops. Seats up to 8 people.",
		Model = "models/ctvehicles/hla/prisoner_transport.mdl",
		Type = 2,
		Max = 5,
		CanBuy = GroundCheck,
		SpawnOverride = function( ply, self )
			local e = ents.Create( "prop_vehicle_jeep" )
			e:SetPos( Vector( -2094, -1754, 6668 ) )
			e:SetAngles( Angle( 0, -90, 0 ) )
			e:SetModel( "models/ctvehicles/hla/prisoner_transport.mdl" )
			e:SetKeyValue( "vehiclescript", "scripts/vehicles/ctvehicles/ctv_hla_prisoner_transport.txt" )
			e:Spawn()
			e:Activate()
			ply:EnterVehicle( e )
			timer.Create( "groundCooldown", 1, CalcCooldown( true ), function() end )
		end
	}
}
