AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local cooldown = 600

function ENT:Initialize()
	self:SetModel("models/props_citizen_tech/firetrap_buttonpad.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	local redlight = ents.Create("light_dynamic")
	redlight:SetPos( self:GetPos() )
	redlight:SetOwner( self:GetOwner() )
	redlight:SetParent(self)
	redlight:SetKeyValue( "_light", "255 0 0 255" )  
	redlight:SetKeyValue("distance", "150" )
	redlight:Spawn()
end

function ENT:Use(caller, activator)
	if timer.Exists("OutlandTimer") then DarkRP.notify( caller, 1, 5, "You must wait until the 30 minute ceasefire has ended." ) return end
	if GetConVar("blowout_enabled"):GetInt() == 1 then
		DarkRP.notify( caller, 1, 8, "ERROR: Cancellation aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else." )
		return
	end
	if GetConVar("blowout_enabled"):GetInt() == 0 then
		if !timer.Exists("rocketinit") then DarkRP.notify( caller, 1, 8, "ERROR: No rocket detected to abort." ) return end
		timer.Create("rocket_timer", cooldown, 1, function() end )
		for k, ply in pairs(player.GetAll() ) do
			DarkRP.notify( ply, 1, 8, "Rocket failed to successfully launch, emergency cancellation button was activated." )
			DarkRP.notify( ply, 0, 8, "There were "..string.ToMinutesSeconds(math.Round (timer.TimeLeft("rocketinit"))).." minutes left until the rocket launched." )
		end
		for k, v in pairs( ents.FindByClass("gb5_proj_icbm_big") ) do
			v:Remove()
		end
	end
end