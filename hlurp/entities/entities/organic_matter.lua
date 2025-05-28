AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Organic Matter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

function ENT:Initialize()
    self:SetModel( "models/props_lab/petridish01d.mdl" )
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

	self.IsFrozen = false
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
		local e = ents.Create( "organic_matter_cooked" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			self:Ignite()
		else
			self:Remove()
		end
	elseif class == "lab_generator" then
		local randchance = math.random( 0, 100 )
		if self.IsFrozen then
			if randchance >= 25 then
				local e = ents.Create( "organic_matter_cooked" )
				e:SetPos( self:GetPos() )
				e:Spawn()
				self:Remove()
			else
				self:Ignite()
				self.IsFrozen = false
			end
		else
			if randchance >= 50 then
				local e = ents.Create( "organic_matter_cooked" )
				e:SetPos( self:GetPos() )
				e:Spawn()
				self:Remove()
			else
				self:Ignite()
				self.IsFrozen = false
			end
		end
	elseif class == "lab_reactor" then
		local e = ents.Create( "organic_matter_radioactive" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_nitrogen" then
		self.IsFrozen = true
		self:SetColor( 0, 0, 255, 255 )
	elseif class == "lab_chemical" then
		self:SetColor( 0, 255, 0, 255 )
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end
