AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vending Machine Resupply"
ENT.Author = "OPGman"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props/CS_militia/food_stack.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetTrigger( true )
	self:PhysWake()
end

function ENT:StartTouch( ent )
	if ent:GetClass() == "vending_machine" then
		ent.Amount = 10
		ent:EmitSound( "physics/cardboard/cardboard_box_break"..math.random( 1, 3 )..".wav" )
		self:Remove()
	end
end
