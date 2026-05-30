AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rubble Obstruction"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_debris/walldestroyed09a.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetHealth( 100 )
	self:SetUseType( SIMPLE_USE )
	local e = EffectData()
	e:SetOrigin( self:GetPos() )
	e:SetScale( 1000 )
	util.Effect( "ThumperDust", e )
	self:EmitSound( "ambient/machines/wall_crash1.wav" )

	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
		if v:IsPlayer() then
			--v:Kill()
		elseif v:IsNPC() then
			v:TakeDamage( 10000, self, self )
		end
	end
	self:PhysWake()
end

function ENT:Use( ply )
	ply:Notify( 0, 6, "This wreckage cannot be cleared by hand. You will need a tool." )
end

function ENT:OnTakeDamage( dmg )
	if dmg:GetAttacker():IsPlayer() then
		local wep = dmg:GetAttacker():GetActiveWeapon()
		if wep:GetClass() == "weapon_hl2pickaxe" then
			self:SetHealth( self:Health() - 3 )
		end
		if self:Health() <= 0 or dmg:IsDamageType( DMG_BLAST ) then
			local e = EffectData()
			e:SetOrigin( self:GetPos() )
			e:SetScale( 1000 )
			util.Effect( "ThumperDust", e )
			self:EmitSound( "physics/concrete/rock_impact_hard1.wav" )
			self:Remove()
		end
	end
end
