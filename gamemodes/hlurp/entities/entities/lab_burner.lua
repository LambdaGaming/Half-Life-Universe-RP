AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bunsen Burner"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/labware/burner.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self:EmitSound( "ambient/fire/mtov_flame2.wav" )
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if string.find( "crystal_", class ) or class == "xen_iron_radioactive" or class == "xen_iron_refined" then
		ent:SetColor( Color( 36, 36, 36, 255 ) )
		self:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "organic_matter_rare" then
		local e = ents.FindByClass( "info_player_start" )
		self:SetPos( table.Random( e ):GetPos() )
		self:EmitSound( "ambient/machines/teleport3.wav" )
		ent:EmitSound( "ambient/machines/teleport1.wav" )
	elseif class == "organic_matter" then
		local e = ents.Create( "organic_matter_cooked" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
		self:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "xen_iron" then
		local e = ents.Create( "xen_iron_refined" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
		self:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	else
		ent:Ignite()
	end
end
