
include( "shared.lua" )

hook.Add( "SpawnMenuOpen", "CascadeSpawnMenu", function()
	local ply = LocalPlayer()
	if ply:Team() != TEAM_SCIENTIST.ID then return false end
end )

local round = 0
local scientist = 0
local hecu = 0

net.Receive( "SyncCascadeTimer", function( len, ply )
	local getround = tonumber( net.ReadString() )
	local getscientist = tonumber( net.ReadString() )
	local gethecu = tonumber( net.ReadString() )
	round = getround + CurTime()
	scientist = getscientist + CurTime()
	hecu = gethecu + CurTime()
end )

net.Receive( "RemoveClientTimers", function()
	round = 0
	scientist = 0
	hecu = 0
end )

surface.CreateFont( "CascadeTimers", {
	font = "Arial",
	size = 16,
	weight = 600
} )

hook.Add( "HUDPaint", "CascadeTimerHUD", function()
	draw.RoundedBoxEx( 14, ScrH() / 2 + 120, 0, 600, 40, Color( 255, 89, 0, 50 ), false, false, true, true )
	if round - CurTime() <= 0 then
		draw.DrawText( "Round Timer: Disabled", "CascadeTimers", ScrW() / 2 - 290, 10, color_white, TEXT_ALIGN_LEFT )
	else
		draw.DrawText( "Round Timer: "..string.ToMinutesSeconds( round - CurTime() ), "CascadeTimers", ScrW() / 2 - 290, 10, color_white, TEXT_ALIGN_LEFT )
	end
	if scientist - CurTime() <= 0 then
		draw.DrawText( "Scientist Timer: Disabled", "CascadeTimers", ScrW() / 2 - 80, 10, color_white, TEXT_ALIGN_LEFT )
	else
		draw.DrawText( "Scientist Timer: "..string.ToMinutesSeconds( scientist - CurTime() ), "CascadeTimers", ScrW() / 2 - 80, 10, color_white, TEXT_ALIGN_LEFT )
	end
	if hecu - CurTime() <= 0 then
		draw.DrawText( "HECU Timer: Disabled", "CascadeTimers", ScrW() / 2 + 140, 10, color_white, TEXT_ALIGN_LEFT )
	else
		draw.DrawText( "HECU Timer: "..string.ToMinutesSeconds( hecu - CurTime() ), "CascadeTimers", ScrW() / 2 + 140, 10, color_white, TEXT_ALIGN_LEFT )
	end
end )