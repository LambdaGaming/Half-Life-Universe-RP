AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Two Way Teleporter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/props_lab/teleplatform.mdl" )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 100 )
	self:SetMaxHealth( 100 )
	self:PhysWake()
	self.active = false
end

function ENT:Use( ply )
	if self.active then
		HLU_Notify( ply, "The teleporter is currently in use.", 1, 6 )
		return
	end
	local pair = self:GetNWEntity( "PairedPortal" )
	if pair == NULL or !IsValid( pair ) then
		HLU_Notify( ply, "ERROR: Portal needs to be paired with a pairing tool. Contact a resistance leader for assistance.", 1, 6 )
		return
	end
	if ply:Alive() then
		timer.Simple( 1, function()
			HLU_Notify( ply, "Teleport starting...", 0, 6 )
		end )
		self:EmitSound( "ambient/levels/labs/teleport_mechanism_windup"..math.random( 1, 5 )..".wav" )
		local time = 5
		timer.Create( "TeleportTimer", 1, 5, function()
			HLU_Notify( ply, "Teleporting in: "..tostring( time ), 0, 6 )
			time = time - 1
		end )
		timer.Simple( 7, function()
			self:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			ply:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			ply:SetPos( pair:GetPos() + Vector( 0, 0, 10 ) )
			CreateEffect( "Sparks", ply:GetPos() + Vector( 0, 0, 30 ) )
			self.active = false
		end )
	end
end

function ENT:OnTakeDamage()
	local dmg = DamageInfo():GetDamage()
	self:SetHealth( self:Health() - dmg )
	if self:Health() <= 0 then
		Explode( self:GetPos(), 0 )
		self:Remove()
	end
end
