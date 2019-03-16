AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

function ENT:SpawnFunction( ply, tr )
	
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "nuke_key" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self:SetModel("models/props/reqprops/oldconsole.mdl")
 
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	
	self.Index = self:EntIndex()
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(caller, activator)
	caller:ChatPrint("Welcome to NukaSys version 42.0. Please place a nuclear device nearby to continue.")
	caller:ChatPrint("Once a nuclear device is in place, press your use key on the device to activate it.")
end