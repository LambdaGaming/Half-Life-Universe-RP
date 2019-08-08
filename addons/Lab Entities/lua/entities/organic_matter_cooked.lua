AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cooked Organic Matter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "organic_matter_cooked" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_junk/garbage_takeoutcarton001a.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger(true)
	end
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( activator, caller )
	if activator:IsPlayer() and activator:Alive() then
		activator:SetHealth( math.Clamp( activator:Health() + 25, 0, 100 ) )
		activator:EmitSound( "npc/barnacle/barnacle_crunch"..math.random( 2, 3 )..".wav" )
		self:Remove()
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end