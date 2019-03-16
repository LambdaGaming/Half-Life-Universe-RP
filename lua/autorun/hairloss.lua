
hook.Add( "InitPostEntity", "hairloss", function()
	if SERVER then
		if game.GetMap() != "rp_sectorc_beta" then return end
		for k,v in pairs( ents.GetAll() ) do
			if v:GetModel() == "models/hair.mdl" or v:GetModel() == "models/fungus.mdl" or v:GetModel() == "models/fungus(small).mdl" then
				v:Remove()
			end
		end
	end
end )