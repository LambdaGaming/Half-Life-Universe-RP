
if SERVER then
	hook.Add( "PlayerSay", "playersayalarm", function( ply, text, public )
		if ( text == "!alarm" ) and ply:Team() == TEAM_ADMIN then
			if game.GetMap() == "rp_sectorc_beta" then
				for k,v in pairs( ents.FindByClass( "func_button" ) ) do
					if v:EntIndex() == 1990 then
						v:Fire( "Press" )
					end
				end
			elseif game.GetMap() == "rp_blackmesa_laboratory" then
				for k,v in pairs( ents.FindByClass( "func_button" ) ) do
					if v:EntIndex() == 712 then
						v:Fire( "Press" )
					end
				end
			elseif game.GetMap() == "rp_blackmesa_complex_fixed" then
				for k,v in pairs( ents.FindByClass( "func_button" ) ) do
					if v:EntIndex() == 1104 then
						v:Fire( "Press" )
					end
				end
			end
			return ""
        end
	end )
end