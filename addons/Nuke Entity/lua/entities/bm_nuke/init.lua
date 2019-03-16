AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

local setmap = {
	"rp_city17_build210",
	"rp_city17_district47",
	"rp_city24_v2",
	"rp_industrial17_v1"
}

local random = table.Random(setmap)

function ENT:SpawnFunction( ply, tr )
	
	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "bm_nuke" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
end

function ENT:Initialize()

	self:SetModel("models/opfor/props/nukecase.mdl")
 
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType(SIMPLE_USE)
	
	self.Index = self:EntIndex()
	
	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Use(activator)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 300)) do
		if not v:GetClass() == "nuke_key" then activator:ChatPrint("You must take the nuke to the detonator terminal before it can be activated!") return end
		if v:GetClass() == "nuke_key" then
			self.Entity:Remove()
			activator:EmitSound("buttons/button3.wav", 50, 100)
	
			timer.Simple( 1, function() RunConsoleCommand( "blowout_enabled", 1 ) end )
			timer.Simple( 2, function() RunConsoleCommand( "blowout_trigger_delayed", 300 ) end )
			timer.Simple( 150, function() RunConsoleCommand ( "gamemode", "city17rp" ); RunConsoleCommand ( "changelevel", random ) end )
	
			for k, ply in pairs( player.GetAll() ) do
				ply:ChatPrint( "Nuke Activated. 2 Minutes until detonation." )
			end
		end
	end
end

function ENT:Think()
	if game.GetMap() == "gm_atomic" then
		self:Remove()
		if CLIENT then
			self.Owner:ChatPrint("ERROR: Black Mesa has already been vaporized. No need for more nukes.")
			self.Owner:ChatPrint("You have been refunded $300 for the removed nuke.")
		end
		self.Owner:addMoney(300)
	end
end