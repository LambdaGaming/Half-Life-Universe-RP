AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Server Event Fixer"
ENT.Author = "OPGman"
ENT.Spawnable = false

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props/propshl2/supercomputer00.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self.broke = false
end

function ENT:Use( caller, activator )
	if self.broke then
		if caller:Team() == TEAM_TECH then
			self:EmitSound( "ambient/levels/citadel/zapper_warmup1.wav" )
			FixServer()
			self.broke = false
			HLU_Notify( caller, "You clean out the dust and reboot the system. (+500)", 1, 6 )
			caller:AddFunds( 500 )
		else
			HLU_Notify( caller, "The server has overheated. Contact a technician to have it fixed.", 1, 6 )
		end
	else
		HLU_Notify( caller, "You check the server stats. Everything looks good.", 1, 6 )
	end
end
