
concommand.Add( "xenspawn", function()
	if SERVER then
		if GAMEMODE_NAME == "bmrphlu" then
			local monsters = {
				"monster_alien_slv",
				"monster_agrunt",
				"monster_controller",
				"npc_headcrab",
				"npc_bullsquid",
				"monster_hound_eye"
			}

			local sectorcpos = {
				Vector( -4312, -10572, 15 ),
				Vector( -4314, -9693, 45 ),
				Vector( -3841, -10562, 30 ),
				Vector( -6203, -11538, 115 ),
				Vector( -4343, -7738, -730 ),
				Vector( -6508, -12717, 115 ),
				Vector( -5484, -9237, -2845 ),
				Vector( -5736, -6869, -975 ),
				Vector( -8775, -7680, -2950 ),
				Vector( -7995, -7833, -2945 ),
				Vector( -10049, -6705, -2660 ),
				Vector( -10490, -7925, -2660 )
			}

			local complexpos = {
				Vector( 8747, -2843, 1425 ),
				Vector( 7985, -3491, 1425 ),
				Vector( 9017, -3441, 1425 ),
				Vector( 9415, -4233, 1055 ),
				Vector( 9579, -4030, 1250 ),
				Vector( 8802, -3951, 1055 ),
				Vector( 9122, -3115, 1090 ),
				Vector( 8276, -3073, 1055 )
			}

			local laboratorypos = {
				Vector( -4480, -39, -350 ),
				Vector( -4278, 1331, -350 ),
				Vector( -4015, 1916, -350 ),
				Vector( -4564, 1512, -350 ),
				Vector( -5243, 1906, -350 ),
				Vector( -4567, 2252, -350 )
			}

			if game.GetMap() == "rp_sectorc_beta" then
				for k,v in ipairs( sectorcpos ) do
					local e = ents.Create( table.Random( monsters ) )
					e:SetPos( v )
					e:Spawn()
				end
			elseif game.GetMap() == "rp_blackmesa_complex_fixed" then
				for k,v in ipairs( complexpos ) do
					local e = ents.Create( table.Random( monsters ) )
					e:SetPos( v )
					e:Spawn()
				end
			elseif game.GetMap() == "rp_blackmesa_laboratory" then
				for k,v in ipairs( laboratorypos ) do
					local e = ents.Create( table.Random( monsters ) )
					e:SetPos( v )
					e:Spawn()
				end
			end
		end
	end
end )