AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vending Machine Resupply"
ENT.Author = "Lambda Gaming"
ENT.Category = "HLU RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	local allowed = {
		["rp_vendingmachine_bm_drink1"] = true,
		["rp_vendingmachine_bm_drink2"] = true,
		["rp_vendingmachine_bm_food1"] = true
	}
	
	function ENT:Initialize()
		self:SetModel( "models/props/CS_militia/food_stack.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetTrigger( true )
		
		local phys = self:GetPhysicsObject()
		if phys:IsValid() then
			phys:Wake()
		end
	end

	function ENT:StartTouch( ent )
		if allowed[ent:GetClass()] then
			ent.Amount = 10
			ent:EmitSound( "physics/cardboard/cardboard_box_break"..math.random( 1, 3 )..".wav" )
			self:Remove()
		end
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end
