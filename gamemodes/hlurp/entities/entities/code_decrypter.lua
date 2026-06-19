AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Detonation Code Decrypter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props_c17/TrapPropeller_Lever.mdl" )
	self:SetMaterial( "models/weapons/v_slam/new light1" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	ply:SystemChat( "Code Decrypter", color_theme, "Touch this with the detonation console in the citadel to activate it." )
end
