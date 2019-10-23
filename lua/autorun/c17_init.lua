
if SERVER then
	timer.Create( "City17Timer", 1800, 1, function()
		local endmessage = "The ceasefire has ended!"
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( "NOTICE: "..endmessage )
		end
		DarkRP.notifyAll( 0, 6, endmessage )
	end )

	hook.Add( "PlayerInitialSpawn", "City17CeasefireNotice", function( ply )
		if timer.Exists( "City17Timer" ) then
			timer.Simple( 10, function()
				local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
				ply:ChatPrint( "NOTICE: "..ceasefiremessage )
				DarkRP.notify( ply, 0, 6, ceasefiremessage )
			end )
		end
	end )

	if game.GetMap() == "rp_city17_build210" then
		hook.Add( "InitPostEntity", "C17Generator", function()
			local genpos = {
				Vector( 786, 6497, -463 ),
				Vector( 1959, -1108, -462 ),
				Vector( -1774, 6948, -463 ),
				Vector( 2865, -3104, 83 )
			}
			local e = ents.Create( "iron_generator" )
			e:SetPos( table.Random( genpos ) )
			e:Spawn()
		end )
	end

	if game.GetMap() == "rp_city17_district47" then
		hook.Add( "InitPostEntity", "C17Generator", function()
			local genpos = {
				Vector( 644, -793, -124 ),
				Vector( 214, -1580, 67 ),
				Vector( 916, -204, 134 ),
				Vector( 3713, -68, 69 )
			}
			local e = ents.Create( "iron_generator" )
			e:SetPos( table.Random( genpos ) )
			e:Spawn()
		end )
	end

	if game.GetMap() == "rp_city24_v2" then
			hook.Add( "InitPostEntity", "C17Generator", function()
			local genpos = {
				Vector( 6185, 5506, -311 ),
				Vector( 6986, 6516, -511 ),
				Vector( 5277, 3485, -305 ),
				Vector( 8008, 3820, -274 )
			}
			local e = ents.Create( "iron_generator" )
			e:SetPos( table.Random( genpos ) )
			e:Spawn()
		end )
	end

	if game.GetMap() == "rp_industrial17_v1" then
		hook.Add( "InitPostEntity", "C17Generator", function()
			local genpos = {
				Vector( 2925, -1120, -166 ),
				Vector( 3499, 1116, 3 ),
				Vector( 3165, 2524, -133 ),
				Vector( 909, 4636, -132 )
			}
			local e = ents.Create( "iron_generator" )
			e:SetPos( table.Random( genpos ) )
			e:Spawn()
		end )
	end
end