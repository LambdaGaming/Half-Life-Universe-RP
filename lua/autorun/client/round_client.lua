
--BROKEN, NEEDS WORK
--[[ if game.GetMap() != "rp_bmrf" then return end
if CLIENT then
	net.Receive("MainRoundTimer", function()
		time = net.ReadFloat()
	end)

	hook.Add( "HUDPaint", "DrawTimers", function()
		draw.DrawText( "Main Round: "..string.ToMinutesSeconds(time - CurTime()), "TargetID", ScrW() * 0.1, ScrH() * 0.1, Color( 255,255,255,255 ), TEXT_ALIGN_CENTER )
	end )
end ]]