
if game.GetMap() != "rp_ineu_valley2_v1a" then return end

timer.Create( "OutlandTimer", 1800, 1, function() for k,v in pairs( player.GetAll() ) do if SERVER then DarkRP.notify( v, 0, 6, "The ceasefire has ended!" ) end end end )

hook.Add( "PostGamemodeLoaded", "SpawnOutlandItems", function()
	if SERVER then
	local position = {
		Vector( 11904, 8654, 384 ),
		Vector( 11472, 9826, 384 ),
		Vector( 12744, 7863, 384 ),
		Vector( 14085, 563, -1483 ),
		Vector( 14319, 3859, -448 ),
		Vector( 15200, 6006, -448 ),
		Vector( 13377, 6642, -448 ),
		Vector( 14345, 7908, -435 ),
		Vector( 11692, 7969, -448 ),
		Vector( 13880, 3822, -448 )
	}
		for k,v in ipairs( position ) do
			local o1 = ents.Create("outland_item_spawner")
			o1:SetPos( v )
			o1:Spawn()
		end
	end
end )

hook.Add( "InitPostEntity", "OutlandJeeps", function()
	if SERVER then
		local carpos = {
			Vector( 4160, 6848, 512 ),
			Vector( 2684, 10425, 541 ),
			Vector( -1524, 13488, 256 ),
			Vector( -4842, 11112, 0 ),
			Vector( -13267, 11801, 0 ),
			Vector( -12493, 12003, 0 ),
			Vector( -5030, 3256, 0 ),
			Vector( -4155, 1150, 0 ),
			Vector( -2920, 605, -2 ),
			Vector( 2435, 204, 512 ),
			Vector( 7320, -3983, 17 ),
			Vector( -13013, 6372, 1024 )
		}
		
		for k,v in ipairs( carpos ) do
			local car = ents.Create( "prop_vehicle_jeep" )
			car:SetModel( "models/buggy.mdl" )
			car:SetKeyValue( "vehiclescript", "scripts/vehicles/jeep_test.txt" )
			car:SetPos( v )
			car:Spawn()
			car:Activate()
		end
	end
end )