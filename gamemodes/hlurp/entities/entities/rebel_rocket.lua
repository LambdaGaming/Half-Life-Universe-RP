AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Rocket"
ENT.Author = "OPGman"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props_silo/rocket_low.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self.Launching = false
	self.Deployed = false
	self.Power = 50
end

function ENT:Use( ply )
	if ply:IsSuperAdmin() then
		self:Launch()
	end
end

function ENT:PhysicsCollide( data, phys )
	if !self.Launching or self.Deployed then return end
	DeployRocket()
	self.Deployed = true
	self:Remove()
end

function ENT:Think()
	if !self.Launching or self.Deployed then return end
	self.Power = self.Power + math.log( self.Power )
	local phys = self:GetPhysicsObject()
	phys:EnableMotion( true )
	phys:AddVelocity( self:GetUp() * self.Power * 2 )
	ParticleEffectAttach( "generic_smoke", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
end

function ENT:Launch()
	BroadcastSound( "ambient/levels/launch/rockettakeoffblast.wav" )
	util.ScreenShake( self:GetPos(), 100, 40, 10, 20000, true )
	self.Launching = true
end
