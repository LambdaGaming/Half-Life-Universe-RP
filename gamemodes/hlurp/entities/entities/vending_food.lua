AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vending Machine Food"
ENT.Author = "OPGman"
ENT.Spawnable = false

if SERVER then
	function ENT:Initialize()
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()
		self:SetHealth( 20 )
	end

	function ENT:OnTakeDamage( dmg )
		self:SetHealth( self:Health() - dmg:GetDamage() )
		if self:Health() <= 0 then
			self:Remove()
		end
	end

	function ENT:Use( ply )
		ply:EmitSound( "ambient/levels/canals/toxic_slime_gurgle4.wav", 50 )
		ply:SetHealth( math.Clamp( ply:Health() + math.random( 10, 25 ), 0, 100 ) )
		self:Remove()
	end
end
