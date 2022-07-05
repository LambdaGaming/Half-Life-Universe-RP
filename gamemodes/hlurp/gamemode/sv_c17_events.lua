
local c17maps = {
	["rp_city17_build210"] = true,
	["rp_city17_district47"] = true,
	["rp_city24_v3"] = true
}
if c17maps[game.GetMap()] then
	local zombiepos = {}
	local indexnum = {}
	local racexpos = {}
	local canpos = {}

	function ZombieInvasion()
		HLU_ChatNotifySystem( "City 17 RP", color_theme, "Zombies From Ravenholm have ended up in the sewers! Please stay indoors until civil protection units deal with the situation." )
		if game.GetMap() == "rp_city17_build210" then
			zombiepos = {
				Vector( 384, 5641, -466 ),
				Vector( 601, 5753, -466 ),
				Vector( 185, 5527, -498 ),
				Vector( 424, 5009, -464 ),
				Vector( 1741, 4837, -466 ),
				Vector( 1907, 1225, -498 ),
				Vector( 1901, 3283, -498 ),
				Vector( 1861, -881, -466 ),
				Vector( 2343, -716, -466 ),
				Vector( -926, 6732, -466 )
			}
		end
		if game.GetMap() == "rp_city17_district47" then
			zombiepos = {
				Vector( -288, -1117, -64 ),
				Vector( -49, -1258, -64 ),
				Vector( -1022, -1284, -64 ),
				Vector( 724, -1401, -120 ),
				Vector( 664, -1693, -256 ),
				Vector( 1718, -2756, -288 ),
				Vector( 556, -1211, -128 ),
				Vector( 909, -562, -128 ),
				Vector( 1201, -292, 128 ),
				Vector( 1200, -946, 64 )
			}
		end
		if game.GetMap() == "rp_city24_v3" then
			zombiepos = {
				Vector( 8361, 7538, -1184 ),
				Vector( 7973, 8439, -1403 ),
				Vector( 8263, 9438, -1184 ),
				Vector( 8445, 8438, -1408 ),
				Vector( 8610, 7116, 264 ),
				Vector( 7919, 5877, -1213 ),
				Vector( 8020, 4352, -1208 ),
				Vector( 7926, 5085, -1404 ),
				Vector( 7168, 5075, -1540 ),
				Vector( 4621, 5658, -1512 )
			}
		end
		local zombies = {
			"npc_zombie",
			"npc_poisonzombie",
			"npc_fastzombie"
		}
		for k,v in ipairs( zombiepos ) do
			local zombie = ents.Create( tostring( table.Random( zombies ) ) )
			zombie:SetPos( v )
			zombie:Spawn()
		end
	end

	function CoreFailure()
		HLU_ChatNotifySystem( "City 17 RP", color_theme, "Power failure at the citadel has caused doors to malfunction! Some of the jail cells are now open!" )
		if game.GetMap() == "rp_city17_build210" then
			indexnum = { 1176, 1178, 1173, 1180, 2534, 661, 277, 1319, 1316, 1311, 1308, 675 }
		end
		if game.GetMap() == "rp_city17_district47" then
			indexnum = { 300, 312, 296, 310, 323, 294, 308, 320, 894, 234, 235, 893, 1639 }
		end
		if game.GetMap() == "rp_city24_v3" then
			indexnum = { 1940, 1780, 3901, 4498, 2074, 1620 }
		end
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( indexnum, v:EntIndex() ) then
				v:Fire("Unlock")
				v:Fire("Open")
				v:Fire("Toggle")
			end
		end
	end

	function RaceX() --why did I agree to do this?
		HLU_ChatNotifySystem( "City 17 RP", color_theme, "Someone screwed up the lore and now Race X is invading the citadel!" )
		if game.GetMap() == "rp_city17_build210" then
			racexpos = {
				Vector( 3017, -255, 76 ),
				Vector( 4450, -71, 76 ),
				Vector( 5236, -1062, 4156 ),
				Vector( 6237, -1404, 4156 ),
				Vector( 5676, -2531, 4924 )
			}
		end
		if game.GetMap() == "rp_city17_district47" then
			racexpos = {
				Vector( -968, -2523, 384 ),
				Vector( -800, -1942, 516 ),
				Vector( -748, -2546, 776 ),
				Vector( -1039, -2606, 1152 ),
				Vector( -165, -1807, 1284 )
			}
		end
		if game.GetMap() == "rp_city24_v3" then
			racexpos = {
				Vector( 12770, 9560, 456 ),
				Vector( 12759, 10502, 696 ),
				Vector( 12779, 7418, 456 ),
				Vector( 14069, 4993, 2064 ),
				Vector( 12283, 4987, 2064 )
			}
		end
		local racexnpcs = {
			"npc_pitdrone",
			"monster_shocktrooper",
			"monster_alien_babyvoltigore"
		}
		for k,v in ipairs( racexpos ) do
			local zombie = ents.Create( tostring( table.Random( racexnpcs ) ) )
			zombie:SetPos( v )
			zombie:Spawn()
		end
	end

	hook.Add( "PlayerSpawn", "ActiveShooterRelationship", function( ply )
		for k,v in pairs( ents.FindByClass( "npc_citizen" ) ) do
			if ply:isCP() then
				v:AddEntityRelationship( ply, D_HT, 99 )
			end
		end
	end )

	function RebelInvasion()
		HLU_ChatNotifySystem( "City 17 RP", color_theme, "Rebels have invaded the citadel!" )
		if game.GetMap() == "rp_city17_build210" then
			rebelpos = {
				Vector( 3017, -255, 76 ),
				Vector( 4450, -71, 76 ),
				Vector( 5236, -1062, 4156 ),
				Vector( 6237, -1404, 4156 ),
				Vector( 5676, -2531, 4924 )
			}
		end
		if game.GetMap() == "rp_city17_district47" then
			rebelpos = {
				Vector( -968, -2523, 384 ),
				Vector( -800, -1942, 516 ),
				Vector( -748, -2546, 776 ),
				Vector( -1039, -2606, 1152 ),
				Vector( -165, -1807, 1284 )
			}
		end
		if game.GetMap() == "rp_city24_v3" then
			rebelpos = {
				Vector( 12770, 9560, 456 ),
				Vector( 12759, 10502, 696 ),
				Vector( 12779, 7418, 456 ),
				Vector( 14069, 4993, 2064 ),
				Vector( 12283, 4987, 2064 )
			}
		end
		local randmodel = {
			"models/humans/group03/female_01.mdl",
			"models/humans/group03/female_02.mdl",
			"models/humans/group03/female_03.mdl",
			"models/humans/group03/female_04.mdl",
			"models/humans/group03/female_06.mdl",
			"models/humans/group03/female_07.mdl",
			"models/humans/group03/male_01.mdl",
			"models/humans/group03/male_02.mdl",
			"models/humans/group03/male_03.mdl",
			"models/humans/group03/male_04.mdl",
			"models/humans/group03/male_05.mdl",
			"models/humans/group03/male_06.mdl",
			"models/humans/group03/male_07.mdl",
			"models/humans/group03/male_08.mdl",
			"models/humans/group03/male_09.mdl"
		}
		for k,v in ipairs( rebelpos ) do
			local rebel = ents.Create( "npc_citizen" )
			rebel:SetPos( v )
			rebel:Spawn()
			rebel:Activate()
			rebel:SetModel( table.Random( randmodel ) )
			rebel:Give( "weapon_smg1" )
			rebel:SetHealth( 300 )
			for k,v in pairs( player.GetAll() ) do
				if v:isCP() then
					rebel:AddEntityRelationship( v, D_HT, 99 )
				end
			end
		end
	end

	function CanisterFail()
		HLU_ChatNotifySystem( "City 17 RP", color_theme, "A nearby canister launcher has failed and headcrab canisters are approaching the city!" )
		if game.GetMap() == "rp_city17_build210" then
			canpos = {
				Vector( -442, -290, 76 ),
				Vector( -1805, -2452, 80 ),
				Vector( 1695, 4520, 115 ),
				Vector( 1759, -103, 76 )
			}
		end
		if game.GetMap() == "rp_city17_district47" then
			canpos = {
				Vector( 319, -1415, 360 ),
				Vector( -2144, -72, 385 ),
				Vector( -627, -1531, 384 ),
				Vector( 1848, -1930, -288 )
			}
		end
		if game.GetMap() == "rp_city24_v3" then
			canpos = {
				Vector( 5388, 6331, 264 ),
				Vector( 7326, 4371, 1 ),
				Vector( 9018, 3569, -41 ),
				Vector( 8585, 5027, 15 )
			}
		end
		for k,v in ipairs( canpos ) do
			local zombie = ents.Create( "env_headcrabcanister" )
			zombie:SetPos( v )
			zombie:SetAngles( Angle( -45, 0, 0 ) )
			zombie:SetKeyValue( "HeadcrabType", 0 )
			zombie:SetKeyValue( "HeadcrabCount", 5 )
			zombie:SetKeyValue( "FlightSpeed", 3000 )
			zombie:SetKeyValue( "FlightTime", 5 )
			zombie:SetKeyValue( "StartingHeight", 1000 )
			zombie:SetKeyValue( "Damage", math.min( 150, 256 ) )
			zombie:SetKeyValue( "DamageRadius", math.min( 750, 1024 ) )
			zombie:SetKeyValue( "SmokeLifetime", 30 )
			zombie:SetKeyValue( "spawnflags", "8192" )
			zombie:Spawn()
			zombie:Activate()
			zombie:Fire( "FireCanister" )
		end
	end
end