AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Extinguisher Case"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( "extinguisher_case" )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/bmrf/bmrf_firexcase.mdl" )
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
	
	self.used = false
end

function ENT:Use( caller, activator )
	if SERVER then
		if self.used then
			caller:ChatPrint( "You open the extinguisher case but find nothing inside." )
			return
		end
		if caller:HasWeapon( "weapon_extinguisher" ) then
			caller:ChatPrint( "You already have a fire extinguisher!" )
			return
		end
		caller:Give( "weapon_extinguisher" )
		caller:ChatPrint( "You have collected a fire extinguisher." )
	end
	self.used = true
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end