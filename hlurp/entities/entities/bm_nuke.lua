AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Thermonuclear Device"
ENT.Author = "OPGman"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if CLIENT then return end

function ENT:Initialize()
	self:SetModel( "models/opfor/props/nukecase.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:PhysWake()
end

function ENT:Use( ply )
	local foundKey = false
	for k,v in ipairs( ents.FindInSphere( self:GetPos(), 300 ) ) do
		if v:GetClass() == "nuke_key" then
			foundKey = true
			break
		end
	end

	if !foundKey then
		HLU_Notify( ply, "You must take the nuke to the detonator terminal before it can be activated!", 1, 6 )
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
	RunConsoleCommand( "blowout_enabled", 1 )
	timer.Simple( 2, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
	timer.Simple( 150, function() RunConsoleCommand ( "changelevel", map ) end )
	HLU_Notify( nil, "Nuke activated. 2 minutes until detonation.", 1, 6, true )
	BroadcastSound( "bmrp_nuke.mp3" )
	ToggleAlarm( true )
end
