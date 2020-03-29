AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Satellite Control"
ENT.Author = "Lambda Gaming"
ENT.Category = "Superadmin Only"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/props_combine/breenconsole.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use(caller, activator)
		if timer.Exists( "OutlandTimer" ) then
			HLU_Notify( caller, "You must wait until the 30 minute ceasefire has ended.", 1, 6 )
			return
		end
		if !caller.hascodes then
			HLU_Notify( caller, "You don't have the codes to shutdown the portal!", 1, 6 )
			return
		end
		if !GetConVar( "blowout_enabled" ):GetBool() then
			HLU_Notify( caller, "ERROR: The portal is already being opened!", 1, 6 )
			return
		end
		RunConsoleCommand( "blowout_enabled", 1 ) --Enables blowout addon
		self:EmitSound( "buttons/button19.wav", 50, 100 ) --Emits sound upon using
		timer.Create( "blowoutcombine", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
		timer.Create( "changelevelcombine", 150, 0, function() RunConsoleCommand ( "changelevel", "gm_atomic" ) end )
		HLU_Notify( nil, "Codes sent to Combine overworld.......... 2 minutes until portal detonation.", 0, 10, true )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
