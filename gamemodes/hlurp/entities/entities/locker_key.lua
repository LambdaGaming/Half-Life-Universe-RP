AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Combine Science Locker Key"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
    self:SetModel( "models/props_c17/TrapPropeller_Lever.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	HLU_ChatNotifySystem( "City 17 RP", color_theme, "Place this key near a science locker and press your use key on the locker to research something.", true, activator )
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
