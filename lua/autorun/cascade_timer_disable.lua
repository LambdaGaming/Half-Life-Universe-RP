
if SERVER then
	hook.Add( "PlayerSay", "playersayremovetimer", function( ply, text, public )
		if ( text == "!disabletimer" ) then
			if timer.Exists( "MainLoop" ) then timer.Remove( "MainLoop" ) end
			if timer.Exists( "MainLoopHalf" ) then timer.Remove( "MainLoopHalf" ) end
			DarkRP.notifyAll( 0, 6, "The timer for this round has been disabled." )
			return ""
        end
	end )
end