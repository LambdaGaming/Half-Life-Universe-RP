AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

local weapon = {
	"weapon_crossbow_hl",
	"weapon_egon",
	"weapon_flechettegrenade",
	"weapon_freezinggun",
	"weapon_gauss",
	"weapon_knife",
	"weapon_penguin",
	"weapon_rpg_hl",
	"weapon_tripmine"
}

function ENT:Initialize()
    self:SetModel( "models/player/gasmask_hecu.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end

	self.waiting = false
	
	local rand = table.Random( weapon )
	self.chosenwep = rand
end

function ENT:AcceptInput( ply, caller )
	if self.waiting then
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v:GetClass() == self.chosenwep then
				v:Remove()
				DarkRP.talkToPerson( caller, Color( 56, 118, 29 ), "Corporal Shepard", color_white, "Thanks! Here's your cash. (Award +600)" )
				caller:addMoney( 600 )
				self:TeleportAway()
				return
			end
		end
	end
	if caller:Team() == TEAM_WEPMAKER then
		umsg.Start( "WepMenu", caller )
		umsg.End()
		DarkRP.talkToPerson( caller, Color( 56, 118, 29 ), "Corporal Shepard", color_white, "I need a "..self.chosenwep.."." )
	else
		DarkRP.talkToPerson( caller, Color( 56, 118, 29 ), "Corporal Shepard", color_white, "I'm looking for a weapons engineer. Have you seen any?" )
	end
end

function ENT:OnTakeDamage( dmg )
	if dmg:GetAttacker():IsPlayer() then
		dmg:GetAttacker():Kill()
		DarkRP.talkToPerson( dmg:GetAttacker(), Color( 56, 118, 29 ), "Corporal Shepard", color_white, "Really? What was that for?" )
	end
end

function ENT:TeleportAway()
	timer.Simple( 1, function()
		if IsValid( self ) then
			local ed = EffectData()
			ed:SetOrigin( self:GetPos() + Vector( 0, 0, 30 ) )
			ed:SetNormal(VectorRand())
			ed:SetMagnitude(3)
			ed:SetScale(1)
			ed:SetRadius(3)
			util.Effect( "Sparks", ed )
			self:EmitSound( "ambient/machines/teleport4.wav" )
			self:Remove()
		end
	end )
end

function ENT:Think()
	self:SetSequence( "idle_all_02" )
end

util.AddNetworkString("WepAccept")
net.Receive("WepAccept", function(length, ply)
	DarkRP.talkToPerson( ply, Color( 56, 118, 29 ), "Corporal Shepard", color_white, "Thanks! I'll be waiting here for you!" )
	self.waiting = true
end)

util.AddNetworkString("WepDeny")
net.Receive("WepDeny", function(length, ply)
	DarkRP.talkToPerson( ply, Color( 56, 118, 29 ), "Corporal Shepard", color_white, "Alright, shame we didn't get to work together." )
	self:TeleportAway()
end)