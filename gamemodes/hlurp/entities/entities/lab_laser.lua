AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "High-Powered Laser Emitter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

sound.Add( {
	name = "lab_laser_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 60,
	pitch = { 95, 110 },
	sound = "ambient/levels/canals/generator_ambience_loop1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/props_lab/surgical_laser.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self:LightUp( "255 0 0 255", self:GetPos() + Vector( 0, 0, 20 ), "0", "600" )
	self:EmitSound( "lab_laser_idle" )
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "crystal_fragment" then
		local randchance = math.random( 0, 100 )
		if randchance >= 40 then
			Explode( self:GetPos(), 100 )
			self:Remove()
		end
		Explode( ent:GetPos(), 100 )
		ent:Remove()
	elseif class == "crystal_harvested" then
		local pos = ent:GetPos() + ent:GetUp() * math.random( 10, 25 )
		CreateEffect( "GlassImpact", pos )
		ent:EmitSound( "physics/glass/glass_largesheet_break"..math.random( 1, 3 )..".wav" )
		local randchance = math.random( 0, 100 )
		if randchance >= 80 then
			local e = ents.Create( "crystal_fragment" )
			e:SetPos( ent:GetPos() )
			e:Spawn()
		end
		ent:Remove()
	elseif string.find( "_radioactive", class ) then
		ent:LightUp( "0 255 0 255", ent:GetPos() + Vector( 0, 0, 20 ), "11" )
	elseif class == "organic_matter" or class == "organic_matter_rare" then
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			ent:Ignite()
		else
			ent:Remove()
		end
	elseif class == "xen_iron_refined" then
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			local e = ents.Create( "xen_iron" )
			e:SetPos( ent:GetPos() + Vector( 0, 0, 10 ) )
			e:Spawn()
		end
		ent:Remove()
	else
		ent:TakeDamage( 25, self, self )
	end
end

function ENT:OnRemove()
	self:StopSound( "lab_laser_idle" )
end
