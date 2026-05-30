AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fire Event"
ENT.Author = "OPGman"
ENT.Spawnable = false

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_NONE )
	self:SetRenderMode( RENDERMODE_TRANSCOLOR )
	self:SetColor( color_transparent )
end

function ENT:Think()
	local found = false
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 500 ) ) do
		if string.match( v:GetClass(), "vfire" ) then
			found = true
		end
	end
	if !found then
		ExtinguishFire()
		self:Remove()
	end
	self:NextThink( CurTime() + 1 )
	return true
end
