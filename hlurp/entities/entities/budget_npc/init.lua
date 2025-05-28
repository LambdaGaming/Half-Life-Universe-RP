AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

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

function ENT:AcceptInput( ply, caller )
	if caller:Team() != TEAM_ADMIN then
		local amount = 0
		local price = 0
		for k,v in pairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v:CPPIGetOwner() == caller then
				if SellableEnts[v:GetClass()] then
					amount = amount + 1
					price = price + SellableEnts[v:GetClass()]
					v:Remove()
				elseif BuyMenuItems[v:GetClass()] then
					amount = amount + 1
					price = price + math.Round( BuyMenuItems[v:GetClass()].Price / 2 )
					v:Remove()
				end
			end
		end
		if amount > 0 then
			HLU_ChatNotifySystem( "Trader", color_red, "You have sold "..amount.." items for $"..price..".", true, caller )
			caller:AddFunds( price )
		else
			HLU_ChatNotifySystem( "Trader", color_red, "No items detected. Try moving them closer.", true, caller )
		end
	end
end

function ENT:Think()
	self:SetSequence( "idle_all_02" )
end
