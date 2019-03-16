
if SERVER then
	hook.Add( "PlayerSay", "callmedic", function( ply, text, public )
		if ( text == "!medic" ) then
			for k,v in pairs( player.GetAll() ) do
				DarkRP.talkToPerson( v, Color( 255, 0, 0 ), ply:Nick().." is requesting medical attention!" )
				DarkRP.talkToPerson( v, Color( 255, 0, 0 ), "They are currently positioned at "..math.Round(ply:GetPos().x, 0)..", "..math.Round(ply:GetPos().y, 0)..", "..math.Round(ply:GetPos().z, 0).."!" )
			end
			return ""
        end
	end )
end