local gm = GetGlobalInt( "CurrentGamemode" )
if gm == 1 then
	DoorRestrictions[2] = {
		Name = "Security Level 3 Access Required",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_ADMIN] = true,
				[TEAM_SECURITYBOSS] = true,
				[TEAM_SECURITY] = true,
				[TEAM_SERVICE] = true
			}
			return allowed[ply:Team()]
		end
	}

	DoorRestrictions[3] = {
		Name = "Service Personnel Only",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_ADMIN] = true,
				[TEAM_SERVICE] = true
			}
			return allowed[ply:Team()]
		end
	}

	DoorRestrictions[4] = {
		Name = "HECU Military Personnel Only",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_MARINEBOSS] = true,
				[TEAM_MARINE] = true,
				[TEAM_WEPBOSS] = true
			}
			return allowed[ply:Team()]
		end
	}

	DoorRestrictions[5] = {
		Name = "Security Level 2 Access Required",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_SURVEY] = true,
				[TEAM_SURVEYBOSS] = true,
				[TEAM_WEPBOSS] = true,
				[TEAM_BIO] = true,
				[TEAM_ADMIN] = true,
				[TEAM_SECURITY] = true,
				[TEAM_SECURITYBOSS] = true,
				[TEAM_TECH] = true,
				[TEAM_MEDIC] = true,
				[TEAM_SERVICE] = true
			}
			return allowed[ply:Team()]
		end
	}
elseif gm == 2 then
	DoorRestrictions[2] = {
		Name = "Overwatch Only",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_EARTHADMIN] = true,
				[TEAM_COMBINEELITE] = true,
				[TEAM_COMBINEGUARD] = true,
				[TEAM_COMBINESOLDIER] = true,
				[TEAM_METROCOP] = true,
				[TEAM_COMBINEGUARDSHOTGUN] = true,
				[TEAM_METROCOPMANHACK] = true,
				[TEAM_CREMATOR] = true
			}
			return allowed[ply:Team()]
		end
	}
elseif gm == 3 then
	DoorRestrictions[2] = {
		Name = "Overwatch Only",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_COMBINEELITE] = true,
				[TEAM_COMBINEGUARD] = true,
				[TEAM_COMBINESOLDIER] = true,
				[TEAM_COMBINEGUARDSHOTGUN] = true,
			}
			return allowed[ply:Team()]
		end
	}

	DoorRestrictions[3] = {
		Name = "Resistance Members Only",
		CheckFunction = function( ply )
			local allowed = {
				[TEAM_RESISTANCELEADER] = true,
				[TEAM_REBEL] = true,
				[TEAM_REBELMEDIC] = true
			}
			return allowed[ply:Team()]
		end
	}
end
