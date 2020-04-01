
if GetGlobalInt( "CurrentGamemode" ) != 3 then return end

TEAM_REFUGEE = 1
TEAM_RESISTANCELEADER = 2
TEAM_REBEL = 3
TEAM_REBELMEDIC = 4
TEAM_COMBINEELITE = 5
TEAM_COMBINEGUARD = 6
TEAM_COMBINESOLDIER = 7
TEAM_COMBINEGUARDSHOTGUN = 8

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
		return false
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
		return false
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
