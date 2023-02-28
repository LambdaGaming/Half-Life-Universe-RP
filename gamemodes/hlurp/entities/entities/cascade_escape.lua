AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cascade Escape Truck"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:Initialize()
    self:SetModel( "models/decay/vehicles/truck_research.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

if SERVER then
	function ENT:Use( ply )
		if ply:GetJobCategory() == "Military" then
			HLU_Notify( ply, "Lead Black Mesa staff to this truck to recruit them into the HECU.", 0, 6 )
			return
		end
		if team.NumPlayers( TEAM_MARINEBOSS ) == 0 then
			ChangeTeam( ply, TEAM_MARINEBOSS, false, true )
			HLU_Notify( ply, "You have successfully escaped the facility! You are now the HECU Captain.", 0, 6 )
			return
		end
		ChangeTeam( ply, TEAM_MARINE, false, true )
		HLU_Notify( ply, "You have successfully escaped the facility! You are now an HECU Marine.", 0, 6 )
	end
end
