--Replace "example" with a custom name, entity names will have to be replaced separately.
if SERVER then
timer.Simple(1,
	function()
		if !file.IsDir("autopos", "DATA") then
			file.CreateDir("autopos", "DATA");
		end;
		   
		if !file.IsDir("autopos/organic/"..string.lower(game.GetMap()).."", "DATA") then
			file.CreateDir("autopos/organic/"..string.lower(game.GetMap()).."", "DATA");
		end;
	 
		for k, v in pairs(file.Find("autopos/organic/"..string.lower(game.GetMap()).."/*.txt", "DATA")) do
			local PosFile = file.Read("autopos/organic/"..string.lower(game.GetMap()).."/"..v, "DATA");
			 
			local spawnNumber = string.Explode(" ", PosFile);         
				   
			local organic = ents.Create("swm_wood_xen");
			organic:SetPos(Vector(spawnNumber[1], spawnNumber[2], spawnNumber[3]));
			organic:SetAngles(Angle(tonumber(spawnNumber[4]), spawnNumber[5], spawnNumber[6]));
			organic:Spawn();
			organic:SetMoveType(MOVETYPE_NONE)
			organic:GetPhysicsObject():EnableMotion(false);
		end;
	end
	);
	 
	function spawnorganicPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
               
            if !fileName then
                ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Choose a uniqueID for your entity.]] } chat.AddText(unpack(tab))");
                return;
            end;
		
			if file.Exists( "autopos/organic/"..string.lower(game.GetMap()).."/organic_".. fileName ..".txt", "DATA") then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This uniqueID is already in use, choose another one or type 'swm_tree_remove "..fileTreeName.."' in console to remove this one.]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
			local organicVector = string.Explode(" ", tostring(ply:GetEyeTrace().HitPos));
			local organicAngles = string.Explode(" ", tostring(ply:GetAngles()+Angle(0, -180, 0)));
					
			local organic = ents.Create("swm_wood_xen");
			organic:SetPos(ply:GetEyeTrace().HitPos);
			organic:SetAngles(ply:GetAngles()+Angle(0, -180, 0));
			organic:Spawn();
			organic:SetMoveType(MOVETYPE_NONE)
			organic:GetPhysicsObject():EnableMotion(false);
					
			file.Write("autopos/organic/"..string.lower(game.GetMap()).."/organic_".. fileName ..".txt", ""..(organicVector[1]).." "..(organicVector[2]).." "..(organicVector[3]).." "..(organicAngles[1]).." "..(organicAngles[2]).." "..(organicAngles[3]).."", "DATA");
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[New pos for the organic has been set.]] } chat.AddText(unpack(tab))");
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");
		end;
	end;
	concommand.Add("organic_spawn", spawnorganicPos);
	 
	function removeorganicPos(ply, cmd, args)
		if (ply:IsAdmin() or ply:IsSuperAdmin()) then
			local fileName = args[1];
				   
			if !fileName then
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Please enter a name of file!]] } chat.AddText(unpack(tab))");
				return;
			end;
					   
			if file.Exists("autopos/organic/"..string.lower(game.GetMap()).."/organic_"..fileName..".txt", "DATA") then
				file.Delete("autopos/organic/"..string.lower(game.GetMap()).."/organic_"..fileName..".txt");
				ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[This entity has been removed. Restart your server!]] } chat.AddText(unpack(tab))");
				return;
			end;
				   
		else
			ply:SendLua("local tab = {Color(0,255,0,255), [[AutoPos - ]], Color(255,255,255), [[Only admins and superadmins can perform this action.]] } chat.AddText(unpack(tab))");                       
		end;
	end;
	concommand.Add("organic_remove", removeorganicPos);
end