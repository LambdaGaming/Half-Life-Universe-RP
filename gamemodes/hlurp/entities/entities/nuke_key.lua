ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Nuke Key"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

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
	HLU_ChatNotify( caller, "Nuke Key", color_black, "Welcome to NukaSys version 42.0. Please place a nuclear device nearby to continue." )
	HLU_ChatNotify( caller, "Nuke Key", color_black, "Once a nuclear device is in place, press your use key on the device to activate it." )
end

function ENT:Draw()
	self:DrawModel()
end