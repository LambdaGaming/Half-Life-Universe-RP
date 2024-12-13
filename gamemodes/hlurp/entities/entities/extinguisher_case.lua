AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Extinguisher Case"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:Initialize()
    self:SetModel( "models/props/bmrf/bmrf_firexcase.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetTrigger( true )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( ply )
	if SERVER then
		if self.used then
			HLU_Notify( ply, "You open the extinguisher case but find nothing inside.", 1, 6 )
			return
		end
		if ply:HasWeapon( "weapon_extinguisher" ) then
			HLU_Notify( ply, "You already have a fire extinguisher!", 1, 6 )
			return
		end
		ply:Give( "weapon_extinguisher" )
		HLU_Notify( ply, "You have obtained a fire extinguisher.", 0, 6 )
		self.used = true
	end
end

function ENT:Touch( ent )
	if SERVER then
		if ent:GetClass() == "weapon_extinguisher" and self.used then
			self.used = false
			ent:Remove()
		end
	end
end
