AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Electric Generator"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

sound.Add( {
	name = "lab_generator_idle",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 60,
	pitch = { 95, 110 },
	sound = "ambient/machines/engine1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/props/portedprops1/battery.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self:EmitSound( "lab_generator_idle" )
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "organic_matter_radioactive" then
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 400 ) ) do
			v:Ignite()
		end
		ent:Remove()
	elseif class == "organic_matter" or class == "organic_matter_rare" then
		local randchance = math.random( 0, 100 )
		if ( ent.IsFrozen and randchance >= 25 ) or ( !ent.IsFrozen and randchance >= 50 ) then
			local e = ents.Create( "organic_matter_cooked" )
			e:SetPos( ent:GetPos() )
			e:Spawn()
			ent:Remove()
		else
			ent:Ignite()
			ent.IsFrozen = false
		end
	end
end

function ENT:Touch( ent )
	local class = ent:GetClass()
	if string.find( "crystal_", class ) or string.find( "xen_iron_", class ) then
		local pos = ent:GetPos() + ent:GetUp() * math.random( 10, 25 )
		CreateEffect( "Sparks", pos )
		ent:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
	end
end

local sparkEnts = {
	crystal_harvested = true,
	crystal_fragment = true,
	crystal_radioactive = true,
	organic_matter_radioactive = true,
	xen_iron_radioactive = true
}
function ENT:Think()
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if sparkEnts[v:GetClass()] then
			local pos = ent:GetPos() + ent:GetUp() * math.random( 10, 25 )
			CreateEffect( "Sparks", pos )
			ent:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
		end
	end
	self:NextThink( CurTime() + math.random( 1, 8 ) )
	return true
end

function ENT:OnRemove()
	self:StopSound( "lab_generator_idle" )
end
