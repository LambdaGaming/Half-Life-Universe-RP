
if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

TEAM_CIVILIAN = 1
TEAM_REFUGEE = 2
TEAM_RESISTANCELEADER = 3
TEAM_SCIENTIST = 4
TEAM_VORT = 5
TEAM_GMANCITY = 6
TEAM_EARTHADMIN = 7
TEAM_COMBINEELITE = 8
TEAM_CREMATOR = 9
TEAM_COMBINEGUARD = 10
TEAM_COMBINEGUARDSHOTGUN = 11
TEAM_COMBINESOLDIER = 12
TEAM_METROCOPMANHACK = 13
TEAM_METROCOP = 14

local blockedtools = {
	["wire_explosive"] = function( ply, tool )
		return false
	end,
	["wire_turret"] = function( ply, tool )
		return false
	end,
	["wire_detonator"] = function( ply, tool )
		return false
	end,
	["wire_expression2"] = function( ply, tool )
		return ply:Team() == TEAM_SCIENTIST
	end,
	["wire_simple_explosive"] = function( ply, tool )
		return false
	end
}

local function RestrictTool( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply, tool )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_SCIENTIST
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
