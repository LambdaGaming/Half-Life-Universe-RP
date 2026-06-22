AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vending Machine"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if SERVER then
	function ENT:Initialize()
		local gm = GetGlobalInt( "CurrentGamemode" )
		if self:GetModel() == "models/error.mdl" then
			self:SetModel( "models/props_interiors/VendingMachineSoda01a.mdl" )
		end
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:PhysWake()
		self.Amount = gm == 1 and 10 or 20
		self.Used = false
	end

	function ENT:Use( ply )
		if self.Used then return end
		local gm = GetGlobalInt( "CurrentGamemode" )
		if self.Amount <= 0 then
			local msg = gm == 1 and "This vending machine is empty. Contact a custodian to get it refilled." or "This vending machine is empty."
			ply:Notify( 1, 6, msg )
			return
		end
		if gm == 1 then
			if !ply:CanAfford( 15 ) then
				ply:Notify( 1, 6, "You don't have enough money to use the vending machine!" )
				return
			end
			ply:RemoveFunds( 15 )
		end
		self.Used = true
		self.Amount = self.Amount - 1
		self:EmitSound( "ambient/levels/labs/coinslot1.wav" )
		timer.Simple( 1.5, function()
			if !IsValid( self ) then return end
			local model = "models/props_junk/PopCan01a.mdl"
			if gm == 1 then
				if self:GetModel() == "models/props/vendingmachines/classicdispenser.mdl" then
					--Food vending machine
					model = "models/halflife/gibs/food/sandwich.mdl"
				else
					model = "models/halflife/props/can.mdl"
				end
			end
			local pos, ang = LocalToWorld( Vector( 20, -5, -30 ), Angle( -90, -90, 0 ), self:GetPos(), self:GetAngles() )
			local e = ents.Create( "vending_food" )
			e:SetPos( pos )
			e:SetAngles( ang )
			e:SetModel( model )
			e:Spawn()
			self.Used = false
		end )
	end
end

local types = {
	{ "Dr. Breen's Private Reserve", "models/props_interiors/VendingMachineSoda01a.mdl" },
	{ "Black Mesa Food", "models/props/vendingmachines/classicdispenser.mdl" },
	{ "Black Mesa Drink 1", "models/props/vendingmachines/sodapop.mdl" },
	{ "Black Mesa Drink 2", "models/props/vendingmachines/enjoy.mdl" }
}

properties.Add( "vending_machine", {
	MenuLabel = "Vending Type",
	Order = 1000,
	Filter = function( self, ent, ply )
		if !IsValid( ent ) or !ply:IsSuperAdmin() then return false end
		return true
	end,
	MenuOpen = function( self, option, ent, tr )
		local sub = option:AddSubMenu()
		for k,v in pairs( types ) do
			sub:AddOption( v[1], function() self:SetType( ent, v[2] ) end )
		end
	end,
	Action = function() end,
	SetType = function( self, ent, model )
		self:MsgStart()
		net.WriteEntity( ent )
		net.WriteString( model )
		self:MsgEnd()
	end,
	Receive = function( self, len, ply )
		local ent = net.ReadEntity()
		local model = net.ReadString()
		if !self:Filter( self, ent, ply ) then return end
		ent:SetModel( model )
	end
} )
