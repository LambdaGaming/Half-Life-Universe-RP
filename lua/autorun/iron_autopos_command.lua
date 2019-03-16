--Replace "example" with a custom name, entity names will have to be replaced separately.
if SERVER then
timer.Simple(1,
	function()
		if !file.IsDir("autopos", "DATA") then
			file.CreateDir("autopos", "DATA");
		end;
		   
		if !file.IsDir("autopos/iron/"..string.lower(game.GetMap()).."", "DATA") then
			file.CreateDir("autopos/iron/"..string.lower(game.GetMap()).."", "DATA");
		end;
	 
		for k, v in pairs(file.Find("autopos/iron/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
			local PosFile = file.Read("autopos/iron/"..string.lower(game.GetMap()).."/"..v, "DATA");
			 
			local spawnNumber = string.Explode(" ", PosFile);         
				   
			local iron = ents.Create("mgs_rock_hl2");
			iron:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]));
			iron:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]));
			iron:Spawn();
			iron:SetMoveType(MOVETYPE_NONE)
			iron:GetPhysicsObject():EnableMotion(false);
		end;
	end
	);
	 
	function spawnironPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
               
            if !fileName then
                ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Choose a uniqueID for your entity.]] } chat.AddText(unpack(tab))");
                return;
            end;
		
			if file.Exists( "autopos/iron/"..string.lower(game.GetMap()).."/iron_".. fileName ..".txt", "DATA") then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This uniqueID is already in use, choose another one or type 'swm_tree_remove "..fileTreeName.."' in console to remove this one.]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
			local ironVector = string.Explode(" ", tostring(ply:GetEyeTrace().HitPos));
			local ironAngles = string.Explode(" ", tostring(ply:GetAngles()+Angle(0, -180, 0)));
					
			local iron = ents.Create("mgs_rock_hl2");
			iron:SetPos(ply:GetEyeTrace().HitPos);
			iron:SetAngles(ply:GetAngles()+Angle(0, -180, 0));
			iron:Spawn();
			iron:SetMoveType(MOVETYPE_NONE)
			iron:GetPhysicsObject():EnableMotion(false);
					
			file.Write("autopos/iron/"..string.lower(game.GetMap()).."/iron_".. fileName ..".txt", ""..(ironVector[1]).." "..(ironVector[2]).." "..(ironVector[3]).." "..(ironAngles[1]).." "..(ironAngles[2]).." "..(ironAngles[3]).."", "DATA");
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[New pos for the iron has been set.]] } chat.AddText(unpack(tab))");
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");
		end;
	end;
	concommand.Add("iron_spawn", spawnironPos);
	 
	function removeironPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
				   
			if !fileName then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Please enter a name of file!]] } chat.AddText(unpack(tab))");
				return;
			end;
					   
			if file.Exists("autopos/iron/"..string.lower(game.GetMap()).."/iron_"..fileName..".txt", "DATA") then
				file.Delete("autopos/iron/"..string.lower(game.GetMap()).."/iron_"..fileName..".txt");
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This entity has been removed. Restart your server!]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");                       
		end;
	end;
	concommand.Add("iron_remove", removeironPos);
end