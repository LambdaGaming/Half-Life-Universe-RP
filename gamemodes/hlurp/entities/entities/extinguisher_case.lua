AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Extinguisher Case"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/props/bmrf/bmrf_firexcase.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()

	--Fix for cases floating
	self:SetPos( self:GetPos() + self:GetRight() * -10 )
end

function ENT:Use( ply )
	if ply:HasWeapon( "weapon_extinguisher" ) then
		if self.used then
			ply:StripWeapon( "weapon_extinguisher" )
			ply:Notify( 0, 6, "You have placed the extinguisher back in the case." )
			self.used = false
			return
		else
			ply:Notify( 1, 6, "You already have a fire extinguisher!" )
			return
		end
	elseif self.used then
		ply:Notify( 1, 6, "You open the extinguisher case but find nothing inside." )
		return
	end
	ply:Give( "weapon_extinguisher" )
	ply:SelectWeapon( "weapon_extinguisher" )
	ply:Notify( 0, 6, "You have obtained a fire extinguisher." )
	self.used = true
end

function ENT:Touch( ent )
	if ent:GetClass() == "weapon_extinguisher" and self.used then
		self.used = false
		ent:Remove()
	end
end
