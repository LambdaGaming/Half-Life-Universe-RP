AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Thermonuclear Device"
ENT.Author = "Lambda Gaming"
ENT.Category = "Superadmin Only"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	local setmap = {
		"rp_city17_build210",
		"rp_city17_district47",
		"rp_city24_v3"
	}

	local random = table.Random( setmap )

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
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
			if v:GetClass() == "nuke_key" then
				foundkey = true
				break
			end
		end

		if !foundkey then
			HLU_Notify( activator, "You must take the nuke to the detonator terminal before it can be activated!", 1, 6 )
			return
		end

		self:EmitSound( "buttons/button3.wav" )
		self:Remove()

		timer.Simple( 1, function() RunConsoleCommand( "blowout_enabled", 1 ) end )
		timer.Simple( 2, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
		timer.Simple( 150, function() RunConsoleCommand ( "changelevel", random ) end )

		HLU_Notify( nil, "Nuke activated. 2 minutes until detonation.", 1, 6, true )
		for k,v in pairs( player.GetHumans() ) do
			v:ConCommand( "play bmrp_nuke.mp3" )
		end
		if SERVER then
			ToggleAlarm( true )
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
