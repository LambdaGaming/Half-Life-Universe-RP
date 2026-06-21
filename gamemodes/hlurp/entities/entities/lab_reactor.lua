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
	self:SetTrigger( true )
	self:PhysWake()
	self:LightUp( "0 100 0 255", self:GetPos() + Vector( 0, 0, 20 ), "6", "600" )
	self:EmitSound( "lab_reactor_idle" )
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "crystal_fragment" then
		local rand = table.Random( player.GetAll() )
		ent:SetPos( rand:GetPos() )
		ent:EmitSound( "ambient/machines/teleport4.wav" )
	elseif class == "crystal_harvested" then
		local e = ents.Create( "crystal_radioactive" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	elseif string.find( "_radioactive", class ) then
		ent:LightUp( "0 255 0 255", ent:GetPos() + Vector( 0, 0, 20 ) )
		ent.IsTicking = true
		local randchance = math.random( 0, 100 )
		if randchance >= 95 then
			for i=1, math.random( 3, 6 ) do
				local e = ents.Create( "radioactive_blob" )
				e:SetPos( ent:GetPos() )
				e:Spawn()
				Explode( self:GetPos() )
				self:Remove()
				ent:Remove()
			end
		end
	elseif class == "organic_matter" or class == "organic_matter_rare" then
		local e = ents.Create( "organic_matter_radioactive" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	elseif class == "xen_iron" or class == "xen_iron_refined" then
		local e = ents.Create( "xen_iron_radioactive" )
		e:SetPos( ent:GetPos() )
		e:Spawn()
		ent:Remove()
	end
end

function ENT:OnRemove()
	self:StopSound( "lab_reactor_idle" )
end
