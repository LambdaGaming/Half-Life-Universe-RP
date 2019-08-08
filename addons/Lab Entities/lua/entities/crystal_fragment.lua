AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "High-Energy Crystal Fragment"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "crystal_fragment" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/bmrf/bmrf_xencrystals.mdl" )
	self:SetModelScale( 0.2 )
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

	if SERVER then
		local redlight = ents.Create("light_dynamic")
		redlight:SetPos( self:GetPos() + Vector( 0, 0, 20 ) )
		redlight:SetOwner( self:GetOwner() )
		redlight:SetParent(self)
		redlight:SetKeyValue( "_light", "255 165 0 255" )  
		redlight:SetKeyValue("distance", "300" )
		redlight:SetKeyValue( "style", "11" )
		redlight:Spawn()
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

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "lab_burner" then
		self:SetColor( Color( 36, 36, 36, 255 ) )
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		local randchance = math.random( 0, 100 )
		if randchance >= 40 then
			Explode( ent:GetPos(), 100, 0, false )
			ent:Remove()
		end
		Explode( self:GetPos(), 100, 0, false )
		self:Remove()
	elseif class == "lab_reactor" then
		local randply = table.Random( player.GetAll() )
		self:SetPos( randply:GetPos() )
		self:EmitSound( "ambient/machines/teleport4.wav" )
	elseif class == "lab_nitrogen" then
		local e = ents.Create( "crystal_harvested" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_chemical" then
		self:SetColor( color_white )
		self:SetMaterial( "models/alyx/emptool_glow" )
		ent:EmitSound( "ambient/machines/machine1_hit1.wav" )
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
function ENT:Think()
	for k,v in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:GetClass() == "lab_generator" then
			if cooldown < CurTime() then
				CreateEffect( self, "Sparks" )
				self:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
				cooldown = cooldown + math.random( 1, 8 )
			end
		end
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end