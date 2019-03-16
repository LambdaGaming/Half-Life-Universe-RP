AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )
	
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "c17_codes" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self:SetModel("models/props_combine/breenconsole.mdl")
 
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )

	
	self.Index = self:EntIndex()
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(activator)
	
	RunConsoleCommand( "blowout_enabled", 1 ) --Enables blowout addon
	
	activator:EmitSound("buttons/button19.wav", 50, 100) --Emits sound upon using
	
	timer.Create( "blowout", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
	
	timer.Create( "changelevel", 150, 0, function() RunConsoleCommand ( "gamemode", "outlandrp" ); RunConsoleCommand ( "changelevel", "rp_ineu_valley2_v1a" ) end )
	
	for k, ply in pairs( player.GetAll() ) do
	ply:ChatPrint( "Codes uploading to core......2 minutes until citadel destruction." ) --Global chat announcement
	end
end