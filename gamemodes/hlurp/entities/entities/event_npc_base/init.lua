AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

local textcolor = Color( 135, 206, 235 )

function ENT:Initialize()
    self:SetModel( "models/gman.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
	
	self.detained = false
end

util.AddNetworkString( "ReviveGovMenu" )
function ENT:AcceptInput( ply, caller )
	if caller:Team() == TEAM_ADMIN and !self.detained then
		net.Start( "ReviveGovMenu" )
		net.Send( caller )
	elseif caller:Team() == TEAM_SECURITY or caller:Team() == TEAM_SECURITYBOSS and self.detained then
		HLU_ChatNotifySystem( "Government Man", textcolor, "Alright fine, I'm leaving. But you haven't seen the last of me...", true, caller )
		self:TeleportAway()
	elseif self.detained then
		HLU_ChatNotifySystem( "Government Man", textcolor, "Security was called on me...I'll leave once they're here....", true, caller )
	else
		HLU_ChatNotifySystem( "Government Man", textcolor, "You have no business being here. Leave.", true, caller )
	end
end

function ENT:OnTakeDamage( dmg )
	local ply = dmg:GetAttacker()
	if IsValid( ply ) and ply:IsPlayer() then
		ply:Kill()
		HLU_ChatNotifySystem( "Government Man", textcolor, "This violence isn't necessary.", true, ply )
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

util.AddNetworkString("ReviveFireAdmin")
net.Receive("ReviveFireAdmin", function(length, ply)
	if ply:Team() == TEAM_ADMIN then
		ChangeTeam( ply, 1 )
		HLU_ChatNotifySystem( "Government Man", textcolor, "Cash would have been preferred, but my employers will be glad to hear of your resignation.", true, ply )
		self:TeleportAway()
	end
end)

util.AddNetworkString("ReviveRemoveCash")
net.Receive("ReviveRemoveCash", function(length, ply)
	if ply:Team() == TEAM_ADMIN then
		ChangeBudget( -5000 )
		HLU_Notify( ply, "You have paid your $5,000 fine to the government.", 0, 6 )
		HLU_ChatNotifySystem( "Government Man", textcolor, "I'm glad we could settle this the easy way. Thanks for the cash.", true, ply )
		self:TeleportAway()
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
				HLU_ChatNotifySystem( "Government Man", textcolor, "Well, it looks like we won't be working together.", true, ply )
				ChangeTeam( ply, 1 )
				self:TeleportAway()
			end )
		end
	end
end)