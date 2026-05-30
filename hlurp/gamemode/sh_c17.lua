if GetGlobalInt( "CurrentGamemode" ) != 2 then return end

TEAM_CIVILIAN = 1
TEAM_RESISTANCELEADER = 2
TEAM_SCIENTIST = 3
TEAM_VORT = 4
TEAM_GMANCITY = 5
TEAM_EARTHADMIN = 6
TEAM_COMBINEELITE = 7
TEAM_CREMATOR = 8
TEAM_COMBINEGUARD = 9
TEAM_COMBINEGUARDSHOTGUN = 10
TEAM_COMBINESOLDIER = 11
TEAM_METROCOPMANHACK = 12
TEAM_METROCOP = 13

BuyMenuItems = {
	["mediaplayer_tv"] = {
		Name = "Media Player",
		Description = "Used to watch videos.",
		Max = 10
	},
	["smg1_shipment_small"] = {
		Name = "SMG (Small Box)",
		Description = "Automatic 9mm SMG with grenade launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SMG" )
			e.WepClass = "weapon_smg1"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["ar2_shipment_small"] = {
		Name = "AR2 (Small Box)",
		Description = "Automatic pulse rifle with energy ball launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "AR2" )
			e.WepClass = "weapon_ar2"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["shotgun_shipment_small"] = {
		Name = "Shotgun (Small Box)",
		Description = "12 gauge shotgun with double fire mode.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Shotgun" )
			e.WepClass = "weapon_shotgun"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["frag_shipment_small"] = {
		Name = "Frag Grenade (Small Box)",
		Description = "Standard frag grenade.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Frag Grenade" )
			e.WepClass = "weapon_frag"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["sniper_shipment_small"] = {
		Name = "Sniper Rifle (Small Box)",
		Description = "Sniper rifle with high accuracy and a 2x-4x scope.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_COMBINEELITE end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Sniper Rifle" )
			e.WepClass = "weapon_bp_sniper"
			e:SetNWInt( "NumWeapons", 5 )
			return e
		end
	},
	["smg1_shipment_big"] = {
		Name = "SMG (Large Box)",
		Description = "Automatic 9mm SMG with grenade launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "SMG" )
			e.WepClass = "weapon_smg1"
			return e
		end
	},
	["ar2_shipment_big"] = {
		Name = "AR2 (Large Box)",
		Description = "Automatic pulse rifle with energy ball launcher.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "AR2" )
			e.WepClass = "weapon_ar2"
			return e
		end
	},
	["shotgun_shipment_big"] = {
		Name = "Shotgun (Large Box)",
		Description = "12 gauge shotgun with double fire mode.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Shotgun" )
			e.WepClass = "weapon_shotgun"
			return e
		end
	},
	["frag_shipment_big"] = {
		Name = "Frag Grenade (Large Box)",
		Description = "Standard frag grenade.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Frag Grenade" )
			e.WepClass = "weapon_frag"
			return e
		end
	},
	["sniper_shipment_big"] = {
		Name = "Sniper Rifle (Large Box)",
		Description = "Sniper rifle with high accuracy and a 2x-4x scope.",
		Max = 20,
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "hlu_shipment" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetNWString( "WepName", "Sniper Rifle" )
			e.WepClass = "weapon_bp_sniper"
			return e
		end
	},
	["crafting_table_combine"] = {
		Name = "Combine Crafting Table",
		Description = "Allows players to craft turrets and science locker keys.",
		Allowed = function( ply ) return ply:Team() == TEAM_EARTHADMIN or ply:Team() == TEAM_SCIENTIST end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:SetTableType( "combine" )
			e:Spawn()
			return e
		end
	},
	["crafting_table_rebel"] = {
		Name = "Rebel Crafting Table",
		Description = "Allows players to craft weapons, tools, traps, and ammo.",
		Allowed = function( ply ) return ply:Team() == TEAM_CIVILIAN or ply:Team() == TEAM_RESISTANCELEADER end,
		SpawnCheck = function( ply )
			if GetLoyalty( ply ) > 90 then
				ply:Notify( 1, 6, "You need to have no more than 90% loyalty to spawn the rebel crafting table." )
				return false
			end
		end,
		SpawnFunction = function( ply, tr )
			local e = ents.Create( "ucs_table" )
			e:SetPos( tr.HitPos + tr.HitNormal )
			e:Spawn()
			e:SetTableType( "rebel" )
			return e
		end
	}
}

