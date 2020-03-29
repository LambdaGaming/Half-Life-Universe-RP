AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Server Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props/propshl2/supercomputer00.mdl" )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		if SERVER then
			self:PhysicsInit( SOLID_VPHYSICS )
			self:SetUseType( SIMPLE_USE )
		end
	
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use( caller, activator )
		if !computerbroke then
			HLU_Notify( caller, "You check the server stats. Everything looks good.", 1, 6 )
			return
		end
		if caller:Team() != TEAM_TECH and computerbroke then
			HLU_Notify( caller, "The server has overheated. Contact a technician to have it fixed.", 1, 6 )
			return
		end
		if caller:Team() == TEAM_TECH and computerbroke then
			self:EmitSound( "ambient/levels/citadel/zapper_warmup1.wav" )
			computerbroke = false
			HLU_Notify( caller, "You clean out the dust and reboot the system. +500 for the facility budget.", 1, 6 )
			ChangeBudget( 500 )
		end
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end