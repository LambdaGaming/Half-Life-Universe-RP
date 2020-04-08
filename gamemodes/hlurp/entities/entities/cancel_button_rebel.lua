AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Emergency Cancellation Button (Outland Rebel Rocket)"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	local cooldown = 600
	function ENT:Initialize()
		self:SetModel( "models/props_citizen_tech/firetrap_buttonpad.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		local phys = self:GetPhysicsObject()
		phys:Wake()
		
		local redlight = ents.Create( "light_dynamic" )
		redlight:SetPos( self:GetPos() )
		redlight:SetOwner( self:GetOwner() )
		redlight:SetParent( self )
		redlight:SetKeyValue( "_light", "255 0 0 255" )  
		redlight:SetKeyValue( "distance", "150" )
		redlight:Spawn()
	end

	function ENT:Use( caller, activator )
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( caller, "You must wait until the 30 minute ceasefire has ended.", 1, 6 )
			return
		end
		if GetConVar( "blowout_enabled" ):GetInt() == 1 then
			HLU_Notify( caller, "ERROR: Cancellation aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else.", 1, 6 )
			return
		end
		if GetConVar( "blowout_enabled" ):GetInt() == 0 then
			if !timer.Exists( "rocketinit" ) then
				HLU_Notify( caller, "ERROR: No rocket detected to abort.", 1, 6 )
				return
			end
			timer.Create( "rocket_timer", cooldown, 1, function() end )
			HLU_Notify( nil, "Rocket failed to successfully launch, emergency cancellation button was activated.", 0, 6, true )
			HLU_Notify( nil, "There were "..string.ToMinutesSeconds( math.Round( timer.TimeLeft( "rocketinit" ) ) ).." minutes left until the rocket launched.", 0, 6, true )
			timer.Remove( "KickTimer" )
			for k,v in pairs( ents.FindByClass( "gb5_proj_icbm_big" ) ) do
				v:Remove()
			end
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
