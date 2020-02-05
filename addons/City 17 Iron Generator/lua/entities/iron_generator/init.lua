AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

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
	sound.Add( {
		name = "gen_sound",
		channel = CHAN_STATIC,
		volume = 1,
		level = 100,
		pitch = { 75, 105 },
		sound = "vehicles/Airboat/fan_motor_idle_loop1.wav"
	} )

    self:SetModel( "models/props_mining/diesel_generator.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Sleep()
	end

	self:SetHealth( 300 )
end

function ENT:Use(caller, activator)
	if timer.Exists( "iron_gen_timer" ) then DarkRP.notify( caller, 1, 6, "The generator is still in the process of producing the iron!" ) return end
	for i=1, 5 do
		local iron = ents.Create( "ironbar" )
		iron:SetPos( self:GetPos() + Vector( 0, 0, 100 + ( i * 4 ) ) )
		iron:SetCollisionGroup( COLLISION_GROUP_PLAYER )
		iron:Spawn()
	end
	self:EmitSound( "gen_sound" )
	timer.Simple( 10, function() self:StopSound("gen_sound") self:EmitSound( "vehicles/Airboat/fan_motor_shut_off1.wav" ) end )
	timer.Create( "iron_gen_timer", 300, 1, function() end )
end

function ENT:OnTakeDamage( dmg )
	local amt = dmg:GetDamage()
	self:SetHealth( self:Health() - amt )
	if self:Health() <= 0 then
		local explode = ents.Create("env_explosion")
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
		self:Remove()
	end
end

function ENT:OnRemove()
	self:StopSound("gen_sound")
end