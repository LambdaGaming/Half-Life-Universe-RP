AddCSLuaFile("shared.lua")
include("shared.lua")

local city17mapcoords = Vector(6286,-1759 ,4220)
local outlandmapcoords = Vector(7121, 14434, 1328)
local district47mapcoords = Vector(-623, -2533, 704)
local city24mapcoords = Vector(-790, 8901, 32)
local industrial17mapcoords = Vector( 2719, 3975, 1920 )

function ENT:Initialize()
	self:SetModel("models/props_lab/teleplatform.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetHealth( 100 )
	self:SetMaxHealth( 100 )
	
	self.active = false
end

function ENT:Use(caller, activator)
	if self.active then DarkRP.notify( caller, 1, 6, "The teleporter is currently in use." ) return end
	if IsValid( caller ) and caller:Alive() then
		self.active = true
		timer.Simple( 1, function() DarkRP.notify( caller, 0, 6, "Teleport starting..." ) end )
		self:EmitSound( "ambient/levels/labs/teleport_mechanism_windup"..math.random( 1,5 )..".wav" )
		
		local time = 5
		timer.Create( "TeleportTimer", 1, 5, function()
			DarkRP.notify( caller, 0, 6, "Teleporting in: "..tostring( time ) )
			time = time - 1
		end )

		timer.Simple( 7, function()
			if game.GetMap() == "rp_city17_build210" then
				caller:SetPos( city17mapcoords )
			elseif game.GetMap() == "rp_ineu_valley2_v1a" then
				caller:SetPos( outlandmapcoords )
			elseif game.GetMap() == "rp_city17_district47" then
				caller:SetPos( district47mapcoords )
			elseif game.GetMap() == "rp_city24_v2" then
				caller:SetPos( city24mapcoords )
			elseif game.GetMap() == "rp_industrial17_v1" then
				caller:SetPos( industrial17mapcoords )
			else
				DarkRP.notify( caller, 1, 6, "ERROR: Cannot teleport, invalid map." )
			end
			self:EmitSound( "ambient/machines/teleport"..math.random( 3,4 )..".wav" )
			caller:EmitSound( "ambient/machines/teleport"..math.random( 3,4 )..".wav" )
			self.active = false
		end )
	end
end

function ENT:OnTakeDamage()
	local dmg = DamageInfo():GetDamage()
	self:SetHealth( self:Health() - dmg )
	if self:Health() <= 0 then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
		self:Remove()
	end
end