
local function SpawnChange()
	if game.GetMap() != "rp_bmrf" then return end
	timer.Simple( 3, function()
		for k,v in pairs( ents.FindByClass( "info_player_start" ) ) do
			v:Remove()
		end
		for k,v in ipairs( CASCADE_DEADPOS ) do
			local e = ents.Create( "info_player_start" )
			e:SetPos( v )
			e:SetAngles( Angle( 0, 90, 0 ) )
			e:Spawn()
		end
	end )
end
hook.Add( "InitPostEntity", "SpawnChange", SpawnChange() )