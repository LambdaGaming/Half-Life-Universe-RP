AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:SpawnFunction( ply, tr, name )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( name )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end

local textcolor = color_red
local SellableEnts = {
	["crystal_fragment"] = 100,
	["crystal_harvested"] = 50,
	["crystal_radioactive"] = 150,
	["organic_matter"] = 50,
	["organic_matter_cooked"] = 100,
	["organic_matter_rare"] = 200,
	["organic_matter_radioactive"] = 150,
	["xen_iron"] = 50,
	["xen_iron_radioactive"] = 150,
	["xen_iron_refined"] = 100
}
local SellableEquipment = {
	["lab_burner"] = true,
	["lab_chemical"] = true,
	["lab_generator"] = true,
	["lab_laser"] = true,
	["lab_nitrogen"] = true,
	["lab_reactor"] = true
}
local GaveLoan = false
function ENT:Initialize()
    self:SetModel( "models/player/magnusson.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	self:SetUseType( SIMPLE_USE )
 
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

util.AddNetworkString( "BudgetMenu" )
function ENT:AcceptInput( ply, caller )
	if caller:Team() != TEAM_ADMIN then
		local amount = 0
		local price = 0
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if SellableEnts[v:GetClass()] then
				amount = amount + 1
				price = price + SellableEnts[v:GetClass()]
				v:Remove()
			end
		end
		if amount > 0 then
			HLU_ChatNotifySystem( "Budget Manager", textcolor, "You have sold "..amount.." mined items for $"..price..".", true, caller )
			ChangeBudget( price )
			return
		end
		HLU_ChatNotifySystem( "Budget Manager", textcolor, "No mined items detected to sell. Try moving them closer.", true, caller )
		return
	end
	if GetGlobalInt( "BMRP_Budget" ) > 500 then
		HLU_ChatNotifySystem( "Budget Manager", textcolor, "The budget looks good to me. No action needed.", true, caller )
		return
	end
	net.Start( "BudgetMenu" )
	net.Send( caller )
end

function ENT:Think()
	self:SetSequence( "idle_all_02" )
end

util.AddNetworkString( "GiveLoan" )
net.Receive( "GiveLoan", function( len, ply )
	if GaveLoan then
		HLU_ChatNotifySystem( "Budget Manager", textcolor, "You have already taken the loan. I can't give out another.", true, ply )
		return
	end
	ChangeBudget( 5000 )
	GaveLoan = true
	HLU_ChatNotifySystem( "Budget Manager", textcolor, "Loan request accepted. $5,000 has been added to the budget.", true, ply )
end )

util.AddNetworkString( "SellEquipment" )
net.Receive( "SellEquipment", function( len, ply )
	local amount = 0
	for k,v in pairs( ents.FindByClass( "lab_*" ) ) do
		amount = amount + 1
	end
	if amount >= 3 then	
		for k,v in pairs( ents.FindByClass( "lab_*" ) ) do
			v:Remove()
		end
		ChangeBudget( 3000 )
		HLU_ChatNotifySystem( "Budget Manager", textcolor, "Lab equipment has been sold. Budget increased by $3,000." )
		return
	end
	HLU_ChatNotifySystem( "Budget Manager", textcolor, "There isn't enough equipment to sell.", true, ply )
end )
