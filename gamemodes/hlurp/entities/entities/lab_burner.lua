AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bunsen Burner"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/labware/burner.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local phys = self:GetPhysicsObject()
		phys:Wake()

		self:EmitSound( "ambient/fire/mtov_flame2.wav" )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