ANNOUNCEMENTS_ADMIN = {
	{ "Illegal Weapon Detected", "npc/overwatch/cityvoice/fcitadel_deploy.wav" },
	{ "Airwatch Dispatched", "npc/overwatch/cityvoice/fprison_airwatchdispatched.wav" },
	{ "Lost Contact With Intercept Team", "npc/overwatch/cityvoice/fprison_contactlostlandsea.wav" },
	{ "Contain Exogen Incursion", "npc/overwatch/cityvoice/fprison_containexogens.wav" },
	{ "Contact Lost in Block B2", "npc/overwatch/cityvoice/fprison_deployinb4.wav" },
	{ "Deservice All Political Conscripts", "npc/overwatch/cityvoice/fprison_deservicepoliticalconscripts.wav" },
	{ "Surveillance Systems Inactive", "npc/overwatch/cityvoice/fprison_detectionsystemsout.wav" },
	{ "Containment Field May Be Compromised", "npc/overwatch/cityvoice/fprison_dropforcesixandeight.wav" },
	{ "Nova Prospekt Exogen Breach", "npc/overwatch/cityvoice/fprison_exogenbreach.wav" },
	{ "Interface Bypass Detected", "npc/overwatch/cityvoice/fprison_interfacebypass.wav" },
	{ "Permanent Off-World Assignment", "npc/overwatch/cityvoice/fprison_missionfailurereminder.wav" },
	{ "Non-Standard Exogen Activity", "npc/overwatch/cityvoice/fprison_nonstandardexogen.wav" },
	{ "Perimeter Restrictors Disengaged", "npc/overwatch/cityvoice/fprison_restrictorsdisengaged.wav" },
	{ "Anti-Citizen Reported", "npc/overwatch/cityvoice/f_anticitizenreport_spkr.wav" },
	{ "Charged With Anti-Civil Activity", "npc/overwatch/cityvoice/f_anticivil1_5_spkr.wav" },
	{ "Evidence of Anti-Civil Activity", "npc/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav" },
	{ "Charged With Capital Malcompliance", "npc/overwatch/cityvoice/f_capitalmalcompliance_spkr.wav" },
	{ "Charged With Socio-Endangerment", "npc/overwatch/cityvoice/f_ceaseevasionlevelfive_spkr.wav" },
	{ "Citizenship Revoked", "npc/overwatch/cityvoice/f_citizenshiprevoked_6_spkr.wav" },
	{ "Confirm Your Civil Status", "npc/overwatch/cityvoice/f_confirmcivilstatus_1_spkr.wav" },
	{ "Malcompliant Defendent", "npc/overwatch/cityvoice/f_evasionbehavior_2_spkr.wav" },
	{ "Inaction is Conspiracy", "npc/overwatch/cityvoice/f_innactionisconspiracy_spkr.wav" },
	{ "Local Unrest Detected", "npc/overwatch/cityvoice/f_localunrest_spkr.wav" },
	{ "Status Evasion in Progress", "npc/overwatch/cityvoice/f_protectionresponse_1_spkr.wav" },
	{ "Autonomous Judgement", "npc/overwatch/cityvoice/f_protectionresponse_4_spkr.wav" },
	{ "Judgement Waiver", "npc/overwatch/cityvoice/f_protectionresponse_5_spkr.wav" },
	{ "Ration Units Deducted", "npc/overwatch/cityvoice/f_rationunitsdeduct_3_spkr.wav" },
	{ "Identity Check in Progress", "npc/overwatch/cityvoice/f_trainstation_assemble_spkr.wav" },
	{ "Assume Inspection Positions", "npc/overwatch/cityvoice/f_trainstation_assumepositions_spkr.wav" },
	{ "Miscount Detected", "npc/overwatch/cityvoice/f_trainstation_cooperation_spkr.wav" },
	{ "Potential Civil Infection", "npc/overwatch/cityvoice/f_trainstation_inform_spkr.wav" },
	{ "Permanent Off-World Relocation", "npc/overwatch/cityvoice/f_trainstation_offworldrelocation_spkr.wav" },
	{ "Unrest Procedures in Effect", "npc/overwatch/cityvoice/f_unrestprocedure1_spkr.wav" }
}

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
	end,
	["duplicator"] = function( ply, tool )
		return ply:Team() == TEAM_SCIENTIST
	end
}

hook.Add( "CanTool", "RestrictTool", function( ply, tr, tool )
	if blockedtools[tool] then
		return blockedtools[tool]( ply, tool )
	end
	if string.find( tool, "pcspawn_" ) then
		return ply:Team() == TEAM_SCIENTIST
	end
end )
