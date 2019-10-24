
hook.Add( "PostInitEntity", "ItemNPCSpawns", function()
	local map = game.GetMap()
	if map == "rp_sectorc_beta" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( -5095, -427, 608 ) )
		e:SetAngles( Angle( 0, 180, 0 ) )
		e:Spawn()
		e:ApplyType( 1 )
	end
	if map == "rp_blackmesa_laboratory" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( 10808, -4008, 922 ) )
		e:SetAngles( Angle( 0, 0, 0 ) )
		e:Spawn()
		e:ApplyType( 1 )
	end
	if map == "rp_blackmesa_complex_fixed" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( -1251, 6766, 2160 ) )
		e:SetAngles( Angle( 0, 0, 0 ) )
		e:Spawn()
		e:ApplyType( 1 )
	end
	if map == "rp_ineu_valley2_v1a" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( 9543, 14860, 1277 ) )
		e:SetAngles( Angle( 0, -90, 0 ) )
		e:Spawn()
		e:ApplyType( 2 )
	end
	if map == "gm_boreas" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( -3112, -7864, -6399 ) )
		e:SetAngles( Angle( 0, 0, 0 ) )
		e:Spawn()
		e:ApplyType( 2 )
	end
	if map == "rp_ineu_valley2_v1a" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( -11046, 6843, 1024 ) )
		e:SetAngles( Angle( 0, 0, 0 ) )
		e:Spawn()
		e:ApplyType( 3 )
	end
	if map == "gm_boreas" then
		local e = ents.Create( "npc_item" )
		e:SetPos( Vector( -367, 370, -6303 ) )
		e:SetAngles( Angle( 0, 67, 0 ) )
		e:Spawn()
		e:ApplyType( 3 )
	end
end )