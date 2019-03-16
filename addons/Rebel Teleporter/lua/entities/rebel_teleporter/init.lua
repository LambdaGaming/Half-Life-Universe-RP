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
	if IsValid(caller) and caller:Alive() then
		self.active = true
		timer.Simple(1, function() caller:ChatPrint("Teleport starting...") end)
		self:EmitSound(Sound("ambient/levels/labs/teleport_mechanism_windup"..math.random(1,5)..".wav") )
		timer.Simple(3, function() caller:ChatPrint("5") end)
		timer.Simple(4, function() caller:ChatPrint("4") end)
		timer.Simple(5, function() caller:ChatPrint("3") end)
		timer.Simple(6, function() caller:ChatPrint("2") end)
		timer.Simple(7, function() caller:ChatPrint("1") end)
		
		if game.GetMap() == "rp_city17_build210" then
			timer.Simple(8, function() 
				caller:SetPos(city17mapcoords)
				self:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				caller:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				self.active = false
			end )

		elseif game.GetMap() == "rp_ineu_valley2_v1a" then
			timer.Simple(8, function() 
				caller:SetPos(outlandmapcoords)
				self:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				caller:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				self.active = false
			end )

		elseif IsValid(caller) and game.GetMap() == "rp_city17_district47" then
			timer.Simple(8, function() 
				caller:SetPos(district47mapcoords)
				self:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				caller:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				self.active = false
			end )

		elseif IsValid(caller) and game.GetMap() == "rp_city24_v1" then
			timer.Simple(8, function() 
				caller:SetPos(city24mapcoords)
				self:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				caller:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				self.active = false
			end )
			
		elseif IsValid(caller) and game.GetMap() == "rp_industrial17_v1" then
			timer.Simple(8, function() 
				caller:SetPos(industrial17mapcoords)
				self:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				caller:EmitSound("ambient/machines/teleport"..math.random(3,4)..".wav")
				self.active = false
			end )
		end
	end
end

function ENT:OnTakeDamage()
	self:SetHealth( self:Health() - 2 )
	if self:Health() <= 0 then
		local explode = ents.Create( "env_explosion" )
		explode:SetPos( self:GetPos() )
		explode:Spawn()
		explode:SetKeyValue( "iMagnitude", "0" )
		explode:Fire( "Explode", 0, 0 )
		self:Remove()
	end
end