
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
		for k,v in pairs( ply ) do
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
	for k,v in pairs( player.GetAll() ) do
		v:SetPos( table.Random( CASCADE_DEADPOS ) )
		v:ChatPrint( "Teleported all players to the starting room." )
	end
end

function LockDoors() --Might need changed since we don't have ownable doors anymore
	--[[ local lockabledoors = { 1968, 619, 620, 2091, 621, 622, 1933, 1657, 1656, 1737, 669, 659, 660, 148, 147, 1748, 1750, 1751, 1047, 1050, 1046, 1052, 55, 56, 65, 125, 124, 253, 213, 214, 1253, 71, 1252, 70,
	1199, 1192, 2055, 2059, 103, 131, 876, 875, 826, 827, 2174, 2175, 1756, 1755, 1757, 1614, 1596, 2065, 2093, 1627, 1526, 1626, 114, 1309, 98, 226, 1324, 1326 }
	for k,v in pairs( ents.GetAll() ) do
		if table.HasValue( lockabledoors, v:EntIndex() ) then
			v:Fire( "Close" )
			v:Fire( "Lock" )
		end
	end ]]
	for k,v in pairs( ents.FindByClass( "prop_door*" ) ) do
		v:Fire( "Close" )
	end
	for k,v in pairs( ents.FindByClass( "func_door*" ) ) do
		v:Fire( "Close" )
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
	for p,l in pairs( ents.FindByClass( "func_button" ) ) do
		if l:EntIndex() == 1153 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1151 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1272 then
			l:Fire( "Press" )
		end
	end
end

function UnpressAlarm() --Turns off the alarm, starts up the trams, and lifts the fire doors
	for p,l in pairs( ents.FindByClass( "func_button" ) ) do
		if l:EntIndex() == 1153 then
			l:Fire( "Press" )
		end
		if l:EntIndex() == 1151 then
			l:Fire( "PressOut" ) --Using PressOut here incase the trams were re-activated during the round
		end
		if l:EntIndex() == 1272 then
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
	SetGlobalBool( "PreRound", true )
end

function CascadeMainRound()
	SetGlobalBool( "PreRound", false )
	SetGlobalBool( "MainRound", true )
	for k,v in pairs( player.GetAll() ) do --Spawns the rest of the players after the pre-round is over
		if v:Team() == admin then
			v:SetPos( table.Random( CASCADE_ADMINPOS ) )
			v:ChatPrint( "You are a facility administrator. Your objective is to kill all non-military personnel on sight and prevent them from escaping." )
		end
		if v:Team() == security then
			v:SetPos( table.Random( CASCADE_SECURITYPOS ) )
			v:ChatPrint( "You are a security officer. Your objective is to work with scientists to escape." )
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
			v:ChatPrint( "You are still a visitor because you spawned in after jobs were selected. You will respawn as HECU in "..string.ToMinutesSeconds( timer.TimeLeft( "HECULoop" ) ) )
		end
	end
end

function ResetRound() --Places everyone in the waiting room, resets everyone's scores, and removes the HECU timer
	for k,v in pairs( player.GetAll() ) do
		--[[ if v:Team() == admin then --Disabled for now, might use MySQL at some point to tap into the player's DarkRP wallet
			v:addMoney( v:Frags() * 200 )
			v:ChatPrint( "You have been awarded $"..( v:Frags() * 200 ).." for getting "..v:Frags().." kills as the facility administrator." )
		end
		if v:Team() != visitor and v:Team() != marine then
			v:addMoney( 1000 )
			v:ChatPrint( "You have been awarded $1000 for staying alive in the facility until the end of the round." )
		end ]]
		v:SetDeaths( 0 )
		v:SetFrags( 0 )
		ChangeTeam( v, TEAM_VISITOR, true )
		v:ChatPrint( "The round has ended." )
	end
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
end

function Cascade()
	if game.GetMap() != "rp_bmrf" then Error( "Cascade will not be loaded. Incorrect map." ) return end
	SetJobs()
	for k,v in pairs( player.GetAll() ) do
		v:ChatPrint( "Teams selected. Starting round in 5 seconds." )
	end
	timer.Simple( 5, function()
		local fastmode = GetGlobalBool( "FastMode" )
		for k,v in pairs( player.GetAll() ) do
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
			for k,v in pairs( player.GetAll() ) do
				if v:Team() == visitor and v:Alive() then
					ChangeTeam( v, TEAM_MARINE, false )
					v:SetPos( table.Random( CASCADE_HECUPOS ) )
					v:ChatPrint( "You are a HECU Marine. Your objective is to kill anyone who isn't a medic, and ensure medics escape safely." )
				end
			end
		end	)
		if fastmode then
			timer.Create( "MainRoundStart", 90, 1, function() CascadeMainRound() end )
			timer.Create( "MainLoop", 600, 1, function() ResetRound() end )
			timer.Create( "MainLoopHalf", 300, 1, function()
				for k,v in pairs( player.GetAll() ) do
					v:ChatPrint( "10 minute warning, the round is half way over." )
				end
			end )
		else
			timer.Create( "MainRoundStart", 180, 1, function() CascadeMainRound() end )
			timer.Create( "MainLoop", 1200, 1, function() ResetRound() end )
			timer.Create( "MainLoopHalf", 600, 1, function()
				for k,v in pairs( player.GetAll() ) do
					v:ChatPrint( "5 minute warning, the round is half way over." )
				end
			end )
		end
		PressAlarm()
		LockDoors()
		SpawnMonsters()
	end )
end