if GetGlobalInt( "CurrentGamemode" ) != 1 then return end

if SERVER then
	local map = game.GetMap()
	local sectorc = "rp_sectorc_beta"
	local laboratory = "rp_blackmesa_laboratory"
	local complex = "rp_blackmesa_complex_fixed"
	local bmrf = "rp_bmrf"
	local NPCEventParticipants = {}

	local function EndEvent( cooldown )
		SetGlobalBool( "EventActive", false )
		SetGlobalBool( "EventCooldownActive", true )
		timer.Simple( cooldown, function() SetGlobalBool( "EventCooldownActive", false ) end )
	end

	util.AddNetworkString( "StartEvent" )
	net.Receive( "StartEvent", function( len, ply )
		local key = net.ReadInt( 8 )
		BMRP_EVENTS[key].OnSelect()
		SetGlobalBool( "EventActive", true )
	end )

	util.AddNetworkString( "GetTask" )
	util.AddNetworkString( "UpdateTask" )
	net.Receive( "GetTask", function( len, ply )
		local key = net.ReadInt( 8 )
		local custom = net.ReadString()
		if custom then
			BMRP_CURRENT_TASKS[key] = custom
		else
			for k,v in pairs( BMRP_TASKS[key].Required ) do
				BMRP_CURRENT_TASKS[v] = BMRP_TASKS[key].Description
			end
		end
		net.Start( "UpdateTask" )
		net.WriteTable( BMRP_CURRENT_TASKS )
		net.Broadcast()
	end )
	-----------------------------------------------------------------
	function PortalBreakDown()
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
		HLU_ChatNotifySystem( "BMRP", color_orange, "The portal has been repaired!" )
		RunConsoleCommand( "vox", "dadeda maintenance reports main portal control inspection nominal" )
		EndEvent( 1800 )
	end
	-----------------------------------------------------------------
	function DoorFailure()
		for k,v in pairs( ents.FindByClass( "func_door*" ) ) do
			v:Fire( "Lock" )
		end
		for k,v in pairs( ents.FindByClass( "event_door_fix" ) ) do
			v.broke = true
			v:EmitSound( "vehicles/Airboat/fan_motor_shut_off1.wav" )
		end
		HLU_ChatNotifySystem( "BMRP", color_orange, "The secondary generator powering some doors has stalled!" )
		RunConsoleCommand( "vox", "bizwarn warning secondary _comma door power system failure" )
	end

	function DoorFix()
		for k,v in pairs( ents.FindByClass( "func_door*" ) ) do
			v:Fire( "Unlock" )
		end
		HLU_ChatNotifySystem( "BMRP", color_orange, "The secondary generator has been restarted!" )
		RunConsoleCommand( "vox", "dadeda maintenance reports secondary _comma door power system inspection nominal" )
		EndEvent( 1800 )
	end
	-----------------------------------------------------------------
	function MedicFaint()
		local players = {}
		for k,v in ipairs( player.GetAll() ) do
			if v:Team() != TEAM_GMAN and v:Team() != TEAM_MEDIC then
				table.insert( players, v )
			end
		end
		local victim = table.Random( players )
		local body = ents.Create( "prop_ragdoll" )
		body:SetPos( victim:GetPos() )
		body:SetAngles( victim:GetAngles() )
		body:SetModel( victim:GetModel() )
		body:Spawn()
		body.Owner = victim
		victim:Lock()
		victim:Spectate( OBS_MODE_CHASE )
		victim:SpectateEntity( body )
		victim:SetActiveWeapon( "pocket" )
		victim.Fainted = true
		HLU_ChatNotifySystem( "BMRP", color_orange, "A medical emergency has been reported! Current location unknown!" )
		RunConsoleCommand( "vox", "bizwarn bizwarn medical emergency in the facility" )
	end

	function MedicRevive( medic, victim )
		local body = victim:GetObserverTarget()
		victim:UnSpectate()
		victim:UnLock()
		victim.Fainted = false
		body:Remove()
		medic:AddFunds( 500 )
		HLU_Notify( medic, "You have successfully revived your unresponsive colleague. (+500)", 0, 6 )
		HLU_ChatNotifySystem( "BMRP", color_orange, "The medical emergency has been located and dealt with!" )
		EndEvent( 2700 )
	end
	-----------------------------------------------------------------
	local function XenBreachEndCheck()
		for k,v in pairs( ents.FindByClass( "monster_*" ) ) do
			if v.IsEventNPC then return end
		end
		for k,v in pairs( NPCEventParticipants ) do
			if IsValid( v ) then
				v:AddFunds( 500 )
				HLU_Notify( v, "You have been awarded $500 for helping defend the facility." )
			end
		end
		NPCEventParticipants = {}
		HLU_ChatNotifySystem( "BMRP", color_orange, "The security breach has been dealt with!" )
		EndEvent( 2700 )
	end

	function XenBreach()
		local xenbreach_npcs = {
			"monster_head_crab",
			"monster_hound_eye",
			"monster_bullsquid",
			"monster_alien_slv"
		}
	
		local breach_maps = {
			[sectorc] = {
				Vector( -11192, -304, -253 ),
				Vector( -11394, -686, -253 ),
				Vector( -11429, -302, -253 ),
				Vector( -12713, -494, -413 ),
				Vector( -3780, -604, -253 ),
				Vector( -3310, -1416, -229 ),
				Vector( -3765, -1711, -229 ),
				Vector( -2257, -3341, -229 )
			},
			[laboratory] = {
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
			},
			[complex] = {
				Vector( -4366, 4418, 2262 ),
				Vector( -5079, 4567, 2307 ),
				Vector( -4345, 5161, 2262 ),
				Vector( -3791, 5681, 2262 ),
				Vector( -4387, 7208, 2262 ),
				Vector( -5223, 6454, 1392 ),
				Vector( -3581, 6876, 2262 ),
				Vector( -3779, 7578, 2262 ),
				Vector( -1863, 5118, 2230 )
			},
			[bmrf] = {
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
		}

		local npc = ents.Create( table.Random( xenbreach_npcs ) )
		npc:SetPos( table.Random( breach_maps[map] ) )
		npc:Spawn()
		npc:EmitSound( "debris/beamstart7.wav" )
		npc:CallOnRemove( "XenBreachEndCheck", XenBreachEndCheck )
		npc.IsEventNPC = true
		local portal = ents.Create( "env_sprite" )
		portal:SetPos( npc:GetPos() + Vector( 0, 0, 20 ) )
		portal:SetKeyValue( "model", "sprites/exit1_anim.vmt" )
		portal:SetKeyValue( "rendermode", "5" ) 
		portal:SetKeyValue( "rendercolor", "255 255 255" ) 
		portal:SetKeyValue( "scale", "0.5" ) 
		portal:SetKeyValue( "spawnflags", "1" ) 
		portal:SetParent( npc )
		portal:Spawn()
		portal:Activate()
		timer.Simple( 3, function() portal:Remove() end )
		HLU_ChatNotifySystem( "BMRP", color_orange, "Security breach detected! Alien life has been spotted loose in the facility!" )
		RunConsoleCommand( "vox", "bizwarn bizwarn warning _comma security _comma breach _comma unauthorized biological _comma forms detected" )
	end

	hook.Add( "EntityTakeDamage", "LogEventParticipants", function( ent, dmg )
		if ent.IsEventNPC then
			local ply = dmg:GetAttacker()
			table.insert( NPCEventParticipants, ply )
		end	
	end )
	-----------------------------------------------------------------
	local function BiohazardCleanup()
		if #ents.FindByClass( "*ium_ent" ) > 0 then
			return
		end
		for k,v in pairs( team.GetPlayers( TEAM_BIO ) ) do
			v:AddFunds( 500 )
			HLU_Notify( v, "You have been awarded $500 for helping cleanup the biohazard.", 0, 6 )
		end
		HLU_ChatNotifySystem( "BMRP", color_orange, "The hazardous waste leak has been cleaned up!" )
		EndEvent( 1800 )
	end

	function Biohazard()
		local hazard = {
			"uranium_ent",
			"plutonium_ent",
			"unubuntium_ent"
		}
	
		local biopos = {
			[sectorc] = {
				Vector( 1596, -984, -338 ),
				Vector( 2167, -4669, -3162 ),
				Vector( 1439, -4103, -2786 )
			},
			[laboratory] = {
				Vector( 833, -2205, -31 ),
				Vector( 2632, -2380, 609 ),
				Vector( -812, -3789, 288 )
			},
			[complex] = {
				Vector( -1285, -1040, -456 ),
				Vector( -1875, -4, 288 ),
				Vector( 544, 6137, 2160 ),
				Vector( -3846, 7020, 2262 )
			},
			[bmrf] = {
				Vector( 2236, -4998, -1439 ),
				Vector( 289, -2657, 96 ),
				Vector( 894, -1411, 61 )
			}
		}

		for i=1, math.random( 1, 6 ) do
			local waste = ents.Create( table.Random( hazard ) )
			waste:SetPos( table.Random( biopos[game.GetMap()] ) )
			waste:Spawn()
			waste:CallOnRemove( "BiohazardCleanup", BiohazardCleanup )
		end
		HLU_ChatNotifySystem( "BMRP", color_orange, "A hazardous waste leak has been detected!" )
		RunConsoleCommand( "vox", "bizwarn bizwarn biohazard _comma warning _comma biological _comma team report to location immediately" )
	end
	-----------------------------------------------------------------
	function Crystal()
		local crystalpos = {
			[sectorc] = {
				Vector( -6837, -677, -253 ),
				Vector( 4227, -1397, -240 ),
				Vector( 915, -3345, -2858 ),
				Vector( -6116, 771, -301 ),
				Vector( -10292, -416, 570 ),
				Vector( -10617, -979, 570 )
			},
			[laboratory] = {
				Vector( -1126, -4457, 608 ),
				Vector( -302, -1059, 289 ),
				Vector( 860, -52, 289 ),
				Vector( 521, -1006, -32 ),
				Vector( 784, -2251, -31 ),
				Vector( 120, -4224, -351 ),
				Vector( 807, -6389, -350 )
			},
			[complex] = {
				Vector( 1270, 1731, -32 ),
				Vector( -2212, 304, 288 ),
				Vector( -2919, 8225, 2262 ),
				Vector( -4800, 6595, 2455 ),
				Vector( -617, 4997, 2160 ),
				Vector( 3785, 5614, 1568 ),
				Vector( 883, 1374, -32 )
			},
			[bmrf] = {
				Vector( -1204, -1393, 64 ),
				Vector( -4221, 623, -111 ),
				Vector( -4269, 2578, -63 ),
				Vector( -446, 2721, -63 ),
				Vector( 4608, -544, -63 ),
				Vector( 2484, -4879, 192 )
			}
		}

		local crystal = ents.Create( "event_crystal" )
		crystal:SetPos( table.Random( crystalpos[game.GetMap()] ) )
		crystal:Spawn()
		HLU_ChatNotifySystem( "BMRP", color_orange, "A crystal has been accidently teleported to a random location in the facility!" )
		HLU_ChatNotifySystem( "BMRP", color_orange, "The survey team should find it before it gets into the wrong hands!" )
		RunConsoleCommand( "vox", "bizwarn _comma alert _comma containment _comma crew detain target delta alpha bravo immediately" )
	end

	function SecureCrystal()
		HLU_ChatNotifySystem( "BMRP", color_orange, "The lost crystal has been secured!" )
		EndEvent( 1800 )
	end
	-----------------------------------------------------------------
	function ServerFailure()
		for k,v in pairs( ents.FindByClass( "event_server" ) ) do
			v.broke = true
		end
		hook.Add( "PlayerUse", "BlockPCUsage", function( ply, ent )
			if string.match( ent:GetClass(), "pcmod_" ) or ent:GetClass() == "sent_computer" then
				if ply.MessageCooldown and ply.MessageCooldown > CurTime() then return end
				HLU_ChatNotifySystem( "BMRP", color_orange, "The main server is currently down. You won't be able to use computers until a technician fixes it.", true, ply )
				ply.MessageCooldown = CurTime() + 1
				return false
			end
		end )
		HLU_ChatNotifySystem( "BMRP", color_orange, "The main server has overheated! Computers will not be able to be used until it is fixed!" )
		RunConsoleCommand( "vox", "deeoo _comma superconducting _comma _comma dual core systems high temperature _comma warning" )
	end

	function FixServer()
		hook.Remove( "BlockPCUsage" )
		HLU_ChatNotifySystem( "BMRP", color_orange, "The servers have been fixed and computers can be used again!" )
		EndEvent( 1800 )
	end
	-----------------------------------------------------------------
	local bosses = {
		"monster_garg",
		"monster_geneworm",
		"monster_gonarch",
		"monster_pitworm_up"
	}

	local function KillBoss()
		for k,v in pairs( NPCEventParticipants ) do
			if IsValid( v ) then
				v:AddFunds( 500 )
				HLU_Notify( v, "You have been awarded $500 for helping defend the facility." )
			end
		end
		NPCEventParticipants = {}
		HLU_ChatNotifySystem( "BMRP", color_orange, "The large hostile life form has been killed!" )
		EndEvent( 3600 )
	end

	function Boss()
		local boss
		if map == sectorc then
			boss = ents.Create( table.Random( bosses ) )
			boss:SetPos( Vector( -10245, -6811, -2661 ) )
			boss:SetAngles( Angle( 0, -55, 0 ) )
		elseif map == laboratory then
			boss = ents.Create( "monster_alien_tentacle" )
			boss:SetPos( Vector( -4331, 1734, -350 ) )
		elseif map == complex then
			boss = ents.Create( "monster_alien_voltigore" )
			boss:SetPos( Vector( 8388, -3671, 1360 ) )
		elseif map == bmrf then
			boss = ents.Create( "monster_pitworm_up" )
			boss:SetPos( Vector( 2664, -2547, -255 ) )
		end
		boss:Spawn()
		boss:CallOnRemove( "KillBoss", KillBoss )
		boss.IsEventNPC = true
		HLU_ChatNotifySystem( "BMRP", color_orange, "All hands on deck! A large hostile life form has teleported into the facility!" )
		RunConsoleCommand( "vox", "bizwarn bizwarn bizwarn attention _comma all personnel report _comma to containment zone immediately" )
	end
	-----------------------------------------------------------------
	function RandomFire()
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
		local e = ents.Create( "event_fire" )
		e:SetPos( randfire )
		e:Spawn()
		CreateVFireBall( 30, 15, e:GetPos(), Vector( 0, 50, 0 ), e )
		HLU_ChatNotifySystem( "BMRP", color_orange, "A fire has been detected by the facility smoke alarms! Evacuate while service officials contain it!" )
		RunConsoleCommand( "vox", "bizwarn bizwarn warning _comma fire detected" )
	end

	function ExtinguishFire()
		for k,v in pairs( team.GetPlayers( TEAM_SERVICE ) ) do
			v:AddFunds( 500 )
			HLU_Notify( v, "You have been awarded $500 for extinguishing a fire.", 0, 6 )
		end
		HLU_ChatNotifySystem( "BMRP", color_orange, "The fire has been extinguished!" )
		EndEvent( 1800 )
	end
end

BMRP_EVENTS = {
	{
		Name = "Xen Portal Failure",
		Description = "Prevents the Xen portal from being activated until a service official repairs a console near the portal controls.",
		Required = TEAM_SERVICE,
		OnSelect = PortalBreakDown
	},
	{
		Name = "Door Failure",
		Description = "Prevents certain doors from being opened until a service official restarts the generator powering them.",
		Required = TEAM_SERVICE,
		OnSelect = DoorFailure
	},
	{
		Name = "Medical Emergency",
		Description = "Causes a random player (excluding you and any medics) to faint and remain on the ground until a medic revives them.",
		Required = TEAM_MEDIC,
		OnSelect = MedicFaint
	},
	{
		Name = "Containment Breach",
		Description = "Hostile Xen creatures enter the facility and attack personnel.",
		Required = TEAM_SECURITYBOSS,
		OnSelect = XenBreach
	},
	{
		Name = "Biohazard",
		Description = "Radioactive materials spill out at a random location within the facility that the biochemist has to cleanup.",
		Required = TEAM_BIO,
		OnSelect = Biohazard
	},
	{
		Name = "Lost Crystal",
		Description = "Xen crystal teleports to a random location within the facility. Survey members need to remove it before it gets lost.",
		Required = TEAM_SURVEYBOSS,
		OnSelect = Crystal
	},
	{
		Name = "Server Failure",
		Description = "Prevents players from using all computers until the server is repaired by a technician.",
		Required = TEAM_TECH,
		OnSelect = ServerFailure
	},
	{
		Name = "Boss Fight",
		Description = "Large hostile Xen creature teleports into the facility.",
		Required = TEAM_WEPBOSS,
		OnSelect = Boss
	},
	{
		Name = "Fire",
		Description = "Fire breaks out at a random location.",
		Required = TEAM_SERVICE,
		OnSelect = RandomFire
	}
}

BMRP_TASKS = {
	{
		Name = "Gather Xen Materials",
		Description = "Gather various materials from Xen to be used in crafting and research.",
		Required = { TEAM_SURVEYBOSS, TEAM_SURVEY }
	},
	{
		Name = "Clear Out Xen",
		Description = "Clear Xen of hostile life forms to make way for future expeditions.",
		Required = { TEAM_SURVEYBOSS, TEAM_SURVEY }
	},
	{
		Name = "Handle Radioactive Materials",
		Description = "Help other scientists handle radioactive materials",
		Required = { TEAM_SURVEYBOSS, TEAM_SURVEY }
	},
	{
		Name = "Setup Computers",
		Description = "Setup computers for all staff that need or want it.",
		Required = { TEAM_TECH }
	},
	{
		Name = "Create Local Server",
		Description = "Create a local server using GTerminal, PCMod, and/or Wiremod so staff can remotely communicate with each other.",
		Required = { TEAM_TECH }
	},
	{
		Name = "Develop Advanced Technology",
		Description = "Develop advanced technology with Wiremod that the facility can use and/or sell. See facility admin for details.",
		Required = { TEAM_TECH }
	},
	{
		Name = "Research Alien Life",
		Description = "Research and attempt to replicate alien life forms.",
		Required = { TEAM_BIO }
	},
	{
		Name = "Develop Biological Weapons",
		Description = "Develop biological weapons using materials obtained from the border world.",
		Required = { TEAM_BIO }
	},
	{
		Name = "Setup Office",
		Description = "Setup an office that staff can visit if they need healed.",
		Required = { TEAM_MEDIC }
	},
	{
		Name = "Setup Medical Equipment",
		Description = "Setup medical equipment such as health and armor chargers around the facility for easy access.",
		Required = { TEAM_MEDIC }
	},
	{
		Name = "Cleanup Facility",
		Description = "Visit each lab and cleanup any unused materials and wipe down walls and floors.",
		Required = { TEAM_SERVICE }
	},
	{
		Name = "Restock Vending Machines",
		Description = "Restock any vending machines around the facility that are empty.",
		Required = { TEAM_SERVICE }
	},
	{
		Name = "Develop Normal Weapons",
		Description = "Develop normal weapons that security can use as alternatives to their stock weapons.",
		Required = { TEAM_WEPMAKER }
	},
	{
		Name = "Develop Prototype Weapons",
		Description = "Develop prototype weapons that the facility can sell to the military or use for advanced projects.",
		Required = { TEAM_WEPMAKER }
	},
	{
		Name = "Develop Unusual Weapons",
		Description = "Develop unusual weapons that we can use for....something...",
		Required = { TEAM_WEPMAKER },
	},
	{
		Name = "Patrol Facility",
		Description = "Patrol the facility and notify personnel of any security risks.",
		Required = { TEAM_SECURITYBOSS, TEAM_SECURITY },
	},
	{
		Name = "Setup Checkpoint",
		Description = "Setup and man a security checkpoint to a restricted area. See facility admin for details.",
		Required = { TEAM_SECURITYBOSS, TEAM_SECURITY },
	}
}

BMRP_CURRENT_TASKS = {}
