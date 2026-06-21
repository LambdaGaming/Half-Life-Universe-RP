AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Radioactive Xen Iron"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/Items/CrossbowRounds.mdl" )
	self:SetColor( Color( 0, 255, 0, 255 ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self.IsTicking = false
end

local nextGeiger = 0
local nextHurt = 0
local nextRad = 0
local immune = {
	[TEAM_BIO] = true,
	[TEAM_SURVEYBOSS] = true,
	[TEAM_SURVEY] = true
}
function ENT:Think()
	if self.IsTicking and nextGeiger < CurTime() then
		self:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
		nextGeiger = nextGeiger + math.random( 1, 3 )
	end
	if nextRad < CurTime() then
		local ed = EffectData()
		ed:SetOrigin( self:GetPos() + self:GetUp() * math.random( 10, 25 ) )
		ed:SetNormal( VectorRand() )
		ed:SetMagnitude( 1 )
		ed:SetScale( 1 )
		ed:SetRadius( 1 )
		util.Effect( "VortDispel", ed, true, true )
		nextRad = CurTime() + math.random( 1, 8 )
	end
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:IsPlayer() and nextHurt < CurTime() and !immune[v:Team()] then
			v:TakeDamage( 5 )
			v:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
			nextHurt = CurTime() + 3
		end
	end
	self:NextThink( CurTime() + 0.5 )
	return true
end
