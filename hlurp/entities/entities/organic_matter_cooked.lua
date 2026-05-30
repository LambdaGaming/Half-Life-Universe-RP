AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cooked Organic Matter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/props_junk/garbage_takeoutcarton001a.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	if ply:IsPlayer() and ply:Alive() then
		ply:SetHealth( math.Clamp( ply:Health() + 25, 0, 100 ) )
		ply:EmitSound( "npc/barnacle/barnacle_crunch"..math.random( 2, 3 )..".wav" )
		self:Remove()
	end
end
