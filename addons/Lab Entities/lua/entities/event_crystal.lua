AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Crystal Event"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "event_crystal" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

local models = {
	"models/props/bm/crystalstrappedroom2.mdl",
	"models/props/bm/crystalstrappedroom3.mdl",
	"models/props/bm/crystalstrappedroom4.mdl",
	"models/props/bm/crystalstrappedroom5.mdl",
	"models/props/xenprops/crystal.mdl",
	"models/props/xenprops/crystal1.mdl",
	"models/props/xenprops/crystal2.mdl"
}

function ENT:Initialize()
    self:SetModel( table.Random( models ) )
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

function ENT:Use( caller, activator )
	if caller:Team() != ( TEAM_SURVEYBOSS or TEAM_SURVEY ) then DarkRP.notify( caller, 1, 6, "The crystal appears as if it doesn't belong here. Contacting the survey team would be a good idea." ) return end
	if caller:Team() == ( TEAM_SURVEYBOSS or TEAM_SURVEY ) then DarkRP.notify( caller, 1, 6, "As per protocol, you are required to take this specimen to the portal control room for containment." ) end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end