AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Door Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/hazardous/generator.mdl" )
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

	self.broke = false
end

function ENT:Use( caller, activator )
	if !self.broke then
		HLU_Notify( caller, "You listen to the generator. It sounds like it's running normally.", 0, 6 )
		return
	end
	if caller:Team() != TEAM_SERVICE and self.broke then
		HLU_Notify( caller, "The generator has stalled. Contact a service official to have it fixed.", 1, 6 )
		return
	end
	if caller:Team() == TEAM_SERVICE and self.broke then
		self:EmitSound( "vehicles/Airboat/fan_motor_start1.wav" )
		DoorFix()
		self.broke = false
		HLU_Notify( caller, "You pull the cord and the generator starts right up. Award: +200", 0, 6 )
		ChangeBudget( 200 )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end