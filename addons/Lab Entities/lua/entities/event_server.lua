AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Server Event Fixer"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "event_server" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/propshl2/supercomputer00.mdl" )
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
	if !computerbroke then DarkRP.notify( caller, 1, 6, "You check the server stats. Everything looks good." ) return end
	if caller:Team() != TEAM_TECH and computerbroke then DarkRP.notify( caller, 1, 6, "The server has overheated. Contact a technician to have it fixed." ) return end
	if caller:Team() == TEAM_TECH and computerbroke then
		self:EmitSound( "ambient/levels/citadel/zapper_warmup1.wav" )
		computerbroke = false
		DarkRP.notify( caller, 0, 6, "You clean out the dust and reboot the system. Award: +500" )
		caller:addMoney( 500 )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end