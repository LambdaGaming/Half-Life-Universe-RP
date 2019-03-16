--Replace "example" with a custom name, entity names will have to be replaced separately.
if SERVER then
timer.Simple(1,
	function()
		if !file.IsDir("autopos", "DATA") then
			file.CreateDir("autopos", "DATA");
		end;
		   
		if !file.IsDir("autopos/ironoutland/"..string.lower(game.GetMap()).."", "DATA") then
			file.CreateDir("autopos/ironoutland/"..string.lower(game.GetMap()).."", "DATA");
		end;
	 
		for k, v in pairs(file.Find("autopos/ironoutland/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
			local PosFile = file.Read("autopos/ironoutland/"..string.lower(game.GetMap()).."/"..v, "DATA");
			 
			local spawnNumber = string.Explode(" ", PosFile);         
				   
			local ironoutland = ents.Create("mgs_iron_rock");
			ironoutland:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]));
			ironoutland:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]));
			ironoutland:Spawn();
			ironoutland:SetMoveType(MOVETYPE_NONE)
			ironoutland:GetPhysicsObject():EnableMotion(false);
		end;
	end
	);
	 
	function spawnironoutlandPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
               
            if !fileName then
                ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Choose a uniqueID for your entity.]] } chat.AddText(unpack(tab))");
                return;
            end;
		
			if file.Exists( "autopos/ironoutland/"..string.lower(game.GetMap()).."/ironoutland_".. fileName ..".txt", "DATA") then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This uniqueID is already in use, choose another one or type 'swm_tree_remove "..fileTreeName.."' in console to remove this one.]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
			local ironoutlandVector = string.Explode(" ", tostring(ply:GetEyeTrace().HitPos));
			local ironoutlandAngles = string.Explode(" ", tostring(ply:GetAngles()+Angle(0, -180, 0)));
					
			local ironoutland = ents.Create("mgs_iron_rock");
			ironoutland:SetPos(ply:GetEyeTrace().HitPos);
			ironoutland:SetAngles(ply:GetAngles()+Angle(0, -180, 0));
			ironoutland:Spawn();
			ironoutland:SetMoveType(MOVETYPE_NONE)
			ironoutland:GetPhysicsObject():EnableMotion(false);
					
			file.Write("autopos/ironoutland/"..string.lower(game.GetMap()).."/ironoutland_".. fileName ..".txt", ""..(ironoutlandVector[1]).." "..(ironoutlandVector[2]).." "..(ironoutlandVector[3]).." "..(ironoutlandAngles[1]).." "..(ironoutlandAngles[2]).." "..(ironoutlandAngles[3]).."", "DATA");
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[New pos for the ironoutland has been set.]] } chat.AddText(unpack(tab))");
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");
		end;
	end;
	concommand.Add("ironoutland_spawn", spawnironoutlandPos);
	 
	function removeironoutlandPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
				   
			if !fileName then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Please enter a name of file!]] } chat.AddText(unpack(tab))");
				return;
			end;
					   
			if file.Exists("autopos/ironoutland/"..string.lower(game.GetMap()).."/ironoutland_"..fileName..".txt", "DATA") then
				file.Delete("autopos/ironoutland/"..string.lower(game.GetMap()).."/ironoutland_"..fileName..".txt");
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This entity has been removed. Restart your server!]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");                       
		end;
	end;
	concommand.Add("ironoutland_remove", removeironoutlandPos);
end