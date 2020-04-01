AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Nuke Key"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props/reqprops/oldconsole.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use( caller, activator )
		HLU_ChatNotifySystem( "Nuke Key", color_black, "Welcome to NukaSys version 42.0. Please place a nuclear device nearby to continue.", true, caller )
		HLU_ChatNotifySystem( "Nuke Key", color_black, "Once a nuclear device is in place, press your use key on the device to activate it.", true, caller )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
