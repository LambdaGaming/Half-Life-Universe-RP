AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Radioactive Harvested Crystal"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "crystal_radioactive" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/xenprops/crystal.mdl" )
	self:SetColor( Color( 11, 88, 0, 255 ) )
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTrigger(true)
	end
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end

	self.IsTicking = false

	timer.Create( "RadiationEffect_"..self:EntIndex(), math.random( 1, 8 ), 0, function()
		if !IsValid( self ) then return end
		local effectdata = EffectData()
		effectdata:SetOrigin( self:GetPos() + self:GetUp() * math.random( 10, 25 ) )
		effectdata:SetNormal( VectorRand() )
		effectdata:SetMagnitude( 1 )
		effectdata:SetScale( 1 )
		effectdata:SetRadius( 1 )
		util.Effect( "VortDispel", effectdata, true, true )
	end )
end

local function Explode( pos, mag, time, stay )
	local e = ents.Create( "env_explosion" )
	e:SetPos( pos )
	e:Spawn()
	e:SetKeyValue( "iMagnitude", mag )
	if stay then
		e:SetKeyValue( "spawnflags", "2" )
	end
	if time <= 0 then
		e:Fire( "Explode", 0, 0 )
	else
		timer.Simple( time, function()
			e:Fire( "Explode", 0, 0 )
		end )
	end
end

local function CreateEffect( ent, effect )
	local effectdata = EffectData()
	effectdata:SetOrigin( ent:GetPos() + ent:GetUp() * math.random( 10, 25 ) )
	effectdata:SetNormal( VectorRand() )
	effectdata:SetMagnitude( 3 )
	effectdata:SetScale( 1 )
	effectdata:SetRadius( 3 )
	util.Effect( effect, effectdata, true, true )
end

local laserlight, reactorlight
function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "lab_burner" then
		self:SetColor( Color( 36, 36, 36, 255 ) )
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		if SERVER then
			if IsValid( reactorlight ) then reactorlight:Remove() end
			laserlight = ents.Create("light_dynamic")
			laserlight:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
			laserlight:SetOwner( self:GetOwner() )
			laserlight:SetParent(self)
			laserlight:SetKeyValue( "_light", "0 255 0 255" )  
			laserlight:SetKeyValue("distance", "300" )
			laserlight:SetKeyValue( "style", "11" )
			laserlight:Spawn()
		end
	elseif class == "lab_reactor" then
		if SERVER then
			if IsValid( laserlight ) then laserlight:Remove() end
			reactorlight = ents.Create("light_dynamic")
			reactorlight:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
			reactorlight:SetOwner( self:GetOwner() )
			reactorlight:SetParent(self)
			reactorlight:SetKeyValue( "_light", "0 255 0 255" )  
			reactorlight:SetKeyValue("distance", "300" )
			reactorlight:Spawn()
			self.IsTicking = true
		end
		local randchance = math.random( 0, 100 )
		if randchance >= 95 then
			local randents = {
				"plutonium_ent",
				"unubuntium_ent",
				"uranium_ent"
			}
			for i=1, math.random( 3, 6 ) do
				local e = ents.Create( table.Random( randents ) )
				e:SetPos( self:GetPos() )
				e:Spawn()
				Explode( ent:GetPos(), 200, 0, false )
				ent:Remove()
				self:Remove()
			end
		end
	elseif class == "lab_nitrogen" then
		local e = ents.Create( "crystal_harvested" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_chemical" then
		CreateEffect( self, "ElectricSpark" )
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			local randnpc = {
				"monster_hound_eye",
				"monster_bullsquid",
				"npc_headcrab",
				"monster_hwgrunt",
				"monster_alien_slv"
			}
			local e = ents.Create( table.Random( randnpc ) )
			e:SetPos( ent:GetPos() )
			e:Spawn()
			Explode( ent:GetPos(), 0, 0, false )
			ent:Remove()
			self:Remove()
		else
			self:Remove()
		end
	elseif ent:IsPlayer() and self.IsTicking then
		ent:Kill()
	end
end

function ENT:Touch( ent )
	local class = ent:GetClass()
	if class == "lab_generator" then
		CreateEffect( self, "Sparks" )
		self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
	end
end

local cooldown = CurTime()
local geigercooldown = CurTime()
local hurtcooldown = CurTime()
function ENT:Think()
	if self.IsTicking and geigercooldown < CurTime() then
		self:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
		geigercooldown = geigercooldown + math.random( 1, 3 )
	end
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:GetClass() == "lab_generator" then
			if cooldown < CurTime() then
				CreateEffect( self, "Sparks" )
				self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
				cooldown = cooldown + math.random( 1, 8 )
			end
		elseif v:IsPlayer() and hurtcooldown < CurTime() then
			if v:Team() == TEAM_BIO or v:Team() == TEAM_SURVEYBOSS or v:Team() == TEAM_SURVEY then return end
			if SERVER then
				v:TakeDamage( 5 )
			end
			if CLIENT then
				surface.PlaySound( "player/geiger"..math.random( 1, 3 )..".wav" )
			end
			hurtcooldown = hurtcooldown + 3
		end
	end
end

function ENT:OnRemove()
	timer.Remove( "RadiationEffect_"..self:EntIndex() )
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end