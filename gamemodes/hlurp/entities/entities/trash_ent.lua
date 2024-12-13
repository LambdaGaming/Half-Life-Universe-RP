AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Trash"
ENT.Author = "Lambda Gaming"
ENT.Category = "Superadmin Only"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_junk/TrashBin01a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use( activator, caller )
		HLU_Notify( activator, "Place this near a trash compactor to dispose of it.", 0, 6 )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
