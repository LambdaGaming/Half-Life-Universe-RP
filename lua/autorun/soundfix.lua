
--Fixes some sounds not being able to be heard on rp_sectorc_beta like the tram announcements and door sounds
hook.Add( "InitPostEntity", "join_con_commands", function()
    if game.GetMap() == "rp_sectorc_beta" then
		RunConsoleCommand( "snd_restart" )
	elseif game.GetMap() == "rp_bmrf" then
		for k,v in pairs( ents.FindByClass( "ambient_generic" ) ) do
			v:Fire( "Volume", 1 )
		end
	end
end )