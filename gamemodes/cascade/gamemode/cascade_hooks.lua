
if SERVER then
	hook.Add( "PlayerSay", "playersayremovetimer", function( ply, text, public )
		if ( text == "!disabletimer" ) then
			if timer.Exists( "MainLoop" ) then timer.Remove( "MainLoop" ) end
			if timer.Exists( "MainLoopHalf" ) then timer.Remove( "MainLoopHalf" ) end
			DarkRP.notifyAll( 0, 6, "The timer for this round has been disabled." )
			return ""
        end
	end )

	hook.Add( "PlayerSay", "playersaycascade", function( ply, text, public )
		if text == "!cascade" then
			if GAMEMODE_NAME != "cascade" then
				ply:ChatPrint( "Cannot start round. Incorrect gamemode." )
				return
			end
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot change round. You are not a superadmin." )
				return
			end
			if GetGlobalInt( "PreRound" ) == 0 and GetGlobalInt( "MainRound" ) == 0 then
				Cascade()
			else
				ResetRound()
			end
			return ""
        end
	end )
	
	hook.Add( "PlayerSay", "playersayreset", function( ply, text, public )
		if ( text == "!teleplayers" ) then
			if GAMEMODE_NAME != "cascade" then
				ply:ChatPrint( "Cannot teleport players to start. Incorrect gamemode." )
				return
			end
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot teleport players to start. You are not a superadmin." )
				return
			end
			TelePlayers()
			return ""
        end
	end )
end