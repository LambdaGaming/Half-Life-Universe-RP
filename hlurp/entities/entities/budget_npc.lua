AddCSLuaFile()

ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "Budget NPC"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

local SellableEnts = {
	crystal_fragment = 100,
	crystal_harvested = 50,
	crystal_radioactive = 150,
	organic_matter = 50,
	organic_matter_cooked = 100,
	organic_matter_rare = 200,
	organic_matter_radioactive = 150,
	xen_iron = 50,
	xen_iron_radioactive = 150,
	xen_iron_refined = 100
}

function ENT:Initialize()
	self:SetModel( "models/player/magnusson.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_INTERACTIVE )
	if SERVER then
		self:SetUseType( SIMPLE_USE )
	end
end

if SERVER then
	function ENT:AcceptInput( name, ply )
		if ply:Team() == TEAM_ADMIN then
			ply:SystemChat( "Trader", color_red, "You cannot use the trader as Facility Admin." )
			return
		end
		local amount = 0
		local price = 0
		for k,v in ipairs( ents.FindInSphere( self:GetPos(), 100 ) ) do
			if v:CPPIGetOwner() != ply then
				continue
			end
			if SellableEnts[v:GetClass()] then
				amount = amount + 1
				price = price + SellableEnts[v:GetClass()]
				v:Remove()
			elseif BuyMenuItems[v:GetClass()] then
				amount = amount + 1
				price = price + math.Round( BuyMenuItems[v:GetClass()].Price * 0.5 )
				v:Remove()
			end
		end
		if amount > 0 then
			ply:SystemChat( "Trader", color_red, "You have sold "..amount.." items for $"..price.."." )
			ply:AddFunds( price )
		else
			ply:SystemChat( "Trader", color_red, "No items detected. Try moving them closer." )
		end
	end

	function ENT:Think()
		self:SetSequence( "idle_all_02" )
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		self:DrawOverheadText( "Trader" )
	end
end
