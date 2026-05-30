AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Rebel Teleporter"
ENT.Author = "OPGman"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "HLU RP"

if CLIENT then return end

local TeleCoords = {
	["rp_city17_build210"] = Vector( 6286, -1759 ,4220 ),
	["rp_city24_v4"] = Vector( 14548, 4986, 2064 ),
	["rp_mezs"] = Vector( -282, -1410, 5836 )
}

function ENT:Initialize()
	self:SetModel( "models/props_lab/teleplatform.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetUseType( SIMPLE_USE )
	self:SetHealth( 100 )
	self:SetMaxHealth( 100 )
	self.active = false
end

function ENT:Use( ply )
	if self.active then
		ply:Notify( 1, 6, "The teleporter is currently in use." )
		return
	end
	if IsValid( ply ) and ply:Alive() then
		self.active = true
		timer.Simple( 1, function()
			ply:Notify( 0, 6, "Teleport starting..." )
		end )
		self:EmitSound( "ambient/levels/labs/teleport_mechanism_windup"..math.random( 1, 5 )..".wav" )
		
		local time = 5
		timer.Create( "TeleportTimer", 1, 5, function()
			ply:Notify( 0, 6, "Teleporting in: "..tostring( time ) )
			time = time - 1
		end )

		timer.Simple( 7, function()
			local map = game.GetMap()
			if !TeleCoords[map] then
				ply:Notify( 1, 6, "ERROR: Current map detected as invalid." )
				return
			end
			ply:SetPos( TeleCoords[map] )
			self:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			ply:EmitSound( "ambient/machines/teleport"..math.random( 3, 4 )..".wav" )
			CreateEffect( "Sparks", ply:GetPos() + Vector( 0, 0, 30 ) )
			self.active = false
		end )
	end
end

function ENT:OnTakeDamage()
	local dmg = DamageInfo():GetDamage()
	self:SetHealth( self:Health() - dmg )
	if self:Health() <= 0 then
		Explode( self:GetPos(), 0 )
		self:Remove()
	end
end
