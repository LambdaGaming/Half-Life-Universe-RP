AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_citizen_tech/firetrap_buttonpad.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:Use(ply)
	
	RunConsoleCommand( "blowout_enabled", 0 ) --Disables blowout and stops timer
	
	timer.Remove( "blowout" )
	
	timer.Remove( "changelevel" )
	
	for k, ply in pairs(player.GetAll() ) do
	ply:ChatPrint("Code upload failed, emergency cancellation button was activated.") --Global chat stating that the blowout will not activate
	end
	
end