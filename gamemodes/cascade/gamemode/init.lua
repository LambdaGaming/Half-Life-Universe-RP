include( "positions.lua" )
include( "round_server.lua" )

RunConsoleCommand( "sbox_maxprops", "30" ) --Limits props so scientists don't become op with the dupe tool
--Other things will be disabled in-game such as certain wiremod entities

DarkRP.removeChatCommand( "pm" ) --Disables pm command so players have to rely on local chat and computers to talk privately

SetGlobalInt( "PreRound", 0 )
SetGlobalInt( "MainRound", 0 )

local scientist = TEAM_SCIENTIST
local admin = TEAM_ADMINC
local visitor = TEAM_VISITORC
local medic = TEAM_MEDICBMC
local marine = TEAM_MARINEC
local security = TEAM_SECURITYC
local vort = TEAM_VORT
local zombie = TEAM_ZOMBIE

--Welcome message that displays when the player spawns in
hook.Add( "PlayerInitialSpawn", "HoldSpectators", function( ply )
	ply:ChatPrint("Welcome to BMRP:Cascade! If you are new here, press F1 for the basic rundown of this gamemode.")
end )

--Spawns the player at the newly created admin room info_player_start's
hook.Add( "PlayerSelectSpawn", "CascadeSpawn", function( ply )
	local spawns = ents.FindByClass( "info_player_start" )
	local random_entry = math.random( #spawns )

	return spawns[ random_entry ]
end )

--Awards players for killing an enemy, also protects against teamkilling
hook.Add( "PlayerDeath", "DeathAward", function( ply, inflictor, attacker ) --Hands out awards for killing players of the opposing team
	if GetGlobalInt( "PreRound" ) == 1 or GetGlobalInt( "MainRound" ) == 1 then return end
	if !IsValid( attacker ) or !IsValid( inflictor ) or !IsValid( ply ) then return end
	if ply == attacker or ply == inflictor then return end
	if !attacker:IsPlayer() or !attacker:IsNPC() then return end
	if attacker:Team() == marine and ( ply:Team() != medic or ply:Team() != marine ) then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing an enemy as HECU." )
	end
	if attacker:Team() == medic and ( ply:Team() != marine or ply:Team() != medic ) then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing an enemy as a medic." )
	end
	if attacker:Team() == security and ( ply:Team() != scientist or ply:Team() != security ) then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing an enemy as security." )
	end
	if attacker:Team() == scientist and ( ply:Team() != security or ply:Team() != scientist ) then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing an enemy as a scientist." )
	end
	if attacker:Team() == vort and ply:Team() == zombie then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing a zombie as a vortigaunt." )
	end
	if attacker:Team() == zombie then
		attacker:addMoney( 300 )
		DarkRP.notify( attacker, 0, 6, "You have been awarded $300 for killing an enemy as a zombie." )
	end
end )

--Respawns players after they died depending on what job they were
hook.Add( "DoPlayerDeath", "CascadeDeath", function( ply, attacker, dmg )
	if GetGlobalInt( "PreRound" ) == 0 and GetGlobalInt( "MainRound" ) == 0 then
		timer.Simple( 1, function() --Respawns the player back at the waiting room if they die before the round starts, doesn't change their job
			ply:Spawn()
			--ply:SetPos( table.Random( CASCADE_DEADPOS ) )
			ply:ChatPrint( "Wow. The round didn't even start and you still managed to die." )
		end )
		return
	end
	if attacker:GetClass() == "npc_headcrab" or attacker:GetClass() == "npc_headcrab_black" or attacker:GetClass() == "npc_headcrab_fast" then
		timer.Simple( 1, function()
			ply:Spawn()
			ply:changeTeam( zombie, true, true )
			ply:ChatPrint( "You have been killed by a headcrab and are now a zombie." )
			ply:ChatPrint( "You are a zombie. Your objective is to kill all living organisms." )
			--ply.deadzombie = true
		end )
		return
	end
	if GetGlobalInt( "PreRound" ) == 1 or GetGlobalInt( "MainRound" ) == 1 then
		timer.Simple( 1, function() --Sets the player's team to visitor and places them in the waiting room until the HECU timer cycles
			ply:Spawn()
			ply:changeTeam( visitor, true, true )
			--ply:SetPos( table.Random( CASCADE_DEADPOS ) )
			ply:ChatPrint( "You have died. You will respawn as HECU once the timer ends." )
		end )
		return
	end
end )

--Prevents players from using the kill command
hook.Add( "CanPlayerSuicide", "CascadeNoSuicide", function()
	return false
end )

--Randomly selects jobs based on how many players there are, credit goes to the creator of Breach
function SetJobs()
	local ply = player.GetAll()
	local plycount = player.GetCount()
	if plycount <= 2 then DarkRP.notifyAll( 0, 6, "BMRP:Cascade is intended to be used with 3 or more players. Errors may occur with 2 or less." ) end
	if plycount <= 3 then
		local adminply = table.Random( ply )
		adminply:changeTeam( admin, true, true )
		table.RemoveByValue( ply, adminply )
		local rndplayer = table.Random( ply )
		table.RemoveByValue( ply, rndplayer )
		rndplayer:changeTeam( scientist, true, true )
		local rndplayer = table.Random( ply )
		table.RemoveByValue( ply, rndplayer )
		rndplayer:changeTeam( security, true, true )
		return
	end
	if plycount > 3 and plycount < 5 then
		local adminply = table.Random( ply )
		adminply:changeTeam( admin, true, true )
		table.RemoveByValue( ply, adminply )
		for i=1, math.Round( #ply / 3 ) do
			local rndplayer = table.Random( ply )
			table.RemoveByValue( ply, rndplayer )
			rndplayer:changeTeam( security, true, true )
		end
		for i=1, math.Round( #ply / 2 ) do
			local rndplayer = table.Random( ply )
			table.RemoveByValue( ply, rndplayer )
			rndplayer:changeTeam( medic, true, true )
		end
		for k,v in pairs( ply ) do
			v:changeTeam( scientist, true, true )
		end
		return
	end
	if plycount >= 5 then
		local adminply = table.Random( ply )
		table.RemoveByValue( ply, adminply )
		local adminply2 = table.Random( ply )
		table.RemoveByValue( ply, adminply2 )
		adminply:changeTeam( admin, true, true )
		local mtrnd = math.random( 1,2 )
		if mtrnd == 1 then
			adminply2:changeTeam( admin, true, true )
		elseif mtrnd == 2 then
			adminply2:changeTeam( vort, true, true )
		end
		for i=1, math.Round( #ply / 4 ) do
			local rndplayer = table.Random(ply)
			table.RemoveByValue(ply, rndplayer)
			rndplayer:changeTeam( security, true, true )
		end
		for i=1, math.Round( #ply / 2 ) do
			local rndplayer = table.Random(ply)
			table.RemoveByValue(ply, rndplayer)
			rndplayer:changeTeam( medic, true, true )
		end
		for k,v in pairs(ply) do
			v:changeTeam( scientist, true, true )
		end
	end
end

--Teleports all players to the admin room
function TelePlayers()
	for k,v in pairs( player.GetAll() ) do
		v:SetPos( table.Random( CASCADE_DEADPOS ) )
	end
	DarkRP.notifyAll( 0, 6, "Teleported all players to the starting room." )
end

--Locks all of the listed doors to prevent players from simply finding the easiest path by opening unlocked doors all the time
function LockDoors() --Going to have to get all of the door indexes manually, for some reason the ent index in the sv.db file differs from the actual one
	local lockabledoors = { 1968, 619, 620, 2091, 621, 622, 1933, 1657, 1656, 1737, 669, 659, 660, 148, 147, 1748, 1750, 1751, 1047, 1050, 1046, 1052, 55, 56, 65, 125, 124, 253, 213, 214, 1253, 71, 1252, 70, 1199, 1192, 2055, 2059, 103, 131, 876, 875, 826, 827, 2174, 2175, 1756, 1755, 1757, 1614, 1596, 2065, 2093, 1627, 1526, 1626, 114, 1309, 98, 226, 1324, 1326 }
	for k,v in pairs( ents.GetAll() ) do
		if table.HasValue( lockabledoors, v:EntIndex() ) then
			v:Fire( "Close" )
			v:Fire( "Lock" )
		end
	end
end

--Spawns random weapon caches, as well as the tram fixer, armor batteries, and escape vehicle
function SetupWeapons()
	if SERVER then
		for k,v in ipairs( CASCADE_PRIMARYPOS ) do
			spawnprimary = ents.Create( table.Random( CASCADE_PRIMARYCLASS ) )
			spawnprimary:SetPos( v )
			spawnprimary:Spawn()
		end
		
		for a,b in ipairs( CASCADE_SECONDARYPOS ) do
			spawnsecondary = ents.Create( table.Random( CASCADE_SECONDARYCLASS ) )
			spawnsecondary:SetPos( b )
			spawnsecondary:Spawn()
		end
		
		for i=1, 3 do --Limits special weapon spawn to 3
			spawnspecial = ents.Create( table.Random( CASCADE_SPECIALCLASS ) )
			spawnspecial:SetPos( table.Random( CASCADE_SPECIALPOS ) )
			spawnspecial:Spawn()
		end
		
		local randtram = table.Random( CASCADE_TRAMFIXPOS )
		spawntramfix = ents.Create( "tram_controller" ) --Putting the tram controller spawn here cuz why not
		spawntramfix:SetPos( randtram[1] )
		spawntramfix:SetAngles( randtram[2] )
		spawntramfix:Spawn()
		
		local randescape = table.Random( CASCADE_ESCAPEPOS )
		spawnescape = ents.Create( "cascade_escape" ) --Also putting escape vehicle here
		spawnescape:SetPos( randescape )
		spawnescape:Spawn()
		
		for c,d in ipairs( CASCADE_ARMORPOS ) do
			spawnarmor = ents.Create( "item_battery" ) --And armor batteries
			spawnarmor:SetPos( d )
			spawnarmor:Spawn()
		end
		
		for e,f in ipairs( CASCADE_PCPOS ) do
			terminal = ents.Create( "sent_computer" ) --Almost forgot the gterminals
			terminal:SetPos( f )
			terminal:Spawn()
		end
	end
end

function RemoveWeapons() --Removes weapons after the round ends
	for k,v in pairs( ents.GetAll() ) do
		if table.HasValue( CASCADE_PRIMARYCLASS, v:GetClass() ) || table.HasValue( CASCADE_SECONDARYCLASS, v:GetClass() ) || table.HasValue( CASCADE_SPECIALCLASS, v:GetClass() ) || v:GetClass() == "tram_controller" || v:GetClass() == "cascade_escape" || v:GetClass() == "item_battery" || v:GetClass() == "sent_computer" || table.HasValue( CASCADE_PCPOS, v:GetClass() ) then
			v:Remove()
		end
	end
end

function RemoveNPCS()
	for k,v in pairs( ents.FindByClass( "monster_*" ) ) do
		v:Remove()
	end
	for k,v in pairs( ents.FindByClass( "npc_*" ) ) do
		v:Remove()
	end
	game.RemoveRagdolls()
end

function SetupObstructions() --Spawns random obstructions that force players to take alternate paths
	if SERVER then
		local function FireBlock() --If all of the fires are put out, the obstruction will clear
			local randomfire = math.random( 1, 3 )
			if randomfire == 1 then
				for a,b in ipairs( CASCADE_FIREBLOCK1 ) do
					CreateVFireBall( 1200, 10, b + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
				end
				for k,v in ipairs( CASCADE_FIREWALLPOS1 ) do
					timer.Simple( 0.5, function()
						blockfirewall = ents.Create( "fire_wall" )
						blockfirewall:SetPos( v[1] )
						blockfirewall:SetAngles( v[2] ) --Positive rate, gear up
						blockfirewall:Spawn()
					end )
				end
			elseif randomfire == 2 then
				for a,b in ipairs( CASCADE_FIREBLOCK2 ) do
					CreateVFireBall( 1200, 10, b + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
				end
				for k,v in ipairs( CASCADE_FIREWALLPOS2 ) do
					timer.Simple( 0.5, function()
						blockfirewall = ents.Create( "fire_wall" )
						blockfirewall:SetPos( v[1] )
						blockfirewall:SetAngles( v[2] )
						blockfirewall:Spawn()
					end )
				end
			elseif randomfire == 3 then
				for a,b in ipairs( CASCADE_FIREBLOCK3 ) do
					CreateVFireBall( 1200, 10, b + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
				end
				for k,v in ipairs( CASCADE_FIREWALLPOS3 ) do
					timer.Simple( 0.5, function()
						blockfirewall = ents.Create( "fire_wall" )
						blockfirewall:SetPos( v[1] )
						blockfirewall:SetAngles( v[2] )
						blockfirewall:Spawn()
					end )
				end
			end
		end
		local function RubbleBlock() --Solid obstruction, cannot be moved or cleared
			local randomrubble = math.random( 1, 3 )
			if randomrubble == 1 then
				for k,v in pairs( CASCADE_RUBBLEPOS1 ) do
					rubblespawn = ents.Create( "rubble_block" )
					rubblespawn:SetPos( v[1] )
					rubblespawn:SetAngles( v[2] )
					rubblespawn:Spawn()
				end
			elseif randomrubble == 2 then
				for k,v in pairs( CASCADE_RUBBLEPOS2 ) do
					rubblespawn = ents.Create( "rubble_block" )
					rubblespawn:SetPos( v[1] )
					rubblespawn:SetAngles( v[2] )
					rubblespawn:Spawn()
				end
			elseif randomrubble == 3 then
				for k,v in pairs( CASCADE_RUBBLEPOS3 ) do
					rubblespawn = ents.Create( "rubble_block" )
					rubblespawn:SetPos( v[1] )
					rubblespawn:SetAngles( v[2] )
					rubblespawn:Spawn()
				end
			end
		end
		FireBlock()
		RubbleBlock()
	end
end

function RemoveObstructions() --Removes obstructions after the round ends
	RunConsoleCommand( "vfire_remove_all" )
	if IsValid(blockfirewall) then blockfirewall:Remove() end
	rubblespawn:Remove()
end

function PressAlarm() --Turns on alarms, disables the trams, and closes the fire doors
	for p,l in pairs( ents.FindByClass( "func_button" ) ) do
		if l:EntIndex() == 1152 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1273 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1154 then
			l:Fire( "Press" )
		end
	end
end

function UnpressAlarm() --Turns off the alarm, starts up the trams, and lifts the fire doors
	for p,l in pairs( ents.FindByClass( "func_button" ) ) do
		if l:EntIndex() == 1152 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1273 then
			l:Fire( "PressOut" ) --Using PressOut here incase the trams were re-activated during the round
		end
		if l:EntIndex() == 1154 then
			l:Fire( "Press" )
		end
	end
end

function CascadePreRound()
	for k,v in pairs( player.GetAll() ) do
		if v:Team() == scientist then
			v:SetPos( table.Random( CASCADE_SCIENTISTSPAWN ) ) --Scientists will first be spawned in a random science lab
			v:ChatPrint( "You are a scientist. Your objective is to work with security to escape, and to build/invent machines to survive." )
		end
		v:ChatPrint( "The pre-round has started. Scientists have been released." )
	end
	SetGlobalInt( "PreRound", 1 )
end

function CascadeMainRound()
	SetGlobalInt( "PreRound", 0 )
	SetGlobalInt( "MainRound", 1 )
	for k,v in pairs( player.GetAll() ) do --Spawns the rest of the players after the pre-round is over
		if v:Team() == admin then
			v:SetPos( table.Random( CASCADE_ADMINPOS ) )
			v:ChatPrint( "You are a facility administrator. Your objective is to kill all personnel on sight and prevent them from escaping. You can optionally work with HECU." )
		end
		if v:Team() == security then
			v:SetPos( table.Random( CASCADE_SECURITYPOS ) )
			v:ChatPrint( "You are a security officer. Your objective is to work with scientists to escape." )
			local randomwep = {
				"weapon_eagle",
				"weapon_9mmhandgun",
				"weapon_357_hl"
			}
			v:Give( table.Random( randomwep ) )
		end
		if v:Team() == medic then
			v:SetPos( table.Random( CASCADE_MEDICPOS ) )
			v:ChatPrint( "You are a medic. Your objective is to avoid being captured by scientists and/or security, and to work with HECU to escape." )
		end
		if v:Team() == vort then
			v:SetPos( table.Random( CASCADE_VORTPOS ) )
			v:ChatPrint( "You are a vortigaunt who has been freed from slavery. Your objective is to protect humans from invading Xen aliens." )
		end	
		if v:Team() == visitor then
			v:SetPos( table.Random( CASCADE_DEADPOS ) )
			v:ChatPrint( "You are still a visitor because you spawned in after jobs were selected. You will respawn as HECU in "..timer.TimeLeft( "HECULoop" ) )
		end
	end
end

function ResetRound() --Places everyone in the waiting room, resets everyone's scores, and removes the HECU timer
	for k,v in pairs( player.GetAll() ) do
		if v:Team() == admin then
			v:addMoney( v:Frags() * 200 )
			DarkRP.notify( v, 0, 6, "You have been awarded $"..( v:Frags() * 200 ).." for getting "..v:Frags().." kills as the facility administrator." )
		end
		if v:Team() != visitor and v:Team() != marine then
			v:addMoney( 1000 )
			DarkRP.notify( v, 0, 6, "You have been awarded $1000 for staying alive in the facility until the end of the round." )
		end
		v:SetDeaths( 0 )
		v:SetFrags( 0 )
		v:Spawn()
		--v:SetPos( table.Random( CASCADE_DEADPOS ) )
		v:changeTeam( visitor, true, true )
		--v:StripWeapons()
		v:ChatPrint( "The round has ended. Pick a new job and get ready for the next round." )
	end
	for k,v in pairs( ents.FindByClass( "extinguisher_case" ) ) do
		v.used = false --Resets all extinguisher cases so they can be used again next round
	end
	UnpressAlarm()
	timer.Remove( "HECULoop" )
	timer.Remove( "MainRoundStart" )
	timer.Remove( "MainLoop" )
	timer.Remove( "MainLoopHalf" )
	SetGlobalInt( "MainRound", 0 )
	SetGlobalInt( "PreRound", 0 )
	RemoveWeapons()
	RemoveObstructions()
	RemoveNPCS()
end

function Cascade()
	if game.GetMap() != "rp_bmrf" then Error( "Cascade will not be loaded. Incorrect map." ) return end
	SetJobs()
	DarkRP.notifyAll( 0, 6, "Teams selected. Starting round in 5 seconds." )
	timer.Simple( 5, function()
		for k,v in pairs( player.GetAll() ) do
			v:ConCommand( "say /setr 42.0" ) --Sets radio channel every round, players will have to manually change it if they want to keep their conversations private
		end
		CascadePreRound()
		SetupWeapons()
		SetupObstructions()
		NetworkMainTimer()
		timer.Create( "HECULoop", 300, 0, function() --Creates timer loop for respawning dead players as HECU
			for k,v in pairs( player.GetAll() ) do
				if v:Team() == visitor and v:Alive() then
					v:changeTeam( marine, true, true )
					v:SetPos( table.Random( CASCADE_HECUPOS ) )
					v:ChatPrint( "You are a HECU Marine. Your objective is to kill anyone who isn't a medic, and ensure medics escape safely." )
					local randomwep = {
						"weapon_shotgun_hl",
						"weapon_9mmar",
						"weapon_sniperrifle",
						"weapon_m249"
					}
					v:Give( table.Random( randomwep ) )
				end
			end
		end	)
		timer.Create( "MainRoundStart", 180, 1, function() CascadeMainRound() end )
		timer.Create( "MainLoop", 1200, 1, function() ResetRound() end )
		timer.Create( "MainLoopHalf", 600, 1, function()
			DarkRP.notifyAll( 0, 8, "10 minute warning, the round is half way over." )
		end )
		PressAlarm()
		LockDoors()
		RunConsoleCommand( "cascadexen" )
	end )
end