AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
	self:SetModel( "models/props_combine/breenconsole.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(caller, activator)
	if timer.Exists( "OutlandTimer" ) then DarkRP.notify( caller, 1, 8, "You must wait until the 30 minute ceasefire has ended." ) return end
	if !caller.hascodes then DarkRP.notify( caller, 1, 5, "You don't have the codes to shutdown the portal!" ) return end
	if !GetConVar("blowout_enabled"):GetBool() then DarkRP.notify( caller, 1, 6, "ERROR: The portal is already being opened!" ) return end
	RunConsoleCommand( "blowout_enabled", 1 ) --Enables blowout addon
	self:EmitSound( "buttons/button19.wav", 50, 100 ) --Emits sound upon using
	timer.Create( "blowoutcombine", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
	timer.Create( "changelevelcombine", 150, 0, function() RunConsoleCommand ( "changelevel", "gm_atomic" ) end )
	DarkRP.notifyAll( 0, 8, "Codes sent to Combine overworld.......... 2 minutes until portal detonation." )
end