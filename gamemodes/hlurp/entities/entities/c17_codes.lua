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
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	local randmap = {
		"rp_ineu_valley2_v1a",
		"gm_boreas"
	}

	function ENT:Use( activator, caller )
		if activator:Team() != TEAM_SCIENTIST then
			HLU_Notify( activator, "Only scientists can upload the detonation codes!", 1, 6 )
			return
		end
		if GetGlobalBool( "BlowoutActive" ) then
			HLU_Notify( activator, "The codes are already being uploaded.", 1, 6 )
			return
		end
		RunConsoleCommand( "blowout_enabled", 1 ) --Enables blowout addon
		activator:EmitSound("buttons/button19.wav", 50, 100) --Emits sound upon using
		timer.Create( "blowout", 2, 0, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
		timer.Create( "changelevel", 150, 0, function()
			RunConsoleCommand( "gamemode", "outlandrp" )
			RunConsoleCommand( "changelevel", table.Random( randmap ) )
		end )
		HLU_Notify( nil, "Codes uploading to core......2 minutes until citadel destruction.", 0, 10, true )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
