AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/reciever01d.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetColor( Color( 255, 255, 255, 0 ) )
	self:SetRenderMode( RENDERMODE_TRANSALPHA )
	local phys = self:GetPhysicsObject()
	phys:Wake()
	
	local greenlight = ents.Create("light_dynamic")
	greenlight:SetPos( self:GetPos() )
	greenlight:SetOwner( self:GetOwner() )
	greenlight:SetParent(self)
	greenlight:SetKeyValue( "_light", "0 255 0 255" )  
	greenlight:SetKeyValue("distance", "150" )
	greenlight:Spawn()
end

function ENT:Use(caller, activator)
	if timer.Exists("OutlandTimer") then DarkRP.notify( caller, 1, 8, "ERROR: You must wait until the 30 minute ceasefire has ended." ) return end
	if GetConVar("blowout_enabled"):GetInt() == 1 then
		DarkRP.notify( caller, 1, 8, "ERROR: Launch aborted. Either the rocket was already put into orbit or the portal is being closed somewhere else." )
		return
	end
	for k,v in pairs(ents.FindByClass("gb5_proj_icbm_big")) do
		if v:IsValid() then DarkRP.notify(activator, 1, 8, "ERROR: The rocket was already spawned!") return end
	end
	if activator:Team() != TEAM_RESISTANCELEADER then DarkRP.notify( caller, 1, 8, "ERROR: Only resistance leaders can launch the rocket!" ) return end
	if timer.Exists("rocket_timer") then DarkRP.notify(activator, 1, 8, "Wait "..string.ToMinutesSeconds(math.Round (timer.TimeLeft("rocket_timer"))).." minutes before activating the rocket again.") return end
		local rocketspawn = ents.Create("gb5_proj_icbm_big")
		rocketspawn:SetPos( Vector( -13185, 8374, -1216 ) )
		rocketspawn:SetAngles( Angle( -90, 0, 0 ) )
		rocketspawn:Spawn()
end