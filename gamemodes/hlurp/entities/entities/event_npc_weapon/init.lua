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

local textcolor = Color( 56, 118, 29 )
local weapon = {
	{"weapon_crossbow_hl", "Crossbow"},
	{"weapon_egon", "Gluon Gun"},
	{"weapon_flechettegrenade", "Flechette Grenade"},
	{"weapon_freezinggun", "Freeze Gun"},
	{"weapon_gauss", "Tau Cannon"},
	{"weapon_knife", "Knife"},
	{"weapon_penguin", "Penguin"},
	{"weapon_rpg_hl", "RPG"},
	{"weapon_tripmine", "Tripmine"}
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
	self.chosenwep = rand[1]
	self.chosenwepname = rand[2]
end

util.AddNetworkString( "WepMenu" )
function ENT:AcceptInput( ply, caller )
	if self.waiting then
		local foundwep = false
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v:GetClass() == self.chosenwep then
				foundwep = true
			end
		end
		if foundwep then
			v:Remove()
			HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "Thanks! Here's your cash. (Award +600)", true, caller )
			ChangeBudget( 600 )
			self:TeleportAway()
			return
		else
			if caller:Team() == TEAM_WEPMAKER then
				HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "You were supposed to bring me a "..self.chosenwepname..".....where is it?", true, caller )
				return
			end
		end
	end
	if caller:Team() == TEAM_WEPMAKER then
		net.Start( "WepMenu" )
		net.Send( caller )
		HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "I need a "..self.chosenwepname..".", true, caller )
		return
	end
	HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "I'm looking for a weapons engineer. Have you seen one?", true, caller )
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	if IsValid( ply ) and ply:IsPlayer() then
		ply:Kill()
		HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "Really? What was that for?", true, ply )
	end
end

function ENT:TeleportAway()
	timer.Simple( 1, function()
		if !IsValid( self ) then return end
		local ed = EffectData()
		ed:SetOrigin( self:GetPos() + Vector( 0, 0, 30 ) )
		ed:SetNormal(VectorRand())
		ed:SetMagnitude(3)
		ed:SetScale(1)
		ed:SetRadius(3)
		util.Effect( "Sparks", ed )
		self:EmitSound( "ambient/machines/teleport4.wav" )
		self:Remove()
	end )
end

function ENT:Think()
	self:SetSequence( "idle_all_02" )
end

util.AddNetworkString("WepAccept")
net.Receive("WepAccept", function(length, ply)
	HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "Thanks! I'll be waiting here for you!", true, ply )
	self.waiting = true
end)

util.AddNetworkString("WepDeny")
net.Receive("WepDeny", function(length, ply)
	HLU_ChatNotifySystem( "Corporal Shepard", textcolor, "Alright, shame we didn't get to work together.", true, ply )
	self:TeleportAway()
end)