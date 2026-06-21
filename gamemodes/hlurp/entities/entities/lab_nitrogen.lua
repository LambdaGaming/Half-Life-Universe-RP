AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Liquid Nitrogen Capsule"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props_lab/sterilizer.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "crystal_fragment" or class == "crystal_radioactive" then
		local e = ents.Create( "crystal_harvested" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	elseif class == "crystal_harvested" then
		ent:SetModel( "models/props/xenprops/crystal1.mdl" )
	elseif class == "organic_matter_radioactive" then
		local e = ents.Create( "organic_matter" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	elseif class == "organic_matter" or class == "organic_matter_rare" then
		ent.IsFrozen = true
		ent:SetColor( 0, 0, 255, 255 )
	elseif class == "xen_iron_radioactive" then
		local e = ents.Create( "xen_iron" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	elseif class == "xen_iron" or class == "xen_iron_refined" then
		ent:SetColor( 0, 0, 255, 255 )
	end
end
