
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

-----------------------------------------------------------------
function PortalBreakDown()
	if team.NumPlayers( TEAM_SURVEY ) + team.NumPlayers( TEAM_SURVEYBOSS ) == 0 or team.NumPlayers( TEAM_SERVICE ) == 0 then return end
	if map == sectorc then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 1207 then
				v:Fire( "Lock" )
			end
		end
	elseif map == laboratory then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 90 then
				v:Fire( "Lock" )
			end
		end
	elseif map == complex then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 977 then
				v:Fire( "Lock" )
			end
		end
	end
	for k,v in pairs( ents.FindByClass( "event_portal_fix" ) ) do
		v.broke = true
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "The portal has malfunctioned! It won't be able to start up again until a service official fixes it!" )
		end
	end
	RunConsoleCommand( "vox", "deeoo deeoo alert main portal control failure" )
	SetGlobalBool( "EventActive", true )
end

function PortalFix()
	if map == sectorc then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 1207 then
				v:Fire( "Unlock" )
			end
		end
	elseif map == laboratory then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 90 then
				v:Fire( "Unlock" )
			end
		end
	elseif map == complex then
		for k,v in pairs( ents.FindByClass( "func_button" ) ) do
			if v:EntIndex() == 977 then
				v:Fire( "Unlock" )
			end
		end
	end
	RunConsoleCommand( "vox", "dadeda maintenance reports main portal control inspection nominal" )
	SetGlobalBool( "EventActive", false )
end
-----------------------------------------------------------------
local sectorcindex = { 1481, 1480, 1514, 1515, 1040, 1021, 1056, 1041, 442, 455, 537, 518, 461, 462, 479, 465 }

local laboratoryindex = { 40, 41, 626, 627, 125, 126, 124, 123, 255, 256, 82, 81, 382, 381, 55, 57, 120, 121, 222, 218, 219, 34, 35, 47, 48, 37, 38, 49, 51, 167, 53, 54, 517, 518, 148, 66, 68 }

local complexindex = { 377, 378, 140, 165, 166, 167, 168, 170, 171, 1014, 520, 521, 330, 966, 967, 1112, 108, 474, 659, 660, 759 }

function DoorFailure()
	if team.NumPlayers( TEAM_SERVICE ) == 0 then return end
	if map == sectorc then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( sectorcindex, v:EntIndex() ) then
				v:Fire( "Lock" )
			end
		end
	elseif map == laboratory then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( laboratoryindex, v:EntIndex() ) then
				v:Fire( "Lock" )
			end
		end
	elseif map == complex then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( complexindex, v:EntIndex() ) then
				v:Fire( "Lock" )
			end
		end
	end
	for k,v in pairs( ents.FindByClass( "event_door_fix" ) ) do
		v.broke = true
		v:EmitSound("vehicles/Airboat/fan_motor_shut_off1.wav")
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "The secondary generator powering some electric doors has stalled!" )
		end
	end
	RunConsoleCommand( "vox", "bizwarn warning secondary _comma door power system failure" )
	SetGlobalBool( "EventActive", true )
end

function DoorFix()
	if game.GetMap() == "rp_sectorc_beta" then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( sectorcindex, v:EntIndex() ) then
				v:Fire( "Unlock" )
			end
		end
	elseif game.GetMap() == "rp_blackmesa_laboratory" then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( laboratoryindex, v:EntIndex() ) then
				v:Fire( "Unlock" )
			end
		end
	elseif game.GetMap() == "rp_blackmesa_complex_fixed" then
		for k,v in pairs( ents.GetAll() ) do
			if table.HasValue( complexindex, v:EntIndex() ) then
				v:Fire( "Unlock" )
			end
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 64, 255, 35 ), "The secondary generator has been restarted!" )
		end
	end
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

function MedicRevive()
	if team.NumPlayers( TEAM_MEDICBM ) == 0 then return end
	if SERVER then
		local victim = ents.Create( "event_revive" )
		if map == sectorc then
			victim:SetPos( table.Random( sectorc_revive ) )
		end
		if map == laboratory then
			victim:SetPos( table.Random( laboratory_revive ) )
		end
		if map == complex then
			victim:SetPos( table.Random( complex_revive ) )
		end
		victim:Spawn()
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "A medical emergency has been reported! Current location unknown!" )
		end
	end
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

function XenBreach()
	if team.NumPlayers( TEAM_SECURITY ) + team.NumPlayers( TEAM_SECURITYBOSS ) == 0 then return end
	if SERVER then
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
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "Security breach detected! Alien life has been spotted loose in the facility!" )
		end
	end
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

