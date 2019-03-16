AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "xen_podium" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/xenprops2/tube.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetTrigger(true)
	self:SetUseType(SIMPLE_USE)
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	greenlight = ents.Create("light_dynamic")
	greenlight:SetPos( self:GetPos() + Vector(0,0,100))
	greenlight:SetParent(self)
	greenlight:SetKeyValue( "_light", "255 0 0 255" )  
	greenlight:SetKeyValue("distance", "1000" )
	greenlight:SetKeyValue("style", "2")
	greenlight:Spawn()
end

function ENT:Use(caller, activator)
	if SERVER then
		DarkRP.notify( caller, 0, 6, "You look at the pole and notice a strange light emitting from it." )
	end
end

function ENT:StartTouch(entity)
if entity:IsPlayer() or entity:IsNPC() or entity:IsWeapon() or entity:IsVehicle() or not entity:IsScripted() then return end
local effect = EffectData()
local d = DamageInfo()
local drone = ents.Create("npc_pitdrone")
local devil = ents.Create("npc_devilsquid")
local panther = ents.Create("monster_panthereye")
local volt = ents.Create("monster_alien_voltigore")
local tent = ents.Create("monster_babygarg")
local bat = ents.Create("npc_stukabat")
local e = ents.Create("env_explosion")
local munition = ents.Create("ammo_spore")

effect:SetOrigin(entity:GetPos())
	if entity:GetClass() == "iron" then
		util.Effect("StunstickImpact", effect)
		drone:SetPos(self:GetPos() + Vector(0,65,0))
		drone:Spawn()
		self:EmitSound("ambient/energy/zap"..math.random(1,9)..".wav")
	elseif entity:GetClass() == "matter" then
		util.Effect("BloodImpact", effect)
		devil:SetPos(self:GetPos() + Vector(0,65,0))
		devil:Spawn()
		self:EmitSound("ambience/the_horror3.wav")
	elseif entity:GetClass() == "syringe" then
		local tele = ents.FindInSphere(self:GetPos(), 300)
		util.Effect("GlassImpact", effect)
		tent:SetPos(self:GetPos() + Vector(0,65,-40))
		tent:Spawn()
		self:EmitSound("ambience/jetflyby1.wav", 75, 40, 1, CHAN_AUTO)
	elseif entity:GetClass() ==  "glass" then
		util.Effect("AntlionGib", effect)
		util.ScreenShake(self:GetPos(), 5, 5, 3, 500)
		panther:SetPos(self:GetPos() + Vector(0,65,0))
		panther:Spawn()
		self:EmitSound("ambient/atmosphere/terrain_rumble1.wav")
	elseif entity:GetClass() == "steel" then
		util.Effect("AR2Impact", effect)
		bat:SetPos(self:GetPos() + Vector(0,65,10))
		bat:Spawn()
		self:EmitSound("ambience/rocket_groan4.wav")
	elseif entity:GetClass() == "circuit" then
		util.Effect("cball_bounce", effect)
		util.ScreenShake(self:GetPos(), 20, 20, 10, 2000)
		volt:SetPos(self:GetPos() + Vector(0,100,0))
		volt:Spawn()
		self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
		self:EmitSound("ambient/atmosphere/terrain_rumble1.wav")
	elseif entity:GetClass() == "ammo" then
		util.Effect("GunshipImpact", effect)
		munition:SetPos(self:GetPos() + Vector(0,65,-95))
		munition:Spawn()
		self:EmitSound("ambient/energy/weld"..math.random(1,2)..".wav")
	else
		e:SetPos( pos )
		e:Spawn()
		e:SetKeyValue("iMagnitude", "0")
		e:Fire("Explode", 0, 0)
		e:Remove()
	end
	entity:Remove()
	timer.Simple( 5, function() util.Effect("ParticleEffectStop", effect) end )
end