
if SERVER then
	hook.Add( "PlayerSay", "playersayresetmoney", function( ply, text, public )
		if ( text == "!resetmoney" ) and ply:IsSuperAdmin() then
			ply:ConCommand( "resetmoney" )
			return ""
        end
	end )
end

--Using mysqlite since darkrp doesn't directly support resetting EVERYONES money at once, including superadmins and offline players
if SERVER then
    concommand.Add( "resetmoney", function() 
		MySQLite.query( [[ UPDATE darkrp_player SET wallet = 3000 ]] )
		DarkRP.notifyAll( 1, 6, "Everyone's money has been successfully reset." )
	end )
end