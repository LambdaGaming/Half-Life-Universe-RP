AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Detonation Code Decrypter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
	self:SetModel( "models/props_c17/TrapPropeller_Lever.mdl" )
	self:SetMaterial( "models/weapons/v_slam/new light1" )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
	self:PhysWake()
end

function ENT:Use( ply )
	HLU_ChatNotifySystem( "Code Decrypter", color_theme, "Touch this with the detonation console in the citadel to activate it.", true, ply )
end
