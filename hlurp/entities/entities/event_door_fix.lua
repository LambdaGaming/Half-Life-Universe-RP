AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Tram Event Fixer"
ENT.Author = "OPGman"
ENT.Spawnable = false

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props/hazardous/generator.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self.broke = false
end

function ENT:Use( ply )
	if self.broke then
		if ply:Team() == TEAM_SERVICE then
			self:EmitSound( "vehicles/Airboat/fan_motor_start1.wav" )
			TramFix()
			self.broke = false
			ply:Notify( 0, 6, "You pull the cord and the generator starts right up. (+200)" )
			ply:AddFunds( 200 )
		else
			ply:Notify( 1, 6, "The generator has stalled. Contact a custodian to have it fixed." )
		end
	else
		ply:Notify( 0, 6, "You listen to the generator. It sounds like it's running normally." )
	end
end
