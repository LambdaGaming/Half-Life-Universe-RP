AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Outland Computer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "out_computer" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

local rebeljobs = {
	TEAM_REBEL,
	TEAM_REBELMEDIC,
	TEAM_RESISTANCELEADER
}

function ENT:Initialize()
    self:SetModel( "models/props_lab/workspace002.mdl" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(caller, activator)
	if self.hascodes == nil then DarkRP.notify( caller, 1, 6, "You searched the database but found nothing of use." ) return end
	if self.hascodes and table.HasValue( rebeljobs, caller:Team() ) then
		DarkRP.notifyAll( 0, 6, "The codes for the combine portal were found inside a computer database! "..caller:Nick().." now has them!" )
		self.hascodes = nil
		caller.hascodes = true
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end