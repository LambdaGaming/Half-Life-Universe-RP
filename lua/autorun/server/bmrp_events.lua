
local allowedmap = {
	["rp_sectorc_beta"] = true,
	["rp_blackmesa_laboratory"] = true,
	["rp_blackmesa_complex_fixed"] = true,
	["rp_bmrf"] = true
}

timer.Simple( 10, function()
	if allowedmap[game.GetMap()] and GetGlobalInt( "CurrentGamemode" ) == 1 then
		local function PickRandomEvent()
			local rand2 = math.random( 1, 10 )
			if rand2 == 1 then
				PortalBreakDown()
			elseif rand2 == 2 then
				DoorFailure()
			elseif rand2 == 3 then
				MedicRevive()
			elseif rand2 == 4 then
				XenBreach()
			elseif rand2 == 5 then
				Biohazard()
			elseif rand2 == 6 then
				Crystal()
			elseif rand2 == 7 then
				MarineWeapon()
			elseif rand2 == 8 then
				ServerFailure()
			elseif rand2 == 9 then
				Boss()
			else
				FIRE_Event()
			end
		end

		timer.Create( "EventLoop", 300, 0, function()
			local rand = math.random( 1, 10 )
			if GetGlobalBool( "EventActive" ) then return end --Doesn't activate another event if there's one active already
			if player.GetCount() == team.NumPlayers( TEAM_VISITOR ) then return end --Doesn't activate an event if all players are visitors
			if rand <= 2 then
				PickRandomEvent()
			end
		end )

		local map = game.GetMap()
		local sectorc = "rp_sectorc_beta"
		local laboratory = "rp_blackmesa_laboratory"
		local complex = "rp_blackmesa_complex_fixed"
		local bmrf = "rp_bmrf"
		-----------------------------------------------------------------
		function PortalBreakDown()
			if team.NumPlayers( TEAM_SURVEY ) + team.NumPlayers( TEAM_SURVEYBOSS ) == 0 or team.NumPlayers( TEAM_SERVICE ) == 0 then return end
			local button
			if map == sectorc then
				button = 1207
			elseif map == laboratory then
				button = 90
			elseif map == complex then
				button = 977
			elseif map == bmrf then
				button = 1523
			end
			for k,v in pairs( ents.FindByClass( "func_button" ) ) do
				if v:EntIndex() == button then
					v:Fire( "Lock" )
				end
			end
			for k,v in pairs( ents.FindByClass( "event_portal_fix" ) ) do
				v.broke = true
			end
			HLU_ChatNotifySystem( "BMRP", color_orange, "The portal has malfunctioned! It won't be able to start up again until a service official fixes it!" )
			RunConsoleCommand( "vox", "deeoo deeoo alert main portal control failure" )
			SetGlobalBool( "EventActive", true )
		end

		function PortalFix()
			local button
			if map == sectorc then
				button = 1207
			elseif map == laboratory then
				button = 90
			elseif map == complex then
				button = 977
			elseif map == bmrf then
				button = 1523
			end
			for k,v in pairs( ents.FindByClass( "func_button" ) ) do
				if v:EntIndex() == button then
					v:Fire( "Unlock" )
				end
			end
			RunConsoleCommand( "vox", "dadeda maintenance reports main portal control inspection nominal" )
			SetGlobalBool( "EventActive", false )
		end
		-----------------------------------------------------------------
		function DoorFailure()
			if team.NumPlayers( TEAM_SERVICE ) == 0 then return end
			for k,v in pairs( ents.FindByClass( "prop_door*" ) ) do
				v:Fire( "Lock" )
			end
			for k,v in pairs( ents.FindByClass( "func_door*" ) ) do
				v:Fire( "Lock" )
			end
			for k,v in pairs( ents.FindByClass( "event_door_fix" ) ) do
				v.broke = true
				v:EmitSound( "vehicles/Airboat/fan_motor_shut_off1.wav" )
			end
			HLU_ChatNotifySystem( "BMRP", color_orange, "The secondary generator powering some doors has stalled!" )
			RunConsoleCommand( "vox", "bizwarn warning secondary _comma door power system failure" )
			SetGlobalBool( "EventActive", true )
		end

		function DoorFix()
			for k,v in pairs( ents.FindByClass( "prop_door*" ) ) do
				v:Fire( "Unlock" )
			end
			for k,v in pairs( ents.FindByClass( "func_door*" ) ) do
				v:Fire( "Unlock" )
			end
			HLU_ChatNotifySystem( "BMRP", color_orange, "The secondary generator has been restarted!" )
			RunConsoleCommand( "vox", "dadeda maintenance reports secondary _comma door power system inspection nominal" )
			SetGlobalBool( "EventActive", false )
		end
		-----------------------------------------------------------------

		local sectorc_revive = {
			Vector( -11732, -558, -413 ),
			Vector( -5838, 408, -301 ),
			Vector( -196, -5235, -253 ),
			Vector( 4312, -2155, -240 )
		}

		local laboratory_revive = {
			Vector( -940, -3882, 592 ),
			Vector( 1775, -3318, 289 ),
			Vector( -8, -2049, -31 ),
			Vector( -894, -3412, -351 ),
			Vector( -34, -5165, -351 )
		}

		local complex_revive = {
			Vector( 1345, 1059, -32 ),
			Vector( 3741, 4708, 1568 ),
			Vector( 661, 4230, 1248 ),
			Vector( -3810, 5620, 2262 ),
			Vector( -638, 1317, 288 ),
			Vector( 1213, 271, -264 )
		}

		local bmrf_revive = {
			Vector( -613, -4786, 352 ),
			Vector( -1752, -1357, 352 ),
			Vector( -7512, -2001, -63 ),
			Vector( -5173, 98, -111 ),
			Vector( 4235, -519, -63 )
		}

		function MedicRevive()
			if team.NumPlayers( TEAM_MEDIC ) == 0 then return end
			local victim = ents.Create( "event_revive" )
			if map == sectorc then
				victim:SetPos( table.Random( sectorc_revive ) )
			elseif map == laboratory then
				victim:SetPos( table.Random( laboratory_revive ) )
			elseif map == complex then
				victim:SetPos( table.Random( complex_revive ) )
			elseif map == bmrf then
				victim:SetPos( table.Random( bmrf_revive ) )
			end
			victim:Spawn()
			HLU_ChatNotifySystem( "BMRP", color_orange, "A medical emergency has been reported! Current location unknown!" )
			RunConsoleCommand( "vox", "bizwarn bizwarn medical emergency reported " )
		end
		-----------------------------------------------------------------
		local xenbreach_npcs = {
			"npc_headcrab",
			"monster_hound_eye",
			"npc_bullsquid",
			"monster_alien_slv"
		}

		local sectorc_breach = {
			Vector( -11192, -304, -253 ),
			Vector( -11394, -686, -253 ),
			Vector( -11429, -302, -253 ),
			Vector( -12713, -494, -413 ),
			Vector( -3780, -604, -253 ),
			Vector( -3310, -1416, -229 ),
			Vector( -3765, -1711, -229 ),
			Vector( -2257, -3341, -229 )
		}

		local laboratory_breach = {
			Vector( 675, -2885, 288 ),
			Vector( 713, -3209, 288 ),
			Vector( 1340, -3187, 288 ),
			Vector( 1382, -2668, 288 ),
			Vector( 283, -3210, 288 ),
			Vector( 137, -2887, 288 ),
			Vector( -316, -3550, -31 ),
			Vector( 273, -3140, -31 ),
			Vector( 265, -2321, -31 ),
			Vector( -306, -2535, -31 ),
			Vector( -32, -5132, -351 ),
			Vector( -1079, -5450, -351 )
		}

		local complex_breach = {
			Vector( -4366, 4418, 2262 ),
			Vector( -5079, 4567, 2307 ),
			Vector( -4345, 5161, 2262 ),
			Vector( -3791, 5681, 2262 ),
			Vector( -4387, 7208, 2262 ),
			Vector( -5223, 6454, 1392 ),
			Vector( -3581, 6876, 2262 ),
			Vector( -3779, 7578, 2262 ),
			Vector( -1863, 5118, 2230 )
		}

		local bmrf_breach = {
			Vector( -10421, -1535, -63 ),
			Vector( -3623, 2157, -39 ),
			Vector( -3269, 1560, -39 ),
			Vector( -763, 756, -1087 ),
			Vector( -461, 1700, -63 ),
			Vector( 770, -2010, 64 ),
			Vector( -957, -1037, 64 ),
			Vector( -1288, -1914, 352 ),
			Vector( -1693, -3340, 352 ),
			Vector( -1011, -3203, -1439 )
		}

		function XenBreach()
			if team.NumPlayers( TEAM_SECURITY ) + team.NumPlayers( TEAM_SECURITYBOSS ) == 0 then return end
			local npc = ents.Create( table.Random( xenbreach_npcs ) )
			if map == sectorc then
				npc:SetPos( table.Random( sectorc_breach ) )
			end
			if map == laboratory then
				npc:SetPos( table.Random( laboratory_breach ) )
			end
			if map == complex then
				npc:SetPos( table.Random( complex_breach ) )
			end
			npc:Spawn()
			local portal = ents.Create("env_sprite")
			portal:SetPos( npc:GetPos() + Vector( 0, 0, 20 ) )
			portal:SetKeyValue("model", "sprites/exit1_anim.vmt")
			portal:SetKeyValue("rendermode", "5") 
			portal:SetKeyValue("rendercolor", "255 255 255") 
			portal:SetKeyValue("scale", "0.5") 
			portal:SetKeyValue("spawnflags", "1") 
			portal:SetParent(npc)
			portal:Spawn()
			portal:Activate()
			timer.Simple( 1, function() npc:EmitSound( "debris/beamstart7.wav" ) end )
			timer.Simple( 3, function() portal:Remove() end )
			HLU_ChatNotifySystem( "BMRP", color_orange, "Security breach detected! Alien life has been spotted loose in the facility!" )
			RunConsoleCommand( "vox", "bizwarn bizwarn warning _comma security _comma breach _comma unauthorized biological _comma forms detected" )
		end
		-----------------------------------------------------------------
		local hazard = {
			"uranium_ent",
			"plutonium_ent",
			"unubuntium_ent"
		}

		local sectorc_bio = {
			Vector( 1596, -984, -338 ),
			Vector( 2167, -4669, -3162 ),
			Vector( 1439, -4103, -2786 )
		}

		local laboratory_bio = {
			Vector( 833, -2205, -31 ),
			Vector( 2632, -2380, 609 ),
			Vector( -812, -3789, 288 )
		}

		local complex_bio = {
			Vector( -1285, -1040, -456 ),
			Vector( -1875, -4, 288 ),
			Vector( 544, 6137, 2160 ),
			Vector( -3846, 7020, 2262 )
		}

		local bmrf_bio = {
			Vector( 2236, -4998, -1439 ),
			Vector( 289, -2657, 96 ),
			Vector( 894, -1411, 61 )
		}

		function Biohazard()
			if team.NumPlayers( TEAM_BIO ) == 0 then return end
			local biopos
			if map == sectorc then
				biopos = sectorc_bio
			elseif map == laboratory then
				biopos = laboratory_bio
			elseif map == complex then
				biopos = complex_bio
			elseif map == bmrf then
				biopos = bmrf_bio
			end
			for i=1, math.random( 1, 6 ) do
				local waste = ents.Create( table.Random( hazard ) )
				waste:SetPos( table.Random( biopos ) )
				waste:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				waste:Spawn()
			end
			HLU_ChatNotifySystem( "BMRP", color_orange, "A hazardous waste leak has been detected!" )
			RunConsoleCommand( "vox", "bizwarn bizwarn biohazard _comma warning _comma biological _comma team report to location immediately" )
		end
		-----------------------------------------------------------------
		local sectorc_crystal = {
			Vector( -6837, -677, -253 ),
			Vector( 4227, -1397, -240 ),
			Vector( 915, -3345, -2858 ),
			Vector( -6116, 771, -301 ),
			Vector( -10292, -416, 570 ),
			Vector( -10617, -979, 570 )
		}

		local laboratory_crystal = {
			Vector( -1126, -4457, 608 ),
			Vector( -302, -1059, 289 ),
			Vector( 860, -52, 289 ),
			Vector( 521, -1006, -32 ),
			Vector( 784, -2251, -31 ),
			Vector( 120, -4224, -351 ),
			Vector( 807, -6389, -350 )
		}

		local complex_crystal = {
			Vector( 1270, 1731, -32 ),
			Vector( -2212, 304, 288 ),
			Vector( -2919, 8225, 2262 ),
			Vector( -4800, 6595, 2455 ),
			Vector( -617, 4997, 2160 ),
			Vector( 3785, 5614, 1568 ),
			Vector( 883, 1374, -32 )
		}

		local bmrf_crystal = {
			Vector( -1204, -1393, 64 ),
			Vector( -4221, 623, -111 ),
			Vector( -4269, 2578, -63 ),
			Vector( -446, 2721, -63 ),
			Vector( 4608, -544, -63 ),
			Vector( 2484, -4879, 192 )
		}

		function Crystal()
			if team.NumPlayers( TEAM_SURVEY ) + team.NumPlayers( TEAM_SURVEYBOSS ) == 0 then return end
			local crystalpos
			if map == sectorc then
				crystalpos = sectorc_crystal
			elseif map == laboratory then
				crystalpos = laboratory_crystal
			elseif map == complex then
				crystalpos = complex_crystal
			elseif map == bmrf then
				crystalpos = bmrf_crystal
			end
			local crystal = ents.Create( "event_crystal" )
			crystal:SetPos( table.Random( crystalpos ) )
			crystal:Spawn()
			HLU_ChatNotifySystem( "BMRP", color_orange, "A crystal has been accidently teleported to a random location in the facility!" )
			HLU_ChatNotifySystem( "BMRP", color_orange, "The survey team should find it before it gets into the wrong hands!" )
			RunConsoleCommand( "vox", "bizwarn _comma alert _comma containment _comma crew detain target delta alpha bravo immediately" )
		end
		-----------------------------------------------------------------
		function ReviveGman()
			if team.NumPlayers( TEAM_ADMIN ) == 0 then return end
			local gmanpos
			if map == sectorc then
				gmanpos = { Vector( 496, -4210, -253 ), Angle( 0, 180, 0 ) }
			elseif map == laboratory then
				gmanpos = { Vector( 2443, 939, -32 ), Angle( 0, 180, 0 ) }
			elseif map == complex then
				gmanpos = { Vector( 987, 1134, -32 ), Angle( 0, -90, 0 ) }
			elseif map == bmrf then
				gmanpos = { Vector( 358, 2368, -63 ), Angle( 0, 180, 0 ) }
			end
			local loot = ents.Create( "event_npc_base" )
			loot:SetPos( gmanpos[1] )
			loot:SetAngles( gmanpos[2] )
			loot:Spawn()
			HLU_ChatNotifySystem( "BMRP", color_orange, "Government officials are requesting to see administration personnel at sector D." )
			RunConsoleCommand( "vox", "dadeda _comma administration personnel report to sector d please" )
		end
		-----------------------------------------------------------------
		function MarineWeapon()
			if team.NumPlayers( TEAM_WEPMAKER ) == 0 then return end
			local marinepos
			if map == sectorc then
				marinepos = { Vector( 491, -4574, -253 ), Angle( 0, 180, 0 ) }
			elseif map == laboratory then
				marinepos = { Vector( 2445, 1028, -32 ), Angle( 0, 180, 0 ) }
			elseif map == complex then
				marinepos = { Vector( 784, 1139, -32 ), Angle( 0, -90, 0 ) }
			elseif map == bmrf then
				marinepos = { Vector( -844, 2631, -63 ), Angle( 0, 180, 0 ) }
			end
			local loot = ents.Create( "event_npc_weapon" )
			loot:SetPos( marinepos[1] )
			loot:SetAngles( marinepos[2] )
			loot:Spawn()
			HLU_ChatNotifySystem( "BMRP", color_orange, "A Corporal has arrived at sector D. He is requesting that a weapons engineer speak with him ASAP." )
			RunConsoleCommand( "vox", "dadeda _comma weapon science team report to sector d immediately" )
		end
		-----------------------------------------------------------------
		computerbroke = false
		function ServerFailure()
			if team.NumPlayers( TEAM_TECH ) == 0 or computerbroke then return end
			computerbroke = true
			HLU_ChatNotifySystem( "BMRP", color_orange, "The main server has overheated! Computers will not be able to be used until it is fixed!" )
			RunConsoleCommand( "vox", "deeoo _comma superconducting _comma _comma dual core systems high temperature _comma warning" )
		end
		-----------------------------------------------------------------
		local bosses = {
			"monster_garg",
			"monster_geneworm",
			"monster_gonarch",
			"monster_pitworm_up",
			"monster_alien_nihilanth"
		}

		local bossplycount = team.NumPlayers( TEAM_MARINE ) + team.NumPlayers( TEAM_MARINEBOSS ) + team.NumPlayers( TEAM_SECURITY ) + team.NumPlayers( TEAM_SECURITYBOSS ) + team.NumPlayers( TEAM_WEPBOSS )

		function Boss()
			if bossplycount < 2 then return end
			if map == sectorc then
				local bos = ents.Create( table.Random( bosses ) )
				bos:SetPos( Vector( -10245, -6811, -2661 ) )
				bos:SetAngles( Angle( 0, -55, 0 ) )
				bos:Spawn()
			elseif map == laboratory then
				local bos = ents.Create( "monster_alien_tentacle" )
				bos:SetPos( Vector( -4331, 1734, -350 ) )
				bos:Spawn()
			elseif map == complex then
				local bos = ents.Create( "monster_alien_voltigore" )
				bos:SetPos( Vector( 8388, -3671, 1360 ) )
				bos:Spawn()
			elseif map == bmrf then
				local bos = ents.Create( "monster_pitworm_up" )
				bos:SetPos( Vector( 2664, -2547, -255 ) )
				bos:Spawn()
			end
			HLU_ChatNotifySystem( "BMRP", color_orange, "All hands on deck! A large hostile life form has teleported into the facility!" )
			RunConsoleCommand( "vox", "bizwarn bizwarn bizwarn attention _comma all personnel report _comma to containment zone immediately" )
		end
	-----------------------------------------------------------------
		function FIRE_Event()
			local FirePos = {
				[sectorc] = {
					Vector( -2001, -3430, -213 ),
					Vector( 832, -3529, -2857 ),
					Vector( -4074, -582, 576 ),
					Vector( -9915, -776, 570 ),
					Vector( -13117, -144, -412 ),
					Vector( 4357, -2199, -239 ),
					Vector( -3963, -3632, -1172 ),
					Vector( -217, -4774, -252 )
				},
				[laboratory] = {
					Vector( 2384, 1766, -31 ),
					Vector( -1, -3379, -350 ),
					Vector( -14, -2087, -30 ),
					Vector( -943, -3769, 592 ),
					Vector( 3298, -724, 466 ),
					Vector( 2088, -1961, -31 ),
					Vector( 122, 879, -526 ),
					Vector( -49, -5074, -350 )
				},
				[complex] = {
					Vector( -5312, 6600, 1392 ),
					Vector( 1139, 1928, 1232 ),
					Vector( 802, -520, -263 ),
					Vector( -2107, 7467, 2262 ),
					Vector( 1326, 1081, -31 ),
					Vector( -3729, 5684, 2262 ),
					Vector( 3732, 4550, 1576 ),
					Vector( -758, 1550, 288 )
				},
				[bmrf] = {
					Vector( -946, -4747, 352 ),
					Vector( 804, -3761, 400 ),
					Vector( -2369, -3044, -1119 ),
					Vector( -4095, 689, -111 ),
					Vector( -929, 3211, -63 ),
					Vector( -799, -1478, 64 ),
					Vector( -1605, -2404, 352 ),
					Vector( -9192, -1772, 704 )
				}
			}

			local randfire = table.Random( FirePos[game.GetMap()] )
			if vFiresCount > 0 then return end
			if team.NumPlayers( TEAM_SERVICE ) == 0 then return end
			CreateVFireBall( 1200, 10, randfire + Vector( 0, 0, 50 ), vector_origin, nil )
			HLU_ChatNotifySystem( "BMRP", color_orange, "A fire has been detected by the facility smoke alarms! Evacuate while service officials contain it!" )
		end
	-----------------------------------------------------------------
	end
end )