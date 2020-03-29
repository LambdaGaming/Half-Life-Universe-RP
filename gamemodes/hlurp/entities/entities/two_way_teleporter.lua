
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Two Way Teleporter"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

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
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetHealth( 100 )
		self:SetMaxHealth( 100 )
	end
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	self.active = false
end

function ENT:Use( activator, caller )
	if self.active then
		HLU_Notify( activator, "The teleporter is currently in use.", 1, 6 )
		return
	end
	local pair = self:GetNWEntity( "PairedPortal" )
	if pair == NULL or !IsValid( pair ) then
		HLU_Notify( activator, "ERROR: Portal needs to be paired with a pairing tool. Contact a resistance leader for assistance.", 1, 6 )
		return
	end
	if activator:Alive() then
		timer.Simple( 1, function()
			HLU_Notify( activator, "Teleport starting...", 0, 6 )
		end )
		self:EmitSound( "ambient/levels/labs/teleport_mechanism_windup"..math.random( 1, 5 )..".wav" )
		local time = 5
		timer.Create( "TeleportTimer", 1, 5, function()
			HLU_Notify( activator, "Teleporting in: "..tostring( time ), 0, 6 )
			time = time - 1
		end )
		timer.Simple( 7, function()
			self:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			caller:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			activator:SetPos( pair:GetPos() + Vector( 0, 0, 10 ) )
			local ed = EffectData()
			ed:SetOrigin( activator:GetPos() + Vector( 0, 0, 30 ) )
			ed:SetNormal(VectorRand())
			ed:SetMagnitude(3)
			ed:SetScale(1)
			ed:SetRadius(3)
			util.Effect( "Sparks", ed )
			self.active = false
		end )
	end
end

function ENT:OnTakeDamage()
	local dmg = DamageInfo():GetDamage()
	self:SetHealth( self:Health() - dmg )
	if self:Health() <= 0 then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
		self:Remove()
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end