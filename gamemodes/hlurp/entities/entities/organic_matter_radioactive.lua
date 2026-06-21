AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Radioactive Organic Matter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
    self:SetModel( "models/props_lab/petridish01d.mdl" )
	self:SetColor( Color( 0, 255, 0, 255 ) )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetTrigger( true )
	self:PhysWake()
	self.IsTicking = false
end

function ENT:StartTouch( ent )
	local class = ent:GetClass()
	if class == "lab_burner" then
		self:Ignite()
	elseif class == "lab_laser" then
		self:LightUp( "0 255 0 255", self:GetPos() + Vector( 0, 0, 20 ), "11" )
	elseif class == "lab_generator" then
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 400 ) ) do
			v:Ignite()
		end
		self:Remove()
	elseif class == "lab_reactor" then
		self:LightUp( "0 255 0 255", self:GetPos() + Vector( 0, 0, 20 ) )
		self.IsTicking = true
		local randchance = math.random( 0, 100 )
		if randchance >= 95 then
			for i=1, math.random( 3, 6 ) do
				local e = ents.Create( "radioactive_blob" )
				e:SetPos( self:GetPos() )
				e:Spawn()
				Explode( ent:GetPos(), 200, 0, false )
				ent:Remove()
				self:Remove()
			end
		end
	elseif class == "lab_nitrogen" then
		local e = ents.Create( "organic_matter" )
		e:SetPos( self:GetPos() )
		e:Spawn()
		self:Remove()
	elseif class == "lab_chemical" then
		local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
		CreateEffect( "ElectricSpark", pos )
		local randchance = math.random( 0, 100 )
		if randchance >= 50 then
			local randnpc = {
				"npc_vj_hlr1_houndeye",
				"npc_vj_hlr1_bullsquid",
				"npc_vj_hlr1_headcrab",
				"npc_vj_hlr1_aliengrunt",
				"npc_vj_hlr1_alienslave"
			}
			local e = ents.Create( table.Random( randnpc ) )
			e:SetPos( ent:GetPos() )
			e:Spawn()
			Explode( ent:GetPos(), 0 )
			ent:Remove()
		end
		self:Remove()
	elseif ent:IsPlayer() and self.IsTicking then
		ent:Kill()
	end
end

local nextSpark = 0
local nextGeiger = 0
local nextHurt = 0
local nextRad = 0
local immune = {
	[TEAM_BIO] = true,
	[TEAM_SURVEYBOSS] = true,
	[TEAM_SURVEY] = true
}
function ENT:Think()
	if self.IsTicking and nextGeiger < CurTime() then
		self:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
		nextGeiger = nextGeiger + math.random( 1, 3 )
	end
	if nextRad < CurTime() then
		local ed = EffectData()
		ed:SetOrigin( self:GetPos() + self:GetUp() * math.random( 10, 25 ) )
		ed:SetNormal( VectorRand() )
		ed:SetMagnitude( 1 )
		ed:SetScale( 1 )
		ed:SetRadius( 1 )
		util.Effect( "VortDispel", ed, true, true )
		nextRad = CurTime() + math.random( 1, 8 )
	end
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
		if v:GetClass() == "lab_generator" then
			if nextSpark < CurTime() then
				local pos = self:GetPos() + self:GetUp() * math.random( 10, 25 )
				CreateEffect( "Sparks", pos )
				self:EmitSound( "ambient/energy/spark"..math.random( 1, 6 )..".wav" )
				nextSpark = nextSpark + math.random( 1, 8 )
			end
		elseif v:IsPlayer() and nextHurt < CurTime() and !immune[v:Team()] then
			v:TakeDamage( 5 )
			v:EmitSound( "player/geiger"..math.random( 1, 3 )..".wav" )
			nextHurt = CurTime() + 3
		end
	end
	self:NextThink( CurTime() + 0.5 )
	return true
end
