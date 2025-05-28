AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Rocket Launch Button"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_combine/combinebutton.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()
		
		self.light = ents.Create( "light_dynamic" )
		self.light:SetPos( self:GetPos() )
		self.light:SetOwner( self:GetOwner() )
		self.light:SetParent( self )
		self.light:SetKeyValue( "_light", "255 0 0 255" )
		self.light:SetKeyValue( "distance", "150" )
		self.light:Spawn()
	end

	function ENT:Use( ply )
		if !self.HasKey then
			HLU_Notify( ply, "You need to craft a key and insert it here to be able to launch the rocket!", 1, 6 )
			return
		end
		if ply:GetJobCategory() == "Combine" then
			if timer.Exists( "KickTimer" ) then
				HLU_Notify( ply, "ERROR: Cancellation aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else.", 1, 6 )
				return
			else
				if !timer.Exists( "rocketinit" ) then
					HLU_Notify( ply, "ERROR: No rocket detected to abort.", 1, 6 )
					return
				end
				timer.Create( "rocket_timer", 600, 1, function() end )
				HLU_Notify( nil, "Rocket failed to successfully launch, emergency cancellation button was activated.", 0, 6, true )
				HLU_Notify( nil, "There were "..math.Round( timer.TimeLeft( "rocketinit" ) ).." seconds left until the rocket launched.", 0, 6, true )
				timer.Remove( "KickTimer" )
				for k,v in ipairs( ents.FindByClass( "gb5_proj_icbm_big" ) ) do
					v:Remove()
				end
			end
		else
			if timer.Exists( "KickTimer" ) then
				HLU_Notify( ply, "ERROR: Launch aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else.", 1, 6 )
				return
			end
			if #ents.FindByClass( "gb5_proj_icbm_big" ) >= 1 then
				HLU_Notify( ply, "ERROR: The rocket was already spawned!", 1, 6 )
				return
			end
			if ply:Team() != TEAM_RESISTANCELEADER then
				HLU_Notify( ply, "ERROR: Only resistance leaders can launch the rocket!", 1, 6 )
				return
			end
			if timer.Exists("rocket_timer") then
				HLU_Notify( ply, "Wait "..math.Round( timer.TimeLeft( "rocket_timer" ) ).." seconds before activating the rocket again.", 1, 6 )
				return
			end
			local rocket = ents.Create( "gb5_proj_icbm_big" )
			rocket:SetPos( Vector( 14360, 8068, 26 ) )
			rocket:Spawn()
			timer.Create( "rocketinit", 300, 1, function() rocket:Launch() end )
			HLU_ChatNotifySystem( "Outland RP", color_green, "Launch sequence activated.......T minus 5 minutes until lift-off." )
			HLU_Notify( nil, "Launch sequence activated.......T minus 5 minutes until lift-off.", 0, 10, true )
		end
	end
end
