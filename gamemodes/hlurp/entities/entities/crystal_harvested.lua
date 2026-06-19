AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Harvested Crystal"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos + ent:GetUp() * 60 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props/xenprops/crystal3.mdl" )
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
		self:SetColor( Color( 36, 36, 36, 255 ) )
		ent:EmitSound( "ambient/fire/gascan_ignite1.wav" )
	elseif class == "lab_laser" then
		local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
		CreateEffect( "GlassImpact", pos )
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
		local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
		CreateEffect( "Sparks", pos )
		self:EmitSound("ambient/energy/spark"..math.random( 1, 6 )..".wav")
	end
end

function ENT:Think()
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:GetClass() == "lab_generator" then
			local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
			CreateEffect( "Sparks", pos )
			self:EmitSound("ambient/energy/spark"..math.random( 1, 6 )..".wav")
		end
	end
	self:NextThink( CurTime() + math.random( 1, 8 ) )
	return true
end
