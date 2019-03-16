AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "event_npc_base" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

local detained = nil
local bye = nil

function ENT:Initialize()
    self:SetModel( "models/gman.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup(COLLISION_GROUP_PLAYER)
	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	detained = false
	bye = false
end

function ENT:AcceptInput( ply, caller )
	if caller:Team() == TEAM_ADMIN and !detained then
		umsg.Start( "ReviveGovMenu", caller )
		umsg.End()
	elseif caller:Team() == TEAM_SECURITY or caller:Team() == TEAM_SECURITYBOSS and detained then
		DarkRP.talkToPerson( caller, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "Alright fine, i'm leaving. But you haven't seen the last of me..." )
		bye = true
	elseif detained then
		DarkRP.talkToPerson( caller, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "Security was called on me...i'll leave once they're here...." )
	else DarkRP.talkToPerson( caller, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "You have no business being here. Leave." )
	end
end

function ENT:OnTakeDamage( dmg )
	if dmg:GetAttacker():IsPlayer() then
		dmg:GetAttacker():Kill()
		DarkRP.talkToPerson( dmg:GetAttacker(), Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "This violence isn't necessary." )
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
	if bye then
		self:TeleportAway()
	end
end

util.AddNetworkString("ReviveFireAdmin")
net.Receive("ReviveFireAdmin", function(length, ply)
	if ply:Team() == TEAM_ADMIN then
		ply:teamBan( TEAM_ADMIN, 600 )
		ply:changeTeam( TEAM_VISITOR, true, false )
		DarkRP.talkToPerson( ply, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "Cash would have been preferred, but my employers will be glad to hear of your resignation." )
		bye = true
	end
end)

util.AddNetworkString("ReviveRemoveCash")
net.Receive("ReviveRemoveCash", function(length, ply)
	if ply:Team() == TEAM_ADMIN then
		ply:addMoney( -5000 )
		DarkRP.notify( ply, 1, 6, "You have paid your $5000 dollar fine to the government." )
		DarkRP.talkToPerson( ply, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "I'm glad we could settle this the easy way. Thanks for the cash." )
		bye = true
	end
end)

util.AddNetworkString("ReviveSecurity")
net.Receive("ReviveSecurity", function(length, ply)
	local rand = math.random( 0, 1 )
	if ply:Team() == TEAM_ADMIN then
		if rand == 0 then
			ply:SendLua( [[RunConsoleCommand( 'say_team', 'Requesting security at my location. A man here needs escorted out.' ) ]] )
			detained = true
		else
			ply:SendLua( [[RunConsoleCommand( 'say_team', 'Requesting security at......WAIT! NO! *gunshots* *static*' ) ]] )
			timer.Simple( 0.5, function()
				ply:EmitSound( "weapons/shotgun/shotgun_fire6.wav" )
				ply:Kill()
				DarkRP.talkToPerson( ply, Color( 135, 206, 235 ), "Government Man", Color( 255, 255, 255 ), "Well, it looks like we won't be working together." )
				ply:teamBan( TEAM_ADMIN, 600 )
				ply:changeTeam( TEAM_VISITOR, true, false )
				bye = true
			end )
		end
	end
end)