AddCSLuaFile()

ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "Revive Event NPC"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "event_revive" )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

local randommodel = {
	"models/Humans/Group01/Male_01.mdl",
	"models/Humans/Group01/Male_02.mdl",
	"models/Humans/Group01/Male_03.mdl",
	"models/Humans/Group01/Male_04.mdl",
	"models/Humans/Group01/Male_05.mdl",
	"models/Humans/Group01/Male_06.mdl",
	"models/Humans/Group01/Male_07.mdl",
	"models/Humans/Group01/Male_08.mdl"
}

function ENT:Initialize()
    self:SetModel( table.Random( randommodel ) )
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.revive = false
	
	timer.Create( "revivemoan", 10, 0, function()
		if self:IsValid() and !self.revive then
			self:EmitSound( "vo/npc/male01/moan0"..math.random( 1, 5 )..".wav" )
		end
	end )
end

function ENT:AcceptInput( ply, caller )
	if self.revive then return end
	if caller:Team() != TEAM_MEDICBM then DarkRP.notify( caller, 0, 6, "You check for a pulse but can't seem to find one. A medic has the tools to help this person." ) return end
	if caller:Team() == TEAM_MEDICBM then DarkRP.notify( caller, 0, 6, "You check for a pulse but can't seem to find one. You may have to use your med kit to revive this person." ) end
end

function ENT:Think()
	if !self.revive then
		self:SetSequence( ACT_VICTORY_DANCE )
	end
	if self.revive then
		self:SetSequence( ACT_IDLE )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end