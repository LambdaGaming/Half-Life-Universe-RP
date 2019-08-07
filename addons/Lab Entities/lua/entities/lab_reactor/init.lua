AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	sound.Add( {
		name = "lab_reactor_idle",
		channel = CHAN_STATIC,
		volume = 1.0,
		level = 60,
		pitch = { 95, 110 },
		sound = "ambient/machines/combine_terminal_loop1.wav"
	} )

	self:SetModel("models/props/hl16props/generator00.mdl")
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
	redlight:SetKeyValue( "_light", "0 100 0 255" )  
	redlight:SetKeyValue("distance", "600" )
	redlight:SetKeyValue( "style", "6" )
	redlight:Spawn()

	self:EmitSound( "lab_reactor_idle" )
end

function ENT:OnRemove()
	self:StopSound( "lab_reactor_idle" )
end