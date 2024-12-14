AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Satellite Control"
ENT.Author = "Lambda Gaming"
ENT.Category = "HLU RP"
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

	function ENT:Use( ply )
		if ply:GetJobCategory() == "Combine" then
			if !GetConVar( "blowout_enabled" ):GetBool() then
				HLU_Notify( ply, "ERROR: Nothing was detected to cancel.", 1, 6 )
				return
			end
			RunConsoleCommand( "blowout_enabled", 0 )
			timer.Remove( "blowoutcombine" )
			timer.Remove( "changelevelcombine" )
			HLU_Notify( nil, "Portal failed to successfully close, emergency cancellation button was activated.", 1, 6, true )
		else
			if timer.Exists( "OutlandTimer" ) then
				HLU_Notify( ply, "You must wait until the 30 minute ceasefire has ended.", 1, 6 )
				return
			end
			if !ply.hascodes then
				HLU_Notify( ply, "You don't have the codes to shutdown the portal!", 1, 6 )
				return
			end
			if !GetConVar( "blowout_enabled" ):GetBool() then
				HLU_Notify( ply, "ERROR: The portal is already being opened!", 1, 6 )
				return
			end
			RunConsoleCommand( "blowout_enabled", 1 )
			self:EmitSound( "buttons/button19.wav", 50, 100 )
			timer.Create( "blowoutcombine", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
			timer.Create( "changelevelcombine", 150, 0, function() RunConsoleCommand ( "changelevel", "gm_atomic" ) end )
			HLU_Notify( nil, "Codes sent to Combine overworld.......... 2 minutes until portal detonation.", 0, 10, true )
		end
	end
end
