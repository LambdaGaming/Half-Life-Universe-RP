
if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

net.Receive( "SendID", function()
	local ply = net.ReadEntity()
	local plyteam = ply:Team()
	local teamcolor = team.GetColor( plyteam )
	chat.AddText( teamcolor, ply:Nick(), color_white, " presents their identification. It reads: ", teamcolor, HLU_JOB[1][plyteam].Name )
end )

hook.Add( "InitPostEntity", "BMRP_SoundFix", function()
	if game.GetMap() == "rp_sectorc_beta" then
		RunConsoleCommand( "snd_restart" ) --Fixes ambient and door sounds not being heard on this map
	end
end )
