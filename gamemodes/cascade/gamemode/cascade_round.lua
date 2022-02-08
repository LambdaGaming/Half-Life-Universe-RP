
local scientist = TEAM_SCIENTIST.ID
local admin = TEAM_ADMIN.ID
local visitor = TEAM_VISITOR.ID
local medic = TEAM_MEDIC.ID
local marine = TEAM_MARINE.ID
local security = TEAM_SECURITY.ID
local vort = TEAM_VORT.ID
local zombie = TEAM_ZOMBIE.ID

function SetJobs() --Randomly selects jobs based on how many players there are, credit goes to the creator of Breach
	local ply = player.GetAll()
	local plycount = player.GetCount()
	if plycount <= 2 then
		for k,v in ipairs( ply ) do
			v:ChatPrint( "BMRP:Cascade is intended to be used with 3 or more players. Errors may occur with 2 or less." )
		end
	end
	if plycount <= 3 then
		local adminply = table.Random( ply )
		ChangeTeam( adminply, TEAM_ADMIN, false )
		table.RemoveByValue( ply, adminply )
		local rndplayer = table.Random( ply )
		table.RemoveByValue( ply, rndplayer )
		ChangeTeam( rndplayer, TEAM_SCIENTIST, false )
		local rndplayer = table.Random( ply )
		table.RemoveByValue( ply, rndplayer )
		ChangeTeam( rndplayer, TEAM_SECURITY, false )
		return
	end
	if plycount > 3 and plycount < 5 then
		local adminply = table.Random( ply )
		ChangeTeam( adminply, TEAM_ADMIN, false )
		table.RemoveByValue( ply, adminply )
		for i=1, math.Round( #ply / 3 ) do
			local rndplayer = table.Random( ply )
			table.RemoveByValue( ply, rndplayer )
			ChangeTeam( rndplayer, TEAM_SECURITY, false )
		end
		for i=1, math.Round( #ply / 2 ) do
			local rndplayer = table.Random( ply )
			table.RemoveByValue( ply, rndplayer )
			ChangeTeam( rndplayer, TEAM_MEDIC, false )
		end
		for k,v in pairs( ply ) do
			ChangeTeam( v, TEAM_SCIENTIST, false )
		end
		return
	end
	if plycount >= 5 then
		local adminply = table.Random( ply )
		table.RemoveByValue( ply, adminply )
		local adminply2 = table.Random( ply )
		table.RemoveByValue( ply, adminply2 )
		ChangeTeam( adminply, TEAM_ADMIN, false )
		local mtrnd = math.random( 1,2 )
		if mtrnd == 1 then
			ChangeTeam( adminply2, TEAM_ADMIN, false )
		elseif mtrnd == 2 then
			ChangeTeam( adminply2, TEAM_VORT, false )
		end
		for i=1, math.Round( #ply / 4 ) do
			local rndplayer = table.Random(ply)
			table.RemoveByValue(ply, rndplayer)
			ChangeTeam( rndplayer, TEAM_SECURITY, false )
		end
		for i=1, math.Round( #ply / 2 ) do
			local rndplayer = table.Random(ply)
			table.RemoveByValue(ply, rndplayer)
			ChangeTeam( rndplayer, TEAM_MEDIC, false )
		end
		for k,v in pairs(ply) do
			ChangeTeam( v, TEAM_SCIENTIST, false )
		end
	end
end

function SpawnMonsters()
	for k,v in ipairs( MONSTER_POS ) do
		local e = ents.Create( table.Random( CASCADE_MONSTERS ) )
		e:SetPos( v )
		e:Spawn()
	end
end

function TelePlayers()
	for k,v in ipairs( player.GetAll() ) do
		v:SetPos( table.Random( CASCADE_DEADPOS ) )
		v:ChatPrint( "Teleported all players to the starting room." )
	end
end

function LockDoors()
	local allowed = {
		["prop_door"] = true,
		["prop_door_rotating"] = true,
		["func_door"] = true,
		["func_door_rotating"] = true
	}
	local allowednums = {
		[2] = true,
		[3] = true,
		[4] = true,
		[5] = true
	}
	for k,v in pairs( ents.FindByClass( "prop_*" ) ) do
		if allowed[v:GetClass()] then
			v:Fire( "Close" )
			if allowednums[DoorTable[v:EntIndex()]] then
				v:Fire( "lock", "", 0 )
			end
		end
	end
	for k,v in pairs( ents.FindByClass( "func_*" ) ) do
		if allowed[v:GetClass()] then
			v:Fire( "Close" )
			if allowednums[DoorTable[v:EntIndex()]] then
				v:Fire( "lock", "", 0 )
			end
		end
	end
end

function SetupWeapons()
	for k,v in ipairs( CASCADE_PRIMARYPOS ) do
		spawnprimary = ents.Create( table.Random( CASCADE_PRIMARYCLASS ) )
		spawnprimary:SetPos( v + Vector( 0, 0, 5 ) )
		spawnprimary:Spawn()
	end
	
	for k,v in ipairs( CASCADE_SECONDARYPOS ) do
		spawnsecondary = ents.Create( table.Random( CASCADE_SECONDARYCLASS ) )
		spawnsecondary:SetPos( v + Vector( 0, 0, 5 ) )
		spawnsecondary:Spawn()
	end
	
	for i=1, 3 do --Limits special weapon spawn to 3
		spawnspecial = ents.Create( table.Random( CASCADE_SPECIALCLASS ) )
		spawnspecial:SetPos( table.Random( CASCADE_SPECIALPOS ) + Vector( 0, 0, 5 ) )
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
	
	for k,v in ipairs( CASCADE_ARMORPOS ) do
		spawnarmor = ents.Create( "item_battery" ) --And armor batteries
		spawnarmor:SetPos( v )
		spawnarmor:Spawn()
	end
end

function RemoveWeapons() --Removes weapons after the round ends
	for k,v in pairs( ents.GetAll() ) do
		local otherents = {
			["tram_controller"] = true,
			["cascade_escape"] = true,
			["item_battery"] = true
		}
		if otherents[v:GetClass()] then
			v:Remove()
		end
	end
	for k,v in pairs( ents.FindByClass( "weapon_*" ) ) do
		v:Remove()
	end
end

function RemoveNPCS()
	for k,v in pairs( ents.FindByClass( "monster_*" ) ) do
		v:Remove()
	end
	for k,v in pairs( ents.FindByClass( "npc_*" ) ) do
		v:Remove()
	end
end

function SetupObstructions() --Spawns random obstructions that force players to take alternate paths
	local function FireBlock() --If all of the fires are put out, the obstruction will clear
		local randomfire = math.random( 1, 3 )
		if randomfire == 1 then
			for k,v in ipairs( CASCADE_FIREBLOCK1 ) do
				CreateVFireBall( 1200, 10, v + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
			end
			for k,v in ipairs( CASCADE_FIREWALLPOS1 ) do
				timer.Simple( 0.5, function()
					blockfirewall = ents.Create( "fire_wall" )
					blockfirewall:SetPos( v[1] )
					blockfirewall:SetAngles( v[2] )
					blockfirewall:Spawn()
				end )
			end
		elseif randomfire == 2 then
			for k,v in ipairs( CASCADE_FIREBLOCK2 ) do
				CreateVFireBall( 1200, 10, v + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
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
			for k,v in ipairs( CASCADE_FIREBLOCK3 ) do
				CreateVFireBall( 1200, 10, v + Vector( 0, 0, 50 ), Vector( 0, 0, 0 ), nil )
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

function RemoveObstructions() --Removes obstructions after the round ends
	RunConsoleCommand( "vfire_remove_all" )
	if IsValid(blockfirewall) then blockfirewall:Remove() end
	rubblespawn:Remove()
end

function PressAlarm() --Turns on alarms, disables the trams, and closes the fire doors (sometimes this doesnt work?)
	for k,v in pairs( ents.FindByClass( "func_button" ) ) do
		if v:EntIndex() == 1153 then
			v:Fire( "Press" )
		elseif v:EntIndex() == 1151 then
			v:Fire( "Press" )
		elseif v:EntIndex() == 1272 then
			v:Fire( "Press" )
		end
	end
end

function UnpressAlarm() --Turns off the alarm, starts up the trams, and lifts the fire doors
	for k,v in pairs( ents.FindByClass( "func_button" ) ) do
		if v:EntIndex() == 1153 then
			v:Fire( "Press" )
		elseif v:EntIndex() == 1151 then
			v:Fire( "PressOut" ) --Using PressOut here incase the trams were re-activated during the round
		elseif v:EntIndex() == 1272 then
			v:Fire( "Press" )
		end
	end
end

local function ResetDoors()
	local allowed = {
		["prop_door"] = true,
		["prop_door_rotating"] = true,
		["func_door"] = true,
		["func_door_rotating"] = true
	}
	for k,v in pairs( ents.FindByClass( "prop_*" ) ) do
		if allowed[v:GetClass()] then
			v:Fire( "Close" )
			v:Fire( "unlock", "", 0 )
			v:SetNWEntity( "DoorOwner", NULL )
		end
	end
	for k,v in pairs( ents.FindByClass( "func_*" ) ) do
		if allowed[v:GetClass()] then
			v:Fire( "Close" )
			v:Fire( "unlock", "", 0 )
			v:SetNWEntity( "DoorOwner", NULL )
		end
	end
end

function CascadePreRound()
	timer.Simple( 3, function()
		for k,v in ipairs( player.GetAll() ) do
			if v:Team() == scientist then
				v:SetPos( table.Random( CASCADE_SCIENTISTSPAWN ) ) --Scientists will first be spawned in a random science lab
				v:ChatPrint( "You are a scientist. Your objective is to work with security to escape, and to build/invent machines to survive." )
			end
			v:ChatPrint( "The pre-round has started. Scientists have been released." )
		end
		SetGlobalBool( "PreRound", true )
	end )
end

function CascadeMainRound()
	SetGlobalBool( "PreRound", false )
	SetGlobalBool( "MainRound", true )
	for k,v in ipairs( player.GetAll() ) do --Spawns the rest of the players after the pre-round is over
		if v:Team() == admin then
			v:SetPos( table.Random( CASCADE_ADMINPOS ) )
			v:ChatPrint( "You are a facility administrator. Your objective is to kill all non-military personnel on sight and prevent them from escaping." )
		elseif v:Team() == security then
			v:SetPos( table.Random( CASCADE_SECURITYPOS ) )
			v:ChatPrint( "You are a security officer. Your objective is to work with scientists to escape." )
		elseif v:Team() == medic then
			v:SetPos( table.Random( CASCADE_MEDICPOS ) )
			v:ChatPrint( "You are a medic. Your objective is to avoid being captured by scientists and/or security, and to work with HECU to escape." )
		elseif v:Team() == vort then
			v:SetPos( table.Random( CASCADE_VORTPOS ) )
			v:ChatPrint( "You are a vortigaunt who has been freed from slavery. Your objective is to protect humans from invading Xen aliens." )
		elseif v:Team() == visitor then
			v:SetPos( table.Random( CASCADE_DEADPOS ) )
			v:ChatPrint( "You are still a visitor because you spawned in after jobs were selected. You will respawn as HECU in "..string.ToMinutesSeconds( timer.TimeLeft( "HECULoop" ) ) )
		end
	end
end

function ResetRound() --Places everyone in the waiting room, resets everyone's scores, and removes the HECU timer
	local WinnerTable = {}
	for k,v in ipairs( player.GetAll() ) do
		if v:Team() == admin then
			local amount = v:Frags() * 200
			v:ChatPrint( "You have been awarded $"..amount.." for getting "..v:Frags().." kills as the facility administrator." )
			WinnerTable[v:SteamID()] = amount
		elseif v:Team() != visitor and v:Team() != marine then
			v:ChatPrint( "You have been awarded $1000 for staying alive in the facility until the end of the round." )
			WinnerTable[v:SteamID()] = 1000
		elseif v:Team() == marine and v.EscortBonus then
			WinnerTable[v:SteamID()] = 600 * v.EscortBonus
			v.EscortBonus = 0
		end
		v:SetDeaths( 0 )
		v:SetFrags( 0 )
		ChangeTeam( v, TEAM_VISITOR, true )
		v:ChatPrint( "The round has ended." )
	end
	file.Write( "CascadeWinners_"..os.clock()..".txt", util.TableToJSON( WinnerTable, true ) )
	for k,v in pairs( ents.FindByClass( "extinguisher_case" ) ) do
		v.used = false --Resets all extinguisher cases so they can be used again next round
	end
	UnpressAlarm()
	timer.Remove( "HECULoop" )
	timer.Remove( "MainRoundStart" )
	timer.Remove( "MainLoop" )
	timer.Remove( "MainLoopHalf" )
	SetGlobalBool( "MainRound", false )
	SetGlobalBool( "PreRound", false )
	RemoveWeapons()
	RemoveObstructions()
	RemoveNPCS()
	ResetDoors()
	RemoveClientTimers()
end

function Cascade()
	if game.GetMap() != "rp_bmrf" then Error( "Cascade will not be loaded. Incorrect map." ) return end
	SetJobs()
	for k,v in ipairs( player.GetAll() ) do
		v:ChatPrint( "Teams selected. Starting round in 5 seconds." )
	end
	timer.Simple( 5, function()
		local fastmode = GetGlobalBool( "FastMode" )
		for k,v in ipairs( player.GetAll() ) do
			v:ConCommand( "say /setr 42.0" ) --Sets radio channel every round, players will have to manually change it if they want to keep their conversations private
		end
		CascadePreRound()
		SetupWeapons()
		SetupObstructions()
		local hecutimer = 0
		if fastmode then
			hecutimer = 150
		else
			hecutimer = 300
		end
		timer.Create( "HECULoop", hecutimer, 0, function() --Creates timer loop for respawning dead players as HECU
			for k,v in ipairs( player.GetAll() ) do
				if v:Team() == visitor and v:Alive() then
					ChangeTeam( v, TEAM_MARINE, false )
					v:SetPos( table.Random( CASCADE_HECUPOS ) )
					v:ChatPrint( "You are a HECU Marine. Your objective is to kill anyone who isn't a medic, and ensure medics escape safely." )
				end
				SyncCascadeTimers( v )
			end
		end	)
		if fastmode then
			timer.Create( "MainRoundStart", 90, 1, function() CascadeMainRound() end )
			timer.Create( "MainLoop", 600, 1, function() ResetRound() end )
			timer.Create( "MainLoopHalf", 300, 1, function()
				for k,v in ipairs( player.GetAll() ) do
					v:ChatPrint( "10 minute warning, the round is half way over." )
				end
			end )
		else
			timer.Create( "MainRoundStart", 180, 1, function() CascadeMainRound() end )
			timer.Create( "MainLoop", 1200, 1, function() ResetRound() end )
			timer.Create( "MainLoopHalf", 600, 1, function()
				for k,v in ipairs( player.GetAll() ) do
					v:ChatPrint( "5 minute warning, the round is half way over." )
				end
			end )
		end
		PressAlarm()
		LockDoors()
		SpawnMonsters()
		for k,v in ipairs( player.GetAll() ) do
			SyncCascadeTimers( v )
		end
	end )
end