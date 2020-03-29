AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Outland Combine Base Emergency Cancellation Button"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_citizen_tech/firetrap_buttonpad.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )

		local phys = self:GetPhysicsObject()
		if IsValid( phys ) then
			phys:Wake()
		end
		
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
		if !GetConVar( "blowout_enabled" ):GetBool() then
			HLU_Notify( caller, "ERROR: Nothing was detected to cancel.", 1, 6 )
			return
		end
		RunConsoleCommand( "blowout_enabled", 0 )
		timer.Remove( "blowoutcombine" )
		timer.Remove( "changelevelcombine" )
		HLU_Notify( nil, "Portal failed to successfully close, emergency cancellation button was activated.", 1, 6, true )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
