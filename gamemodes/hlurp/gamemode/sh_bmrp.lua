
if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

TEAM_VISITOR = 1
TEAM_ADMIN = 2
TEAM_SURVEYBOSS = 3
TEAM_SURVEY = 4
TEAM_DEV = 5
TEAM_TECH = 6
TEAM_BIO = 7
TEAM_MEDIC = 8
TEAM_SERVICE = 9
TEAM_GMAN = 10
TEAM_MARINE = 11
TEAM_MARINEBOSS = 12
TEAM_WEPBOSS = 13
TEAM_WEPMAKER = 14
TEAM_SECURITYBOSS = 15
TEAM_SECURITY = 16

local blockedtools = {
	["wire_explosive"] = function( ply, tool )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_turret"] = function( ply, tool )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_detonator"] = function( ply, tool )
		return ply:Team() == TEAM_WEPMAKER
	end,
	["wire_expression2"] = function( ply, tool )
		return ply:IsJobCategory( "Science" )
	end,
	["wire_simple_explosive"] = function( ply, tool )
		return ply:Team() == TEAM_WEPMAKER
	end
}

local function RestrictTool( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply, tool )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_TECH
	end
end
hook.Add( "CanTool", "RestrictTool", RestrictTool )
