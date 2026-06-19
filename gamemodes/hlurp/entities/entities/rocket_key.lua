AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rocket Key"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props_c17/TrapPropeller_Lever.mdl" )
	self:SetMaterial( "models/weapons/v_slam/new light2" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
end

function ENT:Use( ply )
	ply:SystemChat( "Rocket Key", color_green, "Touch this with the rocket launch button." )
end

function ENT:StartTouch( ent )
	if ent:GetClass() == "rocket_launch_button" then
		ent.HasKey = true
		ent:EmitSound( "buttons/button5.wav" )
		ent.light:SetKeyValue( "_light", "0 255 0 255" )
		self:Remove()
		BroadcastSystemChat( "Outland RP", color_green, "The rocket is fully prepped and ready for launch!" )
	end
end
