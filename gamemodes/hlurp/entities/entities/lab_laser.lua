AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "High-Powered Laser Emitter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

sound.Add( {
	name = "lab_laser_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 60,
	pitch = { 95, 110 },
	sound = "ambient/levels/canals/generator_ambience_loop1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/props_lab/surgical_laser.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self:LightUp( "255 0 0 255", self:GetPos() + Vector( 0, 0, 20 ), "0", "600" )
	self:EmitSound( "lab_laser_idle" )
end

function ENT:OnRemove()
	self:StopSound( "lab_laser_idle" )
end
