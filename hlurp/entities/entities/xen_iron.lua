AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Xen Iron"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/Items/CrossbowRounds.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
end

function ENT:StartTouch( ent )
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
		end
		self:Remove()
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
		local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
		CreateEffect( "Sparks", pos )
		self:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
	end
end

function ENT:Think()
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:GetClass() == "lab_generator" then
			local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
			CreateEffect( "Sparks", pos )
			self:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
		end
	end
	self:NextThink( CurTime() + math.random( 1, 8 ) )
	return true
end
