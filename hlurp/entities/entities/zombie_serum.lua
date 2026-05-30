AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Zombie Serum"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
    self:SetModel( "models/labware/flask2.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor( color_green )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
	self:PhysWake()
end

if SERVER then
	function ENT:Use( ply )
		if ply.IsZombie then
			HLU_Notify( ply, "You are already a zombie!", 1, 6 )
			return
		end
		self:EmitSound( "physics/glass/glass_bottle_break1.wav" )
		ply:MakeZombie()
		self:Remove()
		timer.Simple( 2, function()
			ply:EmitSound( "npc/zombie_poison/pz_alert1.wav" )
		end )
	end
else
	local smokevelocity = Vector( 0, 0, 5 )
	local add = Vector( 0, 0, 9 )
	function ENT:Think()
		local rand = math.random( 1, 9 )
		local pos = self:LocalToWorld( add )
		local smoke = ParticleEmitter( pos ):Add( "particle/smokesprites_000"..rand, pos )
		local dietime = math.Rand( 0.6, 1.3 )
		local startsize = math.random( 0, 1 )
		local endsize = math.random( 2, 5 )
		smoke:SetVelocity( smokevelocity )
		smoke:SetDieTime( dietime )
		smoke:SetStartSize( startsize )
		smoke:SetEndSize( endsize )
		smoke:SetColor( 0, 128, 0 )
	end
end
