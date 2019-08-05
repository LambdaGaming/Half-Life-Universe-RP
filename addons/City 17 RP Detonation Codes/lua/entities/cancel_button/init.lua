AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_citizen_tech/firetrap_buttonpad.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	local redlight = ents.Create("light_dynamic")
	redlight:SetPos( self:GetPos() )
	redlight:SetOwner( self:GetOwner() )
	redlight:SetParent(self)
	redlight:SetKeyValue( "_light", "255 0 0 255" )  
	redlight:SetKeyValue("distance", "150" )
	redlight:Spawn()
end

function ENT:Use( activator, caller )
	if !GetGlobalBool( "BlowoutActive" ) then
		DarkRP.notify( activator, 1, 6, "Cancellation aborted, there is nothing to cancel." )
		return
	end
	RunConsoleCommand( "blowout_enabled", 0 ) --Disables blowout and stops timer
	timer.Remove( "blowout" )
	timer.Remove( "changelevel" )
	DarkRP.notifyAll( 1, 10, "Code upload failed, emergency cancellation button was activated.") --Global chat stating that the blowout will not activate
end