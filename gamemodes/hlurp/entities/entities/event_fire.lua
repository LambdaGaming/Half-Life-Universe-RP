AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Fire Event"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/hunter/misc/sphere025x025.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetColor( color_transparent )
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Think()
	local found = false
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if string.match( v:GetClass(), "vfire" ) or v:GetClass() == "entityflame" then
			found = true
		end
	end
	if !found then
		ExtinguishFire()
		self:Remove()
	end
	self:NextThink( CurTime() + 1 )
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end