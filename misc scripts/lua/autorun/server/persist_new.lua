hook.Add( "PlayerSay", "playersaypersist", function( ply, text, public )
	local entnum = string.Explode( " ", text )
	local tbl = {}
	if entnum[1] == "!save" and ply:IsSuperAdmin() then
		local tr = ply:GetEyeTrace().Entity
		local name = tr:GetClass()
		
		if !entnum[2] then ply:ChatPrint( "Please add an identifier as an argument." ) return end
		if !IsValid( tr ) then ply:ChatPrint( "Save aborted. This entity doesn't exist according to the server." ) return end
		if tr:CreatedByMap() then ply:ChatPrint( "Save aborted. Cannot save entities created by the world." ) return end
		if tr:IsWorld() or tr:IsPlayer() then ply:ChatPrint( "Save aborted. Cannot save world or players." ) return end

		local path = "newpersist/"..game.GetMap().."/"..name.."-"..entnum[2]..".txt"
		tbl = { tr:GetPos(), tr:GetAngles(), tr:GetModel(), tr:GetMaterial() }
		file.CreateDir( "newpersist/"..game.GetMap() )
		file.Write( path, util.TableToJSON( tbl ) )
		ply:ChatPrint( [[Entity "]]..name..[[" saved successfully.]] )
		return ""
	end
end )

hook.Add( "InitPostEntity", "LoadNewPersist", function()
	local findpath = "newpersist/"..game.GetMap().."/*.txt"
	local files, directories = file.Find( findpath, "DATA" )
	for k,v in pairs( files ) do
		local path = "newpersist/"..game.GetMap().."/"..v
		local readtxt = file.Read( path, "DATA" )
		local readunpack = util.JSONToTable( readtxt )
		local split = string.Explode( "-", v )
		local e = ents.Create( split[1] )
		e:SetPos( readunpack[1] )
		e:SetAngles( readunpack[2] )
		e:SetModel( readunpack[3] )
		e:SetMaterial( readunpack[4] )
		e:Spawn()
		e:Activate()
		e:SetMoveType( MOVETYPE_NONE )
		e.IsPermaProp = true
	end
	MsgC( color_red, "\n[HLU RP] Loaded perma props.\n" )
end )
