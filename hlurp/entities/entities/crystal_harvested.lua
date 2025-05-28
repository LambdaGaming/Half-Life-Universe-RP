AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Harvested Crystal"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "crystal_harvested" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/xenprops/crystal3.mdl" )
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

function ENT:Touch( ent )
	local class = ent:GetClass()
	if class == "lab_burner" then
		self:SetColor( Color( 36, 36, 36, 255 ) )
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		CreateEffect( self, "GlassImpact" )
		self:EmitSound( "physics/glass/glass_largesheet_break"..math.random( 1, 3 )..".wav" )
		local randchance = math.random( 0, 100 )
		if randchance >= 80 then
			local e = ents.Create( "crystal_fragment" )
			e:SetPos( self:GetPos() )
			e:Spawn()
		end
		self:Remove()
	elseif class == "lab_reactor" then
		local e = ents.Create( "crystal_radioactive" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_nitrogen" then
		self:SetModel( "models/props/xenprops/crystal1.mdl" )
	elseif class == "lab_chemical" then
		self:SetModel( "models/props/xenprops/crystal.mdl" )
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
