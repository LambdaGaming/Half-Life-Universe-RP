AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Nuclear Reactor"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

sound.Add( {
	name = "lab_reactor_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 70,
	pitch = { 95, 110 },
	sound = "ambient/machines/combine_terminal_loop1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/props/hl16props/generator00.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self:LightUp( "0 100 0 255", self:GetPos() + Vector( 0, 0, 20 ), "6", "600" )
	self:EmitSound( "lab_reactor_idle" )
end

function ENT:OnRemove()
	self:StopSound( "lab_reactor_idle" )
end
