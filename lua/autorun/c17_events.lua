
if GAMEMODE_NAME == "city17rp" then
	local zombiepos = {}
	local indexnum = {}
	local racexpos = {}
	local canpos = {}

	function ZombieInvasion()
		for k,v in pairs(player.GetAll()) do
			v:ChatPrint("Zombies From Ravenholm have ended up in the sewers! Please stay indoors until civil protection units deal with the situation.")
		end
		if SERVER then
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
			if game.GetMap() == "rp_city24_v2" then
				zombiepos = {
					Vector( 10976, 7871, 136 ),
					Vector( 10926, 6589, -56 ),
					Vector( 10517, 8646, 8 ),
					Vector( 9024, 8978, 8 ),
					Vector( 6875, 5983, -512 ),
					Vector( 9381, 6466, -384 ),
					Vector( 8964, 7983, -384 ),
					Vector( 8760, 8164, -991 ),
					Vector( 9640, 7394, -376 ),
					Vector( 10328, 8471, 9 )
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
	end

	function CoreFailure()
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint("Power failure at the citadel has caused doors to malfunction! Some of the jail cells are now open!")
		end
		if game.GetMap() == "rp_city17_build210" then
			indexnum = {
				1176,
				1178,
				1173,
				1180,
				2534,
				661,
				277,
				1319,
				1316,
				1311,
				1308,
				675
			}
		end
		if game.GetMap() == "rp_city17_district47" then
			indexnum = {
				300,
				312,
				296,
				310,
				323,
				294,
				308,
				320,
				894,
				234,
				235,
				893,
				1639
			}
		end
		if game.GetMap() == "rp_city24_v2" then
			indexnum = {
				1106,
				1104,
				1099,
				1098,
				1513
			}
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
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint("Someone screwed up the lore and race X has invaded the citadel!")
		end
		if SERVER then
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
			if game.GetMap() == "rp_city24_v2" then
				racexpos = {
					Vector( 488, 9047, 520 ),
					Vector( -1324, 8996, 601 ),
					Vector( -887, 8319, 857 ),
					Vector( -663, 6911, 867 ),
					Vector( -1342, 8835, -32 )
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
	end

	function CanisterFail()
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint("A nearby canister launcher has failed and headcrab canisters are approaching the city!")
		end
		if SERVER then
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
			if game.GetMap() == "rp_city24_v2" then
				canpos = {
					Vector( 7155, 6089, 256 ),
					Vector( 6511, 4641, 0 ),
					Vector( 3276, 8984, 520 ),
					Vector( 5658, 9785, 520 )
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
end