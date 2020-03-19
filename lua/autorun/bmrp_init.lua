
local allowedmap = {
	["rp_sectorc_beta"] = true,
	["rp_blackmesa_laboratory"] = true,
	["rp_blackmesa_complex_fixed"] = true
}

if SERVER and allowedmap[game.GetMap()] then
	local cooldown
	local Commands
	local BMRPCommandsAdmin = {
        { "/admindamage", "bizwarn bizwarn bizwarn _comma any damage control team to sector c immediately" },
        { "/adminevacuate", "buzwarn buzwarn administration _comma personnel evacuate _comma sector d immediately" },
        { "/adminreport", "deeoo deeoo attention _comma any sector c science personnel please report status" },
        { "/reportviolation", "bloop attention _comma report _comma any security violation _comma to administration _comma _comma sub level one" },
        { "/scientistevacuate", "buzwarn attention _comma any sector c science personnel evacuate _comma area immediately" },
        { "/securityreport", "deeoo deeoo attention security personnel _comma to sector d" },
        { "/biohazard", "bizwarn bizwarn bizwarn biohazard _comma warning in sector b and c" },
        { "/servicereport", "dadeda inspection _comma team to radioactive materials handling bay" },
        { "/hallaccess", "bloop maintenance _comma area access granted" },
        { "/reportams", "dadeda sector c science personnel report _comma to anomalous materials test lab" },
        { "/mendown", "deeoo deeoo security officer reports _comma men down in sector c medical help required" },
        { "/checkelevator", "deeoo service team check elevator one sector c" },
        { "/tramworking", "bloop transportation _comma control reports _comma all systems on time" },
        { "/badenergy", "bizwarn bizwarn bizwarn warning anomalous energy field detected _comma in administration _comma center" },
        { "/detonations", "bizwarn bizwarn bizwarn warning high energy detonation detected _comma in materials lab" },
        { "/failelevator", "buzwarn warning sector c elevator failure _comma do not use" },
        { "/aliens", "bizwarn bizwarn warning unauthorized biological _comma forms detected _comma in sector c" }
	}
	local BMRPCommandsHECU = {
		{ "/militaryvox", "bizwarn bizwarn bizwarn attention _comma this announcement system _comma now under military _comma command" },
		{ "/militarykos", "buzwarn buzwarn alert military personnel _comma you are authorized _comma to shoot the renegade on sight" },
		{ "/militarycallsecurity", "buzwarn buzwarn attention _comma all security personnel wanted for immediate questioning" },
		{ "/militarycallscience", "buzwarn buzwarn attention _comma all science personnel report topside _comma for immediate questioning" },
		{ "/militaryforce", "buzwarn buzwarn military personnel prosecute _comma delta alpha bravo _comma with extreme force" },
		{ "/militarybackup", "buzwarn buzwarn search _comma and destroy force reports _comma back up required engaged _comma with extreme resistance" }
	}

	util.AddNetworkString( "HLUCommandSounds" )
	local function CommandSound( ply, text )
		if ply:Team() == TEAM_ADMIN or ply:Team() == TEAM_MARINEBOSS then
			if cooldown and cooldown > CurTime() then
				DarkRP.notify( ply, 1, 6, "Please wait before using this command again." )
				return ""
			end
			if ply:Team() == TEAM_ADMIN then
				Commands = BMRPCommandsAdmin
			else
				Commands = BMRPCommandsHECU
			end
			if text == "/fatboy" then
				for k,v in pairs( player.GetAll() ) do
					v:ConCommand( "play admin/fat_boy.ogg" )
					cooldown = CurTime() + 5
				end
				return ""
			end
			for k,v in pairs( Commands ) do
				if text == v[1] then
					RunConsoleCommand( "vox", v[2] )
					cooldown = CurTime() + 5
					return ""
				end
			end
		end
	end
	hook.Add( "PlayerSay", "HLUCommandSounds", CommandSound )
end