function Biohazard()
	if team.NumPlayers( TEAM_BIO ) == 0 then return end
	if SERVER then
		if map == sectorc then
			for i=1, math.random( 1, 6 ) do
				local waste = ents.Create( table.Random( hazard ) )
				waste:SetPos( table.Random( sectorc_bio ) )
				waste:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				waste:Spawn()
			end
		end
		if map == laboratory then
			for i=1, math.random( 1, 6 ) do
				local waste = ents.Create( table.Random( hazard ) )
				waste:SetPos( table.Random( laboratory_bio ) )
				waste:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				waste:Spawn()
			end
		end
		if map == complex then
			for i=1, math.random( 1, 6 ) do
				local waste = ents.Create( table.Random( hazard ) )
				waste:SetPos( table.Random( complex_bio ) )
				waste:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				waste:Spawn()
			end
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "A hazardous waste leak has been detected!" )
		end
	end
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

function Crystal()
	if team.NumPlayers( TEAM_SURVEY ) + team.NumPlayers( TEAM_SURVEYBOSS ) == 0 then return end
	if SERVER then
		if map == sectorc then
			local crystal = ents.Create( "event_crystal" )
			crystal:SetPos( table.Random( sectorc_crystal ) )
			crystal:Spawn()
		end
		if map == laboratory then
			local crystal = ents.Create( "event_crystal" )
			crystal:SetPos( table.Random( laboratory_crystal ) )
			crystal:Spawn()
		end
		if map == complex then
			local crystal = ents.Create( "event_crystal" )
			crystal:SetPos( table.Random( complex_crystal ) )
			crystal:Spawn()
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "A crystal has been accidently teleported to a random location in the facility!" )
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "The survey team should find it before it gets into the wrong hands!" )
		end
	end
	RunConsoleCommand( "vox", "bizwarn _comma alert _comma containment _comma crew detain target delta alpha bravo immediately" )
end
-----------------------------------------------------------------
function ReviveGman()
	if team.NumPlayers( TEAM_ADMIN ) == 0 then return end
	if SERVER then
		if map == sectorc then
			local loot = ents.Create( "event_npc_base" )
			loot:SetPos( Vector( 496, -4210, -253 ) )
			loot:SetAngles( Angle( 0, 180, 0 ) )
			loot:Spawn()
		end
		if map == laboratory then
			local loot = ents.Create( "event_npc_base" )
			loot:SetPos( Vector( 2443, 939, -32 ) )
			loot:SetAngles( Angle( 0, 180, 0 ) )
			loot:Spawn()
		end
		if map == complex then
			local loot = ents.Create( "event_npc_base" )
			loot:SetPos( Vector( 987, 1134, -32 ) )
			loot:SetAngles( Angle( 0, -90, 0 ) )
			loot:Spawn()
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 64, 255, 35 ), "Government officials are requesting to see administration personnel at sector D." )
		end
	end
	RunConsoleCommand( "vox", "dadeda _comma administration personnel report to sector d please" )
end
-----------------------------------------------------------------
chosenwep = nil

function MarineWeapon()
	if team.NumPlayers( TEAM_WEPMAKER ) == 0 then return end
	if SERVER then
		if map == sectorc then
			local loot = ents.Create( "event_npc_weapon" )
			loot:SetPos( Vector( 491, -4574, -253 ) )
			loot:SetAngles( Angle( 0, 180, 0 ) )
			loot:Spawn()
		end
		if map == laboratory then
			local loot = ents.Create( "event_npc_weapon" )
			loot:SetPos( Vector( 2445, 1028, -32 ) )
			loot:SetAngles( Angle( 0, 180, 0 ) )
			loot:Spawn()
		end
		if map == complex then
			local loot = ents.Create( "event_npc_weapon" )
			loot:SetPos( Vector( 784, 1139, -32 ) )
			loot:SetAngles( Angle( 0, -90, 0 ) )
			loot:Spawn()
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 64, 255, 35 ), "A Corporal has arrived at sector D. He is requesting that a weapons engineer speak with him ASAP." )
		end
	end
	RunConsoleCommand( "vox", "dadeda _comma weapon science team report to sector d immediately" )
end
-----------------------------------------------------------------
computerbroke = false

function ServerFailure()
	if team.NumPlayers( TEAM_TECH ) == 0 then return end
	computerbroke = true
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "The main server has overheated! Computers will not be able to be used until it is fixed!" )
		end
	end
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
	if SERVER then
		if map == sectorc then
			local bos = ents.Create( table.Random( bosses ) )
			bos:SetPos( Vector( -10245, -6811, -2661 ) )
			bos:SetAngles( Angle( 0, -55, 0 ) )
			bos:Spawn()
		end
		if map == laboratory then
			local bos = ents.Create( "monster_alien_tentacle" )
			bos:SetPos( Vector( -4331, 1734, -350 ) )
			bos:Spawn()
		end
		if map == complex then
			local bos = ents.Create( "monster_alien_voltigore" )
			bos:SetPos( Vector( 8388, -3671, 1360 ) )
			bos:Spawn()
		end
	end
	for k,v in pairs( player.GetAll() ) do
		if SERVER then
			DarkRP.talkToPerson( v, Color( 255, 64, 35 ), "All hands on deck! A large hostile life form has teleported into the facility!" )
		end
	end
	RunConsoleCommand( "vox", "bizwarn bizwarn bizwarn attention _comma all personnel report _comma to containment zone immediately" )
end
-----------------------------------------------------------------