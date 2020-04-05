AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Rocket Launch Button"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

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

	function ENT:Use(caller, activator)
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( caller, "ERROR: You must wait until the 30 minute ceasefire has ended.", 1, 6 )
			return
		end
		if GetConVar( "blowout_enabled" ):GetInt() == 1 then
			HLU_Notify( caller, "ERROR: Launch aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else.", 1, 6 )
			return
		end
		if #ents.FindByClass( "gb5_proj_icbm_big" ) >= 1 then
			HLU_Notify( caller, "ERROR: The rocket was already spawned!", 1, 6 )
			return
		end
		if caller:Team() != TEAM_RESISTANCELEADER then
			HLU_Notify( caller, "ERROR: Only resistance leaders can launch the rocket!", 1, 6 )
			return
		end
		if timer.Exists("rocket_timer") then
			HLU_Notify( caller, "Wait "..string.ToMinutesSeconds( math.Round( timer.TimeLeft( "rocket_timer" ) ) ).." before activating the rocket again.", 1, 6 )
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

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
