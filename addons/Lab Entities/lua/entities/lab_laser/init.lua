AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	sound.Add( {
		name = "lab_laser_idle",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 60,
		pitch = { 95, 110 },
		sound = "ambient/levels/canals/generator_ambience_loop1.wav"
	} )

	self:SetModel("models/props_lab/surgical_laser.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	local redlight = ents.Create("light_dynamic")
	redlight:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
	redlight:SetOwner( self:GetOwner() )
	redlight:SetParent(self)
	redlight:SetKeyValue( "_light", "255 0 0 255" )  
	redlight:SetKeyValue("distance", "600" )
	redlight:Spawn()

	self:EmitSound( "lab_laser_idle" )
end

function ENT:OnRemove()
	self:StopSound( "lab_laser_idle" )
end