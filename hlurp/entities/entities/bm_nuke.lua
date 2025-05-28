AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Thermonuclear Device"
ENT.Author = "Lambda Gaming"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	function ENT:Initialize()
		self:SetModel( "models/opfor/props/nukecase.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:Use( activator, caller )
		local foundkey = false
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
			if v:GetClass() == "nuke_key" then
				foundkey = true
				break
			end
		end

		if !foundkey then
			HLU_Notify( activator, "You must take the nuke to the detonator terminal before it can be activated!", 1, 6 )
			return
		end

		local map
		if City17Map == "C17" then
			map = "rp_city17_build210"
		else
			map = "rp_city24_v4"
		end

		self:EmitSound( "buttons/button3.wav" )
		self:Remove()

		timer.Simple( 1, function() RunConsoleCommand( "blowout_enabled", 1 ) end )
		timer.Simple( 2, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
		timer.Simple( 150, function() RunConsoleCommand ( "changelevel", map ) end )

		HLU_Notify( nil, "Nuke activated. 2 minutes until detonation.", 1, 6, true )
		for k,v in ipairs( player.GetHumans() ) do
			v:ConCommand( "play bmrp_nuke.mp3" )
		end
		ToggleAlarm( true )
	end
end
