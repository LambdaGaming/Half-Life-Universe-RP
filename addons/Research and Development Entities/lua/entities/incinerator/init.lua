AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/surgical_laser.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetTrigger(true)
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

local blacklist = {
	"swm_wood_xen",
	"nuke_key",
	"rp_vendingmachine_bm_drink2",
	"rp_vendingmachine_bm_drink1",
	"rp_vendingmachine_bm_food1",
	"mgs_crystal",
	"door",
    "func_door",
    "player",
    "beam",
    "worldspawn",
	"prop_dynamic",
	"func_button",
	"func_wall",
	"func_healthcharger",
	"func_recharge",
	"func_door_rotating",
	"prop_door_rotating",
	"prop_door",
	"sammyservers_textscreen",
	"func_tracktrain",
	"func_pushable",
	"func_train",
	"func_brush",
	"func_breakable",
	"xen_podium"
}

function ENT:Touch(entity)
local pos = entity:GetPos()
	if entity:IsPlayer() or entity:IsWorld() or table.HasValue( blacklist, entity:GetClass() ) then return end
	
		local explosion = ents.Create("env_explosion")
		explosion:SetPos( pos )
		explosion:Spawn()
		explosion:SetKeyValue("iMagnitude", "0")
		explosion:Fire("Explode", 0, 0)
		explosion:Remove()
		entity:Remove()
end

function ENT:AcceptInput(caller, activator)
	activator:ChatPrint("Use a magnifying glass on this item to research it, or touch an item with it and see what happens.")
end