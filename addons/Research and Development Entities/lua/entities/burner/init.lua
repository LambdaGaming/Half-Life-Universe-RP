AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/labware/burner.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:Touch(entity)
local pos = self:GetPos() + Vector( 0, -30, 30 )
local sound = "ambient/fire/gascan_ignite1.wav"
local class = entity:GetClass()
	if class == "iron" then
		local melt = ents.Create("steel")
		melt:SetPos( pos )
		melt:Spawn()
		entity:Remove()
		self:EmitSound( sound )
	elseif class == "matter" then
		local clean = ents.Create("prop_physics")
		clean:SetModel("models/props_lab/petridish01c.mdl")
		clean:SetPos( pos ) 
		clean:Spawn()
		entity:Remove()
		self:EmitSound( sound )
	elseif class == "syringe" then
		local melt2 = ents.Create("iron")
		melt2:SetPos( pos )
		melt2:Spawn()
		entity:Remove()
		self:EmitSound( sound )
	elseif class == "glass" then
		local melt3 = ents.Create("iron")
		melt3:SetPos( pos )
		melt3:Spawn()
		entity:Remove()
		self:EmitSound( sound )
	elseif class == "ammo" then
		local explosion = ents.Create("env_explosion")
		explosion:SetPos( pos )
		explosion:Spawn()
		explosion:SetKeyValue("iMagnitude", "50")
		explosion:Fire("Explode", 0, 0)
		explosion:Remove()
		entity:Remove()
		self:Remove()
	else entity:Ignite(30, 50)
	end
end

function ENT:AcceptInput(caller, activator)
	activator:ChatPrint("Use a magnifying glass on this item to research it, or touch an item with it and see what happens.")
end