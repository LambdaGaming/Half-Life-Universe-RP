AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Xen Iron"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "xen_iron" )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/Items/CrossbowRounds.mdl" )
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
		local e = ents.Create( "xen_iron_refined" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			local e = ents.Create( "xen_iron" )
			e:SetPos( self:GetPos() + Vector( 0, 0, 10 ) )
			e:Spawn()
			self:Remove()
		else
			self:Remove()
		end
	elseif class == "lab_reactor" then
		local e = ents.Create( "xen_iron_radioactive" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_nitrogen" then
		self:SetColor( 0, 0, 255, 255 )
	elseif class == "lab_chemical" then
		self:SetColor( 0, 255, 0, 255 )
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