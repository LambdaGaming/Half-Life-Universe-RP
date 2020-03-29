AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Citadel Detonation Emergency Cancellation Button"
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

	function ENT:Use( activator, caller )
		if !GetGlobalBool( "BlowoutActive" ) then
			HLU_Notify( activator, "Cancellation aborted, there is nothing to cancel.", 1, 6 )
			return
		end
		RunConsoleCommand( "blowout_enabled", 0 ) --Disables blowout and stops timer
		timer.Remove( "blowout" )
		timer.Remove( "changelevel" )
		HLU_Notify( nil, "Code upload failed, emergency cancellation button was activated.", 1, 10, true )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
