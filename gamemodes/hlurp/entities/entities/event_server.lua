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

function ENT:Use( ply )
	if self.broke then
		if ply:Team() == TEAM_TECH then
			self:EmitSound( "ambient/levels/citadel/zapper_warmup1.wav" )
			FixServer()
			self.broke = false
			ply:Notify( 0, 6, "You clean out the dust and reboot the system. (+500)" )
			ply:AddFunds( 500 )
		else
			ply:Notify( 1, 6, "The server has overheated. Contact a technician to have it fixed." )
		end
	else
		ply:Notify( 0, 6, "You check the server stats. Everything looks good." )
	end
end
