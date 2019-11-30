
--Run command if things go haywire:
--lua_run for k,v in pairs( ents.FindByClass( [ENTCLASS] ) ) do v.hascodes = true end

local combinejobs = {
	[TEAM_COMBINESOLDIER] = true,
	[TEAM_COMBINEGUARD] = true,
	[TEAM_COMBINEELITE] = true
}

local outlandents = {
	"out_crate",
	"out_generator",
	"out_log"
}

hook.Add( "InitPostEntity", "OutlandPostEnt", function()
	if GAMEMODE_NAME != "outlandrp" then return end
	for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
		v.hascodes = true
	end
end )

hook.Add( "PlayerDeath", "OutlandPlayerDeath", function(victim, inflictor, attacker)
	if GAMEMODE_NAME != "outlandrp" then return end
	if victim.hascodes == true then
		victim.hascodes = nil
		for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
			v.hascodes = true
		end
		for k,ply in pairs(player.GetAll()) do
			DarkRP.notify( ply, 1, 6, victim:Nick().." has been killed and the portal codes are lost again!" )
		end
	end
end )

hook.Add( "OnPlayerChangedTeam", "OutlandPlayerChange", function(ply, before, after)
	if GAMEMODE_NAME != "outlandrp" then return end
	if ply.hascodes == true and combinejobs[after] then
		ply.hascodes = nil
		for k,v in pairs( ents.FindByClass( table.Random( outlandents ) ) ) do
			v.hascodes = true
		end
		for k,l in pairs(player.GetAll()) do
			if SERVER then
				DarkRP.notify( l, 1, 6, ply:Nick().." has changed jobs and the portal codes are lost again!" )
			end
		end
	end
end )