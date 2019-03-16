--Replace "example" with a custom name, entity names will have to be replaced separately.
if SERVER then
timer.Simple(1,
	function()
		if !file.IsDir("autopos", "DATA") then
			file.CreateDir("autopos", "DATA");
		end;
		   
		if !file.IsDir("autopos/crystal/"..string.lower(game.GetMap()).."", "DATA") then
			file.CreateDir("autopos/crystal/"..string.lower(game.GetMap()).."", "DATA");
		end;
	 
		for k, v in pairs(file.Find("autopos/crystal/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
			local PosFile = file.Read("autopos/crystal/"..string.lower(game.GetMap()).."/"..v, "DATA");
			 
			local spawnNumber = string.Explode(" ", PosFile);         
				   
			local crystal = ents.Create("mgs_crystal");
			crystal:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]));
			crystal:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]));
			crystal:Spawn();
			crystal:SetMoveType(MOVETYPE_NONE)
			crystal:GetPhysicsObject():EnableMotion(false);
		end;
	end
	);
	 
	function spawncrystalPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
               
            if !fileName then
                ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Choose a uniqueID for your entity.]] } chat.AddText(unpack(tab))");
                return;
            end;
		
			if file.Exists( "autopos/crystal/"..string.lower(game.GetMap()).."/crystal_".. fileName ..".txt", "DATA") then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This uniqueID is already in use, choose another one or type 'swm_tree_remove "..fileTreeName.."' in console to remove this one.]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
			local crystalVector = string.Explode(" ", tostring(ply:GetEyeTrace().HitPos));
			local crystalAngles = string.Explode(" ", tostring(ply:GetAngles()+Angle(0, -180, 0)));
					
			local crystal = ents.Create("mgs_crystal");
			crystal:SetPos(ply:GetEyeTrace().HitPos);
			crystal:SetAngles(ply:GetAngles()+Angle(0, -180, 0));
			crystal:Spawn();
			crystal:SetMoveType(MOVETYPE_NONE)
			crystal:GetPhysicsObject():EnableMotion(false);
					
			file.Write("autopos/crystal/"..string.lower(game.GetMap()).."/crystal_".. fileName ..".txt", ""..(crystalVector[1]).." "..(crystalVector[2]).." "..(crystalVector[3]).." "..(crystalAngles[1]).." "..(crystalAngles[2]).." "..(crystalAngles[3]).."", "DATA");
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[New pos for the crystal has been set.]] } chat.AddText(unpack(tab))");
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");
		end;
	end;
	concommand.Add("crystal_spawn", spawncrystalPos);
	 
	function removecrystalPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
				   
			if !fileName then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Please enter a name of file!]] } chat.AddText(unpack(tab))");
				return;
			end;
					   
			if file.Exists("autopos/crystal/"..string.lower(game.GetMap()).."/crystal_"..fileName..".txt", "DATA") then
				file.Delete("autopos/crystal/"..string.lower(game.GetMap()).."/crystal_"..fileName..".txt");
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This entity has been removed. Restart your server!]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");                       
		end;
	end;
	concommand.Add("crystal_remove", removecrystalPos);
end