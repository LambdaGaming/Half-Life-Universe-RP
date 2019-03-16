
concommand.Add( "cascadexen", function()
	if SERVER then
		if GAMEMODE_NAME != "cascade" then return end

		local monsterpos = {
			Vector( 2192, -4962, 192 ),
			Vector( -627, -4618, 352 ),
			Vector( -919, -3827, 352 ),
			Vector( 289, -3486, 352 ),
			Vector( -1846, -3840, -1440 ),
			Vector( -2359, -4140, -1120 ),
			Vector( -604, -3112, -1440 ),
			Vector( -3126, -4684, -1439 ),
			Vector( 1317, -3188, -1440 ),
			Vector( -1698, -2038, 352 ),
			Vector( -2721, -213, 704 ),
			Vector( -2585, -1489, 208 ),
			Vector( -908, -1419, 64 ),
			Vector( 619, 295, -64 ),
			Vector( 4579, -519, -64 ),
			Vector( 5908, -394, -63 ),
			Vector( -138, 2260, -64 ),
			Vector( -151, 2732, -63 ),
			Vector( -4793, 2062, -64 ),
			Vector( -5825, -155, -112 ),
			Vector( -1150, 1328, -1088 ),
			Vector( 6851, -5744, 352 ),
			Vector( -9242, -1768, -63 ),
			Vector( -10420, -1537, -64 ),
			Vector( -8774, -1859, 705 )
		}
			
		for k,v in ipairs( monsterpos ) do
			local e = ents.Create( table.Random( CASCADE_MONSTERS ) )
			e:SetPos( v )
			e:Spawn()
		end
	end
end )