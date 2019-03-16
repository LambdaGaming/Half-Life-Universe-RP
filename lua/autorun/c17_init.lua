
if game.GetMap() == "rp_city17_build210" then
	hook.Add( "InitPostEntity", "C17Generator", function()
		if SERVER then
			local genpos = {
				Vector( 786, 6497, -463 ),
				Vector( 1959, -1108, -462 ),
				Vector( -1774, 6948, -463 ),
				Vector( 2865, -3104, 83 )
			}
			local car = ents.Create( "iron_generator" )
			car:SetPos( table.Random( genpos ) )
			car:Spawn()
		end
	end )
end

if game.GetMap() == "rp_city17_district47" then
	hook.Add( "InitPostEntity", "C17Generator", function()
		if SERVER then
			local genpos = {
				Vector( 644, -793, -124 ),
				Vector( 214, -1580, 67 ),
				Vector( 916, -204, 134 ),
				Vector( 3713, -68, 69 )
			}
			local car = ents.Create( "iron_generator" )
			car:SetPos( table.Random( genpos ) )
			car:Spawn()
		end
	end )
end

if game.GetMap() == "rp_c24_v1" then
		hook.Add( "InitPostEntity", "C17Generator", function()
		if SERVER then
			local genpos = {
				Vector( 7404, -7884, -253 ),
				Vector( 7871, -10100, -901 ),
				Vector( 9648, 5153, -243 ),
				Vector( 11387, 6892, -52 )
			}
			local car = ents.Create( "iron_generator" )
			car:SetPos( table.Random( genpos ) )
			car:Spawn()
		end
	end )
end

if game.GetMap() == "rp_industrial17_v1" then
	hook.Add( "InitPostEntity", "C17Generator", function()
		if SERVER then
			local genpos = {
				Vector( 2925, -1120, -166 ),
				Vector( 3499, 1116, 3 ),
				Vector( 3165, 2524, -133 ),
				Vector( 909, 4636, -132 )
			}
			local car = ents.Create( "iron_generator" )
			car:SetPos( table.Random( genpos ) )
			car:Spawn()
		end
	end )
end