
include( "shared.lua" )

hook.Add( "SpawnMenuOpen", "CascadeSpawnMenu", function()
	local ply = LocalPlayer()
	if ply:Team() != TEAM_SCIENTIST.ID then return false end
end )

--TODO: Round timer on the HUD
