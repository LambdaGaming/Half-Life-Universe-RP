AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Nuke Key"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props/reqprops/oldconsole.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	ply:SystemChat( "Nuke Key", color_black, "Welcome to NukaSys version 42.0. Please place a nuclear device nearby to continue." )
	ply:SystemChat( "Nuke Key", color_black, "Once a nuclear device is in place, press your use key on the device to activate it." )
end
