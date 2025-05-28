AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Iron Generator"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

sound.Add( {
	name = "gen_sound",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = { 75, 105 },
	sound = "vehicles/Airboat/fan_motor_idle_loop1.wav"
} )

function ENT:Initialize()
	self:SetModel( "models/props_mining/diesel_generator.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self.Cooldown = 0
	end
	self:SetHealth( 300 )
end

if SERVER then
	function ENT:Use( ply )
		if self.Cooldown > CurTime() then
			HLU_Notify( ply, "The generator is still in the process of producing the iron!", 1, 6 )
			return
		end
		for i=1, 5 do
			local iron = ents.Create( "ucs_iron" )
			iron:SetPos( self:GetPos() + Vector( 0, 0, 100 + ( i * 4 ) ) )
			iron:SetCollisionGroup( COLLISION_GROUP_PLAYER )
			iron:Spawn()
		end
		self:EmitSound( "gen_sound" )
		timer.Simple( 10, function()
			self:StopSound( "gen_sound" )
			self:EmitSound( "vehicles/Airboat/fan_motor_shut_off1.wav" )
		end )
		self.Cooldown = CurTime() + 300
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
		self:StopSound( "gen_sound" )
	end
end
