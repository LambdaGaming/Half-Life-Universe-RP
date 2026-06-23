AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Rocket Launch Button"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/props_combine/combinebutton.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
	self:LightUp( "255 0 0 255", self:GetPos(), "0", "150" )
end

function ENT:Use( ply )
	if !self.HasKey then
		ply:Notify( 1, 6, "You need to craft a key and insert it here to be able to launch the rocket!" )
		return
	end
	if ply:GetJobCategory() == "Combine" then
		if timer.Exists( "KickTimer" ) then
			ply:Notify( 1, 6, "ERROR: Cancellation aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else." )
			return
		else
			if !timer.Exists( "rocketinit" ) then
				ply:Notify( 1, 6, "ERROR: No rocket detected to abort." )
				return
			end
			timer.Create( "rocket_timer", 600, 1, function() end )
			BroadcastNotify( 0, 6, "Rocket failed to successfully launch, emergency cancellation button was activated." )
			BroadcastNotify( 0, 6, "There were "..math.Round( timer.TimeLeft( "rocketinit" ) ).." seconds left until the rocket launched." )
			timer.Remove( "CombinePortalTimer" )
			timer.Remove( "KickTimer" )
			for k,v in ipairs( ents.FindByClass( "rebel_rocket" ) ) do
				v:Remove()
			end
		end
	else
		if timer.Exists( "KickTimer" ) then
			ply:Notify( 1, 6, "ERROR: Launch aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else." )
			return
		end
		if #ents.FindByClass( "rebel_rocket" ) >= 1 then
			ply:Notify( 1, 6, "ERROR: The rocket was already spawned!" )
			return
		end
		if ply:Team() != TEAM_RESISTANCELEADER then
			ply:Notify( 1, 6, "ERROR: Only resistance leaders can launch the rocket!" )
			return
		end
		if timer.Exists( "rocket_timer" ) then
			ply:Notify( 1, 6, "Wait "..math.Round( timer.TimeLeft( "rocket_timer" ) ).." seconds before activating the rocket again." )
			return
		end
		local rocket = ents.Create( "rebel_rocket" )
		rocket:SetPos( Vector( 13103, 8531, -323 ) )
		rocket:Spawn()
		timer.Create( "rocketinit", 300, 1, function() rocket:Launch() end )
		BroadcastSystemChat( "Outland RP", color_green, "Launch sequence activated.......T minus 5 minutes until lift-off." )
		BroadcastNotify( 0, 10, "Launch sequence activated.......T minus 5 minutes until lift-off." )
	end
end
