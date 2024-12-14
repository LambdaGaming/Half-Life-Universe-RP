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
		self:SetModel( "models/props_lab/reciever01d.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		local phys = self:GetPhysicsObject()
		phys:Wake()
		
		local greenlight = ents.Create( "light_dynamic" )
		greenlight:SetPos( self:GetPos() )
		greenlight:SetOwner( self:GetOwner() )
		greenlight:SetParent( self )
		greenlight:SetKeyValue( "_light", "0 255 0 255" )  
		greenlight:SetKeyValue( "distance", "150" )
		greenlight:Spawn()
	end

	function ENT:Use( ply )
		if ply:GetJobCategory() == "Combine" then
			if timer.Exists( "OutlandTimer" ) then
				HLU_Notify( ply, "You must wait until the 30 minute ceasefire has ended.", 1, 6 )
				return
			end
			if GetConVar( "blowout_enabled" ):GetInt() == 1 then
				HLU_Notify( ply, "ERROR: Cancellation aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else.", 1, 6 )
				return
			end
			if GetConVar( "blowout_enabled" ):GetInt() == 0 then
				if !timer.Exists( "rocketinit" ) then
					HLU_Notify( ply, "ERROR: No rocket detected to abort.", 1, 6 )
					return
				end
				timer.Create( "rocket_timer", 600, 1, function() end )
				HLU_Notify( nil, "Rocket failed to successfully launch, emergency cancellation button was activated.", 0, 6, true )
				HLU_Notify( nil, "There were "..math.Round( timer.TimeLeft( "rocketinit" ) ).." seconds left until the rocket launched.", 0, 6, true )
				timer.Remove( "KickTimer" )
				for k,v in pairs( ents.FindByClass( "gb5_proj_icbm_big" ) ) do
					v:Remove()
				end
			end
		else
			if timer.Exists( "OutlandTimer" ) then
				HLU_Notify( ply, "ERROR: You must wait until the 30 minute ceasefire has ended.", 1, 6 )
				return
			end
			if GetConVar( "blowout_enabled" ):GetInt() == 1 then
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
			if game.GetMap() == "rp_ineu_valley2_v1a" then
				local rocketspawn = ents.Create("gb5_proj_icbm_big")
				rocketspawn:SetPos( Vector( -13185, 8374, -1216 ) )
				rocketspawn:Spawn()
			else
				local rocketspawn = ents.Create("gb5_proj_icbm_big")
				rocketspawn:SetPos( Vector( -79, 5578, -6102 ) )
				rocketspawn:Spawn()
			end
		end
	end
end
