
if SERVER then
	hook.Add( "PlayerSay", "CascadeChatCommands", function( ply, text, public )
		if text == "!disabletimer" then
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot disable round timer. You are not a superadmin." )
				return ""
			end
			if timer.Exists( "MainLoop" ) then timer.Remove( "MainLoop" ) end
			if timer.Exists( "MainLoopHalf" ) then timer.Remove( "MainLoopHalf" ) end
			for k,v in ipairs( player.GetAll() ) do
				v:ChatPrint( "The timer for this round has been disabled." )
			end
			return ""
		elseif text == "!cascade" then
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot change round. You are not a superadmin." )
				return ""
			end
			if !GetGlobalBool( "PreRound" ) and !GetGlobalBool( "MainRound" ) then
				Cascade()
			else
				ResetRound()
			end
			return ""
		elseif text == "!teleplayers" then
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot teleport players to start. You are not a superadmin." )
				return ""
			end
			TelePlayers()
			return ""
		elseif text == "!fastmode" then
			if !ply:IsSuperAdmin() then
				ply:ChatPrint( "Cannot teleport players to start. You are not a superadmin." )
				return ""
			end
			if GetGlobalBool( "FastMode" ) then
				SetGlobalBool( "FastMode", false )
				for k,v in ipairs( player.GetAll() ) do
					v:ChatPrint( "Fast mode has been disabled. Timers will now have their default times." )
				end
			else
				SetGlobalBool( "FastMode", true )
				for k,v in ipairs( player.GetAll() ) do
					v:ChatPrint( "The gamemode is now running in fast mode. All timers have been cut in half." )
				end
			end
			return ""
        end
	end )
end