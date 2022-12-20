AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "City 17 Detonation Console"
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
		self:SetTrigger( true )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
		self.Decrypted = false
	end

	local randmap = {
		"rp_ineu_valley2_v1a",
		"gm_boreas"
	}

	function ENT:Use( ply )
		if ply:GetJobCategory() == "Combine" then
			if !GetGlobalBool( "BlowoutActive" ) then
				HLU_Notify( ply, "Cancellation aborted, there is nothing to cancel.", 1, 6 )
				return
			end
			RunConsoleCommand( "blowout_enabled", 0 )
			timer.Remove( "blowout" )
			timer.Remove( "changelevel" )
			HLU_Notify( nil, "Code upload failed, emergency cancellation button was activated.", 1, 10, true )
		else
			if !self.Decrypted then
				HLU_Notify( ply, "Insert a detonation code decrypter to use this console.", 1, 6 )
				return
			end
			if GetGlobalBool( "BlowoutActive" ) then
				HLU_Notify( ply, "The codes are already being uploaded.", 1, 6 )
				return
			end
			RunConsoleCommand( "blowout_enabled", 1 )
			ply:EmitSound("buttons/button19.wav", 50, 100)
			timer.Create( "blowout", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
			timer.Create( "changelevel", 150, 0, function()
				RunConsoleCommand( "gamemode", "outlandrp" )
				RunConsoleCommand( "changelevel", table.Random( randmap ) )
			end )
			HLU_Notify( nil, "Codes uploading to core......2 minutes until citadel destruction.", 0, 10, true )
		end
	end

	function ENT:StartTouch( ent )
		if ent:GetClass() == "code_decrypter" then
			self:EmitSound( "buttons/button5.wav" )
			self.Decrypted = true
			ent:Remove()
		end
	end
end
