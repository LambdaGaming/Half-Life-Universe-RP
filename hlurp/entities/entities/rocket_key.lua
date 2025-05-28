AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rocket Key"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
	self:SetModel( "models/props_c17/TrapPropeller_Lever.mdl" )
	self:SetMaterial( "models/weapons/v_slam/new light2" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetTrigger( true )
	end
	self:PhysWake()
end

function ENT:Use( ply )
	HLU_ChatNotifySystem( "Rocket Key", color_green, "Touch this with the rocket launch button.", true, ply )
end

function ENT:StartTouch( ent )
	if ent:GetClass() == "rocket_launch_button" then
		ent.HasKey = true
		ent:EmitSound( "buttons/button5.wav" )
		ent.light:SetKeyValue( "_light", "0 255 0 255" )
		self:Remove()
		HLU_ChatNotifySystem( "Outland RP", color_green, "The rocket is fully prepped and ready for launch!" )
	end
end
