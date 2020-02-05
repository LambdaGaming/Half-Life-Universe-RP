AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/props_citizen_tech/firetrap_buttonpad.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	local phys = self:GetPhysicsObject()
	if IsValid( phys ) then
		phys:Wake()
	end
	
	local redlight = ents.Create( "light_dynamic" )
	redlight:SetPos( self:GetPos() )
	redlight:SetOwner( self:GetOwner() )
	redlight:SetParent( self )
	redlight:SetKeyValue( "_light", "255 0 0 255" )  
	redlight:SetKeyValue( "distance", "150" )
	redlight:Spawn()
end

function ENT:Use( caller, activator )
	if timer.Exists( "OutlandTimer" ) then DarkRP.notify( caller, 1, 5, "You must wait until the 30 minute ceasefire has ended." ) return end
	if !GetConVar( "blowout_enabled" ):GetBool() then DarkRP.notify( caller, 1, 6, "ERROR: Nothing was detected to cancel." ) return end
	RunConsoleCommand( "blowout_enabled", 0 )
	timer.Remove( "blowoutcombine" )
	timer.Remove( "changelevelcombine" )
	DarkRP.notifyAll( 1, 8, "Portal failed to successfully close, emergency cancellation button was activated." )
